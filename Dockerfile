# Build SCSS to CSS
    FROM dart:stable AS scss_build
    COPY --from=bufbuild/buf /usr/local/bin/buf /usr/local/bin/

    WORKDIR /dart-sass
    RUN git clone https://github.com/sass/dart-sass.git . && \
        dart pub get && \
        dart run grinder protobuf

    COPY hzine/scss /scss
    RUN dart ./bin/sass.dart /scss/main.scss /build.css

# Run Flask webapp
    FROM python:3-alpine AS flask
    WORKDIR /build

    COPY hzine/requirements.txt .
    RUN pip install --no-cache-dir -r requirements.txt

    COPY --from=scss_build /build.css hzine/static/build.css

    COPY . .
    CMD [ "python", "-m", "hzine" ]
