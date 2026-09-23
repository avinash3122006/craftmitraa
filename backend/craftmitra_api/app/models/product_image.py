from sqlalchemy import Column, String

from app.database.base import Base


class ProductImage(Base):
    __tablename__ = 'product_images'

    id = Column(String, primary_key=True, index=True)
    product_id = Column(String, nullable=False)
    image_url = Column(String, nullable=False)
    public_id = Column(String, nullable=True)
