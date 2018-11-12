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

# Setup
I usually pre-configure at least 4 terminal windows.: a primary window for demo 1-3 and then three more windows for demo 4. I recommend  disabling line-wrapping for the `docker stats` window. To do this on mac, run `tput rmam` (disables line wrapping). If you need to re-enable line wrapping, run `tput smam`.

If demo'ing this at a conference, remember a few things:
1. Your text is almost never 'too big'. Your default font size is REALLY SMALL on a projector (even a large one).
2. Color contrast is really important. Try to use high-contrast settings. Black on White, or White on Black is safest.
3. Bad things happen during demos. Network access is unreliable at conferences. Pre-build everything, take screen shots or build slides which the relevant information!

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
4. In Terminal 3, run `docker run --name openj9 -p 8081:8080 --rm spring-petclinic-openj9`  
5. In Terminal 1, compare the memory usage of the images
