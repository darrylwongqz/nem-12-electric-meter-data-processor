from fastapi import APIRouter, HTTPException, Query
from pydantic import BaseModel
from typing import Optional
from datetime import datetime

from app.models import (
    MeterReadingsResponse,
    MeterReading,
    MeterMetadata,
    FileUploadResponse,
    FileUploadStatusResponse,
    ErrorResponse,
)
from app.services.readings_service import (
    process_file_upload,
    get_meter_readings,
    get_file_upload_status,
    get_download_url_for_sql_file,
    get_readings_stats,
)
from app.config import get_settings
from app.logging_config import get_logger

router = APIRouter()
logger = get_logger(__name__)
settings = get_settings()

# Payload model for notifying the backend of a raw file upload
class FileUploadPayload(BaseModel):
    """
    Payload for file upload notification.
    
    Attributes:
        original_filename (str): The name of the uploaded file.
        storage_filename (str): The name of the file in Firebase Storage.
        raw_file_url (str): The URL where the raw file is stored in Firebase Storage.
    """
    original_filename: str
    storage_filename: str
    raw_file_url: str

# Response model for readings stats
class ReadingsStatsResponse(BaseModel):
    """Response model for readings stats API endpoint."""
    total_readings: int
    flagged_readings: int

@router.post(
    "/upload",
    response_model=FileUploadResponse,
    status_code=202,
    summary="Notify backend of raw file upload",
    description=(
        "This endpoint notifies the backend that a new raw NEM12 file has been uploaded directly "
        "to cloud storage. The frontend must upload the file directly (e.g., to Firebase Storage) "
        "and then call this endpoint with the filename and raw file URL. The backend will then trigger "
        "processing by fetching the file from the provided URL."
    )
)
async def upload_nem12_file(payload: FileUploadPayload):
    try:
        original_filename = payload.original_filename
        storage_filename = payload.storage_filename
        raw_file_url = payload.raw_file_url
        
        # Process the file by passing the raw file URL instead of file content.
        result = await process_file_upload(original_filename, storage_filename, raw_file_url)
        return result
    except Exception as e:
        logger.exception("File upload processing failed", error=str(e))
        raise HTTPException(
            status_code=500,
            detail=f"Failed to process the file: {str(e)}"
        )

@router.get(
    "/files/{file_id}",
    response_model=FileUploadStatusResponse,
    summary="Get file upload status",
    description="Retrieve the status and metadata of a file upload by file ID."
)
async def get_file_status(file_id: int):
    try:
        result = await get_file_upload_status(file_id)
        return FileUploadStatusResponse(**result)
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        logger.exception("Failed to get file status", error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to get file status: {str(e)}")

@router.get(
    "/readings",
    response_model=MeterReadingsResponse,
    summary="Retrieve meter readings",
    description=(
        "Retrieve meter readings with optional filtering. You can filter by NMI, "
        "start and end dates, and choose whether to include flagged (substituted) readings. "
        "Pagination is supported via 'limit' and 'offset'."
    )
)
async def get_readings(
    nmi: Optional[str] = None,
    start_date: Optional[datetime] = None,
    end_date: Optional[datetime] = None,
    include_flagged: bool = Query(True, description="Include flagged/substituted readings"),
    limit: int = Query(100, ge=1, le=1000),
    offset: int = Query(0, ge=0),
):
    try:
        readings, count, metadata = await get_meter_readings(
            nmi=nmi,
            start_date=start_date,
            end_date=end_date,
            include_flagged=include_flagged,
            limit=limit,
            offset=offset,
        )
        meter_readings = [MeterReading(**r) for r in readings]
        meter_metadata = MeterMetadata(**metadata) if metadata else None
        return MeterReadingsResponse(
            readings=meter_readings,
            count=count,
            metadata=meter_metadata,
        )
    except Exception as e:
        logger.exception("Failed to get readings", error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to get readings: {str(e)}")

@router.get(
    "/files/{file_id}/download",
    summary="Download SQL output file",
    description="Get a download URL for the processed SQL file associated with the file upload ID.",
    responses={
        200: {
            "description": "Successful retrieval of download URL",
            "content": {
                "application/json": {
                    "example": {
                        "download_url": "https://firebasestorage.googleapis.com/v0/b/your-bucket/o/uploads%2Foutputs%2Ffile_output.sql?alt=media&token=..."
                    }
                }
            }
        }
    }
)
async def download_sql_file(file_id: int):
    try:
        download_url = await get_download_url_for_sql_file(file_id)
        return {"download_url": download_url}
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        logger.exception("Failed to get download URL", error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to get download URL: {str(e)}")

@router.get(
    "/stats",
    response_model=ReadingsStatsResponse,
    summary="Get readings statistics",
    description="Get total number of readings and flagged readings."
)
async def get_stats():
    try:
        stats = await get_readings_stats()
        return ReadingsStatsResponse(**stats)
    except Exception as e:
        logger.exception("Failed to get readings stats", error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to get readings stats: {str(e)}")