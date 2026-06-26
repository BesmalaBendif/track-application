from sqlalchemy.orm import Session

from app.models.project import Project
from app.schemas.project import (
    ProjectCreate,
    ProjectUpdate,
)


def create_project(
    db: Session,
    project: ProjectCreate,
):

    db_project = Project(
        name=project.name,
        client=project.client,
        location=project.location,
        description=project.description,
        status=project.status,
        start_date=project.start_date,
        end_date=project.end_date,
    )

    db.add(db_project)
    db.commit()
    db.refresh(db_project)

    return db_project


def get_projects(db: Session):

    return (
        db.query(Project)
        .order_by(Project.id.desc())
        .all()
    )


def get_project_by_id(
    db: Session,
    project_id: int,
):

    return (
        db.query(Project)
        .filter(Project.id == project_id)
        .first()
    )


def update_project(
    db: Session,
    project_id: int,
    project: ProjectUpdate,
):

    db_project = (
        db.query(Project)
        .filter(Project.id == project_id)
        .first()
    )

    if not db_project:
        return None

    update_data = project.model_dump(
        exclude_unset=True
    )

    for key, value in update_data.items():
        setattr(db_project, key, value)

    db.commit()
    db.refresh(db_project)

    return db_project


def delete_project(
    db: Session,
    project_id: int,
):

    db_project = (
        db.query(Project)
        .filter(Project.id == project_id)
        .first()
    )

    if not db_project:
        return None

    db.delete(db_project)
    db.commit()

    return db_project