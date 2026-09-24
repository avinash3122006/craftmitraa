from contextlib import asynccontextmanager

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.core.config import settings
from app.database.base import Base
from app.database.database import engine

# Routes
from app.routes.ai_routes import router as ai_router
from app.routes.artisan_routes import router as artisan_router
from app.routes.auth_routes import router as auth_router
from app.routes.order_routes import router as order_router
from app.routes.payment_routes import router as payment_router
from app.routes.product_routes import router as product_router
from app.routes.search_routes import router as search_router
from app.routes.shipping_routes import router as shipping_router
from app.routes.user_routes import router as user_router


# ============================================================
# DATABASE LIFESPAN
# ============================================================

@asynccontextmanager
async def lifespan(app: FastAPI):
    """
    Runs when the FastAPI application starts and stops.
    """

    # Create database tables if they don't already exist
    try:
        Base.metadata.create_all(bind=engine)
        print("✅ Database tables initialized")
    except Exception as e:
        print(f"❌ Database initialization failed: {e}")

    yield

    # Shutdown logic can be added here if required
    print("🛑 CraftMitra API shutting down")


# ============================================================
# FASTAPI APPLICATION
# ============================================================

app = FastAPI(
    title="CraftMitra AI API",
    description=(
        "Backend API connecting rural artisans with customers "
        "through AI-powered product creation, cultural storytelling, "
        "fair pricing, marketplace search, payments, and shipping."
    ),
    version="1.0.0",
    lifespan=lifespan,
)


# ============================================================
# CORS CONFIGURATION
# ============================================================

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# ============================================================
# API ROUTES
# ============================================================

API_PREFIX = "/api/v1"

# Authentication
app.include_router(
    auth_router,
    prefix=API_PREFIX,
)

# Users
app.include_router(
    user_router,
    prefix=API_PREFIX,
)

# Artisans
app.include_router(
    artisan_router,
    prefix=API_PREFIX,
)

# Products
app.include_router(
    product_router,
    prefix=API_PREFIX,
)

# Orders
app.include_router(
    order_router,
    prefix=API_PREFIX,
)

# Payments
app.include_router(
    payment_router,
    prefix=API_PREFIX,
)

# Search
app.include_router(
    search_router,
    prefix=API_PREFIX,
)

# Shipping
app.include_router(
    shipping_router,
    prefix=API_PREFIX,
)

# AI
app.include_router(
    ai_router,
    prefix=API_PREFIX,
)


# ============================================================
# ROOT ENDPOINT
# ============================================================

@app.get("/", tags=["root"])
def root():
    """
    Basic API information.
    """
    return {
        "message": "Welcome to CraftMitra AI API",
        "service": "CraftMitra AI Backend",
        "version": "1.0.0",
        "status": "running",
        "docs": "/docs",
    }


# ============================================================
# HEALTH CHECK
# ============================================================

@app.get("/health", tags=["health"])
def health_check():
    """
    Check whether the backend is running.
    """
    return {
        "status": "healthy",
        "service": "CraftMitra AI Backend",
        "version": "1.0.0",
    }


# ============================================================
# AI SERVICE HEALTH CHECK
# ============================================================

@app.get("/api/v1/system/health", tags=["health"])
async def system_health():
    """
    Basic backend system health endpoint.
    """

    return {
        "backend": "healthy",
        "database": "configured",
        "ai_engine": "connected through AI client",
        "status": "healthy",
    }