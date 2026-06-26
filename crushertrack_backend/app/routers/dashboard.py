from typing import Optional

from fastapi import APIRouter
from fastapi import Depends

from sqlalchemy.orm import Session

from app.database import get_db

from app.schemas.dashboard import DashboardResponse

from app.services.dashboard import get_dashboard


router = APIRouter(
    prefix="/dashboard",
    tags=["Dashboard"],
)


@router.get(
    "/",
    response_model=DashboardResponse,
)
def dashboard(
    project_id: Optional[int] = None,
    db: Session = Depends(get_db),
):
    return get_dashboard(
        db=db,
        project_id=project_id,
    )