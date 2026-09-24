import os
from typing import Optional

import httpx


class AIClient:
    """
    Client used by CraftMitra backend to communicate
    with the separate CraftMitra AI Engine.
    """

    def __init__(self):
        self.base_url = os.getenv(
            "AI_ENGINE_URL",
            "http://127.0.0.1:8100"
        ).rstrip("/")

        self.timeout = float(
            os.getenv(
                "AI_ENGINE_TIMEOUT",
                "120"
            )
        )

    # --------------------------------------------------
    # HEALTH
    # --------------------------------------------------

    async def health(self) -> dict:

        async with httpx.AsyncClient(
            timeout=10
        ) as client:

            response = await client.get(
                f"{self.base_url}/health"
            )

            response.raise_for_status()

            return response.json()

    # --------------------------------------------------
    # SPEECH TO TEXT
    # --------------------------------------------------

    async def speech_to_text(
        self,
        audio_bytes: bytes,
        filename: str
    ) -> dict:

        files = {
            "file": (
                filename,
                audio_bytes
            )
        }

        async with httpx.AsyncClient(
            timeout=self.timeout
        ) as client:

            response = await client.post(

                f"{self.base_url}"
                "/api/v1/ai/speech-to-text",

                files=files
            )

            response.raise_for_status()

            return response.json()

    # --------------------------------------------------
    # PRODUCT ANALYSIS
    # --------------------------------------------------

    async def analyze_product(
        self,
        image_bytes: bytes,
        filename: str,
        voice_text: str = "",
        language: str = "auto",
        content_type: str = "image/jpeg"
    ) -> dict:

        files = {
            "image": (
                filename,
                image_bytes,
                content_type
            )
        }

        data = {
            "voice_text": voice_text,
            "language": language
        }

        async with httpx.AsyncClient(
            timeout=self.timeout
        ) as client:

            response = await client.post(

                f"{self.base_url}"
                "/api/v1/ai/analyze-product",

                files=files,

                data=data
            )

            response.raise_for_status()

            return response.json()

    # --------------------------------------------------
    # DESCRIPTION
    # --------------------------------------------------

    async def generate_description(
        self,
        product_name: str,
        material: str = "",
        craft_type: str = "",
        usage: str = "",
        story: str = "",
        language: str = "English"
    ) -> dict:

        data = {
            "product_name": product_name,
            "material": material,
            "craft_type": craft_type,
            "usage": usage,
            "artisan_story": story,
            "language": language
        }

        async with httpx.AsyncClient(
            timeout=self.timeout
        ) as client:

            response = await client.post(

                f"{self.base_url}"
                "/api/v1/ai/generate-description",

                data=data
            )

            response.raise_for_status()

            return response.json()

    # --------------------------------------------------
    # TRANSLATION
    # --------------------------------------------------

    async def translate(
        self,
        text: str,
        source_language: str,
        target_language: str
    ) -> dict:

        data = {
            "text": text,
            "source_language": source_language,
            "target_language": target_language
        }

        async with httpx.AsyncClient(
            timeout=self.timeout
        ) as client:

            response = await client.post(

                f"{self.base_url}"
                "/api/v1/ai/translate",

                data=data
            )

            response.raise_for_status()

            return response.json()

    # --------------------------------------------------
    # PRICE PREDICTION
    # --------------------------------------------------

    async def estimate_price(
        self,
        material: str,
        category: str,
        craft_type: str,
        state: str,
        size: str,
        material_qty_kg: float,
        labor_hours: float,
        material_cost: float,
        labor_cost: float,
        overhead_cost: float
    ) -> dict:

        data = {
            "material": material,
            "category": category,
            "craft_type": craft_type,
            "state": state,
            "size": size,
            "material_qty_kg": str(material_qty_kg),
            "labor_hours": str(labor_hours),
            "material_cost_inr": str(material_cost),
            "labor_cost_inr": str(labor_cost),
            "overhead_cost_inr": str(overhead_cost)
        }

        async with httpx.AsyncClient(
            timeout=self.timeout
        ) as client:

            response = await client.post(

                f"{self.base_url}"
                "/api/v1/ai/estimate-price",

                data=data
            )

            response.raise_for_status()

            return response.json()

    # --------------------------------------------------
    # IMAGE ENHANCEMENT
    # --------------------------------------------------

    async def enhance_image(
        self,
        image_bytes: bytes,
        filename: str
    ) -> dict:

        files = {
            "image": (
                filename,
                image_bytes
            )
        }

        async with httpx.AsyncClient(
            timeout=self.timeout
        ) as client:

            response = await client.post(

                f"{self.base_url}"
                "/api/v1/ai/enhance-image",

                files=files
            )

            response.raise_for_status()

            return response.json()