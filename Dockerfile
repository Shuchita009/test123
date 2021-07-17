FROM openjdk:8u191-jre-alpine3.8
 
RUN apk add curl jq
 
# Workspace
WORKDIR /usr/share/udemy
 
# ADD .jar under target from host
# into this image
ADD target/selenium-docker1.jar selenium-docker1.jar
ADD target/selenium-docker1-tests.jar selenium-docker1-tests.jar
ADD target/libs libs
 
# in case of any other dependency like .csv / .json / .xls
# please ADD any files required here
 
 
# ADD health check script

ADD healthcheck.sh healthcheck.sh
RUN dos2unix healthcheck.sh
 
# BROWSER
# HUB_HOST
# MODULE
#ENTRYPOINT java -cp selenium-docker.jar:selenium-docker-tests.jar:libs/* \
 #   -DHUB_HOST=$HUB_HOST \
  #  -DBROWSER=$BROWSER \
   # -Dcucumber.options=$CUCUMBER_OPTIONS \
   # org.testng.TestNG -testclass com.runner.TestRunner
    
    ENTRYPOINT sh healthcheck.sh