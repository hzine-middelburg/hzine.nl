import os

from waitress import serve

from hzine import create_app

if __name__ == "__main__":
    app = create_app()
    serve(app, host="0.0.0.0", port=80)
