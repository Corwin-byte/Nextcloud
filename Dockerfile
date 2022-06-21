FROM alpine:3.11

ADD https://php.hernandev.com/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

RUN apk --update-cache add ca-certificates && \
    echo "https://php.hernandev.com/v3.11/php-7.4" >> /etc/apk/repositories
RUN apk --update --no-cache add ca-certificates nginx


# install php and some extensions
RUN apk add --update-cache \
    php \
    php-common \
    php-gd \
    php-xmlreader \
    php-bcmath \
    php-ctype \
    php-curl \
    php-exif \
    php-iconv \
    php-intl \
    php-mbstring \
    php-opcache \
    php-openssl \
    php-pcntl \
    php-phar \
    php-session \
    php-xml \
    php-xsl \
    php-zip \
    php-zlib \
    php-dom \
    php-fpm \
    php-pdo \
    php-mysqli \
    php-json \
    php-pdo_sqlite\
    php-sqlite3 \
    # sqlite
    sqlite 
USER container
ENV  USER container
ENV HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/ash", "/entrypoint.sh"]