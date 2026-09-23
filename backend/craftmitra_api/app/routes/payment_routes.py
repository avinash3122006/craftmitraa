from fastapi import APIRouter, Depends, status
from sqlalchemy.orm import Session

from app.core.dependencies import get_current_user, get_db
from app.models.user import User
from app.schemas.payment_schema import PaymentCreate, PaymentResponse
from app.services.payment_service import payment_service

router = APIRouter(prefix='/payments', tags=['payments'])


@router.post('/process', response_model=PaymentResponse, status_code=status.HTTP_201_CREATED)
def process_payment(
    data: PaymentCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    return payment_service.process_payment(db=db, data=data)


@router.get('/order/{order_id}', response_model=list[PaymentResponse])
def get_order_payments(
    order_id: str,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    return payment_service.get_order_payments(db=db, order_id=order_id)
