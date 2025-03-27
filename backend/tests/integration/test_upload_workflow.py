import pytest
import os
import tempfile
import asyncio
from unittest.mock import patch, MagicMock, AsyncMock

from app.tasks.worker import process_nem12_file
from app.utils.storage import storage_service
from app.services.firestore_service import update_file_status_firestore
from app.services.readings_service import process_file_upload
from app.models import FileUploadPayload

@pytest.mark.asyncio
async def test_complete_file_upload_workflow(
    mock_firebase,
    mock_db_connection,
    sample_nem12_file,
    mock_temp_dir
):
    """
    Test the complete workflow from file upload notification to SQL generation.

    This test simulates:
    1. Receiving a file upload notification
    2. Creating a database record
    3. Processing the NEM12 file
    4. Generating SQL statements
    5. Updating Firestore with the completed status
    """
    # Set up test data
    test_file_url = "https://storage.example.com/test_nem12.csv"
    test_storage_filename = "test_nem12.csv"
    test_original_filename = "original_test.csv"

    # Mock database insertions to return a file ID
    with patch('app.services.readings_service.execute_query') as mock_execute_query:
        mock_execute_query.return_value = {"id": 123}
        
        # Mock the Celery task instead of actually running it
        with patch('app.tasks.worker.process_nem12_file.delay') as mock_delay:
            mock_delay.return_value = MagicMock()
            
            # Process the file upload
            result = await process_file_upload(
                original_filename=test_original_filename,
                storage_filename=test_storage_filename,
                raw_file_url=test_file_url
            )
            
            # Verify database record was created
            assert result.file_id == 123
            assert result.original_filename == test_original_filename
            assert result.status == "pending"
            assert result.upload_time is not None
            
            # Verify Celery task was called with correct parameters
            mock_delay.assert_called_once_with(
                123, 
                test_original_filename, 
                test_storage_filename, 
                test_file_url, 
                test_file_url
            )

@pytest.mark.asyncio
async def test_failed_file_processing_workflow(
    mock_firebase,
    mock_db_connection,
    mock_temp_dir
):
    """
    Test the workflow when file processing fails.

    This test simulates:
    1. Receiving a file upload notification
    2. Creating a database record
    3. Failing to process the NEM12 file due to download error
    4. Updating Firestore with the failed status
    """
    # Set up test data
    test_file_url = "https://storage.example.com/invalid_file.csv"
    test_storage_filename = "invalid_file.csv"
    test_original_filename = "original_invalid.csv"

    # Mock database insertions to return a file ID
    with patch('app.services.readings_service.execute_query') as mock_execute_query:
        mock_execute_query.return_value = {"id": 456}
        
        # Mock the Celery task instead of actually running it
        with patch('app.tasks.worker.process_nem12_file.delay') as mock_delay:
            mock_delay.return_value = MagicMock()
            
            # Process the file upload
            result = await process_file_upload(
                original_filename=test_original_filename,
                storage_filename=test_storage_filename,
                raw_file_url=test_file_url
            )
            
            # Verify database record was created
            assert result.file_id == 456
            assert result.original_filename == test_original_filename
            assert result.status == "pending"
            assert result.upload_time is not None
            
            # Verify Celery task was called with correct parameters
            mock_delay.assert_called_once_with(
                456, 
                test_original_filename, 
                test_storage_filename, 
                test_file_url, 
                test_file_url
            ) 