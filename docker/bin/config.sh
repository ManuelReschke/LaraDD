#!/bin/bash

# Prefix
DOCKER_PREFIX="laravel_"

USERID=$(id -u)
GROUPID=$(id -g)

cp .env.dist .env
sed -i "s/USERID=1000/USERID=${USERID}/" .env
sed -i "s/GROUPID=1000/GROUPID=${GROUPID}/" .env