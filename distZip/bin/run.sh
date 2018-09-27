#!/bin/sh

CUR_DIR="$(cd $(dirname $0) && pwd)"
/home/vcap/app/.java/jre/bin/java -jar $CUR_DIR/../lib/spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar 
