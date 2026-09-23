from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session

from app.core.dependencies import get_db
from app.schemas.product_schema import ProductResponse
from app.services.product_service import product_service

router = APIRouter(prefix='/search', tags=['search'])


@router.get('/', response_model=list[ProductResponse])
def search_catalog(
    q: str = Query(..., min_length=1),
    skip: int = Query(0, ge=0),
    limit: int = Query(50, ge=1, le=100),
    db: Session = Depends(get_db),
):
    return product_service.list_products(
        db=db,
        search=q,
        skip=skip,
        limit=limit,
    )
