# Build SCSS to CSS
    FROM dart:stable AS scss_build
    COPY --from=bufbuild/buf /usr/local/bin/buf /usr/local/bin/

    WORKDIR /dart-sass
    RUN git clone https://github.com/sass/dart-sass.git . && \
        dart pub get && \
        dart run grinder protobuf

    COPY src/scss /scss
    RUN dart ./bin/sass.dart /scss/main.scss /build.css

# Minify CSS
    FROM node:alpine as css_minify

    RUN npm install clean-css-cli -g

    COPY --from=scss_build /build.css /build.css
    RUN cleancss /build.css -O2 -o /build.min.css

# Run Flask webapp
    FROM python:3-alpine AS flask
    WORKDIR /build

    COPY owdex/requirements.txt .
    RUN pip install --no-cache-dir -r requirements.txt

    COPY --from=css_minify /build.min.css src/static/build.css

    COPY . .
    CMD [ "python", "-m", "hzine" ]
