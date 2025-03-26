from datetime import datetime
import os
from typing import Dict, List, Tuple, Any, Optional
import requests
import logging
from datetime import timedelta

from app.tasks.celery_app import celery_app
from app.config import get_settings
from app.logging_config import get_logger
from app.services.firestore_service import update_file_status_firestore
from app.utils.storage import storage_service
from app.db import execute_query_sync, execute_many_sync

logger = get_logger(__name__)
settings = get_settings()

# Record type identifiers
NMI_METADATA_RECORD = "200"
INTERVAL_DATA_RECORD = "300"
QUALITY_FLAG_RECORD = "400"

# Constants
VALID_INTERVALS = [5, 15, 30]
MAX_REASONABLE_KWH = 100000
BATCH_SIZE = 100

@celery_app.task(bind=True, name="process_nem12_file")
def process_nem12_file(self, file_id: int, original_filename: str, storage_filename: str, raw_file_url: str, storage_uri: str):
    """Process a NEM12 file to extract meter data, generate SQL statements, and update file status."""
    logger.info("Starting NEM12 file processing", 
                file_id=file_id, 
                original_filename=original_filename,
                storage_filename=storage_filename,
                raw_file_url=raw_file_url)
    
    try:
        # Update file status to processing in PostgreSQL and Firestore
        _update_file_status(file_id, "processing")
        
        try:
            # Update file status in Firestore
            # Make sure to pass original_filename to ensure it's preserved
            update_file_status_firestore(
                file_id=file_id,
                status="processing",
                original_filename=original_filename
            )
        except Exception as e:
            logger.warning("Failed to update Firestore status, continuing without it", error=str(e))
        
        # Download the file from Firebase Storage URL
        local_file_path = _download_file(raw_file_url, storage_filename, file_id)
        
        # Parse the file and generate SQL statements
        meter_data, sql_statements = _parse_nem12_file(local_file_path)
        
        # Generate SQL file and upload it
        sql_file_path = _generate_sql_file(file_id, original_filename, sql_statements)
        sql_storage_key = f"uploads/outputs/{os.path.basename(sql_file_path)}"
        
        try:
            sql_storage_uri = storage_service.upload_to_storage(sql_file_path, sql_storage_key)
        except Exception as e:
            logger.warning("Failed to upload SQL file to Firebase, continuing with local file", error=str(e))
            sql_storage_uri = sql_file_path  # Use local path as fallback
        
        # Execute the SQL statements
        _execute_sql_statements_sync(sql_statements)
        
        # Update file status to completed and store the SQL output URI in both systems
        _update_file_status(file_id, "completed", sql_output_path=sql_storage_uri)
        
        try:
            # Update file status in Firestore
            update_file_status_firestore(
                file_id=file_id,
                status="completed",
                sql_output_path=sql_storage_uri,
                original_filename=original_filename
            )
        except Exception as e:
            logger.warning("Failed to update Firestore completion status", error=str(e))
        
        # Clean up the local temporary files
        _cleanup_files(local_file_path, sql_file_path)
        
        logger.info("NEM12 file processing completed", file_id=file_id, sql_output_path=sql_storage_uri)
        return {"status": "completed", "file_id": file_id, "sql_output_path": sql_storage_uri}
    
    except Exception as e:
        logger.exception("NEM12 file processing failed", error=str(e), file_id=file_id)
        _update_file_status(file_id, "failed", error_message=str(e))
        
        try:
            # Update failure status in Firestore
            update_file_status_firestore(
                file_id=file_id,
                status="failed",
                error_message=str(e),
                original_filename=original_filename
            )
        except Exception as fe:
            logger.warning("Failed to update Firestore failure status", error=str(fe))
            
        return {"status": "failed", "file_id": file_id, "error": str(e)}

def _download_file(url: str, filename: str, file_id: int) -> str:
    """Download a file from a URL to a local temporary path."""
    logger.info("Downloading file from URL", url=url, file_id=file_id)
    
    # Create the uploads directory if it doesn't exist
    os.makedirs(settings.upload_dir, exist_ok=True)
    
    # Create a local file path
    local_path = os.path.join(settings.upload_dir, f"{file_id}_{filename}")
    
    try:
        # Download the file
        response = requests.get(url, stream=True)
        response.raise_for_status()  # Raise an exception for HTTP errors
        
        # Save the file to the local path
        with open(local_path, 'wb') as f:
            for chunk in response.iter_content(chunk_size=8192):
                f.write(chunk)
        
        logger.info("File downloaded successfully", local_path=local_path, file_id=file_id)
        return local_path
    
    except Exception as e:
        logger.exception("Failed to download file", error=str(e), url=url, file_id=file_id)
        raise

def _parse_nem12_file(file_path: str) -> Tuple[Dict[str, Any], List[str]]:
    """Parse a NEM12 file and extract meter data and generate SQL statements."""
    logger.info("Parsing NEM12 file", file_path=file_path)
    
    meter_data = {"metadata": {}, "readings": [], "quality_flags": []}
    sql_statements = []
    current_nmi = None
    
    try:
        with open(file_path, 'r') as f:
            for line_number, line in enumerate(f, 1):
                try:
                    line = line.strip()
                    if not line:
                        continue
                    
                    parts = [part.strip() for part in line.split(',')]
                    
                    if len(parts) < 2:
                        logger.warning(f"Line {line_number} has insufficient parts", line=line)
                        continue
                    
                    record_type = parts[0]
                    
                    if record_type == NMI_METADATA_RECORD:
                        if not _process_nmi_metadata(parts, line_number, meter_data, sql_statements):
                            continue
                        current_nmi = parts[1]
                    
                    elif record_type == INTERVAL_DATA_RECORD and current_nmi:
                        _process_interval_data(parts, line_number, current_nmi, meter_data, sql_statements)
                            
                    elif record_type == QUALITY_FLAG_RECORD and current_nmi:
                        _process_quality_flags(parts, line_number, current_nmi, meter_data, sql_statements)
                    
                    else:
                        logger.info(f"Ignoring record with type {record_type} at line {line_number}")
                        
                except Exception as e:
                    logger.exception(f"Error processing line {line_number}", error=str(e), line=line)
                    continue
        
        logger.info("NEM12 file parsed successfully", 
                  metadata_records=len(meter_data["metadata"]), 
                  reading_records=len(meter_data["readings"]), 
                  flag_records=len(meter_data["quality_flags"]))
                  
        return meter_data, sql_statements
    
    except Exception as e:
        logger.exception("Failed to parse NEM12 file", error=str(e), file_path=file_path)
        raise

def _process_nmi_metadata(parts: List[str], line_number: int, meter_data: Dict[str, Any], sql_statements: List[str]) -> bool:
    """Process NMI metadata record and generate SQL."""
    if len(parts) < 10:
        logger.error(f"Line {line_number}: NMI metadata record has insufficient parts", line=','.join(parts))
        return False
        
    try:
        nmi = parts[1]
        config_id = parts[2]
        register_id = parts[3]
        meter_serial = parts[4]
        nmi_suffix = parts[5]
        nmi_checksum = parts[6]
        unit_of_measure = parts[7]
        interval_length_str = parts[8]
        start_date_str = parts[9]
        
        # Validate and parse interval length
        try:
            interval_length = int(interval_length_str)
            if interval_length not in VALID_INTERVALS:
                logger.error(f"Line {line_number}: Invalid interval length {interval_length}, must be one of {VALID_INTERVALS}")
                return False
        except ValueError:
            logger.error(f"Line {line_number}: Invalid interval length format", value=interval_length_str)
            return False
        
        # Validate and parse start date
        try:
            start_date = datetime.strptime(start_date_str, "%Y%m%d")
        except ValueError:
            logger.error(f"Line {line_number}: Invalid start date format", value=start_date_str)
            return False
        
        meter_data["metadata"][nmi] = {
            "nmi": nmi,
            "interval_length": interval_length,
            "start_date": start_date,
            "config_id": config_id,
            "register_id": register_id,
            "meter_serial": meter_serial,
            "nmi_suffix": nmi_suffix,
            "nmi_checksum": nmi_checksum,
            "unit_of_measure": unit_of_measure
        }
        
        sql = f"""
            INSERT INTO meter_metadata (nmi, interval_length, start_date) 
            VALUES ('{nmi}', {interval_length}, '{start_date.isoformat()}') 
            ON CONFLICT (nmi) DO UPDATE 
            SET interval_length = {interval_length}, start_date = '{start_date.isoformat()}';
        """
        sql_statements.append(sql)
        
        return True
        
    except Exception as e:
        logger.exception(f"Error processing NMI metadata record at line {line_number}", error=str(e))
        return False

def _process_interval_data(parts: List[str], line_number: int, current_nmi: str, meter_data: Dict[str, Any], sql_statements: List[str]):
    """Process interval data record and generate SQL."""
    if len(parts) < 3:
        logger.warning(f"Line {line_number}: Interval data record has insufficient parts", line=','.join(parts))
        return
        
    if current_nmi not in meter_data["metadata"]:
        logger.error(f"Line {line_number}: No metadata found for NMI {current_nmi}")
        return
        
    interval_length = meter_data["metadata"][current_nmi]["interval_length"]
    date_str = parts[1]
    
    try:
        date = datetime.strptime(date_str, "%Y%m%d")
    except ValueError:
        logger.warning(f"Line {line_number}: Invalid date format in interval data", value=date_str)
        return
    
    values = []
    for v in parts[2:]:
        v = v.strip()
        if v:
            try:
                value = float(v)
                if value < 0 or value > MAX_REASONABLE_KWH:
                    logger.warning(f"Line {line_number}: Reading value out of reasonable range", value=value)
                    continue
                values.append(value)
            except ValueError:
                logger.warning(f"Line {line_number}: Invalid reading value", value=v)
    
    if not values:
        logger.warning(f"Line {line_number}: No valid values found", line=','.join(parts))
        return
        
    for i, value in enumerate(values):
        timestamp = date + timedelta(minutes=i * interval_length)
        reading = {
            "nmi": current_nmi,
            "timestamp": timestamp,
            "consumption": value,
            "is_flagged": False
        }
        meter_data["readings"].append(reading)
        
        sql = f"""
            INSERT INTO meter_readings (nmi, timestamp, consumption, is_flagged) 
            VALUES ('{current_nmi}', '{timestamp.isoformat()}', {value}, FALSE) 
            ON CONFLICT (nmi, timestamp) 
            DO UPDATE SET consumption = {value}, is_flagged = FALSE;
        """
        sql_statements.append(sql)

def _process_quality_flags(parts: List[str], line_number: int, current_nmi: str, meter_data: Dict[str, Any], sql_statements: List[str]):
    """Process quality flag record and generate SQL."""
    if len(parts) < 5:
        logger.warning(f"Line {line_number}: Quality flag record has insufficient parts", line=','.join(parts))
        return
        
    if current_nmi not in meter_data["metadata"]:
        logger.error(f"Line {line_number}: No metadata found for NMI {current_nmi}")
        return
        
    interval_length = meter_data["metadata"][current_nmi]["interval_length"]
    date_str = parts[1]
    quality_method = parts[2]
    
    try:
        flag_start_pos = int(parts[3])
        flag_end_pos = int(parts[4])
        date = datetime.strptime(date_str, "%Y%m%d")
    except (ValueError, IndexError) as e:
        logger.warning(f"Line {line_number}: Invalid flag positions or date", error=str(e))
        return
        
    for pos in range(flag_start_pos, flag_end_pos + 1):
        timestamp = date + timedelta(minutes=(pos-1) * interval_length)
        flag = {
            "nmi": current_nmi,
            "timestamp": timestamp,
            "quality_method": quality_method
        }
        meter_data["quality_flags"].append(flag)
        
        sql = f"""
            UPDATE meter_readings 
            SET is_flagged = TRUE, quality_method = '{quality_method}' 
            WHERE nmi = '{current_nmi}' AND timestamp = '{timestamp.isoformat()}';
        """
        sql_statements.append(sql)

def _generate_sql_file(file_id: int, filename: str, sql_statements: List[str]) -> str:
    """Generate an SQL file with the SQL insert statements."""
    base_name = os.path.splitext(os.path.basename(filename))[0]
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_filename = f"{base_name}_{timestamp}_output.sql"
    
    # Make sure the outputs directory exists
    outputs_dir = os.path.join(settings.upload_dir, "outputs")
    os.makedirs(outputs_dir, exist_ok=True)
    
    output_path = os.path.join(outputs_dir, output_filename)
    
    with open(output_path, 'w') as f:
        f.write("-- Generated SQL insert statements for NEM12 file\n")
        f.write(f"-- Original file: {filename}\n")
        f.write(f"-- Generated at: {datetime.now().isoformat()}\n\n")
        for sql in sql_statements:
            f.write(f"{sql}\n")
    
    logger.info("SQL file generated", file_id=file_id, output_path=output_path, statement_count=len(sql_statements))
    return output_path

def _execute_sql_statements_sync(sql_statements: List[str]):
    """Execute SQL statements in batches using a direct sync approach."""
    try:
        total_batches = (len(sql_statements) + BATCH_SIZE - 1) // BATCH_SIZE
        
        logger.info(f"Executing SQL statements in {total_batches} batches", 
                   statement_count=len(sql_statements), 
                   batch_size=BATCH_SIZE)
        
        for i in range(0, len(sql_statements), BATCH_SIZE):
            batch = sql_statements[i:i + BATCH_SIZE]
            batch_number = i // BATCH_SIZE + 1
            logger.info(f"Executing batch {batch_number}/{total_batches}", 
                       statements_in_batch=len(batch))
            
            execute_many_sync(batch)
        
        logger.info("SQL execution completed successfully", 
                   total_statements=len(sql_statements))
    except Exception as e:
        logger.error("Failed to execute SQL statements", error=str(e))
        raise

def _update_file_status(file_id: int, status: str, sql_output_path: Optional[str] = None, error_message: Optional[str] = None):
    """Update the file upload status in the database."""
    update_sql = f"UPDATE file_uploads SET status = '{status}'"
    if sql_output_path:
        update_sql += f", sql_output_path = '{sql_output_path}'"
    if error_message:
        # Escape single quotes in error message
        error_message = error_message.replace("'", "''")
        update_sql += f", error_message = '{error_message}'"
    update_sql += f" WHERE id = {file_id};"
    
    logger.info("Updating file status in database", file_id=file_id, status=status)
    
    try:
        execute_query_sync(update_sql)
        logger.info("File status updated successfully", file_id=file_id, status=status)
    except Exception as e:
        logger.exception("Failed to update file status", error=str(e), file_id=file_id)

def _cleanup_files(local_file_path: str, sql_file_path: str):
    """Clean up temporary files after processing."""
    try:
        if os.path.exists(local_file_path):
            os.remove(local_file_path)
            logger.info("Local file removed", path=local_file_path)
        
        if os.path.exists(sql_file_path):
            os.remove(sql_file_path)
            logger.info("SQL file removed", path=sql_file_path)
    except Exception as e:
        logger.warning("Failed to clean up temporary files", error=str(e))