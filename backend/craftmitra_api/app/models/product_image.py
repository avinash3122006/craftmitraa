import uuid

from sqlalchemy import Boolean, Column, ForeignKey, String
from sqlalchemy.orm import relationship

from app.database.base import Base


class ProductImage(Base):
    __tablename__ = 'product_images'

    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()), index=True)
    product_id = Column(String, ForeignKey('products.id'), nullable=False, index=True)
    image_url = Column(String, nullable=False)
    public_id = Column(String, nullable=True)
    is_primary = Column(Boolean, default=False)

    # Relationships
    product = relationship('Product', back_populates='images')
