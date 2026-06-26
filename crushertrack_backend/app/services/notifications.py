from datetime import date

from sqlalchemy.orm import Session

from app.models.machine import Machine
from app.models.maintenance import Maintenance
from app.models.production import Production
from app.models.attendance import Attendance
from app.models.project import Project
def get_low_fuel_notifications(
    db: Session,
    project_id: int | None = None,
):
    notifications = []

    query = db.query(Machine)

    if project_id:
        query = query.filter(
            Machine.project_id == project_id
        )

    machines = query.all()

    for machine in machines:

        if machine.fuel_capacity <= 0:
            continue

        percentage = (
            machine.current_fuel /
            machine.fuel_capacity
        ) * 100

        if percentage <= 15:

            notifications.append({

                "type": "warning",

                "category": "Fuel",

                "title": "Low Fuel",

                "message":
                f"{machine.name} fuel level is only {percentage:.0f}%",

                "action": "machine",

                "action_id": machine.id,
            })

    return notifications
def get_machine_status_notifications(
    db: Session,
    project_id: int | None = None,
):
    notifications = []

    query = db.query(Machine)

    if project_id:
        query = query.filter(
            Machine.project_id == project_id
        )

    machines = query.all()

    for machine in machines:

        if machine.status == "Maintenance":

            notifications.append({

                "type": "warning",

                "category": "Machine",

                "title": "Machine in Maintenance",

                "message":
                f"{machine.name} is under maintenance.",

                "action": "machine",

                "action_id": machine.id,
            })

        elif machine.status == "Out of Service":

            notifications.append({

                "type": "danger",

                "category": "Machine",

                "title": "Machine Out of Service",

                "message":
                f"{machine.name} is out of service.",

                "action": "machine",

                "action_id": machine.id,
            })

    return notifications
from datetime import timedelta
def get_project_notifications(
    db: Session,
):
    notifications = []

    today = date.today()

    projects = db.query(Project).all()

    for project in projects:

        if project.end_date is None:
            continue

        remaining = (
            project.end_date - today
        ).days

        if 0 <= remaining <= 7:

            notifications.append({

                "type": "warning",

                "category": "Project",

                "title": "Project Ending Soon",

                "message":
                f"{project.name} ends in {remaining} days.",

                "action": "project",

                "action_id": project.id,
            })

    return notifications
from datetime import timedelta


def get_maintenance_notifications(
    db: Session,
    project_id: int | None = None,
):
    notifications = []

    today = date.today()

    query = db.query(Maintenance)

    if project_id:
        query = query.filter(
            Maintenance.project_id == project_id
        )

    maintenances = query.all()

    for maintenance in maintenances:

        if maintenance.next_service_date is None:
            continue

        remaining = (
            maintenance.next_service_date - today
        ).days

        if remaining < 0:

            notifications.append({

                "type": "danger",

                "category": "Maintenance",

                "title": "Maintenance Overdue",

                "message":
                f"{maintenance.machine.name} maintenance is overdue.",

                "action": "maintenance",

                "action_id": maintenance.id,
            })

        elif remaining <= 7:

            notifications.append({

                "type": "warning",

                "category": "Maintenance",

                "title": "Maintenance Due Soon",

                "message":
                f"{maintenance.machine.name} maintenance is due in {remaining} days.",

                "action": "maintenance",

                "action_id": maintenance.id,
            })

    return notifications
def get_attendance_notifications(
    db: Session,
    project_id: int | None = None,
):
    notifications = []

    today = date.today()

    query = (
        db.query(Attendance)
        .filter(
            Attendance.attendance_date == today
        )
    )

    if project_id:
        query = query.filter(
            Attendance.project_id == project_id
        )

    attendances = query.all()

    for attendance in attendances:

        if attendance.status == "Absent":

            notifications.append({

                "type": "warning",

                "category": "Attendance",

                "title": "Employee Absent",

                "message":
                f"{attendance.employee.full_name} is absent today.",

                "action": "employee",

                "action_id": attendance.employee.id,
            })

        elif attendance.status == "Leave":

            notifications.append({

                "type": "info",

                "category": "Attendance",

                "title": "Employee On Leave",

                "message":
                f"{attendance.employee.full_name} is on leave.",

                "action": "employee",

                "action_id": attendance.employee.id,
            })

    return notifications
def get_production_notifications(
    db: Session,
    project_id: int | None = None,
):
    notifications = []

    today = date.today()

    projects = db.query(Project).all()

    if project_id:
        projects = [
            p for p in projects
            if p.id == project_id
        ]

    for project in projects:

        count = (
            db.query(Production)
            .filter(
                Production.project_id == project.id,
                Production.production_date == today,
            )
            .count()
        )

        if count == 0:

            notifications.append({

                "type": "warning",

                "category": "Production",

                "title": "No Production",

                "message":
                f"{project.name} has no production recorded today.",

                "action": "project",

                "action_id": project.id,
            })

    return notifications
def get_notifications(
    db: Session,
    project_id: int | None = None,
):
    notifications = []

    notifications.extend(
        get_low_fuel_notifications(
            db,
            project_id,
        )
    )

    notifications.extend(
        get_machine_status_notifications(
            db,
            project_id,
        )
    )

    notifications.extend(
        get_project_notifications(
            db,
        )
    )

    notifications.extend(
        get_maintenance_notifications(
            db,
            project_id,
        )
    )

    notifications.extend(
        get_attendance_notifications(
            db,
            project_id,
        )
    )

    notifications.extend(
        get_production_notifications(
            db,
            project_id,
        )
    )

    notifications.sort(
        key=lambda x: (
            0 if x["type"] == "danger"
            else 1 if x["type"] == "warning"
            else 2
        )
    )

    return {

        "count": len(notifications),

        "notifications": notifications,
    }
