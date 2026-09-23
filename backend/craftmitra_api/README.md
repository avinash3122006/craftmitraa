# CraftMitra AI Backend (FastAPI)

Production-ready backend service connecting rural Indian artisans with conscious modern buyers through direct fair trade, cultural storytelling, and AI assistance.

## Architecture

- **Web Framework**: FastAPI with Pydantic v2 schemas and CORS middleware
- **ORM & Database**: SQLAlchemy 2.0 with PostgreSQL support and zero-config local SQLite fallback (`sqlite:///./craftmitra.db`)
- **Security & Authentication**: JWT Access Tokens (HS256) with standard bcrypt password hashing
- **Mock Integrations**: Self-contained mock adapters for Razorpay, Shiprocket, Cloudinary, and AI Engine so no live 3rd-party credentials or paid API keys are required for development.

## Setup & Running

### 1. Install Dependencies
```bash
pip install -r requirements.txt
```

### 2. Seed Initial Craft Data
Populate master artisans (Molela pottery, Chanderi silk, Madhubani painting, Bastar Dhokra) and initial users:
```bash
python ../../database/seeds/seed_data.py
```

### 3. Start the API Server
```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### 4. Interactive API Documentation
- Swagger UI: [http://localhost:8000/docs](http://localhost:8000/docs)
- ReDoc: [http://localhost:8000/redoc](http://localhost:8000/redoc)
- Health Check: [http://localhost:8000/health](http://localhost:8000/health)

## Main API Modules

- `POST /api/v1/auth/register` & `/login`: JWT user and artisan authentication
- `GET /api/v1/artisans/`: Master artisan profiles, legacy years, and studio metrics
- `GET /api/v1/products/`: Filterable craft catalog (Terracotta, Handloom, Madhubani, Brass, Wood, Eco)
- `POST /api/v1/products/create`: Artisan craft listing
- `POST /api/v1/orders/create`: Customer checkout with 85%+ direct artisan share calculation
- `POST /api/v1/payments/process`: Simulated instant direct-to-artisan payment settlement
- `POST /api/v1/ai/speech-to-text`: Multilingual voice transcription
- `POST /api/v1/ai/analyze-product`: Multimodal craft analysis and fair-price estimation
