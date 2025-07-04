from fastapi import FastAPI

app = FastAPI()

@app.get("/health")
async def health():
    return {"status": "ok"}

@app.post("/signup")
async def signup():
    return {"status": "ok"}

@app.post("/login")
async def login():
    return {"status": "ok"}

@app.post("/logout")
async def logout():
    return {"status": "ok"}

# return user information
@app.get("/me")
async def read_user_me():
    return {"status": "ok"}