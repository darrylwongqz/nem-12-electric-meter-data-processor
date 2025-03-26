import logging
import sys
import structlog
from typing import Dict, Any, Optional

def configure_logging():
    """Configure structured logging for the application."""
    # Set up processor pipeline for structlog
    structlog.configure(
        processors=[
            structlog.contextvars.merge_contextvars,
            structlog.stdlib.filter_by_level,
            structlog.stdlib.add_logger_name,
            structlog.stdlib.add_log_level,
            structlog.stdlib.PositionalArgumentsFormatter(),
            structlog.processors.TimeStamper(fmt="iso"),
            structlog.processors.StackInfoRenderer(),
            structlog.processors.format_exc_info,
            structlog.processors.UnicodeDecoder(),
            structlog.dev.ConsoleRenderer(colors=True)  # Use colored console output for development
        ],
        logger_factory=structlog.stdlib.LoggerFactory(),
        wrapper_class=structlog.stdlib.BoundLogger,
        cache_logger_on_first_use=True,
    )

    # Set up root logger
    root_logger = logging.getLogger()
    root_logger.setLevel(logging.INFO)

    # Remove existing handlers
    for handler in root_logger.handlers[:]:
        root_logger.removeHandler(handler)

    # Add console handler
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setLevel(logging.INFO)
    root_logger.addHandler(console_handler)
    
    # Set uvicorn access log to warning level to reduce noise
    logging.getLogger("uvicorn.access").setLevel(logging.WARNING)
    
    # Set up other loggers
    logging.getLogger("uvicorn").setLevel(logging.INFO)
    logging.getLogger("fastapi").setLevel(logging.INFO)
    
    # Log startup message
    logger = get_logger("app")
    logger.info("Logging configured", log_level="INFO")

def get_logger(name: str):
    """Get a structured logger with the given name."""
    return structlog.get_logger(name)

class LoggingMiddleware:
    """Middleware to add request information to the structured logger context."""
    
    async def __call__(
        self, request: Any, call_next: Any
    ):
        # Clear context for each request
        structlog.contextvars.clear_contextvars()
        
        # Generate a request ID if not provided
        request_id = request.headers.get("X-Request-ID", "-")
        
        # Add request context
        structlog.contextvars.bind_contextvars(
            request_id=request_id,
            method=request.method,
            path=request.url.path,
            client=request.client.host if request.client else "unknown"
        )
        
        # Log request received
        logger = get_logger("http")
        logger.info("Request received")
        
        # Process the request
        response = await call_next(request)
        
        # Add response context
        structlog.contextvars.bind_contextvars(
            status_code=response.status_code,
        )
        
        # Log response sent
        logger.info("Response sent", 
                  status_code=response.status_code,
                  processing_time_ms=None)  # In a real app, you'd calculate this
        
        return response