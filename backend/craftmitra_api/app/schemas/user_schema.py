from datetime import datetime

from pydantic import BaseModel, ConfigDict


class UserProfile(BaseModel):
    id: str
    name: str
    email: str
    phone: str | None = None
    role: str
    created_at: datetime | None = None

    model_config = ConfigDict(from_attributes=True)


class UserUpdate(BaseModel):
    name: str | None = None
    phone: str | None = None
