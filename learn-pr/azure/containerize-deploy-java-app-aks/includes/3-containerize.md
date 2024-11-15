In this unit, you'll containerize a Java application.

As mentioned earlier, containers run directly on top of the host operating system, kernel, and hardware as essentially just another system process. Containers require fewer system resources, which results in a smaller footprint, less overhead, and faster application startup times. These are great use cases for scaling on demand.

There are Windows containers and Linux containers. In this module, you’ll leverage the widely used Docker runtime to build a Linux container image. You'll then deploy the Linux container image to the host operating system of your local machine. Finally, you'll deploy the Linux container image to Azure Kubernetes Service.

## Docker overview

The Docker runtime is used to build, pull, run, and push container images. The following image depicts these use cases followed by a description of each use case/Docker command.

:::image type="content" source="../media/what-is-docker.png" alt-text="Diagram showing Docker commands.":::

| Docker command | Description |
|-|-|
| `docker build` | Builds a container image; essentially, the instructions/layers needed for Docker to ultimately create a running container from an image. The result of this command is an image. |
| `docker pull`  | Containers are initialized from images, which are pulled from registries such as Azure Container Registry, and this is where Azure Kubernetes Service will pull from. The result of this command is a network pull of an image that will occur in Azure. Note that you can optionally pull images locally; this is common when building images that require dependencies/layers for which your application might need, such as an application server. |
| `docker run`   | A running instance of an image is a container, and this command executes all of the layers needed to run and interact with the running container application. The result of this command is a running application process on the host operating system. |
| `docker push` | Azure Container Registry will store the images so they're readily available and network close for Azure deployments and scale. |

## Clone the Java Application

First, you'll clone the Flight Booking System for Airline Reservations repository and cd to the Airlines web application project folder.

> [!NOTE]
> If the Azure Kubernetes Service creation has successfully completed in your CLI tab, use that tab; if it's still running, open a new tab and cd to the location where you prefer to clone the Flight Booking System for Airline Reservations.

Run the following command in your CLI:

```bash
git clone https://github.com/Azure-Samples/containerize-and-deploy-Java-app-to-Azure.git
```

Run the following command in your CLI:

```bash
cd containerize-and-deploy-Java-app-to-Azure/Project/Airlines
```

> [!NOTE]
> Optionally, if you have Java and Maven installed, you can run the following command(s) in your terminal console to get a sense of the experience in building the application without Docker. If you don't have Java and Maven installed, you can safely jump ahead to the next section, *Construct a Docker file*. In that section, you'll use Docker to pull down Java and Maven to execute the builds on your behalf.

Optionally, if you have Maven and a JDK(17) or higher installed, you can run the following command in your CLI:

```bash
mvn clean package
```

> [!NOTE]
> We've used the ```mvn clean package``` command to illustrate the operational challenges of not using Docker multistage builds, which we'll cover next. Again, this step is optional; either way, you can safely move along without executing the Maven command.

Maven should have successfully built the Flight Booking System for Airline Reservations Web Application Archive artifact AirlinesReservationSample-0.0.1-SNAPSHOT.war, as in the following output:

```output
[INFO] Building war: $PROJECT_PATH/containerize-and-deploy-Java-app-to-Azure/Project/Airlines/target/AirlinesReservationSample-0.0.1-SNAPSHOT.war
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  11.776 s
[INFO] Finished at: 2024-11-15T09:33:26+09:00
[INFO] ------------------------------------------------------------------------
```

Imagine you're a Java developer and you've just built this `AirlinesReservationSample-0.0.1-SNAPSHOT.war`. Your next step is to probably work with the operation engineers to get this artifact deployed to either an on-premises server or a virtual machine. For the application to start and run successfully, this requires that the servers and virtual machines are available and configured with the required dependencies. This is challenging and time consuming, especially on demand when increased load is hitting your application. With containers, these challenges are alleviated.

## Construct a Dockerfile

At this point, you're ready to construct a Dockerfile. A Dockerfile is a text document that contains all the commands a user could execute on the command line to assemble a container image, each of which are layers (which can be cached for efficiency) that build on top of each other.

For example, Flight Booking System for Airline Reservations needs to deploy to and run inside of an application server. An application server isn't packaged inside of the `AirlinesReservationSample-0.0.1-SNAPSHOT.war`; it's an external dependency needed for the `AirlinesReservationSample-0.0.1-SNAPSHOT.war` to run, listen for and process HTTP requests, manage user sessions, and facilitate flight bookings. If this was a traditional, non-containerized deployment, operation engineers would install and configure an application server on some physical server and/or virtual machine before deploying the `AirlinesReservationSample-0.0.1-SNAPSHOT.war` to it. These operation engineers would also need to ensure that the JDK being used on your machine (what `mvn clean package` was using to compile the .war) in fact corresponds to the same JRE being used by the application server. Managing these dependencies is challenging and time consuming.

With a Dockerfile, you can write the instructions (layers) needed to accomplish this automatically by layering in the steps needed to ensure Flight Booking System for Airline Reservations has all of the dependencies needed to deploy to the Docker container runtime. This is very compelling when you start to think about on-demand scale at unplanned intervals. It's worth noting that each layer is leveraging Docker cache, which contains the state of the container image at each instructional milestone, optimizing compute time and reuse. If a layer isn't changing, cached layers are used. Common use cases for cached layers are things like Java runtime, application server, and/or other dependencies for the Flight Booking System for Airline Reservations Web application. If and when a version changes on a previously cached layer, a new cached entry is created.

The following image depicts the layers of a container image. You'll notice that the top layer is the read/write Flight Booking System for the Airline Reservations web application layer, which is built on top of the previous read-only layers, all of which are resulting from the commands in the Dockerfile.

:::image type="content" source="../media/docker-layers.png" alt-text="Diagram showing the Docker layers":::

Docker also has the concept of multistage builds, a feature that allows you to create a smaller container image with better caching and a smaller security footprint, allowing for increased optimization and maintenance of the Dockerfile over time; for example, by separating the container build stage for compiling and building the application from the stage for running the application, you can copy only the artifacts generated during the build to the production container image, thereby reducing the footprint. Since container images are cached, if there are no changes, the cached images can be reused, reducing the cost and time of downloading from the network.
Additionally, services exposed in the production environment must be carefully managed with regard to security. Therefore, a secure container image is used and operated in the production environment. In the example, we use the `CBL-Mariner` image provided by Microsoft.
`CBL-Mariner` Linux is a lightweight operating system, containing only the packages needed for a cloud environment. CBL-Mariner can be customized through custom packages and tools, to fit the requirements of your application. CBL-Mariner undergoes Azure validation tests, is compatible with Azure agents, and is built and tested by the Azure Edge & Platform to power various use cases, ranging from Azure services to powering IoT infrastructure. CBL-Mariner is the internally recommended Linux distribution for use with Microsoft cloud services and related products.

> [!NOTE]
> Microsoft provides Container images bundled with OpenJDK, including `Ubuntu`, `CBL-Mariner`, and `distroless` images. The `distroless` image has the smallest image size, but running Tomcat on it is challenging. To achieve a lightweight design, the distroless image removes many commands and tools, including the shell, which means you cannot call `catalina.sh` to start Tomcat. The `distroless` image is suitable for running executable JARs, such as those used with Spring Boot or Quarkus.

In the following example, the same version of Microsoft Build of OpenJDK is used in both the `Build stage` and the `final stage`. This is because it is important to build the source code with the same version of the JDK that the Tomcat used for service deployment will utilize. This approach helps avoid unexpected behavior due to version mismatches.

The following image depicts the multistage build and what's occurring in each stage based on the commands specified in the Dockerfile.

:::image type="content" source="../media/dockerfile-package-stage.png" alt-text="Diagram showing the Docker multistage build.":::

1. In Stage 0, Tomcat is downloaded and extracted into a directory specified by an environment variable on an Ubuntu image. The version of Tomcat to be downloaded is specified by the `TOMCAT_VERSION` variable. If a new version of Tomcat is released, you should update the version number. A new image is only fetched when the version number is changed; otherwise, the cached image is used. The Tomcat downloaded here is copied to the Final Stage environment for use.
2. In Stage 1, Maven is installed on an Ubuntu image, and the created source code and configuration files are copied over before building the Maven project. Each layer is cached, so the OS image and Maven image layers reuse the cache. If configuration files, source code files, or the web directory are updated, the layers from the changes onward are rebuilt. If the build completes successfully without errors during compilation, an artifact named `AirlinesReservationSample-0.0.1-SNAPSHOT.war` is generated under the `target` directory. This artifact is copied to the Final Stage environment for use.
3. In the Final Stage, the secure `CBL-Mariner` image provided by Microsoft is used to copy the Tomcat and Java build artifacts from Stage 0 and Stage 1, respectively. All files used within the project are set to be owned by a user named `app`, and the application is also run as the `app` user instead of with `root` privileges. This ensures that the container image can be operated securely without granting unnecessary permissions. Finally, port number 8080 is exposed, and the `catalina.sh` script is executed to start Tomcat. When this is run on your local Docker Desktop, you can access it via the URL `http://localhost:8080/AirlinesReservationSample`.

Within the root of your project, containerize-and-deploy-Java-app-to-Azure/Project/Airlines, Create a file called Dockerfile:

```bash
vi Dockerfile
```

Add the following contents to Dockerfile, then save and exit by pressing <kbd>ESC</kbd>, then typing *:wq!* and pressing <kbd>Enter</kbd>:

```dockerfile
############################################
# Tomcat Intall stage
############################################
FROM mcr.microsoft.com/openjdk/jdk:17-ubuntu AS tomcat

ENV CATALINA_HOME=/usr/local/tomcat

# Configure Tomcat Version (Please change the latest version)
ENV TOMCAT_VERSION=10.1.33
  
# Install Tomcat and required packages
RUN apt-get update ; \  
    apt-get install -y curl ; \  
    curl -O https://downloads.apache.org/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz ; \
    tar xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz ; \  
    mv apache-tomcat-${TOMCAT_VERSION} ${CATALINA_HOME} ; \
    rm apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    apt-get remove --purge -y curl && \
    apt-get autoremove -y && \
    apt-get clean  

############################################
# Build stage (Compile with Java 17)
############################################
FROM mcr.microsoft.com/openjdk/jdk:17-ubuntu AS build

WORKDIR /build

# Install Maven 
RUN apt-get update && apt-get install -y maven && mvn --version

# Copy source code
COPY pom.xml .
COPY src ./src
COPY web ./web

# Build the project
RUN mvn clean package

############################################
# Package final stage
############################################
FROM mcr.microsoft.com/openjdk/jdk:17-mariner

# Configure the location of the Tomcat installation
ENV CATALINA_HOME=/usr/local/tomcat
# Configure the path to the Tomcat binaries
ENV PATH=$CATALINA_HOME/bin:$PATH

# This is the user that will run the Tomcat process
USER app

# Copy the Tomcat installation from the Tomcat stage
COPY --chown=app:app --from=tomcat ${CATALINA_HOME} ${CATALINA_HOME}
# Copy the Tomcat configuration files
COPY --chown=app:app tomcat-users.xml ${CATALINA_HOME}/conf
# Copy the compiled WAR file from the build stage
COPY --chown=app:app --from=build /build/target/*.war ${CATALINA_HOME}/webapps/AirlinesReservationSample.war

# Expose the default Tomcat port
EXPOSE 8080
# Start Tomcat
CMD ["catalina.sh", "run"]
```

> [!NOTE]
> Optionally, the Dockerfile_Solution in the root of your project contains the contents needed.

The Dockerfile is divided into three stages:

## Tomcat Install Stage

| Docker Command | Description |
|----------------|-------------|
| `FROM`         | `FROM mcr.microsoft.com/openjdk/jdk:17-ubuntu AS tomcat` sets the base image to Microsoft Build of OpenJDK 17 on Ubuntu, and names this stage `tomcat`. This is where Tomcat will be installed. |
| `ENV`          | `ENV CATALINA_HOME=/usr/local/tomcat` sets an environment variable for the Tomcat installation directory. |
| `ENV`          | `ENV TOMCAT_VERSION=10.1.33` sets the version of Tomcat to be installed. This should be updated to the latest version as needed. |
| `RUN`          | The `RUN` command updates the package list, installs `curl`, downloads the specified version of Tomcat, extracts it, moves it to the specified directory, and cleans up unnecessary files and packages. This ensures that the image remains lightweight. |

## Build Stage (Compile with Java 17)

| Docker Command | Description |
|----------------|-------------|
| `FROM`         | `FROM mcr.microsoft.com/openjdk/jdk:17-ubuntu AS build` sets the base image to Microsoft Build of OpenJDK 17 on Ubuntu, and names this stage `build`. This stage is used for compiling the Java application. |
| `WORKDIR`      | `WORKDIR /build` sets the working directory inside the container to `/build`, where the source code will be copied and compiled. |
| `RUN`          | `RUN apt-get update && apt-get install -y maven && mvn --version` installs Maven, a build automation tool used for Java projects, and verifies its installation. |
| `COPY`         | `COPY pom.xml .` copies the Maven configuration file into the working directory. This file is essential for building the project. |
| `COPY`         | `COPY src ./src` copies the source code directory into the container. This is where the Java application code resides. |
| `COPY`         | `COPY web ./web` copies the web resources directory into the container. This includes web application resources needed for the build. |
| `RUN`          | `RUN mvn clean package` executes the Maven build process, which compiles the Java application and packages it into a WAR file. |

## Package Final Stage

| Docker Command | Description |
|----------------|-------------|
| `FROM`         | `FROM mcr.microsoft.com/openjdk/jdk:17-mariner` sets the base image to Microsoft Build of OpenJDK 17 on CBL-Mariner, which is used for the final deployment of the application. |
| `ENV`          | `ENV CATALINA_HOME=/usr/local/tomcat` sets the environment variable for the Tomcat installation directory, similar to the install stage. |
| `ENV`          | `ENV PATH=$CATALINA_HOME/bin:$PATH` adds the Tomcat bin directory to the system `PATH`, allowing Tomcat commands to be run easily. |
| `USER`         | `USER app` specifies the user under which the Tomcat process will run, enhancing security by not running as the root user. |
| `COPY`         | `COPY --chown=app:app --from=tomcat ${CATALINA_HOME} ${CATALINA_HOME}` copies the Tomcat installation from the `tomcat` stage, setting the ownership to the `app` user. |
| `COPY`         | `COPY --chown=app:app tomcat-users.xml ${CATALINA_HOME}/conf` copies the Tomcat user configuration file into the container, setting the ownership to the `app` user. |
| `COPY`         | `COPY --chown=app:app --from=build /build/target/*.war ${CATALINA_HOME}/webapps/AirlinesReservationSample.war` copies the compiled WAR file from the `build` stage into the Tomcat webapps directory, setting the ownership to the `app` user. |
| `EXPOSE`       | `EXPOSE 8080` exposes port 8080, the default port for Tomcat, allowing external access to the application. |
| `CMD`          | `CMD ["catalina.sh", "run"]` specifies the command to start Tomcat when the container is run. |

For more information on Dockerfile construction, see [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
