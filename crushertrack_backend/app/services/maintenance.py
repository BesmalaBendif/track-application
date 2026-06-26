from sqlalchemy.orm import Session

from app.models.maintenance import Maintenance
from app.models.project import Project
from app.models.machine import Machine

from app.schemas.maintenance import (
    MaintenanceCreate,
    MaintenanceUpdate,
)

from app.services.base_service import BaseService

from app.core.constants import (
    MAINTENANCE_TYPES,
    MAINTENANCE_STATUS,
)


class MaintenanceService(BaseService):

    def __init__(self):
        super().__init__(Maintenance)


maintenance_service = MaintenanceService()


def create_maintenance(
    db: Session,
    maintenance: MaintenanceCreate,
):
    # Check project
    project = (
        db.query(Project)
        .filter(Project.id == maintenance.project_id)
        .first()
    )

    if not project:
        return None

    # Check machine
    machine = (
        db.query(Machine)
        .filter(Machine.id == maintenance.machine_id)
        .first()
    )

    if not machine:
        return None

    # Make sure the machine belongs to the selected project
    if machine.project_id != maintenance.project_id:
        return None

    # Validate maintenance type
    if maintenance.maintenance_type not in MAINTENANCE_TYPES:
        return None

    # Validate status
    if maintenance.status not in MAINTENANCE_STATUS:
        return None

    db_maintenance = Maintenance(
        project_id=maintenance.project_id,
        machine_id=maintenance.machine_id,
        maintenance_date=maintenance.maintenance_date,
        maintenance_type=maintenance.maintenance_type,
        description=maintenance.description,
        labor_cost=maintenance.labor_cost,
        parts_cost=maintenance.parts_cost,
        total_cost=maintenance.labor_cost + maintenance.parts_cost,
        service_provider=maintenance.service_provider,
        next_service_hours=maintenance.next_service_hours,
        next_service_date=maintenance.next_service_date,
        status=maintenance.status,
        notes=maintenance.notes,
    )

    return maintenance_service.create(
        db,
        db_maintenance,
    )


def get_maintenances(
    db: Session,
):
    return maintenance_service.get_all(db)


def get_maintenance_by_id(
    db: Session,
    maintenance_id: int,
):
    return maintenance_service.get_by_id(
        db,
        maintenance_id,
    )


def get_project_maintenances(
    db: Session,
    project_id: int,
):
    return (
        db.query(Maintenance)
        .filter(
            Maintenance.project_id == project_id
        )
        .order_by(Maintenance.id.desc())
        .all()
    )


def get_machine_maintenances(
    db: Session,
    machine_id: int,
):
    return (
        db.query(Maintenance)
        .filter(
            Maintenance.machine_id == machine_id
        )
        .order_by(Maintenance.id.desc())
        .all()
    )


def update_maintenance(
    db: Session,
    maintenance_id: int,
    maintenance: MaintenanceUpdate,
):
    db_maintenance = maintenance_service.get_by_id(
        db,
        maintenance_id,
    )

    if not db_maintenance:
        return None

    update_data = maintenance.model_dump(
        exclude_unset=True
    )

    # Validate project if changed
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

    # Validate machine if changed
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

    # Validate maintenance type
    if "maintenance_type" in update_data:
        if update_data["maintenance_type"] not in MAINTENANCE_TYPES:
            return None

    # Validate status
    if "status" in update_data:
        if update_data["status"] not in MAINTENANCE_STATUS:
            return None

    # Make sure machine belongs to project
    project_id = update_data.get(
        "project_id",
        db_maintenance.project_id,
    )

    machine_id = update_data.get(
        "machine_id",
        db_maintenance.machine_id,
    )

    machine = (
        db.query(Machine)
        .filter(Machine.id == machine_id)
        .first()
    )

    if machine.project_id != project_id:
        return None

    # Automatically calculate total cost
    labor = update_data.get(
        "labor_cost",
        db_maintenance.labor_cost,
    )

    parts = update_data.get(
        "parts_cost",
        db_maintenance.parts_cost,
    )

    update_data["total_cost"] = labor + parts

    return maintenance_service.update(
        db,
        db_maintenance,
        update_data,
    )


def delete_maintenance(
    db: Session,
    maintenance_id: int,
):
    db_maintenance = maintenance_service.get_by_id(
        db,
        maintenance_id,
    )

    if not db_maintenance:
        return None

    maintenance_service.delete(
        db,
        db_maintenance,
    )

    return db_maintenance