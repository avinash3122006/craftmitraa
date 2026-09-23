from pydantic import BaseModel


class ShippingEstimate(BaseModel):
    city: str
    pincode: str


class ShippingCreate(BaseModel):
    order_id: str
    address: str
