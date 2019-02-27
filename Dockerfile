
# https://github.com/nginx-modules/docker-nginx-boringssl
# https://github.com/TrafeX/docker-php-nginx
FROM denji/nginx-boringssl:mainline-alpine
LABEL Maintainer="Fork from Tim de Pater docker image <code@trafex.nl>" \
      Description="Lightweight container with Nginx 1.14 & PHP-FPM 7.3 based on Alpine Linux."

# https://github.com/codecasts/php-alpine
ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
RUN apk --no-cache --update add ca-certificates
RUN echo "@php https://php.codecasts.rocks/v3.9/php-7.3" >> /etc/apk/repositories

# Install packages
RUN apk --no-cache add --update php7@php php7-fpm@php php7-json@php php7-openssl@php php7-curl@php \
    php7-zlib@php php7-xml@php php7-phar@php php7-intl@php php7-dom@php php7-xmlreader@php php7-ctype@php \
    php7-mbstring@php php7-gd@php supervisor curl php7-sqlite3@php sqlite-libs php7-common@php php7-pdo_sqlite@php php7-tokenizer@php

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/zzz_custom.conf
COPY config/php.ini /etc/php7/conf.d/zzz_custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add application
RUN mkdir -p /var/www/html
WORKDIR /var/www/html
#COPY src/ /var/www/html/

EXPOSE 80 443
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
