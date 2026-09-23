import uuid

from fastapi import HTTPException, status
from sqlalchemy.orm import Session

from app.integrations.razorpay_client import RazorpayClient
from app.models.order import Order
from app.models.payment import Payment
from app.schemas.payment_schema import PaymentCreate


class PaymentService:
    def __init__(self):
        self.razorpay = RazorpayClient()

    def process_payment(self, db: Session, data: PaymentCreate) -> Payment:
        order = db.query(Order).filter(Order.id == data.order_id).first()
        if not order:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail='Order not found',
            )

        # Create simulated payment transaction
        mock_rzp = self.razorpay.create_order(amount=data.amount)
        tx_id = f'txn_cm_{uuid.uuid4().hex[:12]}'

        payment = Payment(
            order_id=order.id,
            payment_id=mock_rzp['id'],
            transaction_id=tx_id,
            status='COMPLETED',
            amount=data.amount,
            payment_method=data.payment_method,
        )
        db.add(payment)

        # Mark order as confirmed / placed
        order.status = 'PLACED'
        db.commit()
        db.refresh(payment)
        return payment

    def get_order_payments(self, db: Session, order_id: str) -> list[Payment]:
        return db.query(Payment).filter(Payment.order_id == order_id).all()


payment_service = PaymentService()
