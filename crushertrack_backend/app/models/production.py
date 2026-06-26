from sqlalchemy import Column
from sqlalchemy import Integer
from sqlalchemy import Float
from sqlalchemy import String
from sqlalchemy import Date
from sqlalchemy import DateTime
from sqlalchemy import ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

from app.database import Base


class Production(Base):
    __tablename__ = "production"

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

    machine_id = Column(
        Integer,
        ForeignKey("machines.id"),
        nullable=False,
    )

    employee_id = Column(
        Integer,
        ForeignKey("employees.id"),
        nullable=False,
    )

    work_date = Column(
        Date,
        nullable=False,
    )

    hours_worked = Column(
        Float,
        nullable=False,
        default=0,
    )

    tons_produced = Column(
        Float,
        nullable=False,
        default=0,
    )

    remarks = Column(
        String(500),
        nullable=True,
    )

    created_at = Column(
        DateTime(timezone=True),
        server_default=func.now(),
    )

    project = relationship(
        "Project",
        back_populates="productions",
    )

    machine = relationship(
        "Machine",
        back_populates="productions",
    )

    employee = relationship(
        "Employee",
        back_populates="productions",
    )