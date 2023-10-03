from waitress import serve
from website import create_app

if __name__ == "__main__":
    app = create_app()
    serve(app, host="0.0.0.0", port="9000")
