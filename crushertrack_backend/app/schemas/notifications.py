from pydantic import BaseModel
from typing import List, Optional


class NotificationItem(BaseModel):
    type: str
    category: str

    title: str
    message: str

    action: str
    action_id: Optional[int] = None


class NotificationResponse(BaseModel):
    count: int
    notifications: List[NotificationItem]