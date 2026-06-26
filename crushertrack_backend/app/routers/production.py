from typing import List

from fastapi import APIRouter
from fastapi import Depends
from fastapi import HTTPException

from sqlalchemy.orm import Session

from app.database import get_db

from app.schemas.production import (
    ProductionCreate,
    ProductionUpdate,
    ProductionResponse,
)

from app.services.production import (
    create_production,
    get_productions,
    get_production_by_id,
    get_project_productions,
    get_machine_productions,
    get_employee_productions,
    update_production,
    delete_production,
)

router = APIRouter(
    prefix="/production",
    tags=["Production"],
)


@router.post(
    "/",
    response_model=ProductionResponse,
)
def create_new_production(
    production: ProductionCreate,
    db: Session = Depends(get_db),
):
    db_production = create_production(
        db,
        production,
    )

    if db_production is None:
        raise HTTPException(
            status_code=404,
            detail="Project, Machine or Employee not found.",
        )

    return db_production


@router.get(
    "/",
    response_model=List[ProductionResponse],
)
def get_all_productions(
    db: Session = Depends(get_db),
):
    return get_productions(db)


@router.get(
    "/{production_id}",
    response_model=ProductionResponse,
)
def get_single_production(
    production_id: int,
    db: Session = Depends(get_db),
):
    production = get_production_by_id(
        db,
        production_id,
    )

    if production is None:
        raise HTTPException(
            status_code=404,
            detail="Production record not found.",
        )

    return production


@router.get(
    "/project/{project_id}",
    response_model=List[ProductionResponse],
)
def get_project_records(
    project_id: int,
    db: Session = Depends(get_db),
):
    return get_project_productions(
        db,
        project_id,
    )


@router.get(
    "/machine/{machine_id}",
    response_model=List[ProductionResponse],
)
def get_machine_records(
    machine_id: int,
    db: Session = Depends(get_db),
):
    return get_machine_productions(
        db,
        machine_id,
    )


@router.get(
    "/employee/{employee_id}",
    response_model=List[ProductionResponse],
)
def get_employee_records(
    employee_id: int,
    db: Session = Depends(get_db),
):
    return get_employee_productions(
        db,
        employee_id,
    )


@router.put(
    "/{production_id}",
    response_model=ProductionResponse,
)
def edit_production(
    production_id: int,
    production: ProductionUpdate,
    db: Session = Depends(get_db),
):
    updated_production = update_production(
        db,
        production_id,
        production,
    )

    if updated_production is None:
        raise HTTPException(
            status_code=404,
            detail="Production, Project, Machine or Employee not found.",
        )

    return updated_production


@router.delete(
    "/{production_id}",
)
def remove_production(
    production_id: int,
    db: Session = Depends(get_db),
):
    deleted_production = delete_production(
        db,
        production_id,
    )

    if deleted_production is None:
        raise HTTPException(
            status_code=404,
            detail="Production record not found.",
        )

    return {
        "message": "Production record deleted successfully."
    }