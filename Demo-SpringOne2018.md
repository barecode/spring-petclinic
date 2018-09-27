# Boost your Spring Boot app with Open Liberty 
Demo instructions for [WebSphere on Pivotal Cloud Foundry](https://springoneplatform.io/2018/sessions/websphere-on-pivotal-cloud-foundry) at [SpringOne 2018](https://springoneplatform.io/2018/agenda)

These instructions guide you through deploying Spring Boot applications to Open Liberty. Three demos are defined:
1. deploying Spring Boot applications directly to Liberty
2. producing a Liberty uber jar
3. creating Liberty based Docker image.

# Demo 1: Deploy the Spring Boot app to Liberty
Branch: `git checkout demo1-SpringBootDeploy`
1. Build the Spring Boot uber jar
    1. `git clone https://github.com/barecode/spring-petclinic.git`
    2. `cd spring-petclinic`
    3. Build `./mvnw package`
    4. Run `java -jar target/spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar`
    5. Browse to `http://localhost:8080/`
2. Start Liberty
    1. `./mvnw io.openliberty.boost:boost-maven-plugin:0.1:start`
    2. Browse to `http://localhost:9080/` (See Open Liberty welcome page)
3. Deploy the Spring Boot uber jar via dropins/spring
    1. `vi target/liberty/wlp/usr/servers/BoostServer/server.xml`
    2. Add `<feature>springBoot-2.0</feature>`
    3. `mkdir target/liberty/wlp/usr/servers/BoostServer/dropins/spring`
    4. `cp target/spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar target/liberty/wlp/usr/servers/BoostServer/dropins/spring`
    5. Browse to `http://localhost:9080/` (See PetClinic)
4. Cleanup
    1. `./mvnw io.openliberty.boost:boost-maven-plugin:0.1:stop`


# Demo 2: Produce a Liberty uber jar
Branch: `git checkout demo2-libertyUberJar`
1. Add the following to the end of pom.xml build plugins section:
    ```xml
      <plugin>
            <groupId>io.openliberty.boost</groupId>
            <artifactId>boost-maven-plugin</artifactId>
            <version>0.1</version>
            <executions>
              <execution>
                    <goals>
                          <goal>package</goal>
                    </goals>
              </execution>
           </executions>
      </plugin>
    ```
2. Run `./mvnw clean package`
3. Run the uber jar: `java -jar target/spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar`
4. Browse to `http://localhost:8080/`



# Demo 3: Create a Liberty based Docker image
Branch: `git checkout demo3-dockerize`
1. Add the following to the end of pom.xml build plugins section:
    ```xml
      <plugin>
            <groupId>io.openliberty.boost</groupId>
            <artifactId>boost-maven-plugin</artifactId>
            <version>0.1</version>
            <executions>
              <execution>
                    <goals>
                          <goal>docker-build</goal>
                    </goals>
              </execution>
           </executions>
      </plugin>
    ```
2. Run `./mvnw clean install`
3. Run the Docker image: `docker run -p 9080:9080 spring-petclinic`
4. Browse to `http://localhost:9080/`



# Demo 4: `cf push`
Branch: `git checkout demo4-cf-push`
Note: due to limitations in Liberty 18.0.0.3 and the Liberty buildpack as of Sept 26, 2018, a work-around for `cf push` is needed. These steps set up a directory structure called `distZip` which push a run script and the Liberty uber jar.

1. Ensure the package goal is set for the Boost plugin execution goals:
    ```xml
      <plugin>
            <groupId>io.openliberty.boost</groupId>
            <artifactId>boost-maven-plugin</artifactId>
            <version>0.1</version>
            <executions>
              <execution>
                    <goals>
                          <goal>package</goal>
                    </goals>
              </execution>
           </executions>
      </plugin>
    ```
2. Run `./mvnw clean package`
3. Copy the jar to `distZip/lib/`
4. Review the `distZip/bin/run.sh`, which uses the known path to Java to run the jar.
```
#!/bin/sh

CUR_DIR="$(cd $(dirname $0) && pwd)"
/home/vcap/app/.java/jre/bin/java -jar $CUR_DIR/../lib/spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar 
```
5. Run `cd distZip`
6. Run `cf push` - if using IBM Cloud, you will need to run `ibmcloud cf push`
7. Browse to the route which Cloud Foundry created




# Demo 5: `docker push`
The demo given at Spring One does not use this repository, but a different fork of Spring Initializr. However, the steps taken in the demo work for this Docker image as well. The steps to create a Kubernetes cluster are not repeated here, as those steps will vary from Kubernetes vendor. To show a Spring Boot with Liberty Docker image running on Kubernetes, follow the instructions for your preferred Kubernetes environment.
