# syntax=docker/dockerfile:1
ARG VERSION=8.5-jre8
# 由 tomcat image(來源 Docker Hub) 開始建置
FROM tomcat:$VERSION

ARG USER_ID \
    GROUP_ID

# 建立資料夾,並更改權擁有者
Run chown -R $USER_ID:$GROUP_ID $CATALINA_HOME/webapps/; \
    chown -R $USER_ID:$GROUP_ID $CATALINA_HOME/logs/

# $CATALINA_HOME 變數來自 tomcat image
COPY ./conf/ $CATALINA_HOME/conf/
COPY ./webapps/ $CATALINA_HOME/webapps

