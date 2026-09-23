from pydantic import BaseModel


class UserProfile(BaseModel):
    id: str
    name: str
    email: str
    role: str
