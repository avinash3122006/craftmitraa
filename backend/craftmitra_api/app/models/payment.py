from sqlalchemy import Column, Float, String

from app.database.base import Base


class Payment(Base):
    __tablename__ = 'payments'

    id = Column(String, primary_key=True, index=True)
    order_id = Column(String, nullable=False)
    payment_id = Column(String, nullable=True)
    status = Column(String, nullable=False, default='PENDING')
    amount = Column(Float, nullable=False)
