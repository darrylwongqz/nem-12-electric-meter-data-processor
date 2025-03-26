import os
import json
import firebase_admin
from firebase_admin import credentials, storage
from typing import BinaryIO
from app.config import get_settings
from app.logging_config import get_logger

logger = get_logger(__name__)
settings = get_settings()

def init_firebase():
    """Initialize Firebase app using credentials from environment variables."""
    firebase_credentials_json = settings.firebase_credentials_json
    bucket_name = settings.firebase_storage_bucket

    if not firebase_credentials_json or not bucket_name:
        raise ValueError("FIREBASE_CREDENTIALS_JSON and FIREBASE_STORAGE_BUCKET must be set in environment variables.")

    firebase_credentials_dict = json.loads(firebase_credentials_json)

    if not firebase_admin._apps:
        cred = credentials.Certificate(firebase_credentials_dict)
        firebase_admin.initialize_app(cred, {'storageBucket': bucket_name})
        logger.info("Firebase app initialized", bucket=bucket_name)
    else:
        logger.info("Firebase app already initialized")

# Initialize Firebase when module is loaded
init_firebase()

class FirebaseStorageService:
    """
    Service to handle file storage using Firebase Storage.
    This version is optimized for our backend workflow—raw files are uploaded directly
    from the frontend, and the backend only handles uploading processed files (e.g., SQL outputs).
    """
    def __init__(self):
        self.bucket = storage.bucket()
        self.upload_dir = settings.upload_dir
        # Ensure the local upload directory and outputs folder exist.
        os.makedirs(self.upload_dir, exist_ok=True)
        os.makedirs(os.path.join(self.upload_dir, "outputs"), exist_ok=True)

    def upload_processed_file(self, local_path: str, filename: str) -> str:
        """
        Upload a processed file (e.g., a generated SQL file) to Firebase Storage.
        The file is stored under the 'uploads/outputs/' folder.
        Returns the public URL of the uploaded file.
        """
        storage_key = f"uploads/outputs/{filename}"
        return self.upload_to_storage(local_path, storage_key)

    def upload_to_storage(self, local_path: str, storage_key: str) -> str:
        """
        Upload a local file to Firebase Storage and return the public URL.
        This method uploads the file, makes it public, and returns its URL.
        """
        blob = self.bucket.blob(storage_key)
        blob.upload_from_filename(local_path)
        blob.make_public()
        storage_uri = blob.public_url
        logger.info("File uploaded to Firebase Storage", storage_uri=storage_uri)
        return storage_uri

    def generate_download_url(self, storage_key: str, expires_in: int = 3600) -> str:
        """
        Generate a signed download URL for a file in Firebase Storage.
        The URL expires after 'expires_in' seconds.
        """
        from datetime import timedelta
        blob = self.bucket.blob(storage_key)
        download_url = blob.generate_signed_url(expiration=timedelta(seconds=expires_in))
        return download_url

# Create and export the storage service instance.
storage_service = FirebaseStorageService()