from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.core.dependencies import get_current_user, get_db
from app.models.user import User
from app.schemas.user_schema import UserProfile, UserUpdate

router = APIRouter(prefix='/users', tags=['users'])


@router.get('/me', response_model=UserProfile)
def get_profile(current_user: User = Depends(get_current_user)):
    return current_user


@router.put('/me', response_model=UserProfile)
def update_profile(
    data: UserUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    update_dict = data.model_dump(exclude_unset=True)
    for key, val in update_dict.items():
        setattr(current_user, key, val)
    db.commit()
    db.refresh(current_user)
    return current_user
