from typing import List

from fastapi import APIRouter
from fastapi import Depends
from fastapi import HTTPException

from sqlalchemy.orm import Session

from app.database import get_db

from app.schemas.machine import (
    MachineCreate,
    MachineUpdate,
    MachineResponse,
)

from app.services.machine import (
    create_machine,
    get_machines,
    get_machine_by_id,
    get_project_machines,
    update_machine,
    delete_machine,
)

router = APIRouter(
    prefix="/machines",
    tags=["Machines"],
)


@router.post(
    "/",
    response_model=MachineResponse,
)
def create_new_machine(
    machine: MachineCreate,
    db: Session = Depends(get_db),
):
    db_machine = create_machine(db, machine)

    if db_machine is None:
        raise HTTPException(
            status_code=404,
            detail="Project not found.",
        )

    return db_machine


@router.get(
    "/",
    response_model=List[MachineResponse],
)
def get_all_machines(
    db: Session = Depends(get_db),
):
    return get_machines(db)


@router.get(
    "/{machine_id}",
    response_model=MachineResponse,
)
def get_single_machine(
    machine_id: int,
    db: Session = Depends(get_db),
):
    machine = get_machine_by_id(
        db,
        machine_id,
    )

    if machine is None:
        raise HTTPException(
            status_code=404,
            detail="Machine not found.",
        )

    return machine


@router.get(
    "/project/{project_id}",
    response_model=List[MachineResponse],
)
def get_all_project_machines(
    project_id: int,
    db: Session = Depends(get_db),
):
    return get_project_machines(
        db,
        project_id,
    )


@router.put(
    "/{machine_id}",
    response_model=MachineResponse,
)
def edit_machine(
    machine_id: int,
    machine: MachineUpdate,
    db: Session = Depends(get_db),
):
    updated_machine = update_machine(
        db,
        machine_id,
        machine,
    )

    if updated_machine is None:
        raise HTTPException(
            status_code=404,
            detail="Machine or Project not found.",
        )

    return updated_machine


@router.delete(
    "/{machine_id}",
)
def remove_machine(
    machine_id: int,
    db: Session = Depends(get_db),
):
    deleted_machine = delete_machine(
        db,
        machine_id,
    )

    if deleted_machine is None:
        raise HTTPException(
            status_code=404,
            detail="Machine not found.",
        )

    return {
        "message": "Machine deleted successfully."
    }