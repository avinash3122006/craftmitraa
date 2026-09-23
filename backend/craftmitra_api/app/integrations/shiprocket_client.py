import random
import uuid


class ShiprocketClient:
    """Mock Shiprocket Client that simulates courier dispatch and tracking

    without requiring live logistics API tokens.
    """

    def __init__(self):
        self.mock_mode = True

    def create_shipment(self, order_id: str, address: str) -> dict:
        awb = f'AWB-INDPOST-{random.randint(10000000, 99999999)}'
        return {
            'order_id': order_id,
            'shipment_id': f'ship_{uuid.uuid4().hex[:8]}',
            'awb_code': awb,
            'courier_name': 'India Post Rural Surface',
            'status': 'PICKUP_SCHEDULED',
            'estimated_delivery': '4-6 business days',
        }

    def track_shipment(self, awb_code: str) -> dict:
        return {
            'awb_code': awb_code,
            'current_status': 'In Transit - Dispatched from Village Cluster',
            'location': 'Molela Postal Substation, Rajasthan',
        }
