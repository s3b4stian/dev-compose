FROM ubuntu:20.04

## install packages
RUN apt-get update -y && \
    apt-get install -yq software-properties-common && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq apt-utils curl sudo mysql-client \
    php8.1 php8.1-fpm php8.1-common php8.1-xml php8.1-zip php8.1-mbstring php8.1-curl php8.1-mysql php8.1-pdo php8.1-xdebug \ 
    php8.1-msgpack php8.1-igbinary php8.1-memcached php8.1-pgsql php8.1-mongodb && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 


## Create required dirs
RUN mkdir -p /run/php/

## PHP Configuration
COPY ./conf/php.ini /etc/php/8.1/fpm/php.ini
COPY ./conf/www.conf /etc/php/8.1/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["/usr/sbin/php-fpm8.1","--nodaemonize","--fpm-config","/etc/php/8.1/fpm/php-fpm.conf"]
