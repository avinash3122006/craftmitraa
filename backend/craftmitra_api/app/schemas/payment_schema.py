from datetime import datetime

from pydantic import BaseModel, ConfigDict


class PaymentCreate(BaseModel):
    order_id: str
    amount: float
    payment_method: str = 'UPI'


class PaymentResponse(BaseModel):
    id: str
    order_id: str
    payment_id: str | None = None
    transaction_id: str | None = None
    status: str
    amount: float
    payment_method: str
    created_at: datetime | None = None

    model_config = ConfigDict(from_attributes=True)
