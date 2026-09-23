from sqlalchemy import Column, Float, String

from app.database.base import Base


class Review(Base):
    __tablename__ = 'reviews'

    id = Column(String, primary_key=True, index=True)
    product_id = Column(String, nullable=False)
    user_id = Column(String, nullable=False)
    rating = Column(Float, nullable=False)
    comment = Column(String, nullable=True)
