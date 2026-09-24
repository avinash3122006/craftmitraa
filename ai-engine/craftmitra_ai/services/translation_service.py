from google import genai

from config import settings


class TranslationService:

    def __init__(self):

        self.client = None

        if (
            not settings.ai_mock_mode
            and settings.gemini_api_key
        ):
            self.client = genai.Client(
                api_key=settings.gemini_api_key
            )

    async def translate(
        self,
        text: str,
        source_language: str = "auto",
        target_language: str = "en"
    ):

        if not text:
            return {
                "translated_text": ""
            }

        # --------------------------------
        # MOCK
        # --------------------------------

        if settings.ai_mock_mode:

            return {
                "translated_text": text,
                "target_language": target_language
            }

        # --------------------------------
        # GEMINI
        # --------------------------------

        if not self.client:

            raise RuntimeError(
                "Gemini API is not configured"
            )

        prompt = f"""
Translate the following product description
from language: {source_language}
into language code: {target_language}

Preserve the meaning and artisan story.

Text:

{text}

Return only the translated text.
"""

        response = self.client.models.generate_content(
            model=settings.gemini_model,
            contents=prompt
        )

        return {
            "translated_text": response.text.strip(),
            "target_language": target_language
        }