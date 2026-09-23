from app.integrations.shiprocket_client import ShiprocketClient


class ShippingService:
    def __init__(self):
        self.client = ShiprocketClient()

    def create_shipment(self, order_id: str, address: str) -> dict:
        return self.client.create_shipment(order_id=order_id, address=address)

    def track_shipment(self, awb_code: str) -> dict:
        return self.client.track_shipment(awb_code=awb_code)


shipping_service = ShippingService()
