
from pydantic import BaseSettings, DirectoryPath


class Settings(BaseSettings):
    DATA_DIR: DirectoryPath | None = None
    USE_GLOBAL_PLUGINS: bool = True
    VALIDATE_UPDATES: bool = False

    class Config:
        env_prefix = "MOVICI_FLOW_"
