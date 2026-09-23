from fastapi import APIRouter

from app.schemas.shipping_schema import ShippingEstimateRequest, ShippingEstimateResponse
from app.services.shipping_service import shipping_service

router = APIRouter(prefix='/shipping', tags=['shipping'])


@router.post('/estimate', response_model=ShippingEstimateResponse)
def estimate_shipping(req: ShippingEstimateRequest):
    return ShippingEstimateResponse(
        carrier='India Post Rural Surface',
        cost=0.0 if req.weight_kg <= 2.0 else 120.0,
        estimated_days='4-6 business days',
        is_eco_packaged=True,
    )


@router.get('/track/{awb_code}')
def track_shipment(awb_code: str):
    return shipping_service.track_shipment(awb_code=awb_code)
