In this unit, you containerize a Java application.

As mentioned earlier, containers run directly on top of the host operating system, kernel, and hardware as ordinary system processes. Containers require fewer system resources, resulting in a smaller footprint, less overhead, and faster application startup times. These benefits are great use cases for scaling on demand.

There are Windows containers and Linux containers. In this module, you use the widely used Docker runtime to build a Linux container image. You then deploy the Linux container image to the host operating system of your local machine. Finally, you deploy the Linux container image to Azure Kubernetes Service.

## Docker overview

The Docker runtime is used to build, pull, run, and push container images, as shown in the following diagram:

:::image type="content" source="../media/what-is-docker.png" alt-text="Diagram that shows Docker build, pull, push, and run commands connecting the client, Docker host, and registry." lightbox="../media/what-is-docker.png" border="false":::

The following table describes each Docker command:

| Docker command | Description                                                                                                                                                                                                                                                                                                                                                                                                                      |
|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `docker build` | Builds a container image consisting of the instructions or layers needed for Docker to create a running container from an image. The result of this command is an image.                                                                                                                                                                                                                                                         |
| `docker pull` | Downloads an image from a registry into the image store of the Docker daemon selected by the client. Existing image layers can be reused. In this module, your local Docker environment uses images from registries during development; later, AKS nodes pull the application image from Azure Container Registry for deployment. |
| `docker run` | Creates and starts a new container from an image. The container runs its configured startup process, subject to command-line overrides. Image layers provide the container's filesystem; Dockerfile build instructions aren't executed again when the container starts. |
| `docker push`  | Azure Container Registry stores the images so they're readily available and network close for Azure deployments and scale.                                                                                                                                                                                                                                                                                                       |

## Clone the Java application

First, clone the Flight Booking System for Airline Reservations repository and navigate to the Airlines web application project folder.

> [!NOTE]
> If the Azure Kubernetes Service creation is finished in your CLI tab, use that tab. If it's still running, open a new tab and navigate to the location where you prefer to clone the Flight Booking System for Airline Reservations.

Run the following commands:

```bash
git clone https://github.com/Azure-Samples/containerize-and-deploy-Java-app-to-Azure.git
cd containerize-and-deploy-Java-app-to-Azure/Project/Airlines
```

Optionally, if you have Java and Maven installed, you can run the following command in your terminal console to get a sense of the experience of building the application without Docker. If you don't have Java and Maven installed, you can safely proceed to the next section, [Construct a Docker file](#construct-a-dockerfile). In that section, you use Docker to pull down Java and Maven to execute the builds on your behalf.

```bash
mvn clean package
```

> [!NOTE]
> We used the `mvn clean package` command to illustrate the operational challenges of not using Docker multistage builds, which we cover next. Again, this step is optional. Either way, you can safely proceed without executing the Maven command.

If the process was successful, Maven successfully built the Flight Booking System for Airline Reservations Web Application Archive artifact **AirlinesReservationSample-0.0.1-SNAPSHOT.war**, as illustrated by the following historical output. Your build timestamp and duration can differ:

```output
[INFO] Building war: $PROJECT_PATH/containerize-and-deploy-Java-app-to-Azure/Project/Airlines/target/AirlinesReservationSample-0.0.1-SNAPSHOT.war
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  11.776 s
[INFO] Finished at: 2024-11-15T09:33:26+09:00
[INFO] ------------------------------------------------------------------------
```

Imagine that you're a Java developer and you just built **AirlinesReservationSample-0.0.1-SNAPSHOT.war**. Your next step is probably to work with the operation engineers to get this artifact deployed to either an on-premises server or a virtual machine. For the application to start and run successfully, the servers and virtual machines must be available and configured with the required dependencies. This process is challenging and time consuming, especially on demand when increased load is hitting your application. With containers, these challenges are alleviated.

## Construct a Dockerfile

You're now ready to construct a Dockerfile. A Dockerfile is a text document that contains all the commands a user would execute on the command line to assemble a container image. A container image can contain multiple read-only filesystem layers. Docker can reuse cached build results for unchanged steps. The layers build on top of each other.

For example, Flight Booking System for Airline Reservations needs to deploy to and run inside of an application server. An application server isn't packaged inside of the **AirlinesReservationSample-0.0.1-SNAPSHOT.war**. It's an external dependency needed for the **AirlinesReservationSample-0.0.1-SNAPSHOT.war** to run, listen for and process HTTP requests, manage user sessions, and facilitate flight bookings. If you used a traditional, non-containerized deployment, operation engineers would install and configure an application server on some physical server or virtual machine before deploying the **AirlinesReservationSample-0.0.1-SNAPSHOT.war** to it. These operation engineers would also need to ensure that the JDK being used on your machine - which is what `mvn clean package` used to compile the WAR file - in fact corresponds to the same JRE being used by the application server. Managing these dependencies is challenging and time consuming.

With a Dockerfile, you can write the instructions or layers needed to accomplish this goal automatically, by layering in the steps needed to ensure that the Flight Booking System for Airline Reservations has all of the dependencies needed to deploy to the Docker container runtime. This solution is compelling when you work with on-demand scale at unplanned intervals. Each layer uses Docker cache, which contains the state of the container image at each instructional milestone, optimizing compute time and reuse. If a layer isn't changing, cached layers are used. Common use cases for cached layers are the Java runtime, application server, and other dependencies for the Flight Booking System for Airline Reservations Web application. If and when a version changes on a previously cached layer, a new cached entry is created.

A container image contains read-only filesystem layers. In this example, the Dockerfile copies Tomcat and the Flight Booking System WAR file into the image at build time. Docker adds a separate writable layer when it creates a container from the image. Each container's writable layer records its own filesystem changes without modifying the image layers.

> [!NOTE]
> For files stored in the container's writable layer, additions, modifications, and deletions affect that container rather than the original image. Changing files that came from an image layer uses copy-on-write behavior.

Docker has the concept of multistage builds, a feature that enables you to create a smaller container image with better caching and a smaller security footprint, enabling increased optimization and maintenance of the Dockerfile over time. For example, you can separate the container build stage for compiling and building the application from the stage for running the application. This feature enables you to copy only the artifacts generated during the build to the production container image, which reduces the footprint. Because container images are cached, if there are no changes, the cached images can be reused, reducing the cost and time of downloading from the network.

Services exposed in the production environment must be carefully managed for security. Therefore, the production environment uses and operates a secure container image. The example uses an Azure Linux image provided by Microsoft.

The final stage uses Microsoft Build of OpenJDK 17 on Azure Linux 3.0. The `17-azurelinux` tag names this base explicitly. The older `17-mariner` tag remains a compatibility alias that mirrors the Azure Linux image; it shouldn't be confused with the retired `17-mariner-cm1` and `17-mariner-cm2` images. For more information, see [Microsoft Build of OpenJDK container images](/java/openjdk/containers#linux-based-images).

> [!NOTE]
> Microsoft provides container images bundled with OpenJDK, including `Ubuntu`, Azure Linux, and `distroless` images. The `distroless` image has the smallest image size, but running Tomcat on it is challenging. To achieve a lightweight design, the `distroless` image removes many commands and tools, including the shell, which means you can't call **catalina.sh** to start Tomcat. The `distroless` image is suitable for running executable JARs, such as those used with Spring Boot or Quarkus.

In the following example, the same version of Microsoft Build of OpenJDK is used in both the build stage and the final stage. This approach ensures that you build the source code with the same version of the JDK that the service deployment Tomcat uses, which helps avoid unexpected behavior due to version mismatches.

The following image depicts the multistage build and what's occurring in each stage based on the commands specified in the Dockerfile:

:::image type="content" source="../media/dockerfile-package-stage.png" alt-text="Diagram that shows Dockerfile instructions creating image layers in the Tomcat install, code build, and runtime stages." lightbox="../media/dockerfile-package-stage.png" border="false":::

In stage 0, Tomcat is downloaded from a version-specific Apache archive, verified with a SHA-512 checksum, and extracted into a directory specified by an environment variable on an Ubuntu image. The `TOMCAT_VERSION` variable specifies the release, and the `TOMCAT_SHA512` build argument specifies its expected checksum. Update both values together when selecting a newer supported release. Docker can reuse the cached installation layer while its instructions and inputs are unchanged. The Tomcat installation is copied to the final stage environment for use.

In stage 1, Maven is installed on an Ubuntu image, and the created source code and configuration files are copied over before building the Maven project. Each layer is cached, so the OS image and Maven image layers reuse the cache. If configuration files, source code files, or the web directory are updated, the layers from the changes onward are rebuilt. If the build completes successfully without errors during compilation, an artifact named **AirlinesReservationSample-0.0.1-SNAPSHOT.war** is generated under the **target** directory. This artifact is copied to the final stage environment for use.

In the final stage, the Tomcat and Java build artifacts from stage 0 and stage 1, respectively, are copied into a Microsoft Build of OpenJDK 17 image on Azure Linux 3.0. A user named `app` owns all files used within the project, and the application is also run as the `app` user instead of having `root` privileges. This setup ensures that the container image can be operated securely without granting unnecessary permissions. Finally, port number 8080 is exposed, and the **catalina.sh** script is executed to start Tomcat. When this is run on your local Docker Desktop, you can access it via the URL `http://localhost:8080/AirlinesReservationSample`.

In `containerize-and-deploy-Java-app-to-Azure/Project/Airlines`, use an installed text editor to create a file named `Dockerfile`. Add the following content and save the file:

> [!IMPORTANT]
> Before building an image that you will expose publicly, check the current supported Tomcat 10.1.x release on the [Apache Tomcat download page](https://tomcat.apache.org/download-10.cgi) and review the [security notices](https://tomcat.apache.org/security-10.html). Update `TOMCAT_VERSION` and `TOMCAT_SHA512` together using Apache's published release information. An artifact remaining available in the [Apache archive](https://archive.apache.org/dist/tomcat/tomcat-10/) does not mean that its version is current or recommended.

```dockerfile
############################################
# Tomcat Intall stage
############################################
FROM mcr.microsoft.com/openjdk/jdk:17-ubuntu AS tomcat

ENV CATALINA_HOME=/usr/local/tomcat

# Configure the reviewed Tomcat version and checksum
ENV TOMCAT_VERSION=10.1.61
ARG TOMCAT_SHA512=35120a2b1182bac3d55438fbec0dc581d03b0f1c16ce692a930f3bb6a1097cf896b94b389152257071a87cb2928ac8c15f1bad08387c14acc7c17dbc1bb598fb

# Install Tomcat and required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates && \
    curl -fSL \
      "https://archive.apache.org/dist/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" \
      -o /tmp/tomcat.tar.gz && \
    echo "${TOMCAT_SHA512}  /tmp/tomcat.tar.gz" | sha512sum -c - && \
    mkdir -p "${CATALINA_HOME}" && \
    tar -xzf /tmp/tomcat.tar.gz --strip-components=1 -C "${CATALINA_HOME}" && \
    rm /tmp/tomcat.tar.gz && \
    apt-get remove --purge -y curl && \
    apt-get autoremove -y && \
    apt-get clean

############################################
# Build stage (Compiles with Java 17)
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
FROM mcr.microsoft.com/openjdk/jdk:17-azurelinux

# Configure the location of the Tomcat installation
ENV CATALINA_HOME=/usr/local/tomcat
# Configure the path to the Tomcat binaries
ENV PATH=$CATALINA_HOME/bin:$PATH

# This is the user that runs the Tomcat process
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
> Use the Dockerfile shown in this unit for this exercise. The application must be copied to `webapps/AirlinesReservationSample.war` so that the URLs in the following units use the `/AirlinesReservationSample/` context. A different WAR filename changes the default Tomcat application context.

The Dockerfile is divided into three stages, which are described in the following tables:

- The Tomcat install stage:

  | Docker command | Description                                                                                                                                                                                                                                              |
  |----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  | `FROM`         | `FROM mcr.microsoft.com/openjdk/jdk:17-ubuntu AS tomcat` sets the base image to Microsoft Build of OpenJDK 17 on Ubuntu, and names this stage `tomcat`. This is where Tomcat is installed.                                                               |
  | `ENV`          | `ENV CATALINA_HOME=/usr/local/tomcat` sets an environment variable for the Tomcat installation directory.                                                                                                                                                |
  | `ENV`          | `ENV TOMCAT_VERSION=10.1.61` sets the Tomcat release pinned for this example. Review supported releases and update it together with `TOMCAT_SHA512` as needed. |
  | `ARG`          | `ARG TOMCAT_SHA512` supplies Apache's published SHA-512 checksum for the selected archive as a build argument. |
  | `RUN`          | Installs `curl` and CA certificates, then uses `curl -fSL` to download the version-specific Apache archive. `-f` makes HTTP errors fail; `-L` follows redirects. The archive is verified with `sha512sum -c -` before extraction into `CATALINA_HOME` with `--strip-components=1`. The `&&` chain stops on failure instead of masking errors during cleanup. Finally, it removes the archive and unneeded packages and cleans the package cache. |

- The Build stage, which compiles with Java 17:

  | Docker command | Description                                                                                                                                                                                                  |
  |----------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  | `FROM`         | `FROM mcr.microsoft.com/openjdk/jdk:17-ubuntu AS build` sets the base image to Microsoft Build of OpenJDK 17 on Ubuntu, and names this stage `build`. This stage is used for compiling the Java application. |
  | `WORKDIR`      | `WORKDIR /build` sets the working directory inside the container to `/build`, where the source code is copied and compiled.                                                                                  |
  | `RUN`          | `RUN apt-get update && apt-get install -y maven && mvn --version` installs Maven, a build automation tool used for Java projects, and verifies its installation.                                             |
  | `COPY`         | `COPY pom.xml .` copies the Maven configuration file into the working directory. This file is essential for building the project.                                                                            |
  | `COPY`         | `COPY src ./src` copies the source code directory into the container. This is where the Java application code resides.                                                                                       |
  | `COPY`         | `COPY web ./web` copies the web resources directory into the container. This includes web application resources needed for the build.                                                                        |
  | `RUN`          | `RUN mvn clean package` executes the Maven build process, which compiles the Java application and packages it into a WAR file.                                                                               |

- The Package final stage:

  | Docker command | Description                                                                                                                                                                                                                                        |
  |----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  | `FROM`         | `FROM mcr.microsoft.com/openjdk/jdk:17-azurelinux` sets the base image to Microsoft Build of OpenJDK 17 on Azure Linux 3.0, which is used for the final deployment of the application. |
  | `ENV`          | `ENV CATALINA_HOME=/usr/local/tomcat` sets the environment variable for the Tomcat installation directory, similar to the install stage.                                                                                                           |
  | `ENV`          | `ENV PATH=$CATALINA_HOME/bin:$PATH` adds the Tomcat bin directory to the system `PATH`, allowing Tomcat commands to be run easily.                                                                                                                 |
  | `USER`         | `USER app` specifies the user under which the Tomcat process runs, enhancing security by not running as the root user.                                                                                                                             |
  | `COPY`         | `COPY --chown=app:app --from=tomcat ${CATALINA_HOME} ${CATALINA_HOME}` copies the Tomcat installation from the `tomcat` stage, setting the ownership to the `app` user.                                                                            |
  | `COPY`         | `COPY --chown=app:app tomcat-users.xml ${CATALINA_HOME}/conf` copies the Tomcat user configuration file into the container, setting the ownership to the `app` user.                                                                               |
  | `COPY`         | `COPY --chown=app:app --from=build /build/target/*.war ${CATALINA_HOME}/webapps/AirlinesReservationSample.war` copies the compiled WAR file from the `build` stage into the Tomcat **webapps** directory, setting the ownership to the `app` user. |
  | `EXPOSE`       | `EXPOSE 8080` documents that the application is expected to listen on TCP port 8080. It doesn't publish a host port. The next unit publishes the port with the `-p 8080:8080` option on `docker run`.                                                                                                                                         |
  | `CMD`          | `CMD ["catalina.sh", "run"]` specifies the command to start Tomcat when the container is run.                                                                                                                                                      |

For more information on Dockerfile construction, see the [Dockerfile reference](https://docs.docker.com/engine/reference/builder/).
