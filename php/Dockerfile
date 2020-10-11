FROM ubuntu:20.04

## install packages
RUN apt update -y && \
    apt upgrade -y && \
    apt install -yq software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -yq curl sudo mysql-client \
    php7.4 php7.4-fpm php7.4-common php7.4-xml php7.4-zip php7.4-mbstring php7.4-curl php7.4-mysql php7.4-pdo php-xdebug \ 
    php7.4-mongodb php7.4-msgpack php7.4-igbinary php-memcached php7.4-pgsql && \
    apt clean && rm -rf /var/lib/apt/lists/*


## Create required dirs
RUN mkdir -p /run/php/

## PHP Configuration
COPY ./conf/php.ini /etc/php/7.4/fpm/php.ini
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4","--nodaemonize","--fpm-config","/etc/php/7.4/fpm/php-fpm.conf"]
