from fastapi import (
    APIRouter,
    UploadFile,
    File,
    Form,
    HTTPException
)

from app.integrations.ai_client import AIClient


router = APIRouter(
    prefix="/ai",
    tags=["AI"]
)


ai_client = AIClient()


# ==================================================
# AI ENGINE HEALTH
# ==================================================

@router.get("/health")
async def ai_health():

    try:

        return await ai_client.health()

    except Exception as e:

        raise HTTPException(
            status_code=503,
            detail=f"AI Engine unavailable: {str(e)}"
        )


# ==================================================
# SPEECH TO TEXT
# ==================================================

@router.post("/speech-to-text")
async def speech_to_text(
    file: UploadFile = File(...)
):

    try:

        audio_bytes = await file.read()

        if not audio_bytes:

            raise HTTPException(
                status_code=400,
                detail="Audio file is empty"
            )

        result = await ai_client.speech_to_text(

            audio_bytes,

            file.filename or "audio.wav"
        )

        return result

    except HTTPException:

        raise

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )


# ==================================================
# ANALYZE PRODUCT
# ==================================================

@router.post("/analyze-product")
async def analyze_product(

    image: UploadFile = File(...),

    voice_text: str = Form(""),

    language: str = Form("auto")
):

    try:

        image_bytes = await image.read()

        if not image_bytes:

            raise HTTPException(
                status_code=400,
                detail="Image is empty"
            )


        result = await ai_client.analyze_product(

            image_bytes=image_bytes,

            filename=(
                image.filename
                or "product.jpg"
            ),

            voice_text=voice_text,

            language=language,

            content_type=(
                image.content_type
                or "image/jpeg"
            )
        )


        return result


    except HTTPException:

        raise

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )


# ==================================================
# DESCRIPTION
# ==================================================

@router.post("/generate-description")
async def generate_description(

    product_name: str = Form(...),

    material: str = Form(""),

    craft_type: str = Form(""),

    usage: str = Form(""),

    story: str = Form(""),

    language: str = Form("English")
):

    try:

        return await ai_client.generate_description(

            product_name,

            material,

            craft_type,

            usage,

            story,

            language
        )

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )


# ==================================================
# TRANSLATION
# ==================================================

@router.post("/translate")
async def translate(

    text: str = Form(...),

    source_language: str = Form("auto"),

    target_language: str = Form("English")
):

    try:

        return await ai_client.translate(

            text,

            source_language,

            target_language
        )

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )


# ==================================================
# PRICE
# ==================================================

@router.post("/estimate-price")
async def estimate_price(

    material: str = Form(""),

    category: str = Form(""),

    craft_type: str = Form(""),

    state: str = Form("Tamil Nadu"),

    size: str = Form("Medium"),

    material_qty_kg: float = Form(1.0),

    labor_hours: float = Form(1.0),

    material_cost: float = Form(0.0),

    labor_cost: float = Form(0.0),

    overhead_cost: float = Form(0.0)
):

    try:

        return await ai_client.estimate_price(

            material,

            category,

            craft_type,

            state,

            size,

            material_qty_kg,

            labor_hours,

            material_cost,

            labor_cost,

            overhead_cost
        )

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )


# ==================================================
# IMAGE ENHANCEMENT
# ==================================================

@router.post("/enhance-image")
async def enhance_image(

    file: UploadFile = File(...)
):

    try:

        image_bytes = await file.read()

        return await ai_client.enhance_image(

            image_bytes,

            file.filename or "product.jpg"
        )

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=str(e)
        )