import pytest
import os
import tempfile
from unittest.mock import patch

from app.tasks.worker import _parse_nem12_file, _process_nmi_metadata, _process_interval_data
from app.models import MeterReading

def test_parse_nem12_file(sample_nem12_file):
    """
    Test parsing a NEM12 file.
    
    This test verifies that the parser can successfully extract readings from a NEM12 file.
    """
    # Parse the sample NEM12 file
    meter_data, sql_statements = _parse_nem12_file(sample_nem12_file)
    
    # Verify the parsed data structure
    assert isinstance(meter_data, dict)
    assert "metadata" in meter_data
    assert "readings" in meter_data
    
    # Check NMI details from metadata
    assert "NMI123" in meter_data["metadata"]
    nmi_data = meter_data["metadata"]["NMI123"]
    assert nmi_data["nmi"] == "NMI123"
    assert nmi_data["interval_length"] == 30  # 30-minute intervals
    
    # Check SQL statements were generated
    assert len(sql_statements) > 0
    
    # Check that we have at least one SQL statement for metadata
    metadata_sql = [sql for sql in sql_statements if "INSERT INTO meter_metadata" in sql]
    assert len(metadata_sql) > 0
    
    # Check that the SQL includes the correct NMI
    assert any("'NMI123'" in sql for sql in sql_statements)

def test_process_readings(sample_nem12_file, mock_db_connection):
    """
    Test processing NEM12 file readings into database format.
    
    This test verifies that readings are properly converted to SQL statements.
    """
    # Parse the sample NEM12 file
    meter_data, sql_statements = _parse_nem12_file(sample_nem12_file)
    
    # Mock the database connection
    with patch('app.tasks.worker.execute_query_sync') as mock_execute:
        # Set up mock to return some data
        mock_execute.return_value = [{"count": 0}]
        
        # Verify the SQL statements were generated
        assert len(sql_statements) > 0
        
        # Check the structure of the SQL statements
        for sql in sql_statements:
            if "INSERT INTO meter_readings" in sql:
                assert "nmi" in sql
                assert "timestamp" in sql
                assert "consumption" in sql
                assert "is_flagged" in sql

def test_parse_nem12_file_with_invalid_content():
    """
    Test parsing an invalid NEM12 file.
    
    This test verifies that the parser handles invalid content gracefully.
    """
    # Create a temporary file with invalid NEM12 content
    with tempfile.NamedTemporaryFile(suffix='.csv', mode='w', delete=False) as f:
        # Write invalid content
        f.write("This is not a valid NEM12 file\n")
        f.write("It's missing the proper structure\n")
        file_path = f.name
    
    try:
        # Parse the invalid file - should parse but return empty data
        meter_data, sql_statements = _parse_nem12_file(file_path)
        
        # The parser should handle invalid files gracefully
        assert len(meter_data["metadata"]) == 0
        assert len(meter_data["readings"]) == 0
        assert len(sql_statements) == 0
    finally:
        # Clean up
        if os.path.exists(file_path):
            os.remove(file_path)

def test_process_nmi_metadata():
    """
    Test processing NMI metadata from a NEM12 record.
    
    This test verifies that NMI metadata is correctly processed.
    """
    # Create test data for a valid NMI metadata record (200 record)
    parts = ["200", "NMI123", "E1", "1", "E1", "N1", "01001", "kWh", "30", "20230101"]
    line_number = 2
    meter_data = {"metadata": {}, "readings": [], "quality_flags": []}
    sql_statements = []
    
    # Process the metadata
    result = _process_nmi_metadata(parts, line_number, meter_data, sql_statements)
    
    # Verify the result
    assert result is True
    assert "NMI123" in meter_data["metadata"]
    assert meter_data["metadata"]["NMI123"]["interval_length"] == 30
    assert len(sql_statements) == 1
    assert "INSERT INTO meter_metadata" in sql_statements[0]
    assert "'NMI123'" in sql_statements[0]

def test_process_nmi_metadata_invalid():
    """
    Test processing invalid NMI metadata.
    
    This test verifies that the parser handles invalid metadata gracefully.
    """
    # Create test data for an invalid NMI metadata record (too few parts)
    parts = ["200", "NMI123"]  # Missing required fields
    line_number = 2
    meter_data = {"metadata": {}, "readings": [], "quality_flags": []}
    sql_statements = []
    
    # Process the metadata - should return False
    result = _process_nmi_metadata(parts, line_number, meter_data, sql_statements)
    
    # Verify the result
    assert result is False
    assert "NMI123" not in meter_data["metadata"]
    assert len(sql_statements) == 0

def test_process_interval_data():
    """
    Test processing interval data from a NEM12 record.
    
    This test verifies that interval data is correctly processed.
    """
    # Setup metadata first
    nmi = "NMI123"
    metadata_parts = ["200", nmi, "E1", "1", "E1", "N1", "01001", "kWh", "30", "20230101"]
    meter_data = {"metadata": {}, "readings": [], "quality_flags": []}
    sql_statements = []
    
    # Process metadata to set up the test
    _process_nmi_metadata(metadata_parts, 2, meter_data, sql_statements)
    
    # Create test data for interval data (300 record)
    # Format: 300,date,value1,value2,...,value48,quality_flag
    interval_parts = ["300", "20230101"]
    # Add 48 values for a day (30-minute intervals)
    for i in range(1, 49):
        interval_parts.append(str(i * 0.5))  # Simple test values
    interval_parts.append("A")  # Quality flag
    
    # Process the interval data
    line_number = 3
    _process_interval_data(interval_parts, line_number, nmi, meter_data, sql_statements)
    
    # Verify results - there should be SQL statements with the interval data
    reading_sql = [sql for sql in sql_statements if "INSERT INTO meter_readings" in sql]
    assert len(reading_sql) > 0
    
    # There should be interval data in the meter_data
    assert len(meter_data["readings"]) > 0 