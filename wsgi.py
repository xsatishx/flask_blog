from init_db import initDB
from app import app

initDB()

if __name__ == "__main__":
        app.run()
