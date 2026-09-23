import uuid


class CloudinaryClient:
    """Mock Cloudinary Client that simulates image asset upload without requiring

    external Cloudinary API credentials or cloud accounts.
    """

    def __init__(self):
        self.mock_mode = True

    def upload_image(self, file_content: bytes | str | None = None, filename: str | None = None) -> dict:
        public_id = f'craftmitra_mock_{uuid.uuid4().hex[:10]}'
        return {
            'public_id': public_id,
            'url': f'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&w=800&q=80',
            'secure_url': f'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&w=800&q=80',
            'format': 'jpg',
            'bytes': 204800,
        }

    def upload(self):
        return self.upload_image()
