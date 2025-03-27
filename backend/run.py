"""
Run script for Railway deployment that ensures proper module path resolution.
"""
import os
import sys

# Add the current directory to the Python path
current_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, current_dir)

# Now import can find the app module
from app.main import app

if __name__ == "__main__":
    # This file can be run directly for testing
    import uvicorn
    uvicorn.run("run:app", host="0.0.0.0", port=8000, reload=True) 