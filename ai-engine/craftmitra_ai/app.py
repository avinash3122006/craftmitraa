from fastapi import (
    FastAPI,
    File,
    Form,
    HTTPException,
    UploadFile
)

from fastapi.responses import Response

from config import settings

from services.speech_service import (
    SpeechService
)

from services.language_service import (
    LanguageService
)

from services.vision_service import (
    VisionService
)

from services.product_extraction import (
    ProductExtractionService
)

from services.description_generator import (
    DescriptionGenerator
)

from services.translation_service import (
    TranslationService
)

from services.image_enhancement import (
    ImageEnhancementService
)

from services.pricing_service import (
    PricingService
)

from services.buyer_matching import (
    BuyerMatchingService
)


# ============================================================
# APP
# ============================================================

app = FastAPI(
    title="CraftMitra AI Engine",
    description=(
        "AI microservice for CraftMitra "
        "multimodal artisan commerce."
    ),
    version="1.0.0"
)


# ============================================================
# SERVICES
# ============================================================

speech_service = SpeechService()
language_service = LanguageService()
vision_service = VisionService()
product_service = ProductExtractionService()
description_service = DescriptionGenerator()
translation_service = TranslationService()
image_service = ImageEnhancementService()
pricing_service = PricingService()
matching_service = BuyerMatchingService()


# ============================================================
# ROOT
# ============================================================

@app.get("/")
async def root():

    return {
        "service": "CraftMitra AI Engine",
        "version": settings.version,
        "status": "running"
    }


# ============================================================
# HEALTH
# ============================================================

@app.get("/health")
async def health():

    return {
        "status": "healthy",
        "service": "CraftMitra AI Engine",
        "mock_mode": settings.ai_mock_mode,
        "gemini_configured": bool(
            settings.gemini_api_key
        ),
        "sarvam_configured": bool(
            settings.sarvam_api_key
        )
    }


# ============================================================
# SPEECH TO TEXT
# ============================================================

@app.post("/api/v1/ai/speech-to-text")
async def speech_to_text(
    file: UploadFile = File(...),
    language: str | None = Form(None)
):

    try:

        audio_bytes = await file.read()

        result = await speech_service.transcribe(
            audio_bytes=audio_bytes,
            filename=file.filename or "audio.wav",
            language=language
        )

        return result

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )


# ============================================================
# ANALYZE PRODUCT
# ============================================================

@app.post("/api/v1/ai/analyze-product")
async def analyze_product(
    image: UploadFile = File(...),
    voice_text: str = Form(""),
    language: str = Form("en")
):

    try:

        image_bytes = await image.read()

        # --------------------------------
        # Language
        # --------------------------------

        detected_language = (
            language_service.detect(
                voice_text
            )
            if voice_text
            else language
        )

        # --------------------------------
        # Vision
        # --------------------------------

        vision_result = await vision_service.analyze(
            image_bytes=image_bytes,
            filename=image.filename or "product.jpg",
            content_type=image.content_type
            or "image/jpeg"
        )

        # --------------------------------
        # Product extraction
        # --------------------------------

        product_result = await product_service.extract(
            image_bytes=image_bytes,
            image_content_type=image.content_type
            or "image/jpeg",
            voice_text=voice_text,
            language=detected_language
        )

        return {
            "success": True,
            "language": detected_language,
            "vision": vision_result,
            "product": product_result
        }

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )


# ============================================================
# GENERATE DESCRIPTION
# ============================================================

@app.post("/api/v1/ai/generate-description")
async def generate_description(
    product_name: str = Form(...),
    material: str = Form(""),
    craft_type: str = Form(""),
    artisan_story: str = Form(""),
    language: str = Form("en")
):

    try:

        result = await description_service.generate(
            product_name=product_name,
            material=material,
            craft_type=craft_type,
            artisan_story=artisan_story,
            language=language
        )

        return {
            "success": True,
            **result
        }

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )


# ============================================================
# TRANSLATE
# ============================================================

@app.post("/api/v1/ai/translate")
async def translate(
    text: str = Form(...),
    source_language: str = Form("auto"),
    target_language: str = Form(...)
):

    try:

        result = await translation_service.translate(
            text=text,
            source_language=source_language,
            target_language=target_language
        )

        return {
            "success": True,
            **result
        }

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )


# ============================================================
# IMAGE ENHANCEMENT
# ============================================================

@app.post("/api/v1/ai/enhance-image")
async def enhance_image(
    image: UploadFile = File(...)
):

    try:

        image_bytes = await image.read()

        enhanced = image_service.enhance(
            image_bytes
        )

        return Response(
            content=enhanced,
            media_type="image/jpeg",
            headers={
                "X-AI-Processed": "true"
            }
        )

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )


# ============================================================
# PRICE ESTIMATION
# ============================================================

@app.post("/api/v1/ai/estimate-price")
async def estimate_price(
    category: str = Form(...),
    craft_type: str = Form(...),
    material: str = Form(...),
    state: str = Form(...),
    size: str = Form(...),
    material_qty_kg: float = Form(...),
    labor_hours: float = Form(...),
    material_cost_inr: float = Form(...),
    labor_cost_inr: float = Form(...),
    overhead_cost_inr: float = Form(...)
):

    try:

        result = await pricing_service.estimate(
            category=category,
            craft_type=craft_type,
            material=material,
            state=state,
            size=size,
            material_qty_kg=material_qty_kg,
            labor_hours=labor_hours,
            material_cost_inr=material_cost_inr,
            labor_cost_inr=labor_cost_inr,
            overhead_cost_inr=overhead_cost_inr
        )

        return {
            "success": True,
            **result
        }

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )


# ============================================================
# BUYER MATCHING
# ============================================================

@app.post("/api/v1/ai/match-products")
async def match_products(
    query: str = Form(...),
    products_json: str = Form("[]")
):

    try:

        import json

        products = json.loads(
            products_json
        )

        result = await matching_service.match(
            query=query,
            products=products
        )

        return {
            "success": True,
            **result
        }

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )