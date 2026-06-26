from sqlalchemy import Column
from sqlalchemy import Integer
from sqlalchemy import Float
from sqlalchemy import String
from sqlalchemy import Date
from sqlalchemy import Time
from sqlalchemy import DateTime
from sqlalchemy import ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

from app.database import Base


class Attendance(Base):
    __tablename__ = "attendance"

    id = Column(
        Integer,
        primary_key=True,
        index=True,
    )

    project_id = Column(
        Integer,
        ForeignKey("projects.id"),
        nullable=False,
    )

    employee_id = Column(
        Integer,
        ForeignKey("employees.id"),
        nullable=False,
    )

    attendance_date = Column(
        Date,
        nullable=False,
    )

    status = Column(
        String(30),
        default="Present",
        nullable=False,
    )

    check_in = Column(
        Time,
        nullable=True,
    )

    check_out = Column(
        Time,
        nullable=True,
    )

    hours_worked = Column(
        Float,
        default=0,
        nullable=False,
    )

    overtime_hours = Column(
        Float,
        default=0,
        nullable=False,
    )

    notes = Column(
        String(500),
        nullable=True,
    )

    created_at = Column(
        DateTime(timezone=True),
        server_default=func.now(),
    )

    project = relationship(
        "Project",
        back_populates="attendances",
    )

    employee = relationship(
        "Employee",
        back_populates="attendances",
    )