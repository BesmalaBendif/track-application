from typing import List

from fastapi import APIRouter
from fastapi import Depends
from fastapi import HTTPException

from sqlalchemy.orm import Session

from app.database import get_db

from app.schemas.employee import (
    EmployeeCreate,
    EmployeeUpdate,
    EmployeeResponse,
)

from app.services.employee import (
    create_employee,
    get_employees,
    get_employee_by_id,
    get_project_employees,
    update_employee,
    delete_employee,
)

router = APIRouter(
    prefix="/employees",
    tags=["Employees"],
)


@router.post(
    "/",
    response_model=EmployeeResponse,
)
def create_new_employee(
    employee: EmployeeCreate,
    db: Session = Depends(get_db),
):
    db_employee = create_employee(
        db,
        employee,
    )

    if db_employee is None:
        raise HTTPException(
            status_code=404,
            detail="Project not found.",
        )

    return db_employee


@router.get(
    "/",
    response_model=List[EmployeeResponse],
)
def get_all_employees(
    db: Session = Depends(get_db),
):
    return get_employees(db)


@router.get(
    "/{employee_id}",
    response_model=EmployeeResponse,
)
def get_single_employee(
    employee_id: int,
    db: Session = Depends(get_db),
):
    employee = get_employee_by_id(
        db,
        employee_id,
    )

    if employee is None:
        raise HTTPException(
            status_code=404,
            detail="Employee not found.",
        )

    return employee


@router.get(
    "/project/{project_id}",
    response_model=List[EmployeeResponse],
)
def get_employees_by_project(
    project_id: int,
    db: Session = Depends(get_db),
):
    return get_project_employees(
        db,
        project_id,
    )


@router.put(
    "/{employee_id}",
    response_model=EmployeeResponse,
)
def edit_employee(
    employee_id: int,
    employee: EmployeeUpdate,
    db: Session = Depends(get_db),
):
    updated_employee = update_employee(
        db,
        employee_id,
        employee,
    )

    if updated_employee is None:
        raise HTTPException(
            status_code=404,
            detail="Employee or Project not found.",
        )

    return updated_employee


@router.delete(
    "/{employee_id}",
)
def remove_employee(
    employee_id: int,
    db: Session = Depends(get_db),
):
    deleted_employee = delete_employee(
        db,
        employee_id,
    )

    if deleted_employee is None:
        raise HTTPException(
            status_code=404,
            detail="Employee not found.",
        )

    return {
        "message": "Employee deleted successfully."
    }