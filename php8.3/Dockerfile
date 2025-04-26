FROM ubuntu:24.04

## install packages
RUN apt-get update -y && \
    apt-get install -yq software-properties-common wget && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update -y

## separate layer
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq apt-utils curl sudo mysql-client \
    php8.3 php8.3-fpm php8.3-common php8.3-xml php8.3-zip php8.3-mbstring php8.3-curl php8.3-mysql php8.3-pdo php8.3-xdebug \ 
    php8.3-msgpack php8.3-igbinary php8.3-memcached php8.3-pgsql php8.3-mongodb php8.3-redis && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

## Create required dirs
RUN mkdir -p /run/php/ && mkdir /php_tools

## PHP Configuration
COPY ./conf/php.ini /etc/php/8.3/fpm/php.ini
COPY ./conf/www.conf /etc/php/8.3/fpm/pool.d/www.conf

## PHP tools
COPY ./tools/* /php_tools
RUN chmod +x /php_tools/*.sh && /php_tools/install-php-tools.sh

EXPOSE 9000

CMD ["/usr/sbin/php-fpm8.3","--nodaemonize","--fpm-config","/etc/php/8.3/fpm/php-fpm.conf"]
