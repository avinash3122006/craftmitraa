# Architecture Overview

This document describes the overall project architecture for CraftMitra AI.

## Layers

- Frontend: Flutter mobile application
- Backend: FastAPI REST API
- AI Engine: multimodal AI processing for voice, vision, and recommendations
- Database: PostgreSQL
- Cloud media: Cloudinary

## Domain flow

1. Artisan uploads product image and voice input.
2. Backend forwards requests to the AI engine.
3. AI engine extracts product and price signals.
4. Artisan reviews and publishes.
5. Customer browses and buys.
6. Orders and payments are tracked via backend services.
