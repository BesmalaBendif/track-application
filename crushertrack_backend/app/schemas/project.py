from pydantic import BaseModel
from datetime import date, datetime
from typing import Optional


class ProjectBase(BaseModel):
    name: str
    client: str
    location: str
    description: Optional[str] = None
    status: str = "Active"
    start_date: date
    end_date: Optional[date] = None


class ProjectCreate(ProjectBase):
    pass


class ProjectUpdate(BaseModel):
    name: Optional[str] = None
    client: Optional[str] = None
    location: Optional[str] = None
    description: Optional[str] = None
    status: Optional[str] = None
    start_date: Optional[date] = None
    end_date: Optional[date] = None


class ProjectResponse(ProjectBase):
    id: int
    created_at: datetime

    class Config:
        from_attributes = True