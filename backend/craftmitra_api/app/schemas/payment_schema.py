from pydantic import BaseModel


class PaymentCreate(BaseModel):
    order_id: str
    amount: float


class PaymentWebhook(BaseModel):
    event: str
    payload: dict
