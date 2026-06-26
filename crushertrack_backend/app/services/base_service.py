from sqlalchemy.orm import Session


class BaseService:

    def __init__(self, model):
        self.model = model

    def get_all(self, db: Session):
        return (
            db.query(self.model)
            .order_by(self.model.id.desc())
            .all()
        )

    def get_by_id(
        self,
        db: Session,
        object_id: int,
    ):
        return (
            db.query(self.model)
            .filter(self.model.id == object_id)
            .first()
        )

    def create(
        self,
        db: Session,
        db_object,
    ):
        db.add(db_object)
        db.commit()
        db.refresh(db_object)
        return db_object

    def update(
        self,
        db: Session,
        db_object,
        data: dict,
    ):
        for key, value in data.items():
            setattr(db_object, key, value)

        db.commit()
        db.refresh(db_object)

        return db_object

    def delete(
        self,
        db: Session,
        db_object,
    ):
        db.delete(db_object)
        db.commit()