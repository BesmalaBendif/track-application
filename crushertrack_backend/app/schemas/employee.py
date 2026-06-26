from pydantic import BaseModel, EmailStr
from datetime import date, datetime
from typing import Optional


class EmployeeBase(BaseModel):
    project_id: int
    full_name: str
    phone: str
    email: Optional[EmailStr] = None
    position: str
    salary: float = 0
    hire_date: date
    status: str = "Active"
    address: Optional[str] = None
    emergency_contact: Optional[str] = None
    notes: Optional[str] = None


class EmployeeCreate(EmployeeBase):
    pass


class EmployeeUpdate(BaseModel):
    project_id: Optional[int] = None
    full_name: Optional[str] = None
    phone: Optional[str] = None
    email: Optional[EmailStr] = None
    position: Optional[str] = None
    salary: Optional[float] = None
    hire_date: Optional[date] = None
    status: Optional[str] = None
    address: Optional[str] = None
    emergency_contact: Optional[str] = None
    notes: Optional[str] = None


class EmployeeResponse(EmployeeBase):
    id: int
    created_at: datetime

    class Config:
        from_attributes = True