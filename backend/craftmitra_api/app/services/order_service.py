from fastapi import HTTPException, status
from sqlalchemy.orm import Session

from app.models.order import Order
from app.models.order_item import OrderItem
from app.models.product import Product
from app.schemas.order_schema import OrderCreate


class OrderService:
    def create_order(self, db: Session, user_id: str, data: OrderCreate) -> Order:
        if not data.items:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail='Order must contain at least one item',
            )

        total_amount = 0.0
        total_artisan_contribution = 0.0
        order_items_to_add = []

        for item_in in data.items:
            product = db.query(Product).filter(Product.id == item_in.product_id).first()
            if not product:
                raise HTTPException(
                    status_code=status.HTTP_404_NOT_FOUND,
                    detail=f'Product {item_in.product_id} not found',
                )

            if product.stock_quantity < item_in.quantity:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail=f'Insufficient stock for {product.name}',
                )

            unit_price = product.price
            artisan_share = (unit_price * product.artisan_share_percent) / 100.0

            total_amount += unit_price * item_in.quantity
            total_artisan_contribution += artisan_share * item_in.quantity

            # Deduct stock
            product.stock_quantity -= item_in.quantity

            order_item = OrderItem(
                product_id=product.id,
                quantity=item_in.quantity,
                unit_price=unit_price,
                artisan_share=artisan_share,
            )
            order_items_to_add.append(order_item)

        order = Order(
            user_id=user_id,
            total_amount=total_amount,
            artisan_contribution=total_artisan_contribution,
            status='PLACED',
            delivery_address=data.delivery_address,
            payment_method=data.payment_method,
        )
        db.add(order)
        db.flush()

        for oi in order_items_to_add:
            oi.order_id = order.id
            db.add(oi)

        db.commit()
        db.refresh(order)
        return order

    def get_order(self, db: Session, order_id: str) -> Order:
        order = db.query(Order).filter(Order.id == order_id).first()
        if not order:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail='Order not found',
            )
        return order

    def list_user_orders(self, db: Session, user_id: str) -> list[Order]:
        return (
            db.query(Order)
            .filter(Order.user_id == user_id)
            .order_by(Order.created_at.desc())
            .all()
        )

    def list_artisan_orders(self, db: Session, artisan_id: str) -> list[Order]:
        return (
            db.query(Order)
            .join(OrderItem, Order.id == OrderItem.order_id)
            .join(Product, OrderItem.product_id == Product.id)
            .filter(Product.artisan_id == artisan_id)
            .distinct()
            .order_by(Order.created_at.desc())
            .all()
        )

    def update_order_status(self, db: Session, order_id: str, new_status: str) -> Order:
        order = self.get_order(db, order_id)
        order.status = new_status
        db.commit()
        db.refresh(order)
        return order


order_service = OrderService()
