import flask as f

from .pages import pages


def create_app():
    app = f.Flask("hzine")

    with app.app_context():
        app.register_blueprint(pages, url_prefix="/")

    return app
