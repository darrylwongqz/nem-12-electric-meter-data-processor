from typing import List, Dict, Any, Optional, Tuple
from datetime import datetime
import os
import uuid

from app.db import fetch_all, execute_query
from app.utils.storage import storage_service
from app.services.firestore_service import update_file_status_firestore
from app.models import MeterMetadata, MeterReading, FileUploadResponse
from app.tasks.worker import process_nem12_file
from app.config import get_settings
from app.logging_config import get_logger

logger = get_logger(__name__)
settings = get_settings()

async def process_file_upload(original_filename: str, storage_filename: str, raw_file_url: str) -> FileUploadResponse:
    """
    Process an uploaded NEM12 file by creating a file upload record and enqueuing
    a background task to process the file.
    
    This function now expects that the raw file has already been uploaded directly
    to cloud storage (via the frontend) and is accessible via `raw_file_url`.
    """
    logger.info("Processing file upload notification", 
                original_filename=original_filename, 
                storage_filename=storage_filename, 
                raw_file_url=raw_file_url)
    
    # We use the raw_file_url as the storage_path (since the file is already in cloud storage)
    storage_uri = raw_file_url  # Already uploaded by the frontend.
    
    # Create a file upload record in PostgreSQL with the raw file URL.
    file_id = await _create_file_upload_record(original_filename, storage_filename, storage_uri)
    logger.info("File upload record created", file_id=file_id, original_filename=original_filename)
    
    # Update Firestore with the file upload information
    current_time = datetime.now()
    try:
        update_file_status_firestore(
            file_id=file_id,
            status="pending",
            original_filename=original_filename
        )
        logger.info("Firestore updated with file upload information", file_id=file_id)
    except Exception as e:
        logger.warning("Failed to update Firestore, continuing without it", error=str(e))
    
    # Enqueue the background task. The task should now fetch the raw file from the URL.
    # Note: The raw_file_url is passed as the file_path since we no longer have a local path
    process_nem12_file.delay(file_id, original_filename, storage_filename, raw_file_url, storage_uri)
    logger.info("Background task enqueued", file_id=file_id)
    
    return FileUploadResponse(
        file_id=file_id,
        original_filename=original_filename,
        status="pending",
        upload_time=current_time
    )

async def get_file_upload_status(file_id: int) -> Dict[str, Any]:
    """Get the status of a file upload."""
    query = f"""
        SELECT id, original_filename, upload_time, status, error_message, sql_output_path
        FROM file_uploads
        WHERE id = {file_id}
    """
    results = await fetch_all(query)
    if not results:
        raise ValueError(f"File upload with ID {file_id} not found")
    return results[0]

async def get_meter_readings(
    nmi: Optional[str] = None,
    start_date: Optional[datetime] = None,
    end_date: Optional[datetime] = None,
    include_flagged: bool = True,
    limit: int = 100,
    offset: int = 0
) -> Tuple[List[Dict[str, Any]], int, Optional[Dict[str, Any]]]:
    """Get meter readings from the database with optional filtering."""
    where_clauses = []
    if nmi:
        where_clauses.append(f"mr.nmi = '{nmi}'")
    if start_date:
        where_clauses.append(f"mr.timestamp >= '{start_date.isoformat()}'")
    if end_date:
        where_clauses.append(f"mr.timestamp <= '{end_date.isoformat()}'")
    if not include_flagged and not settings.ignore_flagged:
        where_clauses.append("mr.is_flagged = FALSE")
    
    where_clause = " AND ".join(where_clauses) if where_clauses else "1=1"
    
    query = f"""
        SELECT mr.nmi, mr.timestamp, mr.consumption, mr.is_flagged, mr.quality_method
        FROM meter_readings mr
        WHERE {where_clause}
        ORDER BY mr.timestamp DESC
        LIMIT {limit} OFFSET {offset}
    """
    readings = await fetch_all(query)
    
    count_query = f"""
        SELECT COUNT(*) as count
        FROM meter_readings mr
        WHERE {where_clause}
    """
    count_result = await fetch_all(count_query)
    total_count = count_result[0]["count"] if count_result else 0
    
    metadata = None
    if nmi:
        metadata_query = f"""
            SELECT nmi, interval_length, start_date
            FROM meter_metadata
            WHERE nmi = '{nmi}'
        """
        metadata_result = await fetch_all(metadata_query)
        if metadata_result:
            metadata = metadata_result[0]
    
    return readings, total_count, metadata

async def get_download_url_for_sql_file(file_id: int) -> str:
    """Get a download URL for the SQL output file."""
    query = f"""
        SELECT sql_output_path
        FROM file_uploads
        WHERE id = {file_id} AND status = 'completed'
    """
    results = await fetch_all(query)
    if not results or not results[0]["sql_output_path"]:
        raise ValueError(f"SQL output file for upload {file_id} not found or not ready")
    storage_uri = results[0]["sql_output_path"]
    storage_key = storage_uri.split("://", 1)[1]
    download_url = storage_service.generate_download_url(storage_key)
    return download_url

async def _create_file_upload_record(original_filename: str, storage_filename: str, storage_path: str) -> int:
    """Create a record for the file upload in the database."""
    try:
        # Use parameterized query to avoid SQL injection and escaping issues
        query = """
            INSERT INTO file_uploads (original_filename, storage_filename, upload_time, storage_path, status)
            VALUES ($1, $2, NOW(), $3, 'pending')
            RETURNING id
        """
        
        result = await execute_query(query, original_filename, storage_filename, storage_path)
        logger.debug("Database insert result", result=result)
        
        if result and 'id' in result:
            file_id = result['id']
            logger.info("File upload record created with ID", file_id=file_id)
            return file_id
        
        logger.error("Could not get file ID from result", result=result)
        raise ValueError(f"Invalid database response: {result}")
            
    except Exception as e:
        logger.exception("Failed to create file upload record", error=str(e))
        raise

async def get_readings_stats() -> Dict[str, int]:
    """Get total number of readings, flagged readings, and file upload stats."""
    try:
        # Get total readings count
        total_query = """
            SELECT COUNT(*) as count
            FROM meter_readings
        """
        total_result = await fetch_all(total_query)
        total_readings = total_result[0]["count"] if total_result else 0
        
        # Get flagged readings count
        flagged_query = """
            SELECT COUNT(*) as count
            FROM meter_readings
            WHERE is_flagged = TRUE
        """
        flagged_result = await fetch_all(flagged_query)
        flagged_readings = flagged_result[0]["count"] if flagged_result else 0
        
        # Get file upload stats
        file_stats_query = """
            SELECT 
                COUNT(*) as total_files,
                COUNT(*) FILTER (WHERE status = 'processing') as processing_files,
                COUNT(*) FILTER (WHERE status = 'completed') as completed_files,
                COUNT(*) FILTER (WHERE status = 'failed') as failed_files
            FROM file_uploads
        """
        file_stats_result = await fetch_all(file_stats_query)
        file_stats = file_stats_result[0] if file_stats_result else {
            "total_files": 0,
            "processing_files": 0,
            "completed_files": 0,
            "failed_files": 0
        }
        
        return {
            "total_readings": total_readings,
            "flagged_readings": flagged_readings,
            "total_files": file_stats["total_files"],
            "processing_files": file_stats["processing_files"],
            "completed_files": file_stats["completed_files"],
            "failed_files": file_stats["failed_files"]
        }
    except Exception as e:
        logger.exception("Failed to get readings stats", error=str(e))
        raise
