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


class FuelLog(Base):
    __tablename__ = "fuel_logs"

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

    fuel_date = Column(
        Date,
        nullable=False,
    )

    liters_added = Column(
        Float,
        nullable=False,
    )

    price_per_liter = Column(
        Float,
        nullable=False,
    )

    total_cost = Column(
        Float,
        nullable=False,
    )

    supplier = Column(
        String(150),
        nullable=True,
    )

    receipt_number = Column(
        String(100),
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
        back_populates="fuel_logs",
    )

    machine = relationship(
        "Machine",
        back_populates="fuel_logs",
    )