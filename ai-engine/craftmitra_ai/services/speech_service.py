import httpx

from config import settings


class SpeechService:

    async def transcribe(
        self,
        audio_bytes: bytes,
        filename: str,
        language: str | None = None
    ):

        # -------------------------------
        # MOCK MODE
        # -------------------------------

        if settings.ai_mock_mode:

            return {
                "text": (
                    "This is a handmade bamboo basket "
                    "made using traditional weaving techniques. "
                    "It is suitable for home decoration and storage."
                ),
                "language": language or "en",
                "confidence": 0.96
            }

        # -------------------------------
        # SARVAM API
        # -------------------------------

        if not settings.sarvam_api_key:
            raise RuntimeError(
                "SARVAM_API_KEY is not configured"
            )

        headers = {
            "api-subscription-key": settings.sarvam_api_key
        }

        files = {
            "file": (
                filename,
                audio_bytes,
                "audio/wav"
            )
        }

        data = {
            "model": settings.sarvam_stt_model
        }

        if language:
            data["language_code"] = language

        async with httpx.AsyncClient(timeout=120) as client:

            response = await client.post(
                settings.sarvam_stt_url,
                headers=headers,
                files=files,
                data=data
            )

        response.raise_for_status()

        result = response.json()

        text = (
            result.get("transcript")
            or result.get("text")
            or ""
        )

        detected_language = (
            result.get("language_code")
            or language
            or "unknown"
        )

        return {
            "text": text,
            "language": detected_language,
            "confidence": result.get(
                "confidence",
                0.0
            )
        }