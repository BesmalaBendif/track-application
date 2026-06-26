from pydantic import BaseModel
from datetime import date, datetime
from typing import Optional


class MaintenanceBase(BaseModel):
    project_id: int
    machine_id: int
    maintenance_date: date
    maintenance_type: str
    description: Optional[str] = None
    labor_cost: float = 0
    parts_cost: float = 0
    service_provider: Optional[str] = None
    next_service_hours: Optional[float] = None
    next_service_date: Optional[date] = None
    status: str = "Completed"
    notes: Optional[str] = None


class MaintenanceCreate(MaintenanceBase):
    pass


class MaintenanceUpdate(BaseModel):
    project_id: Optional[int] = None
    machine_id: Optional[int] = None
    maintenance_date: Optional[date] = None
    maintenance_type: Optional[str] = None
    description: Optional[str] = None
    labor_cost: Optional[float] = None
    parts_cost: Optional[float] = None
    service_provider: Optional[str] = None
    next_service_hours: Optional[float] = None
    next_service_date: Optional[date] = None
    status: Optional[str] = None
    notes: Optional[str] = None


class MaintenanceResponse(MaintenanceBase):
    id: int
    total_cost: float
    created_at: datetime

    class Config:
        from_attributes = True