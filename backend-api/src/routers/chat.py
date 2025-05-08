from fastapi import APIRouter, Request

router = APIRouter()

@router.post("/")
async def chat_handler(request: str):
    data = await request.jason()
    return {"response": f"Received prompt: {data.get('prompt')}"}