from datetime import datetime

from pydantic import BaseModel, ConfigDict


class OrderItemCreate(BaseModel):
    product_id: str
    quantity: int = 1


class OrderItemResponse(BaseModel):
    id: str
    product_id: str
    quantity: int
    unit_price: float
    artisan_share: float

    model_config = ConfigDict(from_attributes=True)


class OrderCreate(BaseModel):
    items: list[OrderItemCreate]
    delivery_address: str
    payment_method: str = 'UPI'


class OrderStatusUpdate(BaseModel):
    status: str  # PLACED, HANDCRAFTED, QUALITY_CHECK, DISPATCHED, DELIVERED


class OrderResponse(BaseModel):
    id: str
    user_id: str
    total_amount: float
    artisan_contribution: float
    status: str
    delivery_address: str
    payment_method: str
    created_at: datetime | None = None
    items: list[OrderItemResponse] = []

    model_config = ConfigDict(from_attributes=True)
