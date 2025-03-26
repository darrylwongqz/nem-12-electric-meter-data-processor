from celery import Celery
from app.config import get_settings

settings = get_settings()

celery_app = Celery(
    "flo-energy",
    broker=settings.redis_url,
    backend=settings.redis_url,
)

celery_app.conf.update(
    task_serializer="json",
    accept_content=["json"],
    result_serializer="json",
    timezone="UTC",
    enable_utc=True,
    worker_concurrency=2,
    task_acks_late=True,
    task_reject_on_worker_lost=True,
    task_track_started=True,
)

celery_app.autodiscover_tasks(["app.tasks"])