from datetime import datetime, timedelta

from jose import JWTError, jwt

from app.core.config import settings


def create_access_token(subject: str, role: str):
    payload = {
        'sub': subject,
        'role': role,
        'exp': datetime.utcnow() + timedelta(minutes=60),
    }
    return jwt.encode(payload, settings.jwt_secret_key, algorithm=settings.jwt_algorithm)
