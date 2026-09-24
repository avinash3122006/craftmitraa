import base64
import json

from google import genai
from google.genai import types

from config import settings


class VisionService:

    def __init__(self):

        self.client = None

        if (
            not settings.ai_mock_mode
            and settings.gemini_api_key
        ):
            self.client = genai.Client(
                api_key=settings.gemini_api_key
            )

    async def analyze(
        self,
        image_bytes: bytes,
        filename: str,
        content_type: str
    ):

        # -------------------------------
        # MOCK
        # -------------------------------

        if settings.ai_mock_mode:

            return {
                "product_type": "Basket",
                "visual_description": (
                    "Handmade woven bamboo basket"
                ),
                "materials": [
                    "Bamboo"
                ],
                "craft_type": "Handwoven",
                "colors": [
                    "Natural Brown"
                ],
                "shape": "Round",
                "quality_observations": [
                    "Visible handwoven pattern",
                    "Natural bamboo texture",
                    "Traditional craftsmanship"
                ]
            }

        # -------------------------------
        # GEMINI VISION
        # -------------------------------

        if not self.client:

            raise RuntimeError(
                "Gemini API is not configured"
            )

        prompt = """
Analyze this artisan-made product image.

Return ONLY valid JSON with:

{
  "product_type": "",
  "visual_description": "",
  "materials": [],
  "craft_type": "",
  "colors": [],
  "shape": "",
  "quality_observations": []
}

Do not invent details that cannot reasonably
be observed from the image.
"""

        image_part = types.Part.from_bytes(
            data=image_bytes,
            mime_type=content_type
        )

        response = self.client.models.generate_content(
            model=settings.gemini_model,
            contents=[
                prompt,
                image_part
            ]
        )

        text = response.text.strip()

        # Remove markdown JSON fences if present
        if text.startswith("```"):
            text = text.replace("```json", "")
            text = text.replace("```", "")
            text = text.strip()

        return json.loads(text)