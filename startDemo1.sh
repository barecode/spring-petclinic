#!/bin/sh

./mvnw clean package -DskipTests

./mvnw io.openliberty.boost:boost-maven-plugin:0.1:start

mkdir target/liberty/wlp/usr/servers/BoostServer/dropins/spring

cp server.xml target/liberty/wlp/usr/servers/BoostServer/server.xml

cp target/spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar target/liberty/wlp/usr/servers/BoostServer/dropins/spring/

tail -f target/liberty/wlp/usr/servers/BoostServer/logs/console.log

