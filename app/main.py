from fastapi import FastAPI

app = FastAPI(
    title="CloudOps Platform",
    description="A practical DevOps learning project",
    version="1.0.0"
)


@app.get("/")
def root():
    return {
        "message": "CloudOps Platform is running!",
        "status": "operational"
    }


@app.get("/health")
def health_check():
    return {"status": "healthy"}