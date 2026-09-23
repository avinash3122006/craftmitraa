from fastapi import HTTPException, status
from sqlalchemy.orm import Session

from app.models.artisan import Artisan
from app.models.order import Order
from app.models.order_item import OrderItem
from app.models.product import Product
from app.schemas.artisan_schema import ArtisanUpdate


class ArtisanService:
    def get_artisan_by_id(self, db: Session, artisan_id: str) -> Artisan:
        artisan = db.query(Artisan).filter(Artisan.id == artisan_id).first()
        if not artisan:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail='Artisan not found',
            )
        return artisan

    def get_artisan_by_user_id(self, db: Session, user_id: str) -> Artisan:
        artisan = db.query(Artisan).filter(Artisan.user_id == user_id).first()
        if not artisan:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail='Artisan profile not found for this user',
            )
        return artisan

    def list_artisans(self, db: Session, skip: int = 0, limit: int = 20) -> list[Artisan]:
        return db.query(Artisan).offset(skip).limit(limit).all()

    def update_artisan_profile(self, db: Session, artisan_id: str, data: ArtisanUpdate) -> Artisan:
        artisan = self.get_artisan_by_id(db, artisan_id)
        update_dict = data.model_dump(exclude_unset=True)
        for key, val in update_dict.items():
            setattr(artisan, key, val)
        db.commit()
        db.refresh(artisan)
        return artisan

    def get_studio_metrics(self, db: Session, artisan_id: str) -> dict:
        total_products = db.query(Product).filter(Product.artisan_id == artisan_id).count()

        # Find orders that contain products by this artisan
        items = (
            db.query(OrderItem)
            .join(Product, OrderItem.product_id == Product.id)
            .filter(Product.artisan_id == artisan_id)
            .all()
        )

        total_orders = len(set(item.order_id for item in items))
        total_payout = sum(item.artisan_share * item.quantity for item in items)

        return {
            'artisan_id': artisan_id,
            'active_listings': total_products,
            'total_orders': total_orders,
            'total_payout_inr': round(total_payout, 2),
            'currency': 'INR',
            'bank_account_verified': True,
        }


artisan_service = ArtisanService()
