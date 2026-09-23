from fastapi import APIRouter, Depends, Query, status
from sqlalchemy.orm import Session

from app.core.dependencies import get_current_user, get_db, require_artisan
from app.models.user import User
from app.schemas.product_schema import ProductCreate, ProductResponse, ProductUpdate
from app.services.artisan_service import artisan_service
from app.services.product_service import product_service

router = APIRouter(prefix='/products', tags=['products'])


@router.get('/', response_model=list[ProductResponse])
def get_products(
    category: str | None = None,
    search: str | None = None,
    only_verified: bool = False,
    skip: int = Query(0, ge=0),
    limit: int = Query(50, ge=1, le=100),
    db: Session = Depends(get_db),
):
    return product_service.list_products(
        db=db,
        category=category,
        search=search,
        only_verified=only_verified,
        skip=skip,
        limit=limit,
    )


@router.get('/{product_id}', response_model=ProductResponse)
def get_product(product_id: str, db: Session = Depends(get_db)):
    return product_service.get_product(db=db, product_id=product_id)


@router.post('/create', response_model=ProductResponse, status_code=status.HTTP_201_CREATED)
def create_product(
    data: ProductCreate,
    current_user: User = Depends(require_artisan),
    db: Session = Depends(get_db),
):
    artisan = artisan_service.get_artisan_by_user_id(db=db, user_id=current_user.id)
    return product_service.create_product(db=db, artisan_id=artisan.id, data=data)


@router.put('/{product_id}', response_model=ProductResponse)
def update_product(
    product_id: str,
    data: ProductUpdate,
    current_user: User = Depends(require_artisan),
    db: Session = Depends(get_db),
):
    artisan = artisan_service.get_artisan_by_user_id(db=db, user_id=current_user.id)
    return product_service.update_product(
        db=db,
        product_id=product_id,
        artisan_id=artisan.id,
        data=data,
    )


@router.delete('/{product_id}', status_code=status.HTTP_204_NO_CONTENT)
def delete_product(
    product_id: str,
    current_user: User = Depends(require_artisan),
    db: Session = Depends(get_db),
):
    artisan = artisan_service.get_artisan_by_user_id(db=db, user_id=current_user.id)
    product_service.delete_product(db=db, product_id=product_id, artisan_id=artisan.id)
    return None
