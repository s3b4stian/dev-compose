#!/bin/bash

export CURRENT_USER=$USER
cp docker-compose.tpl docker-compose.yml
sed -i "s/__CURRENT_USER__/${CURRENT_USER}/g" docker-compose.yml
docker-compose config > config.log
docker-compose build
