from pydantic import BaseModel


class ShippingEstimateRequest(BaseModel):
    pincode: str
    weight_kg: float = 1.0


class ShippingEstimateResponse(BaseModel):
    carrier: str = 'India Post Rural Surface'
    cost: float = 0.0  # Free or standard
    estimated_days: str = '4-6 business days'
    is_eco_packaged: bool = True
