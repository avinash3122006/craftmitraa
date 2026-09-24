import os

from dotenv import load_dotenv


load_dotenv()


class Settings:

    # General
    app_name: str = "CraftMitra AI Engine"
    version: str = "1.0.0"

    # Mock mode
    ai_mock_mode: bool = (
        os.getenv("AI_MOCK_MODE", "true").lower() == "true"
    )

    # Gemini
    gemini_api_key: str = os.getenv(
        "GEMINI_API_KEY",
        ""
    )

    gemini_model: str = os.getenv(
        "GEMINI_MODEL",
        "gemini-2.5-flash"
    )

    # Sarvam
    sarvam_api_key: str = os.getenv(
        "SARVAM_API_KEY",
        ""
    )

    sarvam_stt_url: str = os.getenv(
        "SARVAM_STT_URL",
        "https://api.sarvam.ai/speech-to-text"
    )

    sarvam_stt_model: str = os.getenv(
        "SARVAM_STT_MODEL",
        "saaras:v4"
    )

    # Cloudinary
    cloudinary_cloud_name: str = os.getenv(
        "CLOUDINARY_CLOUD_NAME",
        ""
    )

    cloudinary_api_key: str = os.getenv(
        "CLOUDINARY_API_KEY",
        ""
    )

    cloudinary_api_secret: str = os.getenv(
        "CLOUDINARY_API_SECRET",
        ""
    )

    # Price model
    price_model_path: str = os.getenv(
        "PRICE_MODEL_PATH",
        "models/pricing_model.pkl"
    )


settings = Settings()