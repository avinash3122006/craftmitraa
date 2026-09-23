from sqlalchemy import Column, String

from app.database.base import Base


class ArtisanStory(Base):
    __tablename__ = 'artisan_stories'

    id = Column(String, primary_key=True, index=True)
    artisan_id = Column(String, nullable=False)
    title = Column(String, nullable=False)
    story = Column(String, nullable=False)
