from math import ceil

from sqlalchemy.orm import Query

from app.schemas.pagination import (
    PaginationMetadata,
    PaginatedResponse,
)


MAX_PAGE_SIZE = 100
DEFAULT_PAGE_SIZE = 20


def paginate(
    query: Query,
    page: int = 1,
    page_size: int = DEFAULT_PAGE_SIZE,
):
    # Validate page
    if page < 1:
        page = 1

    # Validate page size
    if page_size < 1:
        page_size = DEFAULT_PAGE_SIZE

    if page_size > MAX_PAGE_SIZE:
        page_size = MAX_PAGE_SIZE

    total_items = query.count()

    total_pages = (
        ceil(total_items / page_size)
        if total_items > 0
        else 1
    )

    items = (
        query
        .offset((page - 1) * page_size)
        .limit(page_size)
        .all()
    )

    return PaginatedResponse(
        items=items,
        pagination=PaginationMetadata(
            page=page,
            page_size=page_size,
            total_items=total_items,
            total_pages=total_pages,
            has_next=page < total_pages,
            has_previous=page > 1,
        ),
    )