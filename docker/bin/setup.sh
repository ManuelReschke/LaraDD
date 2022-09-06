#!/bin/bash

set -e

### Start Docker Setup
DIR=`dirname $(readlink -f $0)`
source $DIR/config.sh

# create folders
mkdir -p log

# fix permissions
#sudo chmod -R 777 log laravel/storage laravel/node_modules laravel/public

# start container
docker-compose up -d

# prevent mysql connection problem
sleep 4

# composer update und install
docker-compose exec laravel_php composer update
docker-compose exec laravel_php composer install

# install laravel
docker-compose exec laravel_php ./vendor/bin/laravel new laravel

# fix permissions
sudo chown -R $USERID:$GROUPID laravel log

# set correct mysql data to env
sed -i -e 's/DB_HOST=127.0.0.1/DB_HOST=laravel_mysql/g' laravel/.env
sed -i -e 's/DB_DATABASE=laravel/DB_DATABASE=app/g' laravel/.env
sed -i -e 's/DB_USERNAME=root/DB_USERNAME=dev/g' laravel/.env
sed -i -e 's/DB_PASSWORD=/DB_PASSWORD=password/g' laravel/.env

# create db
bash docker/bin/artisan.sh migrate

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
