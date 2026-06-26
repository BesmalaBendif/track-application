from typing import List

from fastapi import APIRouter
from fastapi import Depends
from fastapi import HTTPException

from sqlalchemy.orm import Session

from app.database import get_db

from app.schemas.project import (
    ProjectCreate,
    ProjectUpdate,
    ProjectResponse,
)

from app.services.project import (
    create_project,
    get_projects,
    get_project_by_id,
    update_project,
    delete_project,
)

router = APIRouter(
    prefix="/projects",
    tags=["Projects"],
)


@router.post(
    "/",
    response_model=ProjectResponse,
)
def create_new_project(
    project: ProjectCreate,
    db: Session = Depends(get_db),
):
    return create_project(db, project)


@router.get(
    "/",
    response_model=List[ProjectResponse],
)
def get_all_projects(
    db: Session = Depends(get_db),
):
    return get_projects(db)


@router.get(
    "/{project_id}",
    response_model=ProjectResponse,
)
def get_single_project(
    project_id: int,
    db: Session = Depends(get_db),
):

    project = get_project_by_id(
        db,
        project_id,
    )

    if project is None:
        raise HTTPException(
            status_code=404,
            detail="Project not found",
        )

    return project


@router.put(
    "/{project_id}",
    response_model=ProjectResponse,
)
def edit_project(
    project_id: int,
    project: ProjectUpdate,
    db: Session = Depends(get_db),
):

    updated_project = update_project(
        db,
        project_id,
        project,
    )

    if updated_project is None:
        raise HTTPException(
            status_code=404,
            detail="Project not found",
        )

    return updated_project


@router.delete(
    "/{project_id}",
)
def remove_project(
    project_id: int,
    db: Session = Depends(get_db),
):

    deleted_project = delete_project(
        db,
        project_id,
    )

    if deleted_project is None:
        raise HTTPException(
            status_code=404,
            detail="Project not found",
        )

    return {
        "message": "Project deleted successfully"
    }