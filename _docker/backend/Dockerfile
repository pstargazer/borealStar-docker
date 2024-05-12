# FROM debian:bookworm
FROM alpine:latest
FROM php:8.1-fpm-alpine
FROM composer:latest

# FROM nginx

COPY ./_docker/backend/conf.d/crontab /var/spool/cron/crontabs/
# RUN /usr/bin/crontab /etc/crontabs
COPY ./_docker/backend/conf.d/crontab /etc/crontabs

# ENV master
ENV CMD_PATH /var/www/html/


WORKDIR "/var/www/html/"
COPY ./backend/ .

# RUN pwd
# RUN ls -l

RUN apk add php81-pgsql \
            php81-pdo_pgsql \
            libpq-dev  
            # prerequesite for pgsql 
ADD _docker/backend/php.ini /usr/local/etc/php.ini

RUN docker-php-ext-configure pdo_pgsql

RUN docker-php-ext-install pdo_pgsql


COPY _docker/backend/entrypoint.sh /tmp/
RUN chmod 777 /tmp/entrypoint.sh

RUN composer install

EXPOSE 80
EXPOSE 443
ENTRYPOINT [ "/bin/bash", "/tmp/entrypoint.sh" ]
# CMD ["php", "artisan", "serve"]
