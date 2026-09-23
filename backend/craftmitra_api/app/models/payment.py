from datetime import datetime
import uuid

from sqlalchemy import Column, DateTime, Float, ForeignKey, String
from sqlalchemy.orm import relationship

from app.database.base import Base


class Payment(Base):
    __tablename__ = 'payments'

    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()), index=True)
    order_id = Column(String, ForeignKey('orders.id'), nullable=False, index=True)
    payment_id = Column(String, nullable=True)
    transaction_id = Column(String, nullable=True)
    status = Column(String, nullable=False, default='COMPLETED')  # PENDING, COMPLETED, FAILED
    amount = Column(Float, nullable=False)
    payment_method = Column(String, nullable=False, default='UPI')
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    order = relationship('Order', back_populates='payments')
