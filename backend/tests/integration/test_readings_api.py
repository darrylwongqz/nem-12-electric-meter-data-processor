import pytest
import asyncio
from unittest.mock import patch, MagicMock
from httpx import AsyncClient
from datetime import datetime, timedelta

from app.main import app
from app.models import MeterReading

@pytest.mark.asyncio
async def test_get_readings_by_nmi(mock_db_connection):
    """
    Test getting readings by NMI through the API endpoint.
    """
    # Setup test readings to be returned by the mocked database
    test_nmi = "NMI123"
    test_readings = [
        {"id": 1, "nmi": test_nmi, "timestamp": "2023-01-01T00:00:00", "consumption": 10.5, "interval_length": 30},
        {"id": 2, "nmi": test_nmi, "timestamp": "2023-01-01T00:30:00", "consumption": 11.2, "interval_length": 30}
    ]
    
    # Mock the readings_service.get_readings_by_nmi function
    with patch('app.services.readings_service.get_readings_by_nmi') as mock_get_readings:
        # Set up the mock to return our test readings
        mock_get_readings.return_value = test_readings
        
        # Create a test client
        async with AsyncClient(app=app, base_url="http://test") as client:
            # Make a request to the endpoint
            response = await client.get(f"/api/v1/readings?nmi={test_nmi}")
            
            # Assert the response is as expected
            assert response.status_code == 200
            response_data = response.json()
            assert len(response_data) == 2
            assert response_data[0]["nmi"] == test_nmi
            assert response_data[0]["consumption"] == 10.5
            
            # Verify the service function was called with correct parameters
            mock_get_readings.assert_called_once_with(
                nmi=test_nmi, 
                start_date=None, 
                end_date=None, 
                limit=100, 
                offset=0
            )

@pytest.mark.asyncio
async def test_get_readings_by_nmi_with_date_range(mock_db_connection):
    """
    Test getting readings by NMI with date range filters.
    """
    # Setup test data
    test_nmi = "NMI123"
    start_date = "2023-01-01T00:00:00"
    end_date = "2023-01-02T00:00:00"
    
    # Mock the readings_service.get_readings_by_nmi function
    with patch('app.services.readings_service.get_readings_by_nmi') as mock_get_readings:
        # Set up the mock to return empty results
        mock_get_readings.return_value = []
        
        # Create a test client
        async with AsyncClient(app=app, base_url="http://test") as client:
            # Make a request to the endpoint with date range
            response = await client.get(
                f"/api/v1/readings?nmi={test_nmi}&start_date={start_date}&end_date={end_date}"
            )
            
            # Assert the response is as expected
            assert response.status_code == 200
            response_data = response.json()
            assert isinstance(response_data, list)
            assert len(response_data) == 0
            
            # Verify the service function was called with correct parameters
            mock_get_readings.assert_called_once()
            call_args = mock_get_readings.call_args[1]
            assert call_args["nmi"] == test_nmi
            assert call_args["start_date"] == start_date
            assert call_args["end_date"] == end_date

@pytest.mark.asyncio
async def test_get_readings_by_nmi_invalid_parameters(mock_db_connection):
    """
    Test getting readings with invalid parameters.
    """
    # Create a test client
    async with AsyncClient(app=app, base_url="http://test") as client:
        # Test without NMI parameter (required)
        response = await client.get("/api/v1/readings")
        assert response.status_code == 422  # Unprocessable Entity for invalid parameters
        
        # Test with invalid date format
        response = await client.get("/api/v1/readings?nmi=NMI123&start_date=invalid-date")
        assert response.status_code == 422
        
        # Test with negative limit
        response = await client.get("/api/v1/readings?nmi=NMI123&limit=-10")
        assert response.status_code == 422

@pytest.mark.asyncio
async def test_get_latest_readings(mock_db_connection):
    """
    Test getting the latest readings for multiple NMIs.
    """
    # Setup test data
    test_nmis = ["NMI123", "NMI456"]
    test_readings = {
        "NMI123": {"nmi": "NMI123", "timestamp": "2023-01-01T00:00:00", "consumption": 10.5},
        "NMI456": {"nmi": "NMI456", "timestamp": "2023-01-01T00:30:00", "consumption": 11.2}
    }
    
    # Mock the readings_service.get_latest_readings function
    with patch('app.services.readings_service.get_latest_readings') as mock_get_latest:
        # Set up the mock to return our test readings
        mock_get_latest.return_value = test_readings
        
        # Create a test client
        async with AsyncClient(app=app, base_url="http://test") as client:
            # Make a request to the endpoint
            response = await client.post("/api/v1/readings/latest", json={"nmis": test_nmis})
            
            # Assert the response is as expected
            assert response.status_code == 200
            response_data = response.json()
            assert len(response_data) == 2
            assert response_data["NMI123"]["consumption"] == 10.5
            assert response_data["NMI456"]["consumption"] == 11.2
            
            # Verify the service function was called with correct parameters
            mock_get_latest.assert_called_once_with(test_nmis)

@pytest.mark.asyncio
async def test_get_readings_statistics(mock_db_connection):
    """
    Test getting reading statistics by NMI.
    """
    # Setup test data
    test_nmi = "NMI123"
    test_statistics = {
        "nmi": test_nmi,
        "count": 48,
        "total_consumption": 1152.5,
        "average_consumption": 24.01,
        "min_consumption": 10.5,
        "max_consumption": 40.2,
        "first_reading": "2023-01-01T00:00:00",
        "last_reading": "2023-01-01T23:30:00"
    }
    
    # Mock the readings_service.get_reading_statistics function
    with patch('app.services.readings_service.get_reading_statistics') as mock_get_stats:
        # Set up the mock to return our test statistics
        mock_get_stats.return_value = test_statistics
        
        # Create a test client
        async with AsyncClient(app=app, base_url="http://test") as client:
            # Make a request to the endpoint
            response = await client.get(f"/api/v1/readings/statistics?nmi={test_nmi}")
            
            # Assert the response is as expected
            assert response.status_code == 200
            response_data = response.json()
            assert response_data["nmi"] == test_nmi
            assert response_data["count"] == 48
            assert response_data["total_consumption"] == 1152.5
            assert response_data["average_consumption"] == 24.01
            
            # Verify the service function was called with correct parameters
            mock_get_stats.assert_called_once_with(
                nmi=test_nmi, 
                start_date=None, 
                end_date=None
            ) 