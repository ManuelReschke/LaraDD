#!/bin/bash

DIR=`dirname $(readlink -f $0)`
DOCKER_DIR=`dirname $DIR`
ROOT_DIR=`dirname $DOCKER_DIR`
REMOTE_HOST=$(hostname -I | awk '{print $1}')
XDEBUG_CONFIG_FILE="/usr/local/etc/php/conf.d/99-docker.ini"

cd "$ROOT_DIR"

source $DIR/config.sh

# check flags
for i in "$@"
do
case $i in
    --enable)
    ENABLE=1
    shift # past argument with no value
    ;;
    --disable)
    ENABLE=0
    shift # past argument with no value
    ;;
    *)
        # unknown option
    ;;
esac
done

echo ""
echo "+--------------------------------+"
echo "| Xdebug remote autostart helper |"
echo "+--------------------------------+"
echo ""

if ([ "$ENABLE" != "0" ] && [ "$ENABLE" != "1" ]); then
    read -p "Enter 1 to enable or 0 to disable > " ENABLE
    ENABLE=${ENABLE:-0}
fi

sudo docker-compose exec ${DOCKER_PREFIX}php sed -i -r "s/xdebug\.remote_host=(\b[0-9]{1,3}\.){3}[0-9]{1,3}\b/xdebug.remote_host=${REMOTE_HOST}/" "${XDEBUG_CONFIG_FILE}"
sudo docker-compose exec ${DOCKER_PREFIX}php sed -i -r "s/xdebug\.remote_autostart=[0-1]{1}/xdebug.remote_autostart=${ENABLE}/" "${XDEBUG_CONFIG_FILE}"

echo ""
echo "==> Verify your new settings"
echo ""
sudo docker-compose exec ${DOCKER_PREFIX}php cat ${XDEBUG_CONFIG_FILE}
echo ""
echo "==> Restarting ${DOCKER_PREFIX}php to ensure that your new settings take effect"
echo ""

sudo docker-compose restart ${DOCKER_PREFIX}php

echo ""
echo "==> Done"

