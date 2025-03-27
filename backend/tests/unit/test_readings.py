import unittest
from unittest.mock import patch, MagicMock
import asyncio
from datetime import datetime
import os
import dotenv

# Mock the database and other dependencies
class TestReadings(unittest.TestCase):
    """Tests for the readings service."""
    
    def setUp(self):
        # Load environment variables from .env file
        dotenv.load_dotenv()

        # Setup test data
        self.test_nmi = "1234567890"
        self.test_interval = 30
        self.test_start_date = datetime(2023, 1, 1)
        
        # Mock fetch_all function
        self.fetch_all_patcher = patch('app.services.readings_service.fetch_all')
        self.mock_fetch_all = self.fetch_all_patcher.start()
        
        # Mock execute_query function
        self.execute_query_patcher = patch('app.services.readings_service.execute_query')
        self.mock_execute_query = self.execute_query_patcher.start()
        
        # Mock storage service
        self.storage_patcher = patch('app.services.readings_service.storage_service')
        self.mock_storage = self.storage_patcher.start()
    
    def tearDown(self):
        # Stop all patches
        self.fetch_all_patcher.stop()
        self.execute_query_patcher.stop()
        self.storage_patcher.stop()

    
    def test_get_meter_readings(self):
        """Test getting meter readings with filters."""
        from app.services.readings_service import get_meter_readings
        
        # Mock database response
        self.mock_fetch_all.side_effect = [
            [  # Readings
                {
                    "nmi": self.test_nmi,
                    "timestamp": self.test_start_date,
                    "consumption": 123.456,
                    "is_flagged": False,
                    "quality_method": None
                }
            ],
            [{"count": 1}],  # Count
            [  # Metadata
                {
                    "nmi": self.test_nmi,
                    "interval_length": self.test_interval,
                    "start_date": self.test_start_date
                }
            ]
        ]
        
        # Call function and get result
        result = asyncio.run(get_meter_readings(
            nmi=self.test_nmi,
            start_date=self.test_start_date
        ))
        
        # Unpack result
        readings, count, metadata = result
        
        # Assert results
        self.assertEqual(len(readings), 1)
        self.assertEqual(readings[0]["nmi"], self.test_nmi)
        self.assertEqual(count, 1)
        self.assertEqual(metadata["nmi"], self.test_nmi)
        self.assertEqual(metadata["interval_length"], self.test_interval)
    
    def test_get_meter_readings_no_results(self):
        """Test getting meter readings with no results."""
        from app.services.readings_service import get_meter_readings

        # Mock database response for no readings
        self.mock_fetch_all.side_effect = [[], [{"count": 0}], []]

        # Call function and get result
        result = asyncio.run(get_meter_readings(
            nmi=self.test_nmi,
            start_date=self.test_start_date
        ))

        # Unpack result
        readings, count, metadata = result

        # Assert results
        self.assertEqual(len(readings), 0)
        self.assertEqual(count, 0)
        self.assertIsNone(metadata)

    def test_get_meter_readings_with_flagged(self):
        """Test getting meter readings including flagged readings."""
        from app.services.readings_service import get_meter_readings

        # Mock database response including flagged readings
        self.mock_fetch_all.side_effect = [
            [  # Readings
                {
                    "nmi": self.test_nmi,
                    "timestamp": self.test_start_date,
                    "consumption": 123.456,
                    "is_flagged": True,
                    "quality_method": None
                }
            ],
            [{"count": 1}],  # Count
            [  # Metadata
                {
                    "nmi": self.test_nmi,
                    "interval_length": self.test_interval,
                    "start_date": self.test_start_date
                }
            ]
        ]

        # Call function and get result
        result = asyncio.run(get_meter_readings(
            nmi=self.test_nmi,
            start_date=self.test_start_date
        ))

        # Unpack result
        readings, count, metadata = result

        # Assert results
        self.assertEqual(len(readings), 1)
        self.assertTrue(readings[0]["is_flagged"])
        self.assertEqual(count, 1)
        self.assertEqual(metadata["nmi"], self.test_nmi)
        self.assertEqual(metadata["interval_length"], self.test_interval)

    def test_get_meter_readings_invalid_nmi(self):
        """Test getting meter readings with an invalid NMI."""
        from app.services.readings_service import get_meter_readings

        # Mock database response for invalid NMI
        self.mock_fetch_all.side_effect = [[], [{"count": 0}], []]

        # Call function and get result
        result = asyncio.run(get_meter_readings(
            nmi="invalid_nmi",
            start_date=self.test_start_date
        ))

        # Unpack result
        readings, count, metadata = result

        # Assert results
        self.assertEqual(len(readings), 0)
        self.assertEqual(count, 0)
        self.assertIsNone(metadata)

    def test_get_meter_readings_future_start_date(self):
        """Test getting meter readings with a future start date."""
        from app.services.readings_service import get_meter_readings

        # Mock database response for future start date
        self.mock_fetch_all.side_effect = [[], [{"count": 0}], []]

        # Call function and get result
        future_date = datetime(2100, 1, 1)
        result = asyncio.run(get_meter_readings(
            nmi=self.test_nmi,
            start_date=future_date
        ))

        # Unpack result
        readings, count, metadata = result

        # Assert results
        self.assertEqual(len(readings), 0)
        self.assertEqual(count, 0)
        self.assertIsNone(metadata)

    def test_get_meter_readings_empty_database(self):
        """Test getting meter readings with an empty database."""
        from app.services.readings_service import get_meter_readings

        # Mock database response for empty database
        self.mock_fetch_all.side_effect = [[], [{"count": 0}], []]

        # Call function and get result
        result = asyncio.run(get_meter_readings(
            nmi=self.test_nmi,
            start_date=self.test_start_date
        ))

        # Unpack result
        readings, count, metadata = result

        # Assert results
        self.assertEqual(len(readings), 0)
        self.assertEqual(count, 0)
        self.assertIsNone(metadata)

    def test_get_meter_readings_with_pagination(self):
        """Test getting meter readings with pagination."""
        from app.services.readings_service import get_meter_readings
        
        # Setup mock data
        reading1 = {
            "nmi": self.test_nmi,
            "timestamp": self.test_start_date,
            "consumption": 123.456,
            "is_flagged": False,
            "quality_method": None
        }
        reading2 = {
            "nmi": self.test_nmi,
            "timestamp": datetime(2023, 1, 2),
            "consumption": 234.567,
            "is_flagged": False,
            "quality_method": None
        }
        
        # Mock database response for pagination (first page)
        self.mock_fetch_all.side_effect = [
            [reading1],  # First page
            [{"count": 2}],  # Total count
            [  # Metadata
                {
                    "nmi": self.test_nmi,
                    "interval_length": self.test_interval,
                    "start_date": self.test_start_date
                }
            ]
        ]
        
        # Call function and get result for first page
        result = asyncio.run(get_meter_readings(
            nmi=self.test_nmi,
            start_date=self.test_start_date,
            limit=1,
            offset=0
        ))
        
        # Unpack result
        readings, count, metadata = result
        
        # Assert results for first page
        self.assertEqual(len(readings), 1)
        self.assertEqual(readings[0]["consumption"], 123.456)
        self.assertEqual(count, 2)
        
        # Mock database response for pagination (second page)
        self.mock_fetch_all.side_effect = [
            [reading2],  # Second page
            [{"count": 2}],  # Total count
            [  # Metadata
                {
                    "nmi": self.test_nmi,
                    "interval_length": self.test_interval,
                    "start_date": self.test_start_date
                }
            ]
        ]
        
        # Call function and get result for second page
        result = asyncio.run(get_meter_readings(
            nmi=self.test_nmi,
            start_date=self.test_start_date,
            limit=1,
            offset=1
        ))
        
        # Unpack result
        readings, count, metadata = result
        
        # Assert results for second page
        self.assertEqual(len(readings), 1)
        self.assertEqual(readings[0]["consumption"], 234.567)
        self.assertEqual(count, 2)

    def test_get_meter_readings_with_end_date(self):
        """Test getting meter readings with both start and end dates."""
        from app.services.readings_service import get_meter_readings
        
        # Mock database response
        self.mock_fetch_all.side_effect = [
            [  # Readings
                {
                    "nmi": self.test_nmi,
                    "timestamp": self.test_start_date,
                    "consumption": 123.456,
                    "is_flagged": False,
                    "quality_method": None
                }
            ],
            [{"count": 1}],  # Count
            [  # Metadata
                {
                    "nmi": self.test_nmi,
                    "interval_length": self.test_interval,
                    "start_date": self.test_start_date
                }
            ]
        ]
        
        # Call function and get result
        end_date = datetime(2023, 1, 31)
        result = asyncio.run(get_meter_readings(
            nmi=self.test_nmi,
            start_date=self.test_start_date,
            end_date=end_date
        ))
        
        # Unpack result
        readings, count, metadata = result
        
        # Assert results
        self.assertEqual(len(readings), 1)
        self.assertEqual(count, 1)
        
        # Verify that end_date was included in the query
        # Extract the SQL query from mock_fetch_all calls
        args, kwargs = self.mock_fetch_all.call_args_list[0]
        query = args[0]
        self.assertIn(f"mr.timestamp <= '{end_date.isoformat()}'", query)

    def test_get_readings_stats(self):
        """Test getting reading statistics."""
        from app.services.readings_service import get_readings_stats
        
        # Mock database response for stats
        expected_stats = {
            "count": 100
        }
        expected_flagged = {
            "count": 10
        }
        expected_file_stats = {
            "total_files": 5,
            "processing_files": 1,
            "completed_files": 3,
            "failed_files": 1
        }
        
        self.mock_fetch_all.side_effect = [
            [expected_stats],  # Total readings
            [expected_flagged],  # Flagged readings
            [expected_file_stats]  # File upload stats
        ]
        
        # Call function and get result
        result = asyncio.run(get_readings_stats())
        
        # Assert results
        self.assertEqual(result["total_readings"], expected_stats["count"])
        self.assertEqual(result["flagged_readings"], expected_flagged["count"])
        self.assertEqual(result["total_files"], expected_file_stats["total_files"])
        self.assertEqual(result["processing_files"], expected_file_stats["processing_files"])
        self.assertEqual(result["completed_files"], expected_file_stats["completed_files"])
        self.assertEqual(result["failed_files"], expected_file_stats["failed_files"])

    def test_process_file_upload(self):
        """Test processing a file upload."""
        from app.services.readings_service import process_file_upload
        
        # Mock dependencies
        file_id = 123
        original_filename = "test.csv"
        storage_filename = "test_1234567890.csv"
        raw_file_url = "https://storage.example.com/test_1234567890.csv"
        
        # Mock execute_query response
        self.mock_execute_query.return_value = {"id": file_id}
        
        # Mock patch for update_file_status_firestore
        with patch('app.services.readings_service.update_file_status_firestore') as mock_update_firestore:
            # Mock patch for process_nem12_file task
            with patch('app.services.readings_service.process_nem12_file') as mock_process_task:
                # Configure mock
                mock_process_task.delay.return_value = None
                
                # Call function and get result
                result = asyncio.run(process_file_upload(
                    original_filename=original_filename,
                    storage_filename=storage_filename,
                    raw_file_url=raw_file_url
                ))
                
                # Assert results
                self.assertEqual(result.file_id, file_id)
                self.assertEqual(result.original_filename, original_filename)
                self.assertEqual(result.status, "pending")
                
                # Verify that update_file_status_firestore was called
                mock_update_firestore.assert_called_once_with(
                    file_id=file_id,
                    status="pending",
                    original_filename=original_filename
                )
                
                # Verify that process_nem12_file.delay was called
                mock_process_task.delay.assert_called_once_with(
                    file_id, original_filename, storage_filename, raw_file_url, raw_file_url
                )

    def test_get_download_url_for_sql_file(self):
        """Test getting a download URL for an SQL file."""
        from app.services.readings_service import get_download_url_for_sql_file
        
        # Mock dependencies
        file_id = 123
        storage_uri = "gs://bucket/path/to/file.sql"
        download_url = "https://storage.googleapis.com/bucket/path/to/file.sql?token=abc"
        
        # Mock fetch_all response
        self.mock_fetch_all.return_value = [{"sql_output_path": storage_uri}]
        
        # Mock storage_service.generate_download_url
        self.mock_storage.generate_download_url.return_value = download_url
        
        # Call function and get result
        result = asyncio.run(get_download_url_for_sql_file(file_id))
        
        # Assert results
        self.assertEqual(result, download_url)
        
        # Verify that storage_service.generate_download_url was called
        self.mock_storage.generate_download_url.assert_called_once_with("bucket/path/to/file.sql")
        
    def test_get_download_url_for_sql_file_not_found(self):
        """Test getting a download URL for a non-existent SQL file."""
        from app.services.readings_service import get_download_url_for_sql_file
        
        # Mock dependencies
        file_id = 999
        
        # Mock fetch_all response for non-existent file
        self.mock_fetch_all.return_value = []
        
        # Call function and expect exception
        with self.assertRaises(ValueError) as context:
            asyncio.run(get_download_url_for_sql_file(file_id))
        
        # Assert exception message
        self.assertIn(f"SQL output file for upload {file_id} not found", str(context.exception))

    def test_get_file_upload_status(self):
        """Test getting the status of a file upload."""
        from app.services.readings_service import get_file_upload_status
        
        # Mock dependencies
        file_id = 123
        expected_result = {
            "id": file_id,
            "original_filename": "test.csv",
            "upload_time": datetime.now(),
            "status": "completed",
            "error_message": None,
            "sql_output_path": "gs://bucket/path/to/file.sql"
        }
        
        # Mock fetch_all response
        self.mock_fetch_all.return_value = [expected_result]
        
        # Call function and get result
        result = asyncio.run(get_file_upload_status(file_id))
        
        # Assert results
        self.assertEqual(result, expected_result)
        
    def test_get_file_upload_status_not_found(self):
        """Test getting the status of a non-existent file upload."""
        from app.services.readings_service import get_file_upload_status
        
        # Mock dependencies
        file_id = 999
        
        # Mock fetch_all response for non-existent file
        self.mock_fetch_all.return_value = []
        
        # Call function and expect exception
        with self.assertRaises(ValueError) as context:
            asyncio.run(get_file_upload_status(file_id))
        
        # Assert exception message
        self.assertIn(f"File upload with ID {file_id} not found", str(context.exception))

if __name__ == '__main__':
    unittest.main() 