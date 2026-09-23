from contextlib import asynccontextmanager

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.core.config import settings
from app.database.base import Base
from app.database.database import engine
from app.routes.ai_routes import router as ai_router
from app.routes.artisan_routes import router as artisan_router
from app.routes.auth_routes import router as auth_router
from app.routes.order_routes import router as order_router
from app.routes.payment_routes import router as payment_router
from app.routes.product_routes import router as product_router
from app.routes.search_routes import router as search_router
from app.routes.shipping_routes import router as shipping_router
from app.routes.user_routes import router as user_router


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Ensure database schema is created on startup
    Base.metadata.create_all(bind=engine)
    yield


app = FastAPI(
    title='CraftMitra AI API',
    description='Backend API connecting rural artisans with conscious buyers through fair trade, cultural storytelling, and AI assistance.',
    version='1.0.0',
    lifespan=lifespan,
)

# CORS middleware for mobile & web clients
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins,
    allow_credentials=True,
    allow_methods=['*'],
    allow_headers=['*'],
)

# Register API Routers
app.include_router(auth_router, prefix='/api/v1')
app.include_router(user_router, prefix='/api/v1')
app.include_router(artisan_router, prefix='/api/v1')
app.include_router(product_router, prefix='/api/v1')
app.include_router(order_router, prefix='/api/v1')
app.include_router(payment_router, prefix='/api/v1')
app.include_router(search_router, prefix='/api/v1')
app.include_router(shipping_router, prefix='/api/v1')
app.include_router(ai_router, prefix='/api/v1')


@app.get('/health', tags=['health'])
def health_check():
    return {
        'status': 'healthy',
        'service': 'CraftMitra AI Backend',
        'version': '1.0.0',
    }
