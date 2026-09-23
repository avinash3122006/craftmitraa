from fastapi import HTTPException, status
from sqlalchemy import or_
from sqlalchemy.orm import Session

from app.models.product import Product
from app.models.product_image import ProductImage
from app.schemas.product_schema import ProductCreate, ProductUpdate


class ProductService:
    def create_product(self, db: Session, artisan_id: str, data: ProductCreate) -> Product:
        product_dict = data.model_dump(exclude={'image_urls'})
        product = Product(artisan_id=artisan_id, **product_dict)
        db.add(product)
        db.flush()

        # Add image records
        for i, url in enumerate(data.image_urls):
            img = ProductImage(
                product_id=product.id,
                image_url=url,
                is_primary=(i == 0),
            )
            db.add(img)

        db.commit()
        db.refresh(product)
        return product

    def get_product(self, db: Session, product_id: str) -> Product:
        product = db.query(Product).filter(Product.id == product_id).first()
        if not product:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail='Product not found',
            )
        return product

    def list_products(
        self,
        db: Session,
        category: str | None = None,
        search: str | None = None,
        only_verified: bool = False,
        skip: int = 0,
        limit: int = 50,
    ) -> list[Product]:
        query = db.query(Product)

        if category and category != 'All':
            query = query.filter(Product.category == category)

        if only_verified:
            query = query.filter(Product.is_verified_craft.is_(True))

        if search:
            search_filter = f'%{search}%'
            query = query.filter(
                or_(
                    Product.name.ilike(search_filter),
                    Product.description.ilike(search_filter),
                    Product.category.ilike(search_filter),
                    Product.material.ilike(search_filter),
                )
            )

        return query.order_by(Product.created_at.desc()).offset(skip).limit(limit).all()

    def update_product(
        self,
        db: Session,
        product_id: str,
        artisan_id: str,
        data: ProductUpdate,
    ) -> Product:
        product = self.get_product(db, product_id)
        if product.artisan_id != artisan_id:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail='Not authorized to edit this product',
            )

        update_dict = data.model_dump(exclude_unset=True, exclude={'image_urls'})
        for key, val in update_dict.items():
            setattr(product, key, val)

        if data.image_urls is not None:
            # Clear old images and set new
            db.query(ProductImage).filter(ProductImage.product_id == product.id).delete()
            for i, url in enumerate(data.image_urls):
                img = ProductImage(
                    product_id=product.id,
                    image_url=url,
                    is_primary=(i == 0),
                )
                db.add(img)

        db.commit()
        db.refresh(product)
        return product

    def delete_product(self, db: Session, product_id: str, artisan_id: str) -> None:
        product = self.get_product(db, product_id)
        if product.artisan_id != artisan_id:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail='Not authorized to delete this product',
            )
        db.delete(product)
        db.commit()


product_service = ProductService()
