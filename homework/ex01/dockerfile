FROM httpd:2.4
#
ARG CREATOR
ARG BUILD_OS_VERSION

LABEL creator=$CREATOR
LABEL build.environment.os.version=$BUILD_OS_VERSION
#
COPY ./html/default-index.html /usr/local/apache2/htdocs/index.html
EXPOSE 80
