#!/usr/bin/env bash
########################################################################################################################
### artisan
########################################################################################################################

# include config
DIR=`dirname $(readlink -f $0)`
source "$DIR/config.sh"
cd `dirname $DIR`
sudo docker exec -itu $(id -u) "${DOCKER_PREFIX}php" php laravel/artisan "$@"