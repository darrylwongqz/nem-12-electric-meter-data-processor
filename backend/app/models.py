from pydantic import BaseModel, Field, validator
from typing import List, Optional
from datetime import datetime

class MeterMetadata(BaseModel):
    """Meter metadata from NEM12 200 records."""
    nmi: str = Field(..., description="National Metering Identifier")
    interval_length: int = Field(..., description="Interval length in minutes (5, 15, 30, 60)")
    start_date: datetime = Field(..., description="Start date for readings")
    
    @validator('interval_length')
    def validate_interval_length(cls, v):
        valid_intervals = [5, 15, 30]
        if v not in valid_intervals:
            raise ValueError(f"Interval length must be one of {valid_intervals}")
        return v
    
    @validator('nmi')
    def validate_nmi(cls, v):
        if len(v) != 10:
            raise ValueError("NMI must be 10 characters long")
        return v

class MeterReading(BaseModel):
    """Individual meter reading from NEM12 300 records."""
    nmi: str
    timestamp: datetime
    consumption: float
    is_flagged: bool = False
    quality_method: Optional[str] = None

class MeterReadingsResponse(BaseModel):
    """Response model for meter readings API endpoint."""
    readings: List[MeterReading]
    count: int
    metadata: Optional[MeterMetadata] = None

class FileUploadPayload(BaseModel):
    """Payload model for file upload API endpoint."""
    original_filename: str
    storage_filename: str
    raw_file_url: str

class FileUploadResponse(BaseModel):
    """Response model for file upload API endpoint."""
    file_id: int
    original_filename: str
    status: str
    upload_time: datetime

class FileUploadStatusResponse(BaseModel):
    """Response model for file upload status API endpoint."""
    file_id: int
    original_filename: str
    status: str
    upload_time: datetime
    error_message: Optional[str] = None
    sql_output_path: Optional[str] = None

class ErrorResponse(BaseModel):
    """Response model for API errors."""
    error: str
    detail: Optional[str] = None

class ReadingsStatsResponse(BaseModel):
    """Response model for readings stats API endpoint."""
    total_readings: int
    flagged_readings: int
    total_files: int
    processing_files: int
    completed_files: int
    failed_files: int