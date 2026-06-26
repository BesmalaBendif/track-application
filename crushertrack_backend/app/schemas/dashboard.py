from datetime import date
from typing import List

from pydantic import BaseModel


# =====================================================
# Overview
# =====================================================

class OverviewSummary(BaseModel):
    total_projects: int
    total_machines: int
    total_employees: int
    running_projects: int


# =====================================================
# Projects
# =====================================================

class ProjectsSummary(BaseModel):
    active: int
    completed: int


# =====================================================
# Machines
# =====================================================

class MachinesSummary(BaseModel):
    total: int
    running: int
    idle: int
    maintenance: int
    out_of_service: int

    fuel_capacity: float
    current_fuel: float
    working_hours: float


# =====================================================
# Production
# =====================================================

class ProductionSummary(BaseModel):
    today_tons: float
    today_hours: float

    month_tons: float
    month_hours: float


# =====================================================
# Fuel
# =====================================================

class FuelSummary(BaseModel):
    today_liters: float
    today_cost: float

    month_liters: float
    month_cost: float


# =====================================================
# Maintenance
# =====================================================

class MaintenanceSummary(BaseModel):
    total_jobs: int
    total_cost: float


# =====================================================
# Employees
# =====================================================

class EmployeesSummary(BaseModel):
    total: int
    active: int
    inactive: int


# =====================================================
# Attendance
# =====================================================

class AttendanceSummary(BaseModel):
    present: int
    absent: int
    leave: int
    half_day: int


# =====================================================
# Dashboard Nested Objects
# =====================================================

class DashboardMachine(BaseModel):
    id: int
    name: str
    machine_code: str

    class Config:
        from_attributes = True


class DashboardEmployee(BaseModel):
    id: int
    full_name: str

    class Config:
        from_attributes = True


# =====================================================
# Recent Production
# =====================================================

class RecentProductionItem(BaseModel):
    id: int
    production_date: date

    machine: DashboardMachine
    employee: DashboardEmployee

    tons_produced: float
    hours_worked: float

    class Config:
        from_attributes = True


# =====================================================
# Recent Fuel Log
# =====================================================

class RecentFuelLogItem(BaseModel):
    id: int
    fuel_date: date

    machine: DashboardMachine

    liters_added: float
    total_cost: float

    class Config:
        from_attributes = True


# =====================================================
# Recent Maintenance
# =====================================================

class RecentMaintenanceItem(BaseModel):
    id: int
    maintenance_date: date

    machine: DashboardMachine

    maintenance_type: str
    total_cost: float
    status: str

    class Config:
        from_attributes = True


# =====================================================
# Recent Activity
# =====================================================

class RecentActivity(BaseModel):
    recent_productions: List[RecentProductionItem]
    recent_fuel_logs: List[RecentFuelLogItem]
    recent_maintenance: List[RecentMaintenanceItem]


# =====================================================
# Dashboard Response
# =====================================================

class DashboardResponse(BaseModel):
    overview: OverviewSummary
    projects: ProjectsSummary
    machines: MachinesSummary
    production: ProductionSummary
    fuel: FuelSummary
    maintenance: MaintenanceSummary
    employees: EmployeesSummary
    attendance: AttendanceSummary
    recent_activity: RecentActivity