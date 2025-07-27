from fastapi import FastAPI, APIRouter, Request, HTTPException
from fastapi.responses import JSONResponse, HTMLResponse, RedirectResponse
from fastapi.middleware.cors import CORSMiddleware
import bcrypt
import secrets
from datetime import datetime, timedelta, timezone
from sqlalchemy import select, insert, update, delete
from src.models import users, sessions
from src.database import database

from src.routers import chat, execute, content

app = FastAPI()

# CORS (adjust origin if needed for frontend)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Use specific domain in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.on_event("startup")
async def connect_db():
    await database.connect()

@app.on_event("shutdown")
async def disconnect_db():
    await database.disconnect()

app.include_router(chat.router, prefix="/chat", tags=["Chat"])
app.include_router(execute.router, prefix="/execute", tags=["Execute"])
app.include_router(content.router, prefix="/content", tags=["Content"])

@app.get("/health")
async def health():
    return {"status": "ok", "message": "Hello World"}

# ---------------- login ----------------------------------
def hash_password(plain_password: str) -> str:
    return bcrypt.hashpw(plain_password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')


def verify_password(plain_password: str, hashed_password: str) -> bool:
    return bcrypt.checkpw(plain_password.encode('utf-8'), hashed_password.encode('utf-8'))


async def create_session(user_id: int) -> str:
    session_token = secrets.token_hex(32)
    expires_time = datetime.now(timezone.utc) + timedelta(hours=2)

    existing_session = await database.fetch_one(select(sessions).where(sessions.c.user_id == user_id))

    if existing_session:
        query = update(sessions).where(sessions.c.user_id == user_id).values(
            session_token=session_token, expires_time=expires_time
        )
    else:
        query = insert(sessions).values(
            user_id=user_id, session_token=session_token, expires_time=expires_time
        )

    await database.execute(query)
    return session_token


# ---------------------- Routes ----------------------

@app.post("/signup")
async def signup(request: Request):
    data = await request.json()
    name = data.get("name")
    email = data.get("email")
    password = data.get("password")

    if not all([name, email, password]):
        raise HTTPException(status_code=400, detail="Name, email, and password are required")

    # Check if user already exists
    existing_user = await database.fetch_one(select(users).where(users.c.email == email))
    if existing_user:
        raise HTTPException(status_code=409, detail="User already exists")

    # Hash password and insert new user
    hashed_pw = hash_password(password)
    query = insert(users).values(name=name, email=email, password=hashed_pw)
    user_id = await database.execute(query)

    # Create session and set cookie
    session_token = await create_session(user_id)

    response = JSONResponse({"message": "Signup successful"}, status_code=201)
    response.set_cookie(key="session_token", value=session_token, httponly=True, max_age=7200)
    return response


@app.get("/login", response_class=HTMLResponse)
async def get_login_page(request: Request):
    # TODO: return login page
    pass 


@app.post("/login")
async def login(request: Request):
    data = await request.json()
    email = data.get("email")
    password = data.get("password")

    if not all([email, password]):
        raise HTTPException(status_code=400, detail="Email and password required")

    query = select(users.c.user_id, users.c.password).where(users.c.email == email)
    user = await database.fetch_one(query)

    if not user or not verify_password(password, user.password):
        raise HTTPException(status_code=401, detail="Invalid email or password")

    session_token = await create_session(user.user_id)

    response = JSONResponse({"message": "Login successful"})
    response.set_cookie(key="session_token", value=session_token, httponly=True, max_age=7200)
    return response


@app.post("/logout")
async def logout(request: Request):
    session_token = request.cookies.get("session_token")
    if not session_token:
        raise HTTPException(status_code=401, detail="Unauthorized")

    session = await database.fetch_one(select(sessions).where(sessions.c.session_token == session_token))
    if not session:
        raise HTTPException(status_code=401, detail="Session not found")

    await database.execute(delete(sessions).where(sessions.c.session_token == session_token))

    response = JSONResponse({"message": "Logout successful"})
    response.delete_cookie(key="session_token")
    return response

# return user information
@app.get("/me")
async def read_user_me():
    return {"status": "ok"}
