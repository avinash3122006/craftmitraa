from pydantic import BaseModel


class OrderCreate(BaseModel):
    product_id: str
    quantity: int = 1


class OrderResponse(BaseModel):
    id: str
    status: str
    total: float
