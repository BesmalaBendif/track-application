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


class Maintenance(Base):
    __tablename__ = "maintenance"

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

    maintenance_date = Column(
        Date,
        nullable=False,
    )

    maintenance_type = Column(
        String(100),
        nullable=False,
    )

    description = Column(
        String(500),
        nullable=True,
    )

    labor_cost = Column(
        Float,
        default=0,
        nullable=False,
    )

    parts_cost = Column(
        Float,
        default=0,
        nullable=False,
    )

    total_cost = Column(
        Float,
        default=0,
        nullable=False,
    )

    service_provider = Column(
        String(150),
        nullable=True,
    )

    next_service_hours = Column(
        Float,
        nullable=True,
    )

    next_service_date = Column(
        Date,
        nullable=True,
    )

    status = Column(
        String(30),
        default="Completed",
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
        back_populates="maintenances",
    )

    machine = relationship(
        "Machine",
        back_populates="maintenances",
    )