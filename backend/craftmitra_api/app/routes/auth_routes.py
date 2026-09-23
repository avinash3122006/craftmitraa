from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.core.dependencies import get_current_user, get_db
from app.models.user import User
from app.schemas.auth_schema import LoginRequest, RegisterRequest, TokenResponse, UserOut
from app.services.auth_service import auth_service

router = APIRouter(prefix='/auth', tags=['auth'])


@router.post('/register', response_model=TokenResponse)
def register(req: RegisterRequest, db: Session = Depends(get_db)):
    return auth_service.register_user(db=db, req=req)


@router.post('/login', response_model=TokenResponse)
def login(req: LoginRequest, db: Session = Depends(get_db)):
    return auth_service.login_user(db=db, req=req)


@router.get('/me', response_model=UserOut)
def get_current_user_profile(current_user: User = Depends(get_current_user)):
    return current_user
