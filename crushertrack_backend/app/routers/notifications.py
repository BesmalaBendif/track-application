from typing import Optional

from fastapi import APIRouter
from fastapi import Depends

from sqlalchemy.orm import Session

from app.database import get_db

from app.schemas.notifications import NotificationResponse

from app.services.notifications import get_notifications


router = APIRouter(
    prefix="/notifications",
    tags=["Notifications"],
)


@router.get(
    "/",
    response_model=NotificationResponse,
)
def notifications(
    project_id: Optional[int] = None,
    db: Session = Depends(get_db),
):
    return get_notifications(
        db=db,
        project_id=project_id,
    )