"""
Worker run script for Railway deployment that ensures proper module path resolution.
"""
import os
import sys

# Add the current directory to the Python path
current_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, current_dir)

# Now import can find the app module
from app.tasks.worker import celery_app

if __name__ == "__main__":
    # This imports the Celery CLI to parse arguments and run the worker
    from celery.__main__ import main as celery_main
    
    # Pass arguments to start a worker with our app
    sys.argv = ["celery", "-A", "worker:celery_app", "worker", "--loglevel=info"]
    celery_main() 