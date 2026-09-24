from pathlib import Path

from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    app_name: str = 'CraftMitra API'
    # Keep a single shared SQLite database at the repo root so the app and seed scripts stay in sync
    project_root: Path = Path(__file__).resolve().parents[4]
    database_url: str = f"sqlite:///{(project_root / 'craftmitra.db').as_posix()}"
    jwt_secret_key: str = 'craftmitra_super_secret_jwt_key_2026_heritage'
    jwt_algorithm: str = 'HS256'
    access_token_expire_minutes: int = 60 * 24  # 24 hours
    cors_origins: list[str] = ['*']

    class Config:
        env_file = '.env'
        extra = 'ignore'


settings = Settings()
