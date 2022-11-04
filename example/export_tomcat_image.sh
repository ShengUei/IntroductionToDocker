#!/bin/bash

TAR_FILE=tomcat8.tar
IMAGE=tomcat:8.5-jre8

echo "Export Tomcat Image"
docker save -o $TAR_FILE $IMAGE

echo "Export Tomcat Image Done"
