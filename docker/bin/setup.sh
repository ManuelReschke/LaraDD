#!/bin/bash

set -e

### Start Docker Setup
DIR=`dirname $(readlink -f $0)`
source $DIR/config.sh

# create folders
mkdir -p log
sudo chmod -R 777 log

# fix permissions
#sudo chmod -R 777 log laravel/storage laravel/node_modules laravel/public

# start container
sudo docker-compose up -d

# prevent mysql connection problem
sleep 4

# composer update und install
docker-compose exec laravel_php composer update
docker-compose exec laravel_php composer install

# install laravel
docker-compose exec laravel_php ./vendor/bin/laravel new laravel -f

# fix permissions
sudo chmod -R 777 laravel

# create db
#bash docker/bin/artisan.sh migrate

# seed db
#bash docker/bin/artisan.sh db:seed

# run deployment
#....

cat << EOF
############################################
Laravel

http:  http://localhost:8888
https: https://localhost:8889
############################################
EOF
