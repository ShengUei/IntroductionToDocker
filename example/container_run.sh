#!/bin/bash

LOGS_PATH=/home/docker/
IMAGE=my_image
VERSION=$(date)
WAIT_TIME=5

docker compose down

if [[ "$(docker image inspect $IMAGE:latest 2> /dev/null)" != "[]" ]]; then
    echo "Delete old image"
    docker image rm $IMAGE:latest
fi

echo "Build new image"
docker build -t $IMAGE:$VERSION -t $IMAGE:latest .

if [ -d $LOGS_PATH/logs ]; then
    echo "Delete old logs directory"
    rm -r -f $LOGS_PATH/logs
fi

echo "Create new logs directory"
mkdir $LOGS_PATH/logs

echo "Run docker-compose"
docker compose up -d

echo "Wait tomcat starting"

while [ "$WAIT_TIME" != "0" ]
do
    echo "$WAIT_TIME s"
    WAIT_TIME=$(($WAIT_TIME-1))

    sleep 1
done

chmod -R +r $LOGS_PATH/logs

echo "container_run Done"
