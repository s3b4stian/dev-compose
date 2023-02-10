FROM ubuntu:22.04

## install packages
RUN apt-get update -y && \
    apt-get install -yq software-properties-common && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    apt-get upgrade -y

## separate layer
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq apt-utils curl sudo mysql-client \
    php8.2 php8.2-fpm php8.2-common php8.2-xml php8.2-zip php8.2-mbstring php8.2-curl php8.2-mysql php8.2-pdo php8.2-xdebug \ 
    php8.2-msgpack php8.2-igbinary php8.2-memcached php8.2-pgsql php8.2-mongodb php8.2-redis && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

## Create required dirs
RUN mkdir -p /run/php/

## PHP Configuration
COPY ./conf/php.ini /etc/php/8.2/fpm/php.ini
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["/usr/sbin/php-fpm8.2","--nodaemonize","--fpm-config","/etc/php/8.2/fpm/php-fpm.conf"]
