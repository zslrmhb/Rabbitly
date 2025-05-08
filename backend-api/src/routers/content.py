from fastapi import APIRouter

router = APIRouter()

@router.post("/")
async def execute_code(code: str):
    return {"status": "Code received", "code":code}