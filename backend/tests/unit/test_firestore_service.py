import unittest
from unittest.mock import patch, MagicMock, call
import json
import dotenv
import os

# Mock firebase_admin before importing firestore_service
import sys
sys.modules['firebase_admin'] = MagicMock()
sys.modules['firebase_admin.credentials'] = MagicMock()
sys.modules['firebase_admin.firestore'] = MagicMock()

class TestFirestoreService(unittest.TestCase):
    """Tests for the firestore_service module."""
    
    def setUp(self):
        # Load environment variables from .env file
        dotenv.load_dotenv()

        # Setup patches
        self.patches = []
        
        # Mock environment variables for settings
        self.env_patch = patch.dict('os.environ', {
            'DATABASE_URL': 'sqlite:///test.db',
            'REDIS_URL': 'redis://localhost:6379/0',
            'API_PREFIX': '/api/v1',
            'IGNORE_FLAGGED': 'False',
            'FIREBASE_CREDENTIALS_JSON': '{"type": "service_account", "project_id": "test-project"}',
            'FIREBASE_STORAGE_BUCKET': 'test-bucket.appspot.com'
        })
        self.env_patch.start()
        self.patches.append(self.env_patch)
        
        # Reset firebase_admin._apps for each test
        sys.modules['firebase_admin']._apps = {}
    
    def tearDown(self):
        # Stop all patches
        for p in self.patches:
            p.stop()
    
    @patch('app.services.firestore_service.credentials')
    @patch('app.services.firestore_service.firebase_admin')
    @patch('app.services.firestore_service.logger')
    def test_init_firebase_success(self, mock_logger, mock_firebase_admin, mock_credentials):
        """Test successful initialization of Firebase."""
        # Import the function to test
        from app.services.firestore_service import init_firebase
        
        # Reset firebase_admin._apps for this test
        mock_firebase_admin._apps = {}
        
        # Mock credentials.Certificate to return a cert object
        mock_cert = MagicMock()
        mock_credentials.Certificate.return_value = mock_cert
        
        # Call the function
        result = init_firebase()
        
        # Assertions
        self.assertTrue(result)
        mock_credentials.Certificate.assert_called_once_with({"type": "service_account", "project_id": "test-project"})
        mock_firebase_admin.initialize_app.assert_called_once_with(mock_cert, {'storageBucket': 'test-bucket.appspot.com'})
        mock_logger.info.assert_called_with("Firebase app initialized", bucket='test-bucket.appspot.com')
    
    @patch('app.services.firestore_service.credentials')
    @patch('app.services.firestore_service.firebase_admin')
    @patch('app.services.firestore_service.logger')
    def test_init_firebase_already_initialized(self, mock_logger, mock_firebase_admin, mock_credentials):
        """Test initialization when Firebase is already initialized."""
        # Import the function to test
        from app.services.firestore_service import init_firebase
        
        # Simulate already initialized firebase
        mock_firebase_admin._apps = {'[DEFAULT]': MagicMock()}
        
        # Call the function
        result = init_firebase()
        
        # Assertions
        self.assertTrue(result)
        mock_credentials.Certificate.assert_not_called()
        mock_firebase_admin.initialize_app.assert_not_called()
        mock_logger.info.assert_called_with("Firebase app already initialized")
    
    @patch('app.services.firestore_service.credentials')
    @patch('app.services.firestore_service.firebase_admin')
    @patch('app.services.firestore_service.logger')
    def test_init_firebase_missing_env_vars(self, mock_logger, mock_firebase_admin, mock_credentials):
        """Test initialization when environment variables are missing."""
        # Import the function to test
        from app.services.firestore_service import init_firebase
        
        # Mock missing environment variables
        with patch.dict('os.environ', {
            'FIREBASE_CREDENTIALS_JSON': '',
            'FIREBASE_STORAGE_BUCKET': ''
        }, clear=True):
            # Reset settings to pick up the new env vars
            with patch('app.services.firestore_service.settings') as mock_settings:
                mock_settings.firebase_credentials_json = ''
                mock_settings.firebase_storage_bucket = ''
                
                # Call the function
                result = init_firebase()
                
                # Assertions
                self.assertFalse(result)
                mock_credentials.Certificate.assert_not_called()
                mock_firebase_admin.initialize_app.assert_not_called()
                mock_logger.warning.assert_called_with(
                    "FIREBASE_CREDENTIALS_JSON or FIREBASE_STORAGE_BUCKET not set. Firebase functionality will be limited."
                )
    
    @patch('app.services.firestore_service.credentials')
    @patch('app.services.firestore_service.firebase_admin')
    @patch('app.services.firestore_service.logger')
    def test_init_firebase_exception(self, mock_logger, mock_firebase_admin, mock_credentials):
        """Test initialization when an exception occurs."""
        # Import the function to test
        from app.services.firestore_service import init_firebase
        
        # Reset firebase_admin._apps for this test
        mock_firebase_admin._apps = {}
        
        # Mock credentials.Certificate to raise an exception
        mock_credentials.Certificate.side_effect = Exception("Invalid credentials")
        
        # Call the function
        result = init_firebase()
        
        # Assertions
        self.assertFalse(result)
        mock_credentials.Certificate.assert_called_once()
        mock_firebase_admin.initialize_app.assert_not_called()
        mock_logger.error.assert_called()
    
    @patch('app.services.firestore_service.firestore')
    @patch('app.services.firestore_service.init_firebase')
    @patch('app.services.firestore_service.logger')
    def test_get_firestore_client_success(self, mock_logger, mock_init_firebase, mock_firestore):
        """Test getting Firestore client when already initialized."""
        # Import the function to test
        from app.services.firestore_service import get_firestore_client
        
        # Set firebase_initialized to True for this test
        with patch('app.services.firestore_service.firebase_initialized', True):
            # Mock firestore.client to return a client
            mock_client = MagicMock()
            mock_firestore.client.return_value = mock_client
            
            # Call the function
            result = get_firestore_client()
            
            # Assertions
            self.assertEqual(result, mock_client)
            mock_init_firebase.assert_not_called()
            mock_firestore.client.assert_called_once()
    
    @patch('app.services.firestore_service.firestore')
    @patch('app.services.firestore_service.init_firebase')
    @patch('app.services.firestore_service.logger')
    def test_get_firestore_client_not_initialized(self, mock_logger, mock_init_firebase, mock_firestore):
        """Test getting Firestore client when not initialized."""
        # Import the function to test
        from app.services.firestore_service import get_firestore_client
        
        # Set firebase_initialized to False for this test
        with patch('app.services.firestore_service.firebase_initialized', False):
            # Mock init_firebase to return True
            mock_init_firebase.return_value = True
            
            # Mock firestore.client to return a client
            mock_client = MagicMock()
            mock_firestore.client.return_value = mock_client
            
            # Call the function
            result = get_firestore_client()
            
            # Assertions
            self.assertEqual(result, mock_client)
            mock_init_firebase.assert_called_once()
            mock_firestore.client.assert_called_once()
    
    @patch('app.services.firestore_service.firestore')
    @patch('app.services.firestore_service.init_firebase')
    @patch('app.services.firestore_service.logger')
    def test_get_firestore_client_init_failed(self, mock_logger, mock_init_firebase, mock_firestore):
        """Test getting Firestore client when initialization fails."""
        # Import the function to test
        from app.services.firestore_service import get_firestore_client
        
        # Set firebase_initialized to False for this test
        with patch('app.services.firestore_service.firebase_initialized', False):
            # Mock init_firebase to return False
            mock_init_firebase.return_value = False
            
            # Call the function
            result = get_firestore_client()
            
            # Assertions
            self.assertIsNone(result)
            mock_init_firebase.assert_called_once()
            mock_firestore.client.assert_not_called()
            mock_logger.error.assert_called_with("Cannot access Firestore: Firebase initialization failed")
    
    @patch('app.services.firestore_service.firestore')
    @patch('app.services.firestore_service.init_firebase')
    @patch('app.services.firestore_service.logger')
    def test_get_firestore_client_exception(self, mock_logger, mock_init_firebase, mock_firestore):
        """Test getting Firestore client when an exception occurs."""
        # Import the function to test
        from app.services.firestore_service import get_firestore_client
        
        # Set firebase_initialized to True for this test
        with patch('app.services.firestore_service.firebase_initialized', True):
            # Mock firestore.client to raise an exception
            mock_firestore.client.side_effect = Exception("Cannot connect to Firestore")
            
            # Call the function
            result = get_firestore_client()
            
            # Assertions
            self.assertIsNone(result)
            mock_init_firebase.assert_not_called()
            mock_firestore.client.assert_called_once()
            mock_logger.error.assert_called()
    
    @patch('app.services.firestore_service.get_firestore_client')
    @patch('app.services.firestore_service.logger')
    def test_update_file_status_firestore_success(self, mock_logger, mock_get_firestore_client):
        """Test successful update of file status in Firestore."""
        # Import the function to test
        from app.services.firestore_service import update_file_status_firestore
        
        # Mock dependencies
        file_id = 123
        status = "completed"
        sql_output_path = "gs://bucket/path/to/file.sql"
        original_filename = "test.csv"
        
        # Mock Firestore client and document
        mock_doc = MagicMock()
        mock_doc.get.return_value.exists = True
        mock_doc.get.return_value.to_dict.return_value = {
            "id": file_id,
            "original_filename": original_filename,
            "status": "processing"
        }
        
        mock_collection = MagicMock()
        mock_collection.document.return_value = mock_doc
        
        mock_db = MagicMock()
        mock_db.collection.return_value = mock_collection
        
        mock_get_firestore_client.return_value = mock_db
        
        # Call the function
        update_file_status_firestore(
            file_id=file_id,
            status=status,
            sql_output_path=sql_output_path,
            original_filename=original_filename
        )
        
        # Assertions
        mock_get_firestore_client.assert_called_once()
        mock_db.collection.assert_called_once_with("fileUploads")
        mock_collection.document.assert_called_once_with(str(file_id))
        mock_doc.get.assert_called_once()
        
        # Verify set was called with the right data
        mock_doc.set.assert_called_once()
        set_args, set_kwargs = mock_doc.set.call_args
        update_data = set_args[0]
        
        self.assertEqual(update_data["id"], file_id)
        self.assertEqual(update_data["status"], status)
        self.assertEqual(update_data["sql_output_path"], sql_output_path)
        self.assertEqual(update_data["original_filename"], original_filename)
        self.assertEqual(set_kwargs["merge"], True)
        
        mock_logger.info.assert_called_with("Firestore file status updated", file_id=file_id, status=status)
    
    @patch('app.services.firestore_service.get_firestore_client')
    @patch('app.services.firestore_service.logger')
    def test_update_file_status_firestore_no_client(self, mock_logger, mock_get_firestore_client):
        """Test update file status when Firestore client is not available."""
        # Import the function to test
        from app.services.firestore_service import update_file_status_firestore
        
        # Mock get_firestore_client to return None
        mock_get_firestore_client.return_value = None
        
        # Call the function
        update_file_status_firestore(file_id=123, status="completed")
        
        # Assertions
        mock_get_firestore_client.assert_called_once()
        mock_logger.warning.assert_called_with("Skipping Firestore update: Firestore client unavailable")
    
    @patch('app.services.firestore_service.get_firestore_client')
    @patch('app.services.firestore_service.time')
    @patch('app.services.firestore_service.logger')
    def test_update_file_status_firestore_retry(self, mock_logger, mock_time, mock_get_firestore_client):
        """Test retry logic when updating file status in Firestore."""
        # Import the function to test
        from app.services.firestore_service import update_file_status_firestore
        
        # Mock dependencies
        file_id = 123
        status = "completed"
        
        # Mock Firestore client and document
        mock_doc = MagicMock()
        mock_doc.get.return_value.exists = True
        mock_doc.get.return_value.to_dict.return_value = {
            "id": file_id,
            "status": "processing"
        }
        
        # Make set fail first time, succeed second time
        mock_doc.set.side_effect = [Exception("Connection error"), None]
        
        mock_collection = MagicMock()
        mock_collection.document.return_value = mock_doc
        
        mock_db = MagicMock()
        mock_db.collection.return_value = mock_collection
        
        mock_get_firestore_client.return_value = mock_db
        
        # Call the function with retries=2
        update_file_status_firestore(
            file_id=file_id,
            status=status,
            retries=2,
            delay=0.1
        )
        
        # Assertions
        mock_get_firestore_client.assert_called_once()
        self.assertEqual(mock_doc.set.call_count, 2)
        mock_time.sleep.assert_called_once_with(0.1)
        mock_logger.exception.assert_called_once()
        mock_logger.info.assert_called_with("Firestore file status updated", file_id=file_id, status=status)
    
    @patch('app.services.firestore_service.get_firestore_client')
    @patch('app.services.firestore_service.time')
    @patch('app.services.firestore_service.logger')
    def test_update_file_status_firestore_max_retries(self, mock_logger, mock_time, mock_get_firestore_client):
        """Test exceeding max retries when updating file status in Firestore."""
        # Import the function to test
        from app.services.firestore_service import update_file_status_firestore
        
        # Mock dependencies
        file_id = 123
        status = "completed"
        
        # Mock Firestore client and document
        mock_doc = MagicMock()
        mock_doc.get.return_value.exists = True
        mock_doc.get.return_value.to_dict.return_value = {
            "id": file_id,
            "status": "processing"
        }
        
        # Make set always fail
        mock_doc.set.side_effect = Exception("Connection error")
        
        mock_collection = MagicMock()
        mock_collection.document.return_value = mock_doc
        
        mock_db = MagicMock()
        mock_db.collection.return_value = mock_collection
        
        mock_get_firestore_client.return_value = mock_db
        
        # Call the function with retries=2
        with self.assertRaises(Exception) as context:
            update_file_status_firestore(
                file_id=file_id,
                status=status,
                retries=2,
                delay=0.1
            )
        
        # Assertions
        self.assertIn("Failed to update Firestore after 2 attempts", str(context.exception))
        mock_get_firestore_client.assert_called_once()
        self.assertEqual(mock_doc.set.call_count, 2)
        self.assertEqual(mock_time.sleep.call_count, 2)
        self.assertEqual(mock_logger.exception.call_count, 2)
    
    @patch('app.services.firestore_service.get_firestore_client')
    @patch('app.services.firestore_service._get_original_filename_from_database')
    @patch('app.services.firestore_service.logger')
    def test_update_file_status_firestore_get_filename_from_db(self, mock_logger, mock_get_filename, mock_get_firestore_client):
        """Test getting original filename from database when updating file status."""
        # Import the function to test
        from app.services.firestore_service import update_file_status_firestore
        
        # Mock dependencies
        file_id = 123
        status = "completed"
        db_filename = "db_test.csv"
        
        # Mock Firestore client and document
        mock_doc = MagicMock()
        mock_doc.get.return_value.exists = True
        mock_doc.get.return_value.to_dict.return_value = {
            "id": file_id,
            "status": "processing"
        }
        
        mock_collection = MagicMock()
        mock_collection.document.return_value = mock_doc
        
        mock_db = MagicMock()
        mock_db.collection.return_value = mock_collection
        
        mock_get_firestore_client.return_value = mock_db
        
        # Mock get_original_filename_from_database
        mock_get_filename.return_value = db_filename
        
        # Call the function without providing original_filename
        update_file_status_firestore(
            file_id=file_id,
            status=status
        )
        
        # Assertions
        mock_get_firestore_client.assert_called_once()
        mock_get_filename.assert_called_once_with(file_id)
        
        # Verify set was called with the filename from database
        mock_doc.set.assert_called_once()
        set_args, set_kwargs = mock_doc.set.call_args
        update_data = set_args[0]
        
        self.assertEqual(update_data["original_filename"], db_filename)
    
    @patch('app.services.firestore_service.execute_query_sync')
    @patch('app.services.firestore_service.logger')
    def test_get_original_filename_from_database_success(self, mock_logger, mock_execute_query_sync):
        """Test successfully getting original filename from database."""
        # Import the function to test
        from app.services.firestore_service import _get_original_filename_from_database
        
        # Mock dependencies
        file_id = 123
        filename = "test.csv"
        
        # Mock execute_query_sync to return a result
        mock_execute_query_sync.return_value = [{"original_filename": filename}]
        
        # Call the function
        result = _get_original_filename_from_database(file_id)
        
        # Assertions
        self.assertEqual(result, filename)
        mock_execute_query_sync.assert_called_once()
        query = mock_execute_query_sync.call_args[0][0]
        self.assertIn(f"WHERE id = {file_id}", query)
    
    @patch('app.services.firestore_service.execute_query_sync')
    @patch('app.services.firestore_service.logger')
    def test_get_original_filename_from_database_no_result(self, mock_logger, mock_execute_query_sync):
        """Test getting original filename when no result is found."""
        # Import the function to test
        from app.services.firestore_service import _get_original_filename_from_database
        
        # Mock dependencies
        file_id = 123
        
        # Mock execute_query_sync to return an empty result
        mock_execute_query_sync.return_value = []
        
        # Call the function
        result = _get_original_filename_from_database(file_id)
        
        # Assertions
        self.assertIsNone(result)
        mock_execute_query_sync.assert_called_once()
    
    @patch('app.services.firestore_service.execute_query_sync')
    @patch('app.services.firestore_service.logger')
    def test_get_original_filename_from_database_exception(self, mock_logger, mock_execute_query_sync):
        """Test handling exception when getting original filename."""
        # Import the function to test
        from app.services.firestore_service import _get_original_filename_from_database
        
        # Mock dependencies
        file_id = 123
        
        # Mock execute_query_sync to raise an exception
        mock_execute_query_sync.side_effect = Exception("Database error")
        
        # Use builtins import to patch subprocess since it's imported inside the function
        with patch('builtins.__import__', side_effect=lambda name, *args, **kwargs: 
                   MagicMock() if name == 'subprocess' else __import__(name, *args, **kwargs)):
            # Call the function
            result = _get_original_filename_from_database(file_id)
        
        # Assertions
        self.assertIsNone(result)
        mock_execute_query_sync.assert_called_once()
        mock_logger.warning.assert_called()


if __name__ == '__main__':
    unittest.main() 