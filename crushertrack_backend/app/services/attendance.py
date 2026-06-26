from sqlalchemy.orm import Session

from app.models.attendance import Attendance
from app.models.project import Project
from app.models.employee import Employee

from app.schemas.attendance import (
    AttendanceCreate,
    AttendanceUpdate,
)

from app.services.base_service import BaseService

from app.core.constants import ATTENDANCE_STATUS


class AttendanceService(BaseService):

    def __init__(self):
        super().__init__(Attendance)


attendance_service = AttendanceService()


def create_attendance(
    db: Session,
    attendance: AttendanceCreate,
):
    # Check project
    project = (
        db.query(Project)
        .filter(Project.id == attendance.project_id)
        .first()
    )

    if not project:
        return None

    # Check employee
    employee = (
        db.query(Employee)
        .filter(Employee.id == attendance.employee_id)
        .first()
    )

    if not employee:
        return None

    # Employee must belong to the selected project
    if employee.project_id != attendance.project_id:
        return None

    # Validate attendance status
    if attendance.status not in ATTENDANCE_STATUS:
        return None

    db_attendance = Attendance(
        **attendance.model_dump()
    )

    return attendance_service.create(
        db,
        db_attendance,
    )


def get_attendances(
    db: Session,
):
    return attendance_service.get_all(db)


def get_attendance_by_id(
    db: Session,
    attendance_id: int,
):
    return attendance_service.get_by_id(
        db,
        attendance_id,
    )


def get_project_attendances(
    db: Session,
    project_id: int,
):
    return (
        db.query(Attendance)
        .filter(
            Attendance.project_id == project_id
        )
        .order_by(Attendance.id.desc())
        .all()
    )


def get_employee_attendances(
    db: Session,
    employee_id: int,
):
    return (
        db.query(Attendance)
        .filter(
            Attendance.employee_id == employee_id
        )
        .order_by(Attendance.id.desc())
        .all()
    )


def update_attendance(
    db: Session,
    attendance_id: int,
    attendance: AttendanceUpdate,
):
    db_attendance = attendance_service.get_by_id(
        db,
        attendance_id,
    )

    if not db_attendance:
        return None

    update_data = attendance.model_dump(
        exclude_unset=True
    )

    project_id = update_data.get(
        "project_id",
        db_attendance.project_id,
    )

    employee_id = update_data.get(
        "employee_id",
        db_attendance.employee_id,
    )

    project = (
        db.query(Project)
        .filter(Project.id == project_id)
        .first()
    )

    if not project:
        return None

    employee = (
        db.query(Employee)
        .filter(Employee.id == employee_id)
        .first()
    )

    if not employee:
        return None

    if employee.project_id != project_id:
        return None

    if "status" in update_data:
        if update_data["status"] not in ATTENDANCE_STATUS:
            return None

    return attendance_service.update(
        db,
        db_attendance,
        update_data,
    )


def delete_attendance(
    db: Session,
    attendance_id: int,
):
    db_attendance = attendance_service.get_by_id(
        db,
        attendance_id,
    )

    if not db_attendance:
        return None

    attendance_service.delete(
        db,
        db_attendance,
    )

    return db_attendance