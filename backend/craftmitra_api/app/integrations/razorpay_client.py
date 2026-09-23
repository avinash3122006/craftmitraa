import uuid


class RazorpayClient:
    """Mock Razorpay Client that simulates Indian payment gateway orders

    and transaction verification without live Razorpay merchant API keys.
    """

    def __init__(self):
        self.mock_mode = True

    def create_order(self, amount: float, currency: str = 'INR', receipt: str | None = None) -> dict:
        mock_order_id = f'order_rzp_mock_{uuid.uuid4().hex[:12]}'
        return {
            'id': mock_order_id,
            'entity': 'order',
            'amount': int(amount * 100),  # In paise
            'currency': currency,
            'receipt': receipt or f'rcpt_{uuid.uuid4().hex[:8]}',
            'status': 'created',
        }

    def verify_payment_signature(self, params: dict) -> bool:
        # In mock mode, automatically succeeds
        return True
