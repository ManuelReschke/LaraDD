#!/bin/bash
########################################################################################################################
### composer
########################################################################################################################

# include config
DIR=`dirname $(readlink -f $0)`
source "$DIR/config.sh"
cd `dirname $DIR`
sudo docker exec -itu $(id -u) "${DOCKER_PREFIX}php" composer "$@" -d laravel