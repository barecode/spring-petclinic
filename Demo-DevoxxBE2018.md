# Optimizing Spring Boot apps for Docker 
Demo instructions for [Optimizing Spring Boot apps for Docker](https://dvbe18.confinabox.com/talk/LJT-6211/Optimizing_Spring_Boot_apps_for_Docker) at [Devoxx Belgium 2018](https://dvbe18.confinabox.com/byday/mon)

These instructions guide you through building Docker images for Spring Boot applications. Four demos are defined:
1. A jar based Docker image
2. A classpath based Docker image
3. A classpath based Docker image with Eclipse OpenJ9
4. Compare the HotSpot and OpenJ9 images

If needed, clone the project:
1. `git clone https://github.com/barecode/spring-petclinic.git`
2. `cd spring-petclinic`

# Demo 1: A jar based Docker image
Branch: `git checkout docker-jar`
1. Build the image
    1. `git checkout docker-jar`
    2. Build `./mvnw clean package -DskipTests`
    3. Run `docker run -p 8080:8080 spring-petclinic`
    4. Browse to `http://localhost:8080/` (See Petclinic)
    5. Ctrl-C to stop the Docker container
2. Inspect the image size and layers
    1. `docker images`
    2. `docker history spring-petclinic` (note the 38MB layer)


# Demo 2: A classpath based Docker image
Branch: `git checkout docker-classpath`
1. Build the image
    1. `git checkout docker-classpath`
    2. Build `./mvnw clean package -DskipTests`
    3. Run `docker run -p 8080:8080 spring-petclinic`
    4. Browse to `http://localhost:8080/` (See Petclinic)
    5. Ctrl-C to stop the Docker container
2. Inspect the image size and layers
    1. `docker images`
    2. `docker history spring-petclinic` (note the 3 layers, the small 1MB layer)



# Demo 3: A classpath based Docker image with Eclipse OpenJ9
Branch: `git checkout docker-classpath-openj9`
1. Tag the previous image (used in Demo 4)
    1. `docker tag spring-petclinic spring-petclinic-hotspot`
2. Build the image
    1. `git checkout docker-classpath-openj9`
    2. Build `./mvnw clean package -DskipTests`
    3. Run `docker run -p 8080:8080 spring-petclinic`
    4. Browse to `http://localhost:8080/` (See Petclinic)
    5. Ctrl-C to stop the Docker container
3. Inspect the image size and layers
    1. `docker images`
    2. `docker history spring-petclinic` (note the 3 layers, the small 1MB layer)
4. Tag the new image (used in Demo 4)
    1. `docker tag spring-petclinic spring-petclinic-openj9`
    
# Demo 4: Compare the HotSpot and OpenJ9 images
1. Open three terminal windows
2. In Terminal 1, run `docker stats`
3. In Terminal 2, run `docker run --name hotspot -p 8080:8080 --rm spring-petclinic-hotspot`
4. In Terminal 3, run `docker run --name openj9 -p 8080:8080 --rm spring-petclinic-openj9`  
5. InTerminal 1, compare the memory usage of the images
