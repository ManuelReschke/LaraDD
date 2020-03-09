#!/bin/bash

set -e

######################################################################
# this script removes all container and images from current project! #
######################################################################

# include config
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/config.sh

COMMAND_DOCKER_PS="docker ps --all --filter \"name=${DOCKER_PREFIX}\" --format \"{{.ID}}\t{{.Names}}\""
COMMAND_DOCKER_IMAGES="docker images --filter=reference='*${DOCKER_PREFIX}*' --format \"{{.ID}}\t{{.Repository}}\""
COMMAND_DOCKER_STOP="sudo docker stop $(eval $COMMAND_DOCKER_PS | awk '{printf "%s ", $1}')"
COMMAND_DOCKER_RM="sudo docker rm --force $(eval $COMMAND_DOCKER_PS | awk '{printf "%s ", $1}')"
COMMAND_DOCKER_RMI="sudo docker rmi --force $(eval $COMMAND_DOCKER_IMAGES | awk '{printf "%s ", $1}')"

echo -e ""
echo -e "\e[34mContainers that will be deleted: \e[0m";
eval $COMMAND_DOCKER_PS
echo -e ""
echo -e "\e[34mImages that will be deleted: \e[0m";
eval $COMMAND_DOCKER_IMAGES

echo -e "";
echo -e "\e[34mCommands: \e[0m";
echo -e "  \e[36m $COMMAND_DOCKER_STOP \e[0m";
echo -e "  \e[36m $COMMAND_DOCKER_RM \e[0m";
echo -e "  \e[36m $COMMAND_DOCKER_RMI \e[0m";
echo -e "";

read -p $'Do you really want to \e[31mdelete\e[0m the project docker containers and images? [y/N]: ' ANSWER
if [ "$ANSWER" == "y" ]
    then
        eval $COMMAND_DOCKER_STOP
        eval $COMMAND_DOCKER_RM
        eval $COMMAND_DOCKER_RMI

        echo -e "\e[32mdone\e[0m";
    else
        echo -e "\e[33maborted\e[0m";
fi
