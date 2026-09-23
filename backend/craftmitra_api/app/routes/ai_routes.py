from fastapi import APIRouter

from app.integrations.ai_client import AIClient
from app.schemas.ai_schema import (
    AIProductAnalyzeRequest,
    AIProductAnalyzeResponse,
    SpeechToTextRequest,
    SpeechToTextResponse,
)

router = APIRouter(prefix='/ai', tags=['ai'])
ai_client = AIClient()


@router.post('/speech-to-text', response_model=SpeechToTextResponse)
def speech_to_text(req: SpeechToTextRequest):
    res = ai_client.speech_to_text(audio_data=req.audio_base64, language=req.language)
    return SpeechToTextResponse(
        transcript=res['transcript'],
        language=res['language'],
        confidence=res['confidence'],
    )


@router.post('/analyze-product', response_model=AIProductAnalyzeResponse)
def analyze_product(req: AIProductAnalyzeRequest):
    res = ai_client.analyze_product_multimodal(
        image_url=req.image_url,
        voice_text=req.voice_text,
        language=req.language,
    )
    return AIProductAnalyzeResponse(
        suggested_title=res['suggested_title'],
        category=res['category'],
        generated_description=res['generated_description'],
        cultural_story=res['cultural_story'],
        detected_materials=res['detected_materials'],
        suggested_fair_price_min=res['suggested_fair_price_min'],
        suggested_fair_price_max=res['suggested_fair_price_max'],
        recommended_price=res['recommended_price'],
        estimated_labor_hours=res['estimated_labor_hours'],
        suggested_tags=res['suggested_tags'],
        confidence_score=res['confidence_score'],
        sustainability_rating=res['sustainability_rating'],
    )
