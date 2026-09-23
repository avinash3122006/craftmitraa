from datetime import datetime
import uuid

from sqlalchemy import Boolean, Column, DateTime, Float, ForeignKey, Integer, String, Text
from sqlalchemy.orm import relationship

from app.database.base import Base


class Product(Base):
    __tablename__ = 'products'

    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()), index=True)
    artisan_id = Column(String, ForeignKey('artisans.id'), nullable=False, index=True)
    name = Column(String, nullable=False, index=True)
    category = Column(String, nullable=False, index=True)
    material = Column(String, nullable=True)
    price = Column(Float, nullable=False)
    original_price = Column(Float, nullable=True)
    description = Column(Text, nullable=True)
    cultural_story = Column(Text, nullable=True)
    dimensions = Column(String, nullable=True)
    weight = Column(String, nullable=True)
    time_to_create_hours = Column(Integer, default=12)
    is_verified_craft = Column(Boolean, default=True)
    is_sustainable = Column(Boolean, default=True)
    stock_quantity = Column(Integer, default=5)
    fair_price_min = Column(Float, nullable=True)
    fair_price_max = Column(Float, nullable=True)
    artisan_share_percent = Column(Float, default=85.0)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    artisan = relationship('Artisan', back_populates='products')
    images = relationship('ProductImage', back_populates='product', cascade='all, delete-orphan')
    order_items = relationship('OrderItem', back_populates='product')
    reviews = relationship('Review', back_populates='product', cascade='all, delete-orphan')
