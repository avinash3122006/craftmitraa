from sqlalchemy import Column, String

from app.database.base import Base


class Artisan(Base):
    __tablename__ = 'artisans'

    id = Column(String, primary_key=True, index=True)
    user_id = Column(String, nullable=False)
    business_name = Column(String, nullable=True)
    craft_type = Column(String, nullable=True)
    location = Column(String, nullable=True)
