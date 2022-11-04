#!/bin/bash

TAR_FILE=tomcat8.tar

echo "Import Tomcat Image"
docker load -i $TAR_FILE

echo "Import Tomcat Image Done"
