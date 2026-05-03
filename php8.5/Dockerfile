FROM ubuntu:24.04

## install packages
RUN apt-get update -y && \
    apt-get install -yq software-properties-common wget && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update -y

## separate layer
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq apt-utils curl git sudo mysql-client postgresql-client \
    php8.5 php8.5-fpm php8.5-common php8.5-xml php8.5-zip php8.5-mbstring php8.5-curl php8.5-mysql php8.5-pdo php8.5-xdebug \ 
    php8.5-msgpack php8.5-igbinary php8.5-memcached php8.5-pgsql php8.5-mongodb php8.5-redis && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

## set ubuntu user password
RUN echo "ubuntu:ubuntu" | chpasswd

## Create required dirs
RUN mkdir -p /run/php/ && mkdir /php_tools

## PHP Configuration
COPY ./conf/php.ini /etc/php/8.5/fpm/php.ini
COPY ./conf/www.conf /etc/php/8.5/fpm/pool.d/www.conf

## PHP tools
COPY ./tools/* /php_tools
RUN chmod +x /php_tools/*.sh && /php_tools/install-php-tools.sh

WORKDIR /var/www/html

EXPOSE 9000

CMD ["/usr/sbin/php-fpm8.5","--nodaemonize","--fpm-config","/etc/php/8.5/fpm/php-fpm.conf"]
