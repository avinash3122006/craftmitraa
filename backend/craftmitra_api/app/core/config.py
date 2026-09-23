from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    app_name: str = 'CraftMitra API'
    database_url: str = 'postgresql://craftmitra:craftmitra@localhost:5432/craftmitra'
    jwt_secret_key: str = 'change_this_secret_key'
    jwt_algorithm: str = 'HS256'

    class Config:
        env_file = '.env'


settings = Settings()
