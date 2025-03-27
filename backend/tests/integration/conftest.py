import pytest
import asyncio
import os
import tempfile
import json
from unittest.mock import MagicMock, patch
import dotenv
import firebase_admin
from firebase_admin import credentials, firestore, storage

# Load env variables for tests
dotenv.load_dotenv()

# Mock firebase modules before any imports that use them
import sys
sys.modules['firebase_admin'] = MagicMock()
sys.modules['firebase_admin.credentials'] = MagicMock()
sys.modules['firebase_admin.firestore'] = MagicMock()
sys.modules['firebase_admin.storage'] = MagicMock()

# After mocking, import app modules
from app.config import get_settings
from app.db import execute_query_sync, execute_query
from app.services.firestore_service import init_firebase, get_firestore_client

@pytest.fixture(scope="session")
def event_loop():
    """Create an instance of the default event loop for each test case."""
    loop = asyncio.get_event_loop_policy().new_event_loop()
    yield loop
    loop.close()

@pytest.fixture(scope="session")
def mock_settings():
    """Fixture for settings with test configurations."""
    with patch.dict('os.environ', {
        'DATABASE_URL': 'sqlite:///test.db',
        'REDIS_URL': 'redis://localhost:6379/0',
        'API_PREFIX': '/api/v1',
        'IGNORE_FLAGGED': 'False',
        'FIREBASE_CREDENTIALS_JSON': '{"type": "service_account", "project_id": "test-project"}',
        'FIREBASE_STORAGE_BUCKET': 'test-bucket.appspot.com'
    }):
        settings = get_settings()
        yield settings

@pytest.fixture
def mock_firebase():
    """Fixture for mocked Firebase services."""
    # Reset mocks for each test
    sys.modules['firebase_admin'] = MagicMock()
    sys.modules['firebase_admin.credentials'] = MagicMock()
    sys.modules['firebase_admin.firestore'] = MagicMock()
    sys.modules['firebase_admin.storage'] = MagicMock()
    
    firebase_admin = sys.modules['firebase_admin']
    firebase_admin._apps = {}
    
    # Mock credentials
    mock_cert = MagicMock()
    credentials.Certificate.return_value = mock_cert
    
    # Mock Firestore
    mock_doc = MagicMock()
    mock_doc.get.return_value.exists = True
    mock_doc.get.return_value.to_dict.return_value = {
        "id": 123,
        "original_filename": "test.csv",
        "status": "processing"
    }
    
    mock_collection = MagicMock()
    mock_collection.document.return_value = mock_doc
    
    mock_db = MagicMock()
    mock_db.collection.return_value = mock_collection
    
    firestore.client.return_value = mock_db
    
    # Mock Storage
    mock_blob = MagicMock()
    mock_blob.download_to_filename.return_value = None
    mock_blob.upload_from_filename.return_value = None
    mock_blob.public_url = "https://storage.example.com/test.sql"
    
    mock_bucket = MagicMock()
    mock_bucket.blob.return_value = mock_blob
    
    storage.bucket.return_value = mock_bucket
    
    # Mock Firebase initialization
    init_firebase_result = init_firebase()
    assert init_firebase_result is True
    
    return {
        "db": mock_db,
        "bucket": mock_bucket,
        "blob": mock_blob,
        "doc": mock_doc
    }

@pytest.fixture
def mock_db_connection():
    """Fixture for mocked database queries."""
    with patch('app.db.execute_query_sync') as mock_execute_sync:
        with patch('app.db.execute_query') as mock_execute:
            # Configure mock for specific queries
            def mock_execute_query_impl(query, *args, **kwargs):
                if "SELECT original_filename FROM file_uploads" in query:
                    return [{"original_filename": "test.csv"}]
                if "SELECT * FROM meter_readings" in query:
                    return [
                        {"id": 1, "nmi": "NMI123", "timestamp": "2023-01-01T00:00:00", "consumption": 10.5},
                        {"id": 2, "nmi": "NMI123", "timestamp": "2023-01-01T00:30:00", "consumption": 11.2}
                    ]
                return []
            
            mock_execute_sync.side_effect = mock_execute_query_impl
            mock_execute.side_effect = mock_execute_query_impl
            
            yield {
                "sync": mock_execute_sync,
                "async": mock_execute
            }

@pytest.fixture
def mock_temp_dir():
    """Fixture for creating and cleaning up a temporary directory."""
    temp_dir = tempfile.mkdtemp()
    yield temp_dir
    # Clean up
    import shutil
    shutil.rmtree(temp_dir)

@pytest.fixture
def sample_nem12_content():
    """Fixture for sample NEM12 file content."""
    return """100,NEM12,202201010000,COMPANY,METERDATA
200,NMI123,E1,1,E1,N1,01001,kWh,30,20230101
300,20230101,1.5,2.5,3.5,4.5,5.5,6.5,7.5,8.5,9.5,10.5,11.5,12.5,13.5,14.5,15.5,16.5,17.5,18.5,19.5,20.5,21.5,22.5,23.5,24.5,25.5,26.5,27.5,28.5,29.5,30.5,31.5,32.5,33.5,34.5,35.5,36.5,37.5,38.5,39.5,40.5,41.5,42.5,43.5,44.5,45.5,46.5,47.5,48.5,A,,,20230101123000
300,20230102,1.6,2.6,3.6,4.6,5.6,6.6,7.6,8.6,9.6,10.6,11.6,12.6,13.6,14.6,15.6,16.6,17.6,18.6,19.6,20.6,21.6,22.6,23.6,24.6,25.6,26.6,27.6,28.6,29.6,30.6,31.6,32.6,33.6,34.6,35.6,36.6,37.6,38.6,39.6,40.6,41.6,42.6,43.6,44.6,45.6,46.6,47.6,48.6,A,,,20230102123000
900"""

@pytest.fixture
def sample_nem12_file(mock_temp_dir, sample_nem12_content):
    """Fixture for creating a sample NEM12 file."""
    file_path = os.path.join(mock_temp_dir, "test_nem12.csv")
    with open(file_path, "w") as f:
        f.write(sample_nem12_content)
    yield file_path
    if os.path.exists(file_path):
        os.remove(file_path) 