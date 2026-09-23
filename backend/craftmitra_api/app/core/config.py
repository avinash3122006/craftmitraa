from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    app_name: str = 'CraftMitra API'
    # Default to local SQLite so backend runs immediately without live PostgreSQL requirement
    database_url: str = 'sqlite:///./craftmitra.db'
    jwt_secret_key: str = 'craftmitra_super_secret_jwt_key_2026_heritage'
    jwt_algorithm: str = 'HS256'
    access_token_expire_minutes: int = 60 * 24  # 24 hours
    cors_origins: list[str] = ['*']

    class Config:
        env_file = '.env'
        extra = 'ignore'


settings = Settings()
