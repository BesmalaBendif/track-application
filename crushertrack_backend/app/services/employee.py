from sqlalchemy.orm import Session

from app.models.employee import Employee
from app.models.project import Project

from app.schemas.employee import (
    EmployeeCreate,
    EmployeeUpdate,
)

from app.services.base_service import BaseService


class EmployeeService(BaseService):

    def __init__(self):
        super().__init__(Employee)


employee_service = EmployeeService()


def create_employee(
    db: Session,
    employee: EmployeeCreate,
):
    project = (
        db.query(Project)
        .filter(Project.id == employee.project_id)
        .first()
    )

    if not project:
        return None

    db_employee = Employee(
        **employee.model_dump()
    )

    return employee_service.create(
        db,
        db_employee,
    )


def get_employees(
    db: Session,
):
    return employee_service.get_all(db)


def get_employee_by_id(
    db: Session,
    employee_id: int,
):
    return employee_service.get_by_id(
        db,
        employee_id,
    )


def get_project_employees(
    db: Session,
    project_id: int,
):
    return (
        db.query(Employee)
        .filter(Employee.project_id == project_id)
        .order_by(Employee.id.desc())
        .all()
    )


def update_employee(
    db: Session,
    employee_id: int,
    employee: EmployeeUpdate,
):
    db_employee = employee_service.get_by_id(
        db,
        employee_id,
    )

    if not db_employee:
        return None

    update_data = employee.model_dump(
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

    return employee_service.update(
        db,
        db_employee,
        update_data,
    )


def delete_employee(
    db: Session,
    employee_id: int,
):
    db_employee = employee_service.get_by_id(
        db,
        employee_id,
    )

    if not db_employee:
        return None

    employee_service.delete(
        db,
        db_employee,
    )

    return db_employee