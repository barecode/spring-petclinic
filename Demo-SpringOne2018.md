# Demo instructions for [WebSphere on Pivotal Cloud Foundry](https://springoneplatform.io/2018/sessions/websphere-on-pivotal-cloud-foundry) at [SpringOne 2018](https://springoneplatform.io/2018/agenda)

These instructions guide you through deploying Spring Boot applications to Open Liberty. Three demos are defined:
1. deploying Spring Boot applications directly to Liberty
2. producing a Liberty uber jar
3. creating Liberty based Docker image.

# Demo 1: Deploy the Spring Boot app to Liberty
Branch: `git checkout demo1-SpringBootDeploy`
1. Build the Spring Boot uber jar
    1. `git clone https://github.com/spring-projects/spring-petclinic.git`
    2. `cd spring-petclinic`
    3. `mvn package`
    4. `java -jar target/spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar`
    5. `open http://localhost:8080/`
2. Install Liberty
    1. `mvn io.openliberty.boost:boost-maven-plugin:0.1:start`
    2. `open http://localhost:9080/` (See Open Liberty welcome page)
3. Deploy the Spring Boot uber jar via dropins/spring
    1. `vi target/liberty/wlp/usr/servers/BoostServer/server.xml`
    2. Add `<feature>jsp-2.3</feature>` to `<feature>springBoot-2.0</feature>`
    3. `mkdir target/liberty/wlp/usr/servers/BoostServer/dropins/spring`
    4. `cp target/spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar target/liberty/wlp/usr/servers/BoostServer/dropins/spring`
    5. `open http://localhost:9080/` (See PetClinic)
4. Cleanup
    1. `mvn io.openliberty.boost:boost-maven-plugin:0.1:stop`


# Demo 2: Produce a Liberty uber jar
Branch: `git checkout demo2-libertyUberJar`
1. Add the following to pom.xml build plugins:
    ```xml
      <plugin>
            <groupId>io.openliberty.boost</groupId>
            <artifactId>boost-maven-plugin</artifactId>
            <version>0.1</version>
            <executions>
              <execution>
                    <phase>package</phase>
                    <goals>
                          <goal>package</goal>
                    </goals>
              </execution>
           </executions>
      </plugin>
    ```
2. Run `mvn clean package`
3. Run the uber jar: `java -jar target/spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar`
4. Browse to `http://localhost:8080/`



# Demo 3: Create a Liberty based Docker image
Branch: `git checkout demo3-dockerize`
1. Add the following to pom.xml build plugins:
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
2. Run `mvn clean install`
3. Run the Docker image: `docker run -p 9080:9080 spring-petclinic`
4. Browse to `http://localhost:9080/`

