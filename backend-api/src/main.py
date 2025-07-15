from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from src.routers import chat, execute, content

app = FastAPI()

<<<<<<< HEAD
# CORS (adjust origin if needed for frontend)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Use specific domain in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(chat.router, prefix="/chat", tags=["Chat"])
app.include_router(execute.router, prefix="/execute", tags=["Execute"])
app.include_router(content.router, prefix="/content", tags=["Content"])


@app.get("/health")
async def health():
    return {"status": "ok","message": "Hello World"}
=======

@app.get("/health")
async def health():
    return {"status": "ok"}
>>>>>>> CYL
