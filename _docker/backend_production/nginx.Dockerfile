FROM php:8.1-fpm

# RUN sudo apt install openssl php-bcmath php-curl php-json php-mbstring php-mysql php-tokenizer php-xml php-zip

FROM nginx:latest
# COPY ./conf.d/ /etc/nginx/conf.d

EXPOSE 80
EXPOSE 443