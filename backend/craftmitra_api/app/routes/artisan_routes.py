from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session

from app.core.dependencies import get_current_user, get_db, require_artisan
from app.models.user import User
from app.schemas.artisan_schema import ArtisanResponse, ArtisanUpdate
from app.services.artisan_service import artisan_service

router = APIRouter(prefix='/artisans', tags=['artisans'])


@router.get('/', response_model=list[ArtisanResponse])
def list_artisans(
    skip: int = Query(0, ge=0),
    limit: int = Query(20, ge=1, le=100),
    db: Session = Depends(get_db),
):
    return artisan_service.list_artisans(db=db, skip=skip, limit=limit)


@router.get('/me', response_model=ArtisanResponse)
def get_my_artisan_profile(
    current_user: User = Depends(require_artisan),
    db: Session = Depends(get_db),
):
    return artisan_service.get_artisan_by_user_id(db=db, user_id=current_user.id)


@router.put('/me', response_model=ArtisanResponse)
def update_my_artisan_profile(
    data: ArtisanUpdate,
    current_user: User = Depends(require_artisan),
    db: Session = Depends(get_db),
):
    artisan = artisan_service.get_artisan_by_user_id(db=db, user_id=current_user.id)
    return artisan_service.update_artisan_profile(db=db, artisan_id=artisan.id, data=data)


@router.get('/{artisan_id}', response_model=ArtisanResponse)
def get_artisan(artisan_id: str, db: Session = Depends(get_db)):
    return artisan_service.get_artisan_by_id(db=db, artisan_id=artisan_id)


@router.get('/{artisan_id}/metrics')
def get_artisan_metrics(artisan_id: str, db: Session = Depends(get_db)):
    return artisan_service.get_studio_metrics(db=db, artisan_id=artisan_id)
