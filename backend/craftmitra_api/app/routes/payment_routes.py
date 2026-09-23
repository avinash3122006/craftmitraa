from fastapi import APIRouter

router = APIRouter(prefix='/payments', tags=['payments'])


@router.post('/create')
def create_payment():
    return {'message': 'create payment placeholder'}


@router.post('/webhook')
def payment_webhook():
    return {'message': 'payment webhook placeholder'}
