from datetime import datetime

from pydantic import BaseModel, ConfigDict


class ArtisanBase(BaseModel):
    business_name: str | None = None
    craft_type: str
    village: str | None = None
    state: str | None = None
    location: str | None = None
    bio: str | None = None
    years_of_experience: int = 10
    avatar_url: str | None = None
    cover_image_url: str | None = None
    awards: str | None = None
    upi_id: str | None = None


class ArtisanCreate(ArtisanBase):
    pass


class ArtisanUpdate(BaseModel):
    business_name: str | None = None
    craft_type: str | None = None
    village: str | None = None
    state: str | None = None
    location: str | None = None
    bio: str | None = None
    years_of_experience: int | None = None
    avatar_url: str | None = None
    cover_image_url: str | None = None
    awards: str | None = None
    upi_id: str | None = None


class ArtisanResponse(ArtisanBase):
    id: str
    user_id: str
    rating: float = 5.0
    review_count: int = 0
    is_verified: bool = True
    bank_account_verified: bool = True
    created_at: datetime | None = None

    model_config = ConfigDict(from_attributes=True)
