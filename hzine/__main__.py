import os

from waitress import serve

from hzine import create_app

if __name__ == "__main__":
    app = create_app()
    serve(app, host="127.0.0.1", port=os.environ.get("PORT", 8080))
