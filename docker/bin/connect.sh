#!/bin/bash
########################################################################################################################
### connect
########################################################################################################################

# include config
DIR=`dirname $(readlink -f $0)`
source "$DIR/config.sh"
cd `dirname $DIR`
sudo docker exec -it "${DOCKER_PREFIX}php" bash