from datetime import datetime
import uuid

from sqlalchemy import Column, DateTime, ForeignKey, Integer, String, Text
from sqlalchemy.orm import relationship

from app.database.base import Base


class ArtisanStory(Base):
    __tablename__ = 'artisan_stories'

    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()), index=True)
    artisan_id = Column(String, ForeignKey('artisans.id'), nullable=False, index=True)
    title = Column(String, nullable=False)
    story = Column(Text, nullable=False)
    audio_url = Column(String, nullable=True)
    audio_duration_seconds = Column(Integer, default=120)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    artisan = relationship('Artisan', back_populates='stories')
