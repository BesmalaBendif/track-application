from datetime import date
from sqlalchemy import func
from sqlalchemy.orm import Session

from app.models.project import Project
from app.models.machine import Machine
from app.models.employee import Employee
from app.models.production import Production
from app.models.fuel_log import FuelLog
from app.models.maintenance import Maintenance
from app.models.attendance import Attendance
from sqlalchemy.orm import joinedload


def get_overview(
    db: Session,
    project_id: int | None = None,
):
    project_query = db.query(Project)
    machine_query = db.query(Machine)
    employee_query = db.query(Employee)

    if project_id:
        project_query = project_query.filter(Project.id == project_id)
        machine_query = machine_query.filter(Machine.project_id == project_id)
        employee_query = employee_query.filter(Employee.project_id == project_id)

    return {
        "total_projects": project_query.count(),
        "total_machines": machine_query.count(),
        "total_employees": employee_query.count(),
        "running_projects": project_query.filter(
            Project.status == "Running"
        ).count(),
    }
def get_projects_summary(
    db: Session,
    project_id: int | None = None,
):
    return {
        "active": db.query(Project)
        .filter(Project.status == "Running")
        .count(),

        "completed": db.query(Project)
        .filter(Project.status == "Completed")
        .count(),
    }
def get_machine_summary(
    db: Session,
    project_id: int | None = None,
):
    query = db.query(Machine)

    if project_id is not None:
        query = query.filter(
            Machine.project_id == project_id
        )

    return {
        "total": query.count(),

        "running": query.filter(
            Machine.status == "Running"
        ).count(),

        "idle": query.filter(
            Machine.status == "Idle"
        ).count(),

        "maintenance": query.filter(
            Machine.status == "Maintenance"
        ).count(),

        "out_of_service": query.filter(
            Machine.status == "Out of Service"
        ).count(),

        "fuel_capacity": query.with_entities(
            func.coalesce(
                func.sum(Machine.fuel_capacity),
                0,
            )
        ).scalar(),

        "current_fuel": query.with_entities(
            func.coalesce(
                func.sum(Machine.current_fuel),
                0,
            )
        ).scalar(),

        "working_hours": query.with_entities(
            func.coalesce(
                func.sum(Machine.working_hours),
                0,
            )
        ).scalar(),
    }
def get_production_summary(
    db: Session,
    project_id: int | None = None,
):
    today = date.today()

    query = db.query(Production)

    if project_id:
        query = query.filter(
            Production.project_id == project_id
        )

    today_query = query.filter(
        Production.production_date == today
    )

    month_query = query.filter(
        func.extract(
            "month",
            Production.production_date,
        ) == today.month,
        func.extract(
            "year",
            Production.production_date,
        ) == today.year,
    )

    return {

        "today_tons":
        today_query.with_entities(
            func.coalesce(
                func.sum(Production.tons_produced),
                0,
            )
        ).scalar(),

        "today_hours":
        today_query.with_entities(
            func.coalesce(
                func.sum(Production.hours_worked),
                0,
            )
        ).scalar(),

        "month_tons":
        month_query.with_entities(
            func.coalesce(
                func.sum(Production.tons_produced),
                0,
            )
        ).scalar(),

        "month_hours":
        month_query.with_entities(
            func.coalesce(
                func.sum(Production.hours_worked),
                0,
            )
        ).scalar(),
    }
def get_fuel_summary(
    db: Session,
    project_id: int | None = None,
):
    today = date.today()

    query = db.query(FuelLog)

    if project_id:
        query = query.filter(
            FuelLog.project_id == project_id
        )

    today_query = query.filter(
        FuelLog.fuel_date == today
    )

    month_query = query.filter(
        func.extract(
            "month",
            FuelLog.fuel_date,
        ) == today.month,
        func.extract(
            "year",
            FuelLog.fuel_date,
        ) == today.year,
    )

    return {

        "today_liters":
        today_query.with_entities(
            func.coalesce(
                func.sum(FuelLog.liters_added),
                0,
            )
        ).scalar(),

        "today_cost":
        today_query.with_entities(
            func.coalesce(
                func.sum(FuelLog.total_cost),
                0,
            )
        ).scalar(),

        "month_liters":
        month_query.with_entities(
            func.coalesce(
                func.sum(FuelLog.liters_added),
                0,
            )
        ).scalar(),

        "month_cost":
        month_query.with_entities(
            func.coalesce(
                func.sum(FuelLog.total_cost),
                0,
            )
        ).scalar(),
    }
def get_maintenance_summary(
    db: Session,
    project_id: int | None = None,
):
    query = db.query(Maintenance)

    if project_id:
        query = query.filter(
            Maintenance.project_id == project_id
        )

    return {

        "total_jobs":
        query.count(),

        "total_cost":
        query.with_entities(
            func.coalesce(
                func.sum(Maintenance.total_cost),
                0,
            )
        ).scalar(),
    }
def get_employee_summary(
    db: Session,
    project_id: int | None = None,
):
    query = db.query(Employee)

    if project_id:
        query = query.filter(
            Employee.project_id == project_id
        )

    return {

        "total":
        query.count(),

        "active":
        query.filter(
            Employee.status == "Active"
        ).count(),

        "inactive":
        query.filter(
            Employee.status == "Inactive"
        ).count(),
    }
def get_attendance_summary(
    db: Session,
    project_id: int | None = None,
):
    today = date.today()

    query = db.query(Attendance).filter(
        Attendance.attendance_date == today
    )

    if project_id:
        query = query.filter(
            Attendance.project_id == project_id
        )

    return {

        "present":
        query.filter(
            Attendance.status == "Present"
        ).count(),

        "absent":
        query.filter(
            Attendance.status == "Absent"
        ).count(),

        "leave":
        query.filter(
            Attendance.status == "Leave"
        ).count(),

        "half_day":
        query.filter(
            Attendance.status == "Half Day"
        ).count(),
    }
def get_recent_activity(
    db: Session,
    project_id: int | None = None,
):
    production_query = (
    db.query(Production)
    .options(
        joinedload(Production.machine),
        joinedload(Production.employee),
    )
)

    fuel_query = (
    db.query(FuelLog)
    .options(
        joinedload(FuelLog.machine),
    )
)

    maintenance_query = (
    db.query(Maintenance)
    .options(
        joinedload(Maintenance.machine),
    )
)

    if project_id:

        production_query = production_query.filter(
            Production.project_id == project_id
        )

        fuel_query = fuel_query.filter(
            FuelLog.project_id == project_id
        )

        maintenance_query = maintenance_query.filter(
            Maintenance.project_id == project_id
        )

    recent_productions = (
        production_query
        .order_by(
            Production.id.desc()
        )
        .limit(5)
        .all()
    )

    recent_fuel_logs = (
        fuel_query
        .order_by(
            FuelLog.id.desc()
        )
        .limit(5)
        .all()
    )

    recent_maintenance = (
        maintenance_query
        .order_by(
            Maintenance.id.desc()
        )
        .limit(5)
        .all()
    )
    return {

    "recent_productions": [

        {
            "id": p.id,

            "production_date": p.production_date,

            "machine": {
                "id": p.machine.id,
                "name": p.machine.name,
                "machine_code": p.machine.machine_code,
            },

            "employee": {
                "id": p.employee.id,
                "full_name": p.employee.full_name,
            },

            "tons_produced": p.tons_produced,
            "hours_worked": p.hours_worked,
        }

        for p in recent_productions
    ],

    "recent_fuel_logs": [

        {
            "id": f.id,

            "fuel_date": f.fuel_date,

            "machine": {
                "id": f.machine.id,
                "name": f.machine.name,
                "machine_code": f.machine.machine_code,
            },

            "liters_added": f.liters_added,

            "total_cost": f.total_cost,
        }

        for f in recent_fuel_logs
    ],

    "recent_maintenance": [

        {
            "id": m.id,

            "maintenance_date": m.maintenance_date,

            "machine": {
                "id": m.machine.id,
                "name": m.machine.name,
                "machine_code": m.machine.machine_code,
            },

            "maintenance_type": m.maintenance_type,

            "total_cost": m.total_cost,

            "status": m.status,
        }

        for m in recent_maintenance
    ],
}

    
def get_dashboard(
    db: Session,
    project_id: int | None = None,
):
    return {

        "overview":
        get_overview(
            db,
            project_id,
        ),

        "projects":
        get_projects_summary(
            db,
        ),

        "machines":
        get_machine_summary(
            db,
            project_id,
        ),

        "production":
        get_production_summary(
            db,
            project_id,
        ),

        "fuel":
        get_fuel_summary(
            db,
            project_id,
        ),

        "maintenance":
        get_maintenance_summary(
            db,
            project_id,
        ),

        "employees":
        get_employee_summary(
            db,
            project_id,
        ),

        "attendance":
        get_attendance_summary(
            db,
            project_id,
        ),

        "recent_activity":
        get_recent_activity(
            db,
            project_id,
        ),
    }
