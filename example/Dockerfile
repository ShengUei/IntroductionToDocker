# syntax=docker/dockerfile:1
ARG VERSION=8.5-jre8
# 由 tomcat image(來源 Docker Hub) 開始建置
FROM tomcat:$VERSION

# 建立在 container 資料夾
# RUN mkdir -p $CATALINA_HOME/ssl/

# $CATALINA_HOME 變數來自 tomcat image
COPY ./conf/ $CATALINA_HOME/conf/
COPY ./webapps/ $CATALINA_HOME/webapps

# 複製 host 中的 ssl.keystore 到 ssl 資料夾
# COPY ./ssl.keystore $CATALINA_HOME/ssl/
