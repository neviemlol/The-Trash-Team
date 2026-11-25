import os
from pathlib import Path
import psycopg2
from dotenv import load_dotenv

BASE_DIR = Path(__file__).resolve().parent
ENV_FILE = BASE_DIR / ".env"

load_dotenv(dotenv_path=ENV_FILE)

def get_db_connection():
    return psycopg2.connect(
        host = os.environ["DB_HOST"],
        user = os.environ["DB_USER"],
        dbname = os.environ["DB_NAME"],
        password = os.environ["DB_PASSWORD"],
        port = os.environ["DB_PORT"]
        )
        
                            
        
