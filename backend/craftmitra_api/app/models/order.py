from sqlalchemy import Column, Float, String

from app.database.base import Base


class Order(Base):
    __tablename__ = 'orders'

    id = Column(String, primary_key=True, index=True)
    user_id = Column(String, nullable=False)
    total = Column(Float, nullable=False)
    status = Column(String, nullable=False, default='PENDING')
