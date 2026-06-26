from pydantic import BaseModel
from datetime import date, time, datetime
from typing import Optional


class AttendanceBase(BaseModel):
    project_id: int
    employee_id: int
    attendance_date: date
    status: str = "Present"
    check_in: Optional[time] = None
    check_out: Optional[time] = None
    hours_worked: float = 0
    overtime_hours: float = 0
    notes: Optional[str] = None


class AttendanceCreate(AttendanceBase):
    pass


class AttendanceUpdate(BaseModel):
    project_id: Optional[int] = None
    employee_id: Optional[int] = None
    attendance_date: Optional[date] = None
    status: Optional[str] = None
    check_in: Optional[time] = None
    check_out: Optional[time] = None
    hours_worked: Optional[float] = None
    overtime_hours: Optional[float] = None
    notes: Optional[str] = None


class AttendanceResponse(AttendanceBase):
    id: int
    created_at: datetime

    class Config:
        from_attributes = True