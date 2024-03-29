#!/usr/bin/env bash
########################################################################################################################
### artisan
########################################################################################################################

# include config
DIR=`dirname $(readlink -f $0)`
source "$DIR/config.sh"
cd `dirname $DIR`
sudo docker exec -itu $(id -u) "${DOCKER_PREFIX}php" bash -c 'cd laravel ; npm run dev ; npm run watch'