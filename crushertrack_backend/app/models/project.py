from sqlalchemy import Column
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy import Date
from sqlalchemy import DateTime
from sqlalchemy import Text
from sqlalchemy.sql import func

from app.database import Base
from sqlalchemy.orm import relationship

class Project(Base):
    __tablename__ = "projects"

    id = Column(
        Integer,
        primary_key=True,
        index=True,
    )

    name = Column(
        String(150),
        nullable=False,
    )

    client = Column(
        String(150),
        nullable=False,
    )

    location = Column(
        String(200),
        nullable=False,
    )

    description = Column(
        Text,
        nullable=True,
    )

    status = Column(
        String(30),
        default="Active",
        nullable=False,
    )

    start_date = Column(
        Date,
        nullable=False,
    )

    end_date = Column(
        Date,
        nullable=True,
    )

    created_at = Column(
        DateTime(timezone=True),
        server_default=func.now(),
    )
    machines = relationship(
        "Machine",
        back_populates="project",
        cascade="all, delete",
    )

    employees = relationship(
        "Employee",
        back_populates="project",
    )

    productions = relationship(
        "Production",
        back_populates="project",
        cascade="all, delete",
    )

    fuel_logs = relationship(
        "FuelLog",
        back_populates="project",
        cascade="all, delete",
    )

    maintenances = relationship(
        "Maintenance",
        back_populates="project",
        cascade="all, delete-orphan",
    )

    attendances = relationship(
        "Attendance",
        back_populates="project",
        cascade="all, delete-orphan",
    )
    