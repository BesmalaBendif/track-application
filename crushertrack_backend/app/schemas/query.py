from typing import Optional

from pydantic import BaseModel


class QueryParams(BaseModel):

    page: int = 1

    page_size: int = 20

    search: Optional[str] = None

    sort: Optional[str] = None