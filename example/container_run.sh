#!/bin/bash

LOGS_PATH=/home/docker/
IMAGE=my_image
VERSION=$(date +'%Y%m%d_%H%M%S')
WAIT_TIME=5

docker compose down

if [[ "$(docker image inspect $IMAGE:latest 2> /dev/null)" != "[]" ]]; then
    echo "Delete old image"
    docker image rm $IMAGE:latest
fi

if [[ "$(docker image inspect $IMAGE:$VERSION 2> /dev/null)" != "[]" ]]; then
    echo "Delete old image $IMAGE:$VERSION"
    docker image rm $IMAGE:$VERSION
fi

echo "Build new image"
docker build --no-cache --build-arg USER_ID=$(id -u adp) --build-arg GROUP_ID=$(id -g adp) -t $IMAGE:$VERSION -t $IMAGE:latest .

if [ ! -d $LOGS_PATH/logs ]; then
    echo "Create logs directory"
    mkdir $LOGS_PATH/logs
fi

echo "Run docker-compose"
USER_ID=$(id -u adp) GROUP_ID=$(id -g adp) docker compose up -d

# echo "Wait tomcat starting"
# while [ "$WAIT_TIME" != "0" ]
# do
#     echo "$WAIT_TIME s"
#     WAIT_TIME=$(($WAIT_TIME-1))
#
#     sleep 1
# done

# chmod -R +r $LOGS_PATH/logs

echo "container_run Done"
