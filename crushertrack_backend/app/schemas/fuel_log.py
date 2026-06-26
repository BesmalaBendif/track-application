from pydantic import BaseModel
from datetime import date, datetime
from typing import Optional


class FuelLogBase(BaseModel):
    project_id: int
    machine_id: int
    fuel_date: date
    liters_added: float
    price_per_liter: float
    supplier: Optional[str] = None
    receipt_number: Optional[str] = None
    notes: Optional[str] = None


class FuelLogCreate(FuelLogBase):
    pass


class FuelLogUpdate(BaseModel):
    project_id: Optional[int] = None
    machine_id: Optional[int] = None
    fuel_date: Optional[date] = None
    liters_added: Optional[float] = None
    price_per_liter: Optional[float] = None
    supplier: Optional[str] = None
    receipt_number: Optional[str] = None
    notes: Optional[str] = None


class FuelLogResponse(FuelLogBase):
    id: int
    total_cost: float
    created_at: datetime

    class Config:
        from_attributes = True