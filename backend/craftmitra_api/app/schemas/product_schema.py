from pydantic import BaseModel


class ProductCreate(BaseModel):
    name: str
    category: str
    material: str | None = None
    price: float
    description: str | None = None


class ProductResponse(ProductCreate):
    id: str
    artisan_id: str
