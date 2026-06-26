from sqlalchemy import Column
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy import Float
from sqlalchemy import Date
from sqlalchemy import DateTime
from sqlalchemy import ForeignKey
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship

from app.database import Base


class Employee(Base):
    __tablename__ = "employees"

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

    full_name = Column(
        String(150),
        nullable=False,
    )

    phone = Column(
        String(30),
        nullable=False,
    )

    email = Column(
        String(150),
        nullable=True,
        unique=True,
    )

    position = Column(
        String(100),
        nullable=False,
    )

    salary = Column(
        Float,
        default=0,
    )

    hire_date = Column(
        Date,
        nullable=False,
    )

    status = Column(
        String(30),
        default="Active",
    )

    address = Column(
        String(250),
        nullable=True,
    )

    emergency_contact = Column(
        String(30),
        nullable=True,
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
    back_populates="employees",
)
    productions = relationship(
    "Production",
    back_populates="employee",
    cascade="all, delete",
)
    attendances = relationship(
    "Attendance",
    back_populates="employee",
    cascade="all, delete-orphan",
)