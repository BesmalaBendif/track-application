from sqlalchemy import asc
from sqlalchemy import desc


def apply_sorting(
    query,
    model,
    sort: str | None,
):
    if not sort:
        return query

    descending = sort.endswith("_desc")

    field = (
        sort[:-5]
        if descending
        else sort
    )

    if not hasattr(model, field):
        return query

    column = getattr(
        model,
        field,
    )

    if descending:
        return query.order_by(
            desc(column)
        )

    return query.order_by(
        asc(column)
    )
from sqlalchemy import or_


def apply_search(
    query,
    model,
    search,
    fields,
):
    if not search:
        return query

    conditions = []

    for field in fields:

        if hasattr(model, field):

            conditions.append(

                getattr(
                    model,
                    field,
                ).ilike(
                    f"%{search}%"
                )

            )

    if conditions:

        query = query.filter(
            or_(*conditions)
        )

    return query