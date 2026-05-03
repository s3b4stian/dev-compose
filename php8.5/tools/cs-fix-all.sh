#!/bin/bash

USER=sebastian

RED='\033[1;31m'
NC='\033[0m' # No Color

cd /var/www/html

repos=($(sed ':a;N;$!ba;s/\n/ /g' /php_tools/repository.txt))

for r in "${repos[@]}"
do
   printf "${RED}$r${NC}\n"
   PHP_CS_FIXER_IGNORE_ENV=1 php-cs-fixer fix /var/www/html/$r --rules=@PSR2,no_whitespace_in_blank_line,return_type_declaration,native_function_invocation --allow-risky=yes
   printf "\n\n"
done
