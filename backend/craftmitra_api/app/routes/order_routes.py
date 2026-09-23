from fastapi import APIRouter, Depends, status
from sqlalchemy.orm import Session

from app.core.dependencies import get_current_user, get_db, require_artisan
from app.models.user import User
from app.schemas.order_schema import OrderCreate, OrderResponse, OrderStatusUpdate
from app.services.artisan_service import artisan_service
from app.services.order_service import order_service

router = APIRouter(prefix='/orders', tags=['orders'])


@router.post('/create', response_model=OrderResponse, status_code=status.HTTP_201_CREATED)
def create_order(
    data: OrderCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    return order_service.create_order(db=db, user_id=current_user.id, data=data)


@router.get('/my-orders', response_model=list[OrderResponse])
def get_my_orders(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    return order_service.list_user_orders(db=db, user_id=current_user.id)


@router.get('/artisan-orders', response_model=list[OrderResponse])
def get_artisan_orders(
    current_user: User = Depends(require_artisan),
    db: Session = Depends(get_db),
):
    artisan = artisan_service.get_artisan_by_user_id(db=db, user_id=current_user.id)
    return order_service.list_artisan_orders(db=db, artisan_id=artisan.id)


@router.get('/{order_id}', response_model=OrderResponse)
def get_order_details(
    order_id: str,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    return order_service.get_order(db=db, order_id=order_id)


@router.put('/{order_id}/status', response_model=OrderResponse)
def update_order_status(
    order_id: str,
    data: OrderStatusUpdate,
    current_user: User = Depends(require_artisan),
    db: Session = Depends(get_db),
):
    return order_service.update_order_status(db=db, order_id=order_id, new_status=data.status)
