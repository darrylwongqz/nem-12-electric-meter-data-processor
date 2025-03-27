"""
WSGI entry point for Railway deployment
"""
import sys
import os

# Add the current directory to Python path
sys.path.insert(0, os.path.dirname(__file__))

from app.main import app

# This enables Railway to find the FastAPI application
application = app 