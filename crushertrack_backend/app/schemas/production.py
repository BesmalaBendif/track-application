from pydantic import BaseModel
from datetime import date, datetime
from typing import Optional


class ProductionBase(BaseModel):
    project_id: int
    machine_id: int
    employee_id: int
    work_date: date
    hours_worked: float
    tons_produced: float
    remarks: Optional[str] = None


class ProductionCreate(ProductionBase):
    pass


class ProductionUpdate(BaseModel):
    project_id: Optional[int] = None
    machine_id: Optional[int] = None
    employee_id: Optional[int] = None
    work_date: Optional[date] = None
    hours_worked: Optional[float] = None
    tons_produced: Optional[float] = None
    remarks: Optional[str] = None


class ProductionResponse(ProductionBase):
    id: int
    created_at: datetime

    class Config:
        from_attributes = True