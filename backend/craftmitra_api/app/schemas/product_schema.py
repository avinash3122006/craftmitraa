from datetime import datetime

from pydantic import BaseModel, ConfigDict


class ProductImageOut(BaseModel):
    id: str
    image_url: str
    is_primary: bool = False

    model_config = ConfigDict(from_attributes=True)


class ProductBase(BaseModel):
    name: str
    category: str
    material: str | None = None
    price: float
    original_price: float | None = None
    description: str | None = None
    cultural_story: str | None = None
    dimensions: str | None = None
    weight: str | None = None
    time_to_create_hours: int = 12
    is_verified_craft: bool = True
    is_sustainable: bool = True
    stock_quantity: int = 5
    fair_price_min: float | None = None
    fair_price_max: float | None = None
    artisan_share_percent: float = 85.0


class ProductCreate(ProductBase):
    image_urls: list[str] = []


class ProductUpdate(BaseModel):
    name: str | None = None
    category: str | None = None
    material: str | None = None
    price: float | None = None
    original_price: float | None = None
    description: str | None = None
    cultural_story: str | None = None
    dimensions: str | None = None
    weight: str | None = None
    time_to_create_hours: int | None = None
    stock_quantity: int | None = None
    is_verified_craft: bool | None = None
    is_sustainable: bool | None = None
    fair_price_min: float | None = None
    fair_price_max: float | None = None
    image_urls: list[str] | None = None


class ProductResponse(ProductBase):
    id: str
    artisan_id: str
    created_at: datetime | None = None
    images: list[ProductImageOut] = []

    model_config = ConfigDict(from_attributes=True)
