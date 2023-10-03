import flask as f
from flask import current_app as app

pages = f.Blueprint("pages", __name__, template_folder="templates")


@pages.route("/")
def home():
    return "Hello, world!"
