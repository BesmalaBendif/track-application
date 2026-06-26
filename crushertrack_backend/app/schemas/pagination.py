from math import ceil
from typing import Generic, List, TypeVar

from pydantic import BaseModel
from pydantic.generics import GenericModel


T = TypeVar("T")


class PaginationMetadata(BaseModel):
    page: int
    page_size: int

    total_items: int
    total_pages: int

    has_next: bool
    has_previous: bool


class PaginatedResponse(GenericModel, Generic[T]):
    items: List[T]
    pagination: PaginationMetadata