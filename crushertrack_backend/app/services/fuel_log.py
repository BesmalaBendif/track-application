from sqlalchemy.orm import Session

from app.models.fuel_log import FuelLog
from app.models.project import Project
from app.models.machine import Machine

from app.schemas.fuel_log import (
    FuelLogCreate,
    FuelLogUpdate,
)

from app.services.base_service import BaseService


class FuelLogService(BaseService):

    def __init__(self):
        super().__init__(FuelLog)


fuel_log_service = FuelLogService()


def create_fuel_log(
    db: Session,
    fuel_log: FuelLogCreate,
):
    project = (
        db.query(Project)
        .filter(Project.id == fuel_log.project_id)
        .first()
    )

    if not project:
        return None

    machine = (
        db.query(Machine)
        .filter(Machine.id == fuel_log.machine_id)
        .first()
    )

    if not machine:
        return None

    db_fuel_log = FuelLog(
        project_id=fuel_log.project_id,
        machine_id=fuel_log.machine_id,
        fuel_date=fuel_log.fuel_date,
        liters_added=fuel_log.liters_added,
        price_per_liter=fuel_log.price_per_liter,
        total_cost=fuel_log.liters_added * fuel_log.price_per_liter,
        supplier=fuel_log.supplier,
        receipt_number=fuel_log.receipt_number,
        notes=fuel_log.notes,
    )

    return fuel_log_service.create(
        db,
        db_fuel_log,
    )


def get_fuel_logs(
    db: Session,
):
    return fuel_log_service.get_all(db)


def get_fuel_log_by_id(
    db: Session,
    fuel_log_id: int,
):
    return fuel_log_service.get_by_id(
        db,
        fuel_log_id,
    )


def get_project_fuel_logs(
    db: Session,
    project_id: int,
):
    return (
        db.query(FuelLog)
        .filter(
            FuelLog.project_id == project_id
        )
        .order_by(FuelLog.id.desc())
        .all()
    )


def get_machine_fuel_logs(
    db: Session,
    machine_id: int,
):
    return (
        db.query(FuelLog)
        .filter(
            FuelLog.machine_id == machine_id
        )
        .order_by(FuelLog.id.desc())
        .all()
    )


def update_fuel_log(
    db: Session,
    fuel_log_id: int,
    fuel_log: FuelLogUpdate,
):
    db_fuel_log = fuel_log_service.get_by_id(
        db,
        fuel_log_id,
    )

    if not db_fuel_log:
        return None

    update_data = fuel_log.model_dump(
        exclude_unset=True
    )

    if "project_id" in update_data:

        project = (
            db.query(Project)
            .filter(
                Project.id == update_data["project_id"]
            )
            .first()
        )

        if not project:
            return None

    if "machine_id" in update_data:

        machine = (
            db.query(Machine)
            .filter(
                Machine.id == update_data["machine_id"]
            )
            .first()
        )

        if not machine:
            return None

    liters = update_data.get(
        "liters_added",
        db_fuel_log.liters_added,
    )

    price = update_data.get(
        "price_per_liter",
        db_fuel_log.price_per_liter,
    )

    update_data["total_cost"] = liters * price

    return fuel_log_service.update(
        db,
        db_fuel_log,
        update_data,
    )


def delete_fuel_log(
    db: Session,
    fuel_log_id: int,
):
    db_fuel_log = fuel_log_service.get_by_id(
        db,
        fuel_log_id,
    )

    if not db_fuel_log:
        return None

    fuel_log_service.delete(
        db,
        db_fuel_log,
    )

    return db_fuel_log