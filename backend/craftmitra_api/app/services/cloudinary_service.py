from app.integrations.cloudinary_client import CloudinaryClient


class CloudinaryService:
    def __init__(self):
        self.client = CloudinaryClient()

    def upload_image(self, file_content: bytes | str | None = None, filename: str | None = None) -> dict:
        return self.client.upload_image(file_content=file_content, filename=filename)


cloudinary_service = CloudinaryService()
