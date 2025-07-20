#!/bin/bash

## Colors for terminal
RED='\e[91m'
YELLOW='\e[93m'
NC='\e[0m'

## Infection version
VER_INFECTION=0.30.3

cd /tmp/php_tools

## Update composer
## ---------------
printf "\n${RED}Update composer${NC}\n"
./composer selfupdate -vvv
./composer --version

## Update phpunit
## --------------
printf "\n${RED}Update phpunit${NC}\n"
./phpunit --check-version
rm phpunit
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
mv phpunit.phar phpunit
./phpunit --check-version

## Update php-cs-fixer
## -------------------
printf "\n${RED}Update php-cs-fixer${NC}\n"
PHP_CS_FIXER_IGNORE_ENV=1 ./php-cs-fixer selfupdate
PHP_CS_FIXER_IGNORE_ENV=1 ./php-cs-fixer --version

## Update infection
## ----------------
printf "\n${RED}Update infection${NC}\n"
rm infection
wget https://github.com/infection/infection/releases/download/$VER_INFECTION/infection.phar
chmod +x infection.phar
mv infection.phar infection
./infection --version

## Copy all to sbin
## ----------------
printf "\n${RED}Copy all to sbin${NC}\n"
sudo cp * /usr/local/sbin