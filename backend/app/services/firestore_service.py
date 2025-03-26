import time
import json
import firebase_admin
from firebase_admin import credentials, firestore
from app.logging_config import get_logger
from app.db import execute_query_sync
from app.config import get_settings
import os

logger = get_logger(__name__)
settings = get_settings()

def init_firebase():
    """Initialize Firebase app using credentials from environment variables."""
    firebase_credentials_json = settings.firebase_credentials_json
    bucket_name = settings.firebase_storage_bucket

    if not firebase_credentials_json or not bucket_name:
        logger.warning("FIREBASE_CREDENTIALS_JSON or FIREBASE_STORAGE_BUCKET not set. Firebase functionality will be limited.")
        return False

    try:
        firebase_credentials_dict = json.loads(firebase_credentials_json)

        if not firebase_admin._apps:
            cred = credentials.Certificate(firebase_credentials_dict)
            firebase_admin.initialize_app(cred, {'storageBucket': bucket_name})
            logger.info("Firebase app initialized", bucket=bucket_name)
        else:
            logger.info("Firebase app already initialized")
        return True
    except Exception as e:
        logger.error(f"Failed to initialize Firebase: {str(e)}")
        return False

# Initialize Firebase when module is loaded
firebase_initialized = init_firebase()

def get_firestore_client():
    """Get Firestore client, initializing Firebase if needed."""
    if not firebase_initialized:
        if not init_firebase():
            logger.error("Cannot access Firestore: Firebase initialization failed")
            return None
    
    try:
        return firestore.client()
    except Exception as e:
        logger.error(f"Error getting Firestore client: {str(e)}")
        return None

def update_file_status_firestore(
    file_id: int,
    status: str,
    sql_output_path: str = None,
    error_message: str = None,
    original_filename: str = None,
    retries: int = 3,
    delay: float = 2.0
) -> None:
    """
    Update the Firestore document for a given file upload.
    This function attempts the update synchronously with retry logic.
    
    :param file_id: The ID of the file upload.
    :param status: The new status (e.g., 'processing', 'completed', 'failed').
    :param sql_output_path: Optional URI of the generated SQL file.
    :param error_message: Optional error message for a failed status.
    :param original_filename: Optional original filename of the uploaded file.
    :param retries: Number of retry attempts.
    :param delay: Base delay in seconds between retries.
    """
    db = get_firestore_client()
    if not db:
        logger.warning("Skipping Firestore update: Firestore client unavailable")
        return
    
    doc_ref = db.collection("fileUploads").document(str(file_id))
    
    # Get existing document data first
    try:
        doc = doc_ref.get()
        existing_data = doc.to_dict() if doc.exists else {}
    except Exception as e:
        logger.warning(f"Could not get existing document: {e}")
        existing_data = {}
    
    # Prepare update data
    update_data = {
        "id": file_id,
        "status": status,
    }

    # Only set the upload_time when creating the document
    if not existing_data:
        update_data["upload_time"] = firestore.SERVER_TIMESTAMP
    
    # Use provided original_filename first, then existing one, then try getting from database
    if original_filename:
        update_data["original_filename"] = original_filename
    elif "original_filename" in existing_data:
        update_data["original_filename"] = existing_data["original_filename"]
    else:
        db_original_filename = _get_original_filename_from_database(file_id)
        if db_original_filename:
            update_data["original_filename"] = db_original_filename
    
    if sql_output_path:
        update_data["sql_output_path"] = sql_output_path
    if error_message:
        update_data["error_message"] = error_message

    attempt = 0
    while attempt < retries:
        try:
            doc_ref.set(update_data, merge=True)
            logger.info("Firestore file status updated", file_id=file_id, status=status)
            return
        except Exception as e:
            attempt += 1
            logger.exception(
                "Failed to update Firestore (attempt %s of %s)", 
                attempt, retries, error=str(e)
            )
            time.sleep(delay * attempt)
    
    raise Exception(f"Failed to update Firestore after {retries} attempts")

def _get_original_filename_from_database(file_id: int) -> str:
    """Get the original_filename from the database for the given file_id."""
    try:
        query = f"SELECT original_filename FROM file_uploads WHERE id = {file_id}"
        
        try:
            # Use the subprocess-based sync function to avoid event loop issues
            results = execute_query_sync(query)
            if results and isinstance(results, list) and results[0] and 'original_filename' in results[0]:
                return results[0]['original_filename']
        except Exception as e:
            logger.warning(f"Could not get original_filename via execute_query_sync: {e}")
            
            # Fallback to script-based approach for simplicity
            import subprocess
            import sys
            import json
            import tempfile
            
            script = f"""
import asyncio
import asyncpg
import json
from app.config import get_settings

async def get_original_filename():
    settings = get_settings()
    conn = await asyncpg.connect(settings.database_url)
    try:
        result = await conn.fetchrow("SELECT original_filename FROM file_uploads WHERE id = {file_id}")
        if result:
            return {{"success": True, "original_filename": result['original_filename']}}
        return {{"success": True, "original_filename": None}}
    except Exception as e:
        return {{"success": False, "error": str(e)}}
    finally:
        await conn.close()

if __name__ == "__main__":
    print(json.dumps(asyncio.run(get_original_filename())))
            """
            
            with tempfile.NamedTemporaryFile(suffix='.py', mode='w', delete=False) as f:
                f.write(script)
                script_path = f.name
            
            try:
                result = subprocess.run([sys.executable, script_path], 
                                      capture_output=True, text=True, check=True)
                os.unlink(script_path)
                
                output = json.loads(result.stdout.strip())
                if output.get("success") and output.get("original_filename"):
                    return output["original_filename"]
            except Exception as inner_e:
                logger.warning(f"Failed to get original_filename via subprocess: {inner_e}")
                if os.path.exists(script_path):
                    os.unlink(script_path)
            
    except Exception as e:
        logger.warning(f"Could not get original_filename for file_id {file_id}: {e}")
    
    return None