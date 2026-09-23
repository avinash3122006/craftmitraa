from fastapi import APIRouter

router = APIRouter(prefix='/search', tags=['search'])


@router.post('/buyer')
def buyer_search():
    return {'message': 'buyer search placeholder'}
