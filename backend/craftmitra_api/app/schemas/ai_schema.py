from pydantic import BaseModel


class SpeechToTextRequest(BaseModel):
    audio_base64: str | None = None
    language: str = 'Hindi'


class SpeechToTextResponse(BaseModel):
    transcript: str
    language: str
    confidence: float = 0.95


class AIProductAnalyzeRequest(BaseModel):
    image_url: str | None = None
    voice_text: str | None = None
    language: str = 'Hindi'


class AIProductAnalyzeResponse(BaseModel):
    suggested_title: str
    category: str
    generated_description: str
    cultural_story: str
    detected_materials: list[str]
    suggested_fair_price_min: float
    suggested_fair_price_max: float
    recommended_price: float
    estimated_labor_hours: int
    suggested_tags: list[str]
    confidence_score: float = 0.94
    sustainability_rating: str = '100% Eco-friendly & Biodegradable'
