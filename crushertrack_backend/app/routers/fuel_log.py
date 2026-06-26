from typing import List

from fastapi import APIRouter
from fastapi import Depends
from fastapi import HTTPException

from sqlalchemy.orm import Session

from app.database import get_db

from app.schemas.fuel_log import (
    FuelLogCreate,
    FuelLogUpdate,
    FuelLogResponse,
)

from app.services.fuel_log import (
    create_fuel_log,
    get_fuel_logs,
    get_fuel_log_by_id,
    get_project_fuel_logs,
    get_machine_fuel_logs,
    update_fuel_log,
    delete_fuel_log,
)

router = APIRouter(
    prefix="/fuel-logs",
    tags=["Fuel Logs"],
)


@router.post(
    "/",
    response_model=FuelLogResponse,
)
def create_new_fuel_log(
    fuel_log: FuelLogCreate,
    db: Session = Depends(get_db),
):
    db_fuel_log = create_fuel_log(
        db,
        fuel_log,
    )

    if db_fuel_log is None:
        raise HTTPException(
            status_code=404,
            detail="Project or Machine not found.",
        )

    return db_fuel_log


@router.get(
    "/",
    response_model=List[FuelLogResponse],
)
def get_all_fuel_logs(
    db: Session = Depends(get_db),
):
    return get_fuel_logs(db)


@router.get(
    "/{fuel_log_id}",
    response_model=FuelLogResponse,
)
def get_single_fuel_log(
    fuel_log_id: int,
    db: Session = Depends(get_db),
):
    fuel_log = get_fuel_log_by_id(
        db,
        fuel_log_id,
    )

    if fuel_log is None:
        raise HTTPException(
            status_code=404,
            detail="Fuel log not found.",
        )

    return fuel_log


@router.get(
    "/project/{project_id}",
    response_model=List[FuelLogResponse],
)
def get_project_logs(
    project_id: int,
    db: Session = Depends(get_db),
):
    return get_project_fuel_logs(
        db,
        project_id,
    )


@router.get(
    "/machine/{machine_id}",
    response_model=List[FuelLogResponse],
)
def get_machine_logs(
    machine_id: int,
    db: Session = Depends(get_db),
):
    return get_machine_fuel_logs(
        db,
        machine_id,
    )


@router.put(
    "/{fuel_log_id}",
    response_model=FuelLogResponse,
)
def edit_fuel_log(
    fuel_log_id: int,
    fuel_log: FuelLogUpdate,
    db: Session = Depends(get_db),
):
    updated_log = update_fuel_log(
        db,
        fuel_log_id,
        fuel_log,
    )

    if updated_log is None:
        raise HTTPException(
            status_code=404,
            detail="Fuel log, Project or Machine not found.",
        )

    return updated_log


@router.delete(
    "/{fuel_log_id}",
)
def remove_fuel_log(
    fuel_log_id: int,
    db: Session = Depends(get_db),
):
    deleted_log = delete_fuel_log(
        db,
        fuel_log_id,
    )

    if deleted_log is None:
        raise HTTPException(
            status_code=404,
            detail="Fuel log not found.",
        )

    return {
        "message": "Fuel log deleted successfully."
    }