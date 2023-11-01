import flask as f
from flask import current_app as app
from jinja2.exceptions import TemplateNotFound

pages = f.Blueprint("pages", __name__, template_folder="templates")


@pages.route("/", defaults={"path": "index"})
@pages.route("/<path:path>")
def catch_all(path):
    print(path)
    try:
        if path.startswith("_"):
            raise TemplateNotFound(path)
        return f.render_template(f"{path}.html.j2", path=path)
    except TemplateNotFound:
        return f"Not found: {path}", 404
