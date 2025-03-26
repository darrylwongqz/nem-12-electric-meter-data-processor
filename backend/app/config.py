from pydantic_settings import BaseSettings
from pydantic import Field
from functools import lru_cache

class Settings(BaseSettings):
    """Application settings loaded from environment variables."""
    # Database settings
    database_url: str = Field(..., env="DATABASE_URL")
    # Redis settings
    redis_url: str = Field(..., env="REDIS_URL")
    # Application settings
    api_prefix: str = Field("/api", env="API_PREFIX")
    ignore_flagged: bool = Field(False, env="IGNORE_FLAGGED")
    # Temporary file storage directory
    upload_dir: str = Field("/tmp/uploads", env="UPLOAD_DIR")
    # Firebase settings
    firebase_credentials_json: str = Field("", env="FIREBASE_CREDENTIALS_JSON")
    firebase_storage_bucket: str = Field("", env="FIREBASE_STORAGE_BUCKET")
    
    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"

@lru_cache()
def get_settings() -> Settings:
    """Get application settings from environment variables with caching."""
    return Settings()