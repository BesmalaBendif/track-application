from pydantic import BaseModel
from datetime import date, datetime
from typing import Optional


class MachineBase(BaseModel):
    project_id: int
    name: str
    machine_code: str
    type: str
    manufacturer: Optional[str] = None
    model: Optional[str] = None
    serial_number: Optional[str] = None
    purchase_date: Optional[date] = None
    status: str = "Running"
    fuel_capacity: float = 0
    current_fuel: float = 0
    working_hours: float = 0
    location: Optional[str] = None
    notes: Optional[str] = None
    is_active: int = 1


class MachineCreate(MachineBase):
    pass


class MachineUpdate(BaseModel):
    project_id: Optional[int] = None
    name: Optional[str] = None
    machine_code: Optional[str] = None
    type: Optional[str] = None
    manufacturer: Optional[str] = None
    model: Optional[str] = None
    serial_number: Optional[str] = None
    purchase_date: Optional[date] = None
    status: Optional[str] = None
    fuel_capacity: Optional[float] = None
    current_fuel: Optional[float] = None
    working_hours: Optional[float] = None
    location: Optional[str] = None
    notes: Optional[str] = None
    is_active: Optional[int] = None


class MachineResponse(MachineBase):
    id: int
    created_at: datetime

    class Config:
        from_attributes = True