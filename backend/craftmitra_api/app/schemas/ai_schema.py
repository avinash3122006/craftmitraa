from pydantic import BaseModel


class AIProductRequest(BaseModel):
    image_url: str | None = None
    voice_text: str | None = None
    language: str = 'en'


class AIProductResponse(BaseModel):
    product_name: str | None = None
    category: str | None = None
    material: str | None = None
    description: str | None = None
    tags: list[str] = []
    price_min: float | None = None
    price_max: float | None = None
