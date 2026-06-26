from typing import List

from fastapi import APIRouter
from fastapi import Depends
from fastapi import HTTPException

from sqlalchemy.orm import Session

from app.database import get_db

from app.schemas.maintenance import (
    MaintenanceCreate,
    MaintenanceUpdate,
    MaintenanceResponse,
)

from app.services.maintenance import (
    create_maintenance,
    get_maintenances,
    get_maintenance_by_id,
    get_project_maintenances,
    get_machine_maintenances,
    update_maintenance,
    delete_maintenance,
)

router = APIRouter(
    prefix="/maintenance",
    tags=["Maintenance"],
)


@router.post(
    "/",
    response_model=MaintenanceResponse,
)
def create_new_maintenance(
    maintenance: MaintenanceCreate,
    db: Session = Depends(get_db),
):
    db_maintenance = create_maintenance(
        db,
        maintenance,
    )

    if db_maintenance is None:
        raise HTTPException(
            status_code=404,
            detail="Invalid project, machine, maintenance type or status.",
        )

    return db_maintenance


@router.get(
    "/",
    response_model=List[MaintenanceResponse],
)
def get_all_maintenances(
    db: Session = Depends(get_db),
):
    return get_maintenances(db)


@router.get(
    "/{maintenance_id}",
    response_model=MaintenanceResponse,
)
def get_single_maintenance(
    maintenance_id: int,
    db: Session = Depends(get_db),
):
    maintenance = get_maintenance_by_id(
        db,
        maintenance_id,
    )

    if maintenance is None:
        raise HTTPException(
            status_code=404,
            detail="Maintenance record not found.",
        )

    return maintenance


@router.get(
    "/project/{project_id}",
    response_model=List[MaintenanceResponse],
)
def get_project_records(
    project_id: int,
    db: Session = Depends(get_db),
):
    return get_project_maintenances(
        db,
        project_id,
    )


@router.get(
    "/machine/{machine_id}",
    response_model=List[MaintenanceResponse],
)
def get_machine_records(
    machine_id: int,
    db: Session = Depends(get_db),
):
    return get_machine_maintenances(
        db,
        machine_id,
    )


@router.put(
    "/{maintenance_id}",
    response_model=MaintenanceResponse,
)
def edit_maintenance(
    maintenance_id: int,
    maintenance: MaintenanceUpdate,
    db: Session = Depends(get_db),
):
    updated = update_maintenance(
        db,
        maintenance_id,
        maintenance,
    )

    if updated is None:
        raise HTTPException(
            status_code=404,
            detail="Maintenance record not found or invalid data.",
        )

    return updated


@router.delete(
    "/{maintenance_id}",
)
def remove_maintenance(
    maintenance_id: int,
    db: Session = Depends(get_db),
):
    deleted = delete_maintenance(
        db,
        maintenance_id,
    )

    if deleted is None:
        raise HTTPException(
            status_code=404,
            detail="Maintenance record not found.",
        )

    return {
        "message": "Maintenance record deleted successfully."
    }