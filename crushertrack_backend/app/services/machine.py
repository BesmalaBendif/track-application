from sqlalchemy.orm import Session

from app.models.machine import Machine
from app.models.project import Project

from app.schemas.machine import (
    MachineCreate,
    MachineUpdate,
)


def create_machine(
    db: Session,
    machine: MachineCreate,
):
    project = (
        db.query(Project)
        .filter(Project.id == machine.project_id)
        .first()
    )

    if not project:
        return None

    db_machine = Machine(
        project_id=machine.project_id,
        name=machine.name,
        machine_code=machine.machine_code,
        type=machine.type,
        manufacturer=machine.manufacturer,
        model=machine.model,
        serial_number=machine.serial_number,
        purchase_date=machine.purchase_date,
        status=machine.status,
        fuel_capacity=machine.fuel_capacity,
        current_fuel=machine.current_fuel,
        working_hours=machine.working_hours,
        location=machine.location,
        notes=machine.notes,
        is_active=machine.is_active,
    )

    db.add(db_machine)
    db.commit()
    db.refresh(db_machine)

    return db_machine


def get_machines(
    db: Session,
):
    return (
        db.query(Machine)
        .filter(Machine.is_active == 1)
        .order_by(Machine.id.desc())
        .all()
    )


def get_machine_by_id(
    db: Session,
    machine_id: int,
):
    return (
        db.query(Machine)
        .filter(
            Machine.id == machine_id,
            Machine.is_active == 1,
        )
        .first()
    )


def get_project_machines(
    db: Session,
    project_id: int,
):
    return (
        db.query(Machine)
        .filter(
            Machine.project_id == project_id,
            Machine.is_active == 1,
        )
        .order_by(Machine.id.desc())
        .all()
    )


def update_machine(
    db: Session,
    machine_id: int,
    machine: MachineUpdate,
):
    db_machine = (
        db.query(Machine)
        .filter(
            Machine.id == machine_id,
            Machine.is_active == 1,
        )
        .first()
    )

    if not db_machine:
        return None

    update_data = machine.model_dump(
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

    for key, value in update_data.items():
        setattr(db_machine, key, value)

    db.commit()
    db.refresh(db_machine)

    return db_machine


def delete_machine(
    db: Session,
    machine_id: int,
):
    db_machine = (
        db.query(Machine)
        .filter(
            Machine.id == machine_id,
            Machine.is_active == 1,
        )
        .first()
    )

    if not db_machine:
        return None

    db_machine.is_active = 0

    db.commit()
    db.refresh(db_machine)

    return db_machine