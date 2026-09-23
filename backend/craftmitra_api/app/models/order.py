from datetime import datetime
import uuid

from sqlalchemy import Column, DateTime, Float, ForeignKey, String, Text
from sqlalchemy.orm import relationship

from app.database.base import Base


class Order(Base):
    __tablename__ = 'orders'

    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()), index=True)
    user_id = Column(String, ForeignKey('users.id'), nullable=False, index=True)
    total_amount = Column(Float, nullable=False)
    artisan_contribution = Column(Float, nullable=False, default=0.0)
    status = Column(String, nullable=False, default='PLACED')  # PLACED, HANDCRAFTED, QUALITY_CHECK, DISPATCHED, DELIVERED
    delivery_address = Column(Text, nullable=False)
    payment_method = Column(String, nullable=False, default='UPI')
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    user = relationship('User', back_populates='orders')
    items = relationship('OrderItem', back_populates='order', cascade='all, delete-orphan')
    payments = relationship('Payment', back_populates='order', cascade='all, delete-orphan')
