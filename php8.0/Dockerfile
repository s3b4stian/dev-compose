FROM ubuntu:20.04

## install packages
RUN apt update -y && \
    apt upgrade -y && \
    apt install -yq software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -yq curl sudo mysql-client \
    php8.0 php8.0-fpm php8.0-common php8.0-xml php8.0-zip php8.0-mbstring php8.0-curl php8.0-mysql php8.0-pdo php8.0-xdebug \ 
    php8.0-msgpack php8.0-igbinary php8.0-memcached php8.0-pgsql && \
    apt clean && rm -rf /var/lib/apt/lists/* 


## Create required dirs
RUN mkdir -p /run/php/

## PHP Configuration
COPY ./conf/php.ini /etc/php/8.0/fpm/php.ini
COPY ./conf/www.conf /etc/php/8.0/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["/usr/sbin/php-fpm8.0","--nodaemonize","--fpm-config","/etc/php/8.0/fpm/php-fpm.conf"]
