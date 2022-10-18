#!/bin/bash

LOGS_PATH=/home/docker
IMAGE=my_image
VERSION=latest

if [[ "$(docker image inspect $IMAGE:$VERSION 2> /dev/null)" == "[]" ]]; then
    echo "$IMAGE:$VERSION not exist"
    echo "Build image"
    docker build -t $IMAGE:$VERSION .
fi

if [ ! -d $LOGS_PATH/logs ]; then
    echo "logs not exist"
    echo "Create logs directory"
    mkdir $LOGS_PATH/logs
fi

echo "Run docker-compose"

docker compose up -d

echo "Wait tomcat starting"

sleep 5

chmod -R +r $LOGS_PATH/logs

echo "Done"
