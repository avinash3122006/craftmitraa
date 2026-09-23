from sqlalchemy import Column, Float, String

from app.database.base import Base


class Product(Base):
    __tablename__ = 'products'

    id = Column(String, primary_key=True, index=True)
    artisan_id = Column(String, nullable=False)
    name = Column(String, nullable=False)
    category = Column(String, nullable=False)
    material = Column(String, nullable=True)
    price = Column(Float, nullable=False)
    description = Column(String, nullable=True)
