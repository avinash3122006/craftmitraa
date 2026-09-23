from datetime import datetime
import uuid

from sqlalchemy import Column, DateTime, Float, ForeignKey, String, Text
from sqlalchemy.orm import relationship

from app.database.base import Base


class Review(Base):
    __tablename__ = 'reviews'

    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()), index=True)
    product_id = Column(String, ForeignKey('products.id'), nullable=False, index=True)
    user_id = Column(String, ForeignKey('users.id'), nullable=False, index=True)
    rating = Column(Float, nullable=False, default=5.0)
    comment = Column(Text, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    product = relationship('Product', back_populates='reviews')
    user = relationship('User', back_populates='reviews')
