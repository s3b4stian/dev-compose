#!/bin/bash

: ${WWW_UID:=33}
: ${WWW_GID:=33}

usermod -u $WWW_UID www-data
groupmod -g $WWW_GID www-data

# Give mysql container time to start
sleep 30

# Very bad solution but now in the only available
mysql -uroot -ppassword -hmysql -e "CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED WITH caching_sha2_password BY 'Admin1Admin1'"
mysql -uroot -ppassword -hmysql -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%'"
mysql -uroot -ppassword -hmysql -e "FLUSH PRIVILEGES"

# Start supervisord and services
exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf