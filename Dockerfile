FROM alpine


# install php and some extensions
RUN apk update
RUN apk --no-cache upgrade

# Install apache from packages with out caching install files
RUN apk add --no-cache apache2 php$phpverx-apache2

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
RUN sed -i 's#^DocumentRoot ".*#DocumentRoot "/home/container/webroot"#g' /etc/apache2/httpd.conf && \
    sed -i 's#AllowOverride [Nn]one#AllowOverride All#' /etc/apache2/httpd.conf && \
    sed -i 's#^ServerRoot .*#ServerRoot /home/container#g'  /etc/apache2/httpd.conf && \
    sed -i 's/^#ServerName.*/ServerName 0.0.0.0/' /etc/apache2/httpd.conf && \
    sed -i 's#^IncludeOptional /etc/apache2/conf#IncludeOptional /home/container/apache/apache.conf#g' /etc/apache2/httpd.conf && \
    sed -i 's#PidFile "/run/.*#Pidfile "/home/container/apache/run/httpd.pid"#g'  /etc/apache2/conf.d/mpm.conf && \
    sed -i 's#Directory "/var/www/localhost/htdocs.*#Directory "/home/container/webroot" >#g' /etc/apache2/httpd.conf && \
    sed -i 's#Directory "/var/www/localhost/cgi-bin.*#Directory "/home/container/webroot" >#g' /etc/apache2/httpd.conf && \
    sed -i 's#/var/log/apache2/#/web/logs/#g' /etc/logrotate.d/apache2 && \
    sed -i 's/Options Indexes/Options /g' /etc/apache2/httpd.conf && \
    rm -rf /var/cache/apk/*
VOLUME /home/container
# Creat directory for apache2 to store PID file
USER container
ENV USER container
ENV HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/ash", "/entrypoint.sh"]