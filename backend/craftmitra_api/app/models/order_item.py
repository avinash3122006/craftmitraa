from sqlalchemy import Column, Float, String

from app.database.base import Base


class OrderItem(Base):
    __tablename__ = 'order_items'

    id = Column(String, primary_key=True, index=True)
    order_id = Column(String, nullable=False)
    product_id = Column(String, nullable=False)
    quantity = Column(String, nullable=False)
    price = Column(Float, nullable=False)
