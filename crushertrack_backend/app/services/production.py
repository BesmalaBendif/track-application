from sqlalchemy.orm import Session

from app.models.production import Production
from app.models.project import Project
from app.models.machine import Machine
from app.models.employee import Employee

from app.schemas.production import (
    ProductionCreate,
    ProductionUpdate,
)

from app.services.base_service import BaseService


class ProductionService(BaseService):

    def __init__(self):
        super().__init__(Production)


production_service = ProductionService()


def create_production(
    db: Session,
    production: ProductionCreate,
):
    project = (
        db.query(Project)
        .filter(Project.id == production.project_id)
        .first()
    )

    if not project:
        return None

    machine = (
        db.query(Machine)
        .filter(Machine.id == production.machine_id)
        .first()
    )

    if not machine:
        return None

    employee = (
        db.query(Employee)
        .filter(Employee.id == production.employee_id)
        .first()
    )

    if not employee:
        return None

    db_production = Production(
        **production.model_dump()
    )

    return production_service.create(
        db,
        db_production,
    )


def get_productions(
    db: Session,
):
    return production_service.get_all(db)


def get_production_by_id(
    db: Session,
    production_id: int,
):
    return production_service.get_by_id(
        db,
        production_id,
    )


def get_project_productions(
    db: Session,
    project_id: int,
):
    return (
        db.query(Production)
        .filter(
            Production.project_id == project_id
        )
        .order_by(Production.id.desc())
        .all()
    )


def get_machine_productions(
    db: Session,
    machine_id: int,
):
    return (
        db.query(Production)
        .filter(
            Production.machine_id == machine_id
        )
        .order_by(Production.id.desc())
        .all()
    )


def get_employee_productions(
    db: Session,
    employee_id: int,
):
    return (
        db.query(Production)
        .filter(
            Production.employee_id == employee_id
        )
        .order_by(Production.id.desc())
        .all()
    )


def update_production(
    db: Session,
    production_id: int,
    production: ProductionUpdate,
):
    db_production = production_service.get_by_id(
        db,
        production_id,
    )

    if not db_production:
        return None

    update_data = production.model_dump(
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

    if "employee_id" in update_data:

        employee = (
            db.query(Employee)
            .filter(
                Employee.id == update_data["employee_id"]
            )
            .first()
        )

        if not employee:
            return None

    return production_service.update(
        db,
        db_production,
        update_data,
    )


def delete_production(
    db: Session,
    production_id: int,
):
    db_production = production_service.get_by_id(
        db,
        production_id,
    )

    if not db_production:
        return None

    production_service.delete(
        db,
        db_production,
    )

    return db_production