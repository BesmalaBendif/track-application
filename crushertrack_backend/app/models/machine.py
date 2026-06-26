from sqlalchemy import Column
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy import Float
from sqlalchemy import Date
from sqlalchemy import DateTime
from sqlalchemy import ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

from app.database import Base


class Machine(Base):
    __tablename__ = "machines"

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

    name = Column(
        String(150),
        nullable=False,
    )

    machine_code = Column(
        String(50),
        unique=True,
        nullable=False,
    )

    type = Column(
        String(100),
        nullable=False,
    )

    manufacturer = Column(
        String(100),
        nullable=True,
    )

    model = Column(
        String(100),
        nullable=True,
    )

    serial_number = Column(
        String(100),
        nullable=True,
    )

    purchase_date = Column(
        Date,
        nullable=True,
    )

    status = Column(
        String(30),
        default="Running",
        nullable=False,
    )

    fuel_capacity = Column(
        Float,
        default=0,
        nullable=False,
    )

    current_fuel = Column(
        Float,
        default=0,
        nullable=False,
    )

    working_hours = Column(
        Float,
        default=0,
        nullable=False,
    )

    location = Column(
        String(150),
        nullable=True,
    )

    notes = Column(
        String(500),
        nullable=True,
    )

    is_active = Column(
        Integer,
        default=1,
        nullable=False,
    )

    created_at = Column(
        DateTime(timezone=True),
        server_default=func.now(),
    )

    # ==========================
    # Relationships
    # ==========================

    project = relationship(
        "Project",
        back_populates="machines",
    )

    productions = relationship(
        "Production",
        back_populates="machine",
        cascade="all, delete-orphan",
    )

    fuel_logs = relationship(
        "FuelLog",
        back_populates="machine",
        cascade="all, delete-orphan",
    )

    maintenances = relationship(
        "Maintenance",
        back_populates="machine",
        cascade="all, delete-orphan",
    )