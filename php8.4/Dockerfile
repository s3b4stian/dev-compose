FROM ubuntu:24.04

## install packages
RUN apt-get update -y && \
    apt-get install -yq software-properties-common wget && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update -y

## separate layer
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq apt-utils curl sudo mysql-client \
    php8.4 php8.4-fpm php8.4-common php8.4-xml php8.4-zip php8.4-mbstring php8.4-curl php8.4-mysql php8.4-pdo php8.4-xdebug \ 
    php8.4-msgpack php8.4-igbinary php8.4-memcached php8.4-pgsql php8.4-mongodb php8.4-redis && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

## Create required dirs
RUN mkdir -p /run/php/ && mkdir /php_tools

## PHP Configuration
COPY ./conf/php.ini /etc/php/8.4/fpm/php.ini
COPY ./conf/www.conf /etc/php/8.4/fpm/pool.d/www.conf

## PHP tools
COPY ./tools/* /php_tools
RUN chmod +x /php_tools/*.sh && /php_tools/install-php-tools.sh

EXPOSE 9000

CMD ["/usr/sbin/php-fpm8.4","--nodaemonize","--fpm-config","/etc/php/8.4/fpm/php-fpm.conf"]
