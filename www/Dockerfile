FROM ubuntu:19.10

## install packages
RUN apt update -y && \
    #apt upgrade -y && \
    apt install -yq software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -yq supervisor apache2 libapache2-mod-fcgid curl sudo mysql-client \
    php7.4 php7.4-fpm php7.4-common php7.4-xml php7.4-zip php7.4-mbstring php7.4-curl php7.4-mysql php7.4-pdo php-xdebug && \
    apt clean && rm -rf /var/lib/apt/lists/*


RUN a2enmod actions fcgid alias proxy_fcgi rewrite ssl && \
    a2dissite 000-default default-ssl

## Create required dirs
RUN mkdir -p /run/php/ && \
    mkdir /etc/apache2/ssl

## Switch to working dir
#WORKDIR /var/www/html

## Copy all project file
#COPY ./source.tar.gz /var/www/html/source.tar.gz
#RUN tar -zxvf /var/www/html/source.tar.gz && \
#    ls -la /var/www/html && \
## Set proper file permissions
#    find . -type f -exec chmod 644 {} + -o -type d -exec chmod 755 {} + && \
#    chown -R root:root . && \
#    chown -R www-data:www-data /var/www/html/public/support_uploads && \
#    chmod -R 666 /var/www/html/src/Templates/_shared

## Copy site configuration
#COPY ./php/.env /var/www/html
#COPY ./php/config.php /var/www/html/config

## PHP Configuration
COPY ./php/php.ini /etc/php/7.4/fpm
#COPY ./php/www.conf /etc/php/7.4/fpm/pool.d

## Apache configuration
RUN rm /etc/apache2/sites-available/*

#COPY ./apache/apache2.conf /etc/apache2
#COPY ./apache/security.conf /etc/apache2/conf-available
COPY ./apache/fcgid.conf /etc/apache2/mods-available
COPY ./apache/site.conf /etc/apache2/sites-available/site.conf
COPY ./apache/site_ssl.conf /etc/apache2/sites-available/site_ssl.conf

RUN a2ensite site site_ssl

ENV APACHE_RUN_USER  sebastian
ENV APACHE_RUN_GROUP sebastian
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_PID_FILE  /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2

RUN mkdir -p $APACHE_RUN_DIR && \
    mkdir -p $APACHE_LOCK_DIR && \
    mkdir -p $APACHE_LOG_DIR && \
    mkdir -p /etc/apache2/ssl

## Apache SSL certificate
## Disable this when a valid certificate is available
RUN openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -subj \
    "/C=US/CN=localhost" \
    -keyout /tmp/ssl.key -out /tmp/ssl.crt && \
    ls -la /tmp && \
    cp /tmp/ssl.key /etc/apache2/ssl && \
    cp /tmp/ssl.crt /etc/apache2/ssl

## Supervisord configuration
COPY ./supervisord/supervisord.conf /etc/supervisor/supervisord.conf
COPY ./supervisord/conf.d/apache.conf /etc/supervisor/conf.d/apache.conf
COPY ./supervisord/conf.d/php-fpm.conf /etc/supervisor/conf.d/php-fpm.conf

# Startup script to change uid/gid (if environment variable passed) and start supervisord in foreground
COPY ./start.sh /start.sh
RUN chmod 755 /start.sh

## Clean
#RUN rm index.html && \
    #rm -R ./.git && \
#    rm *.sql && \
#    rm source.tar.gz && \
#   rm README.md

EXPOSE 443
EXPOSE 80

CMD ["/bin/bash", "/start.sh"]