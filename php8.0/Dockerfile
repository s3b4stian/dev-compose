FROM ubuntu:20.04

## install packages
RUN apt-get update -y && \
    apt-get install -yq software-properties-common && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq curl sudo mysql-client \
    php8.0 php8.0-fpm php8.0-common php8.0-xml php8.0-zip php8.0-mbstring php8.0-curl php8.0-mysql php8.0-pdo php8.0-xdebug \ 
    php8.0-msgpack php8.0-igbinary php8.0-memcached php8.0-pgsql php8.0-mongodb && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 


## Create required dirs
RUN mkdir -p /run/php/

## PHP Configuration
COPY ./conf/php.ini /etc/php/8.0/fpm/php.ini
COPY ./conf/www.conf /etc/php/8.0/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["/usr/sbin/php-fpm8.0","--nodaemonize","--fpm-config","/etc/php/8.0/fpm/php-fpm.conf"]
