from datetime import datetime
import uuid

from sqlalchemy import Column, DateTime, String
from sqlalchemy.orm import relationship

from app.database.base import Base


class User(Base):
    __tablename__ = 'users'

    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()), index=True)
    name = Column(String, nullable=False)
    email = Column(String, unique=True, index=True, nullable=False)
    phone = Column(String, nullable=True)
    password_hash = Column(String, nullable=False)
    role = Column(String, nullable=False, default='customer')  # customer, artisan, admin
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    artisan_profile = relationship('Artisan', back_populates='user', uselist=False, cascade='all, delete-orphan')
    orders = relationship('Order', back_populates='user', cascade='all, delete-orphan')
    reviews = relationship('Review', back_populates='user', cascade='all, delete-orphan')
