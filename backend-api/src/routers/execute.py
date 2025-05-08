from fastapi import APIRouter
import json
from pathlib import Path

router = APIRouter()

async def get_lessons_metadata():
    metadata_path = Path("content/metadata.json")
    with open(metadata_path, "r") as f:
        data = json.load(f)
    return data