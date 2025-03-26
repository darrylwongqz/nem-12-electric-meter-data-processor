from fastapi import FastAPI, Request, HTTPException
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse
from app.models import ErrorResponse
from app.logging_config import get_logger, configure_logging, LoggingMiddleware
from app.routes.readings import router as readings_router
from app.db import setup_db
from app.config import get_settings
import uvicorn
from fastapi.middleware.cors import CORSMiddleware
from fastapi.openapi.utils import get_openapi

logger = get_logger(__name__)
settings = get_settings()

configure_logging()

app = FastAPI(
    title="Flo-Energy API",
    description="API for processing and querying NEM12 meter data files",
    version="1.0.0",
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, restrict origins appropriately.
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Add logging middleware
app.middleware("http")(LoggingMiddleware())

# Include routes
app.include_router(
    readings_router,
    prefix=f"{settings.api_prefix}/readings",
    tags=["readings"],
)

# Custom exception handler for validation errors
@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    logger.error("Validation error", errors=exc.errors())
    custom_error = ErrorResponse(
        error="Validation Error",
        detail=str(exc.errors())
    )
    return JSONResponse(
        status_code=422,
        content=custom_error.dict(),
    )

# Custom OpenAPI generation to remove 422 response from docs
def custom_openapi():
    if app.openapi_schema:
        return app.openapi_schema
    openapi_schema = get_openapi(
        title=app.title,
        version=app.version,
        description=app.description,
        routes=app.routes,
    )
    # Remove 422 responses from all paths
    for path in openapi_schema.get("paths", {}).values():
        for method in path.values():
            responses = method.get("responses", {})
            if "422" in responses:
                del responses["422"]
    app.openapi_schema = openapi_schema
    return app.openapi_schema

app.openapi = custom_openapi

@app.get(
    "/health",
    tags=["health"],
    summary="Health Check",
    description="Endpoint to verify that the API is running and healthy.",
    responses={
        200: {
            "description": "Successful health check",
            "content": {
                "application/json": {
                    "example": {"status": "healthy"}
                }
            }
        }
    }
)
async def health_check():
    logger.info("Health check requested")
    return {"status": "healthy"}

@app.on_event("startup")
async def startup_event():
    logger.info("Application startup initiated")
    try:
        await setup_db()
        logger.info("Application startup completed successfully")
    except Exception as e:
        logger.error("Application startup failed", error=str(e))
        raise

if __name__ == "__main__":
    logger.info("Starting application with Uvicorn")
    uvicorn.run("app.main:app", host="0.0.0.0", port=8000, reload=True)