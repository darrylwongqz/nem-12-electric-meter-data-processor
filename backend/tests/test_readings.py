import unittest
from unittest.mock import patch, MagicMock
import asyncio
from datetime import datetime

# Mock the database and other dependencies
class TestReadings(unittest.TestCase):
    """Tests for the readings service."""
    
    def setUp(self):
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
    
    
if __name__ == '__main__':
    unittest.main() 