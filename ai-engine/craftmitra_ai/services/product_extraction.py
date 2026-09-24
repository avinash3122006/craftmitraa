import json

from google import genai
from google.genai import types

from config import settings


class ProductExtractionService:

    def __init__(self):

        self.client = None

        if (
            not settings.ai_mock_mode
            and settings.gemini_api_key
        ):
            self.client = genai.Client(
                api_key=settings.gemini_api_key
            )

    async def extract(
        self,
        image_bytes: bytes,
        image_content_type: str,
        voice_text: str,
        language: str = "en"
    ):

        # --------------------------------
        # MOCK RESPONSE
        # --------------------------------

        if settings.ai_mock_mode:

            return {
                "suggested_title":
                    "Handwoven Bamboo Basket",

                "category":
                    "Home Decor",

                "generated_description":
                    (
                        "A beautifully handcrafted bamboo basket "
                        "created using traditional hand-weaving "
                        "techniques. Its natural texture and "
                        "durable construction make it suitable "
                        "for storage and home decoration."
                    ),

                "cultural_story":
                    (
                        "This basket represents traditional "
                        "artisan craftsmanship and hand-weaving "
                        "knowledge passed through generations."
                    ),

                "detected_materials": [
                    "Bamboo"
                ],

                "suggested_fair_price_min": 400,

                "suggested_fair_price_max": 600,

                "recommended_price": 499,

                "estimated_labor_hours": 5,

                "suggested_tags": [
                    "handmade",
                    "bamboo",
                    "handwoven",
                    "eco-friendly",
                    "home-decor"
                ],

                "confidence_score": 0.94,

                "sustainability_rating": "High"
            }

        # --------------------------------
        # GEMINI
        # --------------------------------

        if not self.client:

            raise RuntimeError(
                "Gemini API is not configured"
            )

        prompt = f"""
You are an AI assistant for rural Indian artisans.

The artisan described the product in:
{language}

Artisan voice transcription:

{voice_text}

Analyze the image and the artisan's description together.

Generate a structured product listing.

Return ONLY JSON:

{{
  "suggested_title": "",
  "category": "",
  "generated_description": "",
  "cultural_story": "",
  "detected_materials": [],
  "suggested_fair_price_min": 0,
  "suggested_fair_price_max": 0,
  "recommended_price": 0,
  "estimated_labor_hours": 0,
  "suggested_tags": [],
  "confidence_score": 0,
  "sustainability_rating": ""
}}

Important:
- Preserve the artisan's meaning.
- Do not make unsupported cultural claims.
- Do not guarantee that a price is fair or market-accurate.
- Price should be treated as an estimate.
"""

        image_part = types.Part.from_bytes(
            data=image_bytes,
            mime_type=image_content_type
        )

        response = self.client.models.generate_content(
            model=settings.gemini_model,
            contents=[
                prompt,
                image_part
            ]
        )

        text = response.text.strip()

        if text.startswith("```"):
            text = text.replace("```json", "")
            text = text.replace("```", "")
            text = text.strip()

        return json.loads(text)