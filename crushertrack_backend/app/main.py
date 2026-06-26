from fastapi import FastAPI
from sqlalchemy import text

from app.database import engine
from app.routers.machine import router as machine_router
from app.routers.auth import router as auth_router
from app.routers.project import router as project_router
from app.routers.employee import router as employee_router
from app.routers.production import router as production_router
from app.routers.fuel_log import router as fuel_log_router
from app.routers.maintenance import router as maintenance_router
from app.routers.attendance import router as attendance_router
from app.routers.dashboard import router as dashboard_router
from app.routers.notifications import router as notifications_router
from fastapi.middleware.cors import CORSMiddleware
app = FastAPI(
    title="CrusherTrack API",
    version="1.0.0",
)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
# Routers
app.include_router(auth_router)
app.include_router(project_router)
app.include_router(machine_router)
app.include_router(employee_router)
app.include_router(production_router)
app.include_router(fuel_log_router)
app.include_router(maintenance_router)
app.include_router(attendance_router)
app.include_router(dashboard_router)
app.include_router(notifications_router)

@app.get("/")
def root():
    return {
        "message": "CrusherTrack Backend is running!"
    }


@app.get("/test-db")
def test_db():
    try:
        with engine.connect() as connection:
            connection.execute(text("SELECT 1"))

        return {
            "status": "success",
            "message": "Connected to PostgreSQL successfully!"
        }

    except Exception as e:
        return {
            "status": "error",
            "message": str(e),
        }