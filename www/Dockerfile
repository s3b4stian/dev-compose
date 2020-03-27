FROM ubuntu:19.10

## install packages
RUN apt update -y && \
    apt upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt install -yq apache2  && \
    apt clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod actions alias proxy_fcgi rewrite ssl && \
    a2dissite 000-default default-ssl

## Create required dirs
RUN mkdir -p /run/php/ && \
    mkdir /etc/apache2/ssl

## Apache configuration
RUN rm /etc/apache2/sites-available/*

COPY ./apache/php7.4-fpm.conf /etc/apache2/conf-enabled/php7.4-fpm.conf
COPY ./apache/site.conf /etc/apache2/sites-available/site.conf
COPY ./apache/site_ssl.conf /etc/apache2/sites-available/site_ssl.conf

RUN a2ensite site site_ssl

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
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

EXPOSE 443
EXPOSE 80

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]