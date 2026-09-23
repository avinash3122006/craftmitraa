from datetime import datetime
import uuid

from sqlalchemy import Boolean, Column, DateTime, Float, ForeignKey, Integer, String, Text
from sqlalchemy.orm import relationship

from app.database.base import Base


class Artisan(Base):
    __tablename__ = 'artisans'

    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()), index=True)
    user_id = Column(String, ForeignKey('users.id'), nullable=False, unique=True)
    business_name = Column(String, nullable=True)
    craft_type = Column(String, nullable=False)
    village = Column(String, nullable=True)
    state = Column(String, nullable=True)
    location = Column(String, nullable=True)
    bio = Column(Text, nullable=True)
    years_of_experience = Column(Integer, default=10)
    rating = Column(Float, default=5.0)
    review_count = Column(Integer, default=0)
    is_verified = Column(Boolean, default=True)
    avatar_url = Column(String, nullable=True)
    cover_image_url = Column(String, nullable=True)
    awards = Column(String, nullable=True)  # Comma-separated or JSON string
    bank_account_verified = Column(Boolean, default=True)
    upi_id = Column(String, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    user = relationship('User', back_populates='artisan_profile')
    products = relationship('Product', back_populates='artisan', cascade='all, delete-orphan')
    stories = relationship('ArtisanStory', back_populates='artisan', cascade='all, delete-orphan')
