from fastapi import HTTPException, status
from sqlalchemy.orm import Session

from app.core.security import create_access_token, hash_password, verify_password
from app.models.artisan import Artisan
from app.models.user import User
from app.schemas.auth_schema import LoginRequest, RegisterRequest, TokenResponse, UserOut


class AuthService:
    def register_user(self, db: Session, req: RegisterRequest) -> TokenResponse:
        existing = db.query(User).filter(User.email == req.email).first()
        if existing:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail='User with this email already exists',
            )

        new_user = User(
            name=req.name,
            email=req.email,
            phone=req.phone,
            password_hash=hash_password(req.password),
            role=req.role,
        )
        db.add(new_user)
        db.flush()

        # If user registered as artisan, create initial artisan studio profile
        if req.role == 'artisan':
            artisan_profile = Artisan(
                user_id=new_user.id,
                business_name=f"{req.name}'s Studio",
                craft_type='Handcrafted Traditional Art',
                location='India',
                is_verified=True,
            )
            db.add(artisan_profile)

        db.commit()
        db.refresh(new_user)

        token = create_access_token(subject=new_user.id, role=new_user.role)
        return TokenResponse(
            access_token=token,
            token_type='bearer',
            user=UserOut.model_validate(new_user),
        )

    def login_user(self, db: Session, req: LoginRequest) -> TokenResponse:
        user = db.query(User).filter(User.email == req.email).first()
        if not user or not verify_password(req.password, user.password_hash):
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail='Invalid email or password',
            )

        token = create_access_token(subject=user.id, role=user.role)
        return TokenResponse(
            access_token=token,
            token_type='bearer',
            user=UserOut.model_validate(user),
        )


auth_service = AuthService()
