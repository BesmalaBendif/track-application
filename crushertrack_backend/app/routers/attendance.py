from typing import List

from fastapi import APIRouter
from fastapi import Depends
from fastapi import HTTPException

from sqlalchemy.orm import Session

from app.database import get_db

from app.schemas.attendance import (
    AttendanceCreate,
    AttendanceUpdate,
    AttendanceResponse,
)

from app.services.attendance import (
    create_attendance,
    get_attendances,
    get_attendance_by_id,
    get_project_attendances,
    get_employee_attendances,
    update_attendance,
    delete_attendance,
)

router = APIRouter(
    prefix="/attendance",
    tags=["Attendance"],
)


@router.post(
    "/",
    response_model=AttendanceResponse,
)
def create_new_attendance(
    attendance: AttendanceCreate,
    db: Session = Depends(get_db),
):
    db_attendance = create_attendance(
        db,
        attendance,
    )

    if db_attendance is None:
        raise HTTPException(
            status_code=404,
            detail="Invalid project, employee or attendance status.",
        )

    return db_attendance


@router.get(
    "/",
    response_model=List[AttendanceResponse],
)
def get_all_attendances(
    db: Session = Depends(get_db),
):
    return get_attendances(db)


@router.get(
    "/{attendance_id}",
    response_model=AttendanceResponse,
)
def get_single_attendance(
    attendance_id: int,
    db: Session = Depends(get_db),
):
    attendance = get_attendance_by_id(
        db,
        attendance_id,
    )

    if attendance is None:
        raise HTTPException(
            status_code=404,
            detail="Attendance record not found.",
        )

    return attendance


@router.get(
    "/project/{project_id}",
    response_model=List[AttendanceResponse],
)
def get_project_records(
    project_id: int,
    db: Session = Depends(get_db),
):
    return get_project_attendances(
        db,
        project_id,
    )


@router.get(
    "/employee/{employee_id}",
    response_model=List[AttendanceResponse],
)
def get_employee_records(
    employee_id: int,
    db: Session = Depends(get_db),
):
    return get_employee_attendances(
        db,
        employee_id,
    )


@router.put(
    "/{attendance_id}",
    response_model=AttendanceResponse,
)
def edit_attendance(
    attendance_id: int,
    attendance: AttendanceUpdate,
    db: Session = Depends(get_db),
):
    updated = update_attendance(
        db,
        attendance_id,
        attendance,
    )

    if updated is None:
        raise HTTPException(
            status_code=404,
            detail="Attendance record not found or invalid data.",
        )

    return updated


@router.delete(
    "/{attendance_id}",
)
def remove_attendance(
    attendance_id: int,
    db: Session = Depends(get_db),
):
    deleted = delete_attendance(
        db,
        attendance_id,
    )

    if deleted is None:
        raise HTTPException(
            status_code=404,
            detail="Attendance record not found.",
        )

    return {
        "message": "Attendance record deleted successfully."
    }