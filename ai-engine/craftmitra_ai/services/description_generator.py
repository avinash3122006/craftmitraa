from google import genai

from config import settings


class DescriptionGenerator:

    def __init__(self):

        self.client = None

        if (
            not settings.ai_mock_mode
            and settings.gemini_api_key
        ):
            self.client = genai.Client(
                api_key=settings.gemini_api_key
            )

    async def generate(
        self,
        product_name: str,
        material: str,
        craft_type: str,
        artisan_story: str = "",
        language: str = "en"
    ):

        if settings.ai_mock_mode:

            return {
                "title":
                    product_name,

                "description":
                    (
                        f"This handmade {product_name.lower()} "
                        f"is crafted using {material} through "
                        f"traditional {craft_type.lower()} "
                        f"techniques."
                    ),

                "features": [
                    "Handmade",
                    f"Material: {material}",
                    f"Craft: {craft_type}",
                    "Unique artisan craftsmanship"
                ]
            }

        if not self.client:

            raise RuntimeError(
                "Gemini API is not configured"
            )

        prompt = f"""
Create an e-commerce listing.

Product:
{product_name}

Material:
{material}

Craft:
{craft_type}

Artisan story:
{artisan_story}

Language:
{language}

Return concise JSON:

{{
  "title": "",
  "description": "",
  "features": []
}}
"""

        response = self.client.models.generate_content(
            model=settings.gemini_model,
            contents=prompt
        )

        text = response.text.strip()

        if text.startswith("```"):
            text = text.replace("```json", "")
            text = text.replace("```", "")
            text = text.strip()

        import json

        return json.loads(text)