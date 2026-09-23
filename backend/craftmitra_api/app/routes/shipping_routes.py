from fastapi import APIRouter

router = APIRouter(prefix='/shipping', tags=['shipping'])


@router.post('/estimate')
def estimate_shipping():
    return {'message': 'shipping estimate placeholder'}


@router.post('/create')
def create_shipment():
    return {'message': 'create shipment placeholder'}
