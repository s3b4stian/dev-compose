#!/bin/bash

source config.sh

## Create directory or clean if already present
## --------------------------------------------
printf "${RED}Create directory or clean if already present${NC}\n"

mkdir /tmp/php_tools
rm /tmp/php_tools/*


## Download PHP tools
## ------------------
printf "${RED}Download PHP tools${NC}\n"

### PHP cs Fixer
#wget https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/$VER_CS_FIXER/php-cs-fixer.phar -P /tmp/php_tools
curl -sL https://api.github.com/repos/FriendsOfPHP/PHP-CS-Fixer/releases/latest | grep "php-cs-fixer.phar" | cut -d : -f 2,3 | tr -d \" | head -n 2 | tail -n 1 | wget -i - -P /tmp/php_tools
### Composer
wget https://getcomposer.org/composer-stable.phar -P /tmp/php_tools
### PHPunit
wget https://phar.phpunit.de/phpunit.phar -P /tmp/php_tools
### Infection
#wget https://github.com/infection/infection/releases/download/$VER_INFECTION/infection.phar -P /tmp/php_tools
curl -sL https://api.github.com/repos/infection/infection/releases/latest | grep "infection.phar" | cut -d : -f 2,3 | tr -d \" | head -n 2 | tail -n 1 | wget -i - -P /tmp/php_tools
### PHP Documentor
wget https://phpdoc.org/phpDocumentor.phar -P /tmp/php_tools


## Make all executable
## -------------------
printf "${RED}Make all executable${NC}\n"

cd /tmp/php_tools

mv php-cs-fixer.phar php-cs-fixer
mv composer-stable.phar composer
mv phpunit.phar phpunit
mv infection.phar infection
mv phpDocumentor.phar php-doc

chmod +x php-cs-fixer
chmod +x composer
chmod +x phpunit
chmod +x infection
chmod +x php-doc

## Copy scripts
## ------------
printf "${RED}Copy scripts${NC}\n"

cp /php_tools/update-all-tools.sh /tmp/php_tools/update-all-tools
cp /php_tools/cs-fix-all.sh /tmp/php_tools/cs-fix-all
chmod +x /tmp/php_tools/update-all-tools
chmod +x /tmp/php_tools/cs-fix-all

## Copy all to sbin
## ----------------
printf "${RED}Copy all to sbin${NC}\n"
sudo cp /tmp/php_tools/* /usr/local/sbin

# make link to permit the compressed phar to work
#sudo ln -s /usr/local/sbin/php-doc.phar php-doc

PHP_CS_FIXER_IGNORE_ENV=1 php-cs-fixer --version
composer --version
phpunit --version
infection --version
php-doc --version
