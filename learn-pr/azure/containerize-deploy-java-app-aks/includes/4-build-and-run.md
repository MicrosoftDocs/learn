In this unit, you build and run the container image. As you learned earlier, a running instance of an image is a container.

## Build a container image

Now that you successfully constructed a Dockerfile, you can instruct Docker to build a container image for you.

> [!NOTE]
> Ensure your Docker runtime is configured to build Linux containers. This configuration is important because the Dockerfile we're using references container images (JDK/JRE) for the Linux architecture.

The command you use to build container images is `docker build`. You use the `-t` argument to specify a container label, and the `.` is the location for Docker to find the Dockerfile. Run the following command:

```bash
docker build -t flightbookingsystemsample .
```

The following output is typical:

```output
docker build -t flightbookingsystemsample .
[+] Building 45.2s (18/18) FINISHED     docker:desktop-linux
 => [internal] load build definition from Dockerfile    0.0s
 => => transferring dockerfile: 2.07kB                  0.0s
 => [internal] load metadata for mcr.microsoft.com/openjdk/jdk:17-ubuntu    0.7s
 => [internal] load metadata for mcr.microsoft.com/openjdk/jdk:17-mariner   0.8s
 => [internal] load .dockerignore                       0.0s
 => => transferring context: 2B                         0.0s
 => [internal] load build context                       0.4s
 => => transferring context: 9.89MB                     0.4s
 => [stage-2 1/4] FROM mcr.microsoft.com/openjdk/jdk:17-mariner@sha256:79****************************************f1ee692d5b8c36f0824510    15.9s
 => => resolve mcr.microsoft.com/openjdk/jdk:17-mariner@sha256:796b833b91****************************************5b8c36f0824510             0.0s

...

 => => extracting sha256:8f818432a4****************************************1791ae8c3b79ca                 2.4s
 => => extracting sha256:1820580505****************************************087e3a0df74b60                 7.1s
 => [build 1/7] FROM mcr.microsoft.com/openjdk/jdk:17-ubuntu@sha256:7982bc2eb79838d70bcc025371c514b7f7fde75f9981906c65eff04e9170627e       15.5s
 => => resolve mcr.microsoft.com/openjdk/jdk:17-ubuntu@sha256:7982bc2eb79838d70bcc025371c514b7f7fde75f9981906c65eff04e9170627e              0.0s

...

 => => extracting sha256:6414378b64****************************************b23a54cb3684ac                 2.4s
 => => extracting sha256:8debc97485****************************************80f38d9f1cb399                 6.5s
 => [build 2/7] WORKDIR /build                          0.4s
 => [tomcat 2/2] RUN apt-get update ;     apt-get install -y curl ;     curl -O https://downloads.apache.org/tomcat/tomcat-10/v10.1.33/bin/apache-tomcat-10.1.33.tar.gz ;     tar xzf apache-tomcat-10.1.33.tar.  23.4s
 => [build 3/7] RUN apt-get update && apt-get install -y maven && mvn --version                          14.5s
 => [build 4/7] COPY pom.xml .                          0.0s
 => [build 5/7] COPY src ./src                          0.0s
 => [build 6/7] COPY web ./web                          0.1s
 => [build 7/7] RUN mvn clean package                  13.4s
 => [stage-2 2/4] COPY --chown=app:app --from=tomcat /usr/local/tomcat /usr/local/tomcat                  0.2s
 => [stage-2 3/4] COPY --chown=app:app tomcat-users.xml /usr/local/tomcat/conf                            0.0s
 => [stage-2 4/4] COPY --chown=app:app --from=build /build/target/*.war /usr/local/tomcat/webapps/AirlinesReservationSample.war             0.1s
 => exporting to image                                  0.2s
 => => exporting layers                                 0.1s
 => => writing image sha256:43d4ab3ab0****************************************c4807bce5af7b4              0.0s
 => => naming to docker.io/library/flightbookingsystemsample
```

Multi-stage builds handle processes efficiently. Specifically, processes that have no dependencies are executed in parallel. For example, in this case, the download of Tomcat in stage 0 and the installation and compilation of Maven in stage 1 are independent processes. Therefore, when you execute `docker build`, the Tomcat process and the Maven process are carried out concurrently. However, the final stage copies the artifacts from stage 0 and stage 1, so it can't be executed until the previous processes are completed. Thus, the final stage waits for the previous processes to finish and proceeds when it becomes possible to do so.

Additionally, if you edit a part of the program's source code and run `docker build` again, you can expect the process to complete more quickly than the first time. Containers are designed to use a layer structure with caching, and unchanged layers are reused from the cache. For instance, if there are no changes in the versions of Java, Tomcat, or Maven, the previously downloaded images are reused. When modifications are made to the source code, only the latter part of the process, which involves replacing the source code and rebuilding the project to replace the artifacts, needs to be changed. Pay attention to how you write Docker commands to efficiently build by reusing the cache as much as possible.

Docker can also display the available images that are resident, which is helpful for viewing what's available to run. Run the following command:

```bash
docker images
```

The following output is typical:

```output
docker images
REPOSITORY                  TAG      IMAGE ID     CREATED        SIZE
flightbookingsystemsample   latest   43d4ab3ab045 30 minutes ago 475MB
```

## Run a container image

Now that you successfully built a container image, you can run it.

You use the `docker run` command to run a container image. The `-p ####:####` argument forwards localhost HTTP traffic - the first port, before the colon - to the container at runtime - the second port, after the colon. The Dockerfile specifies that the Tomcat app server is listening for HTTP traffic on port 8080. Therefore, that's the container port that you need to expose. Finally, you need the image tag `flightbookingsystemsample` to tell Docker which image to run. Run the following command:

```bash
docker run -p 8080:8080 flightbookingsystemsample
```

The following output is typical:

```output
docker run -p 8080:8080 flightbookingsystemsample
15-Nov-2024 12:11:12.229 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server version name:   Apache Tomcat/10.1.33
15-Nov-2024 12:11:12.236 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server built:          Nov 7 2024 22:28:55 UTC
15-Nov-2024 12:11:12.236 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server version number: 10.1.33.0
15-Nov-2024 12:11:12.237 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log OS Name:               Linux
15-Nov-2024 12:11:12.237 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log OS Version:            6.10.11-linuxkit
15-Nov-2024 12:11:12.237 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Architecture:          amd64
15-Nov-2024 12:11:12.238 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Java Home:             /usr/lib/jvm/msopenjdk-17
15-Nov-2024 12:11:12.238 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log JVM Version:           17.0.13+11-LTS
15-Nov-2024 12:11:12.238 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log JVM Vendor:            Microsoft
15-Nov-2024 12:11:12.238 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log CATALINA_BASE:         /usr/local/tomcat
15-Nov-2024 12:11:12.239 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log CATALINA_HOME:         /usr/local/tomcat
15-Nov-2024 12:11:12.262 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties
15-Nov-2024 12:11:12.262 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager
15-Nov-2024 12:11:12.263 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djdk.tls.ephemeralDHKeySize=2048
15-Nov-2024 12:11:12.264 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.protocol.handler.pkgs=org.apache.catalina.webresources
15-Nov-2024 12:11:12.264 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dorg.apache.catalina.security.SecurityListener.UMASK=0027
15-Nov-2024 12:11:12.265 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.lang=ALL-UNNAMED
15-Nov-2024 12:11:12.266 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.io=ALL-UNNAMED
15-Nov-2024 12:11:12.267 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.util=ALL-UNNAMED
15-Nov-2024 12:11:12.267 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.util.concurrent=ALL-UNNAMED
15-Nov-2024 12:11:12.268 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED
15-Nov-2024 12:11:12.268 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dcatalina.base=/usr/local/tomcat
15-Nov-2024 12:11:12.268 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dcatalina.home=/usr/local/tomcat
15-Nov-2024 12:11:12.269 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.io.tmpdir=/usr/local/tomcat/temp
15-Nov-2024 12:11:12.271 INFO [main] org.apache.catalina.core.AprLifecycleListener.lifecycleEvent The Apache Tomcat Native library which allows using OpenSSL was not found on the java.library.path: [/usr/java/packages/lib:/usr/lib64:/lib64:/lib:/usr/lib]
15-Nov-2024 12:11:12.699 INFO [main] org.apache.coyote.AbstractProtocol.init Initializing ProtocolHandler ["http-nio-8080"]
15-Nov-2024 12:11:12.760 INFO [main] org.apache.catalina.startup.Catalina.load Server initialization in [845] milliseconds
15-Nov-2024 12:11:12.855 INFO [main] org.apache.catalina.core.StandardService.startInternal Starting service [Catalina]
15-Nov-2024 12:11:12.855 INFO [main] org.apache.catalina.core.StandardEngine.startInternal Starting Servlet engine: [Apache Tomcat/10.1.33]
15-Nov-2024 12:11:12.891 INFO [main] org.apache.catalina.startup.HostConfig.deployWAR Deploying web application archive [/usr/local/tomcat/webapps/AirlinesReservationSample.war]
15-Nov-2024 12:11:15.150 INFO [main] org.apache.jasper.servlet.TldScanner.scanJars At least one JAR was scanned for TLDs yet contained no TLDs. Enable debug logging for this logger for a complete list of JARs that were scanned but no TLDs were found in them. Skipping unneeded JARs during scanning can improve startup time and JSP compilation time.
15-Nov-2024 12:11:17.112 INFO [main] com.sun.xml.ws.server.MonitorBase.createRoot Metro monitoring rootname successfully set to: com.sun.metro:pp=/,type=WSEndpoint,name=/AirlinesReservationSample-PriceAndSeats-PriceAndSeatsPort
15-Nov-2024 12:11:17.400 INFO [main] com.sun.xml.ws.transport.http.servlet.WSServletDelegate.<init> WSSERVLET14: XML-WS servlet initializing
WARNING:Error in the metadata of the table SEATS: table's row count in the metadata is 5 but 6 records have been found and loaded by UCanAccess. All will work fine, but it's better to repair your database.
15-Nov-2024 12:11:18.281 INFO [main] com.sun.xml.ws.transport.http.servlet.WSServletContextListener.contextInitialized WSSERVLET12: XML-WS context listener initializing
15-Nov-2024 12:11:18.282 INFO [main] com.sun.xml.ws.transport.http.servlet.WSServletContextListener.contextInitialized WSSERVLET12: XML-WS context listener initializing
15-Nov-2024 12:11:18.320 INFO [main] org.apache.catalina.startup.HostConfig.deployWAR Deployment of web application archive [/usr/local/tomcat/webapps/AirlinesReservationSample.war] has finished in [5,428] ms
15-Nov-2024 12:11:18.322 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deploying web application directory [/usr/local/tomcat/webapps/ROOT]
15-Nov-2024 12:11:18.363 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deployment of web application directory [/usr/local/tomcat/webapps/ROOT] has finished in [40] ms
15-Nov-2024 12:11:18.363 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deploying web application directory [/usr/local/tomcat/webapps/docs]
15-Nov-2024 12:11:18.404 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deployment of web application directory [/usr/local/tomcat/webapps/docs] has finished in [41] ms
15-Nov-2024 12:11:18.406 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deploying web application directory [/usr/local/tomcat/webapps/examples]
15-Nov-2024 12:11:18.716 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deployment of web application directory [/usr/local/tomcat/webapps/examples] has finished in [310] ms
15-Nov-2024 12:11:18.717 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deploying web application directory [/usr/local/tomcat/webapps/manager]
15-Nov-2024 12:11:18.753 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deployment of web application directory [/usr/local/tomcat/webapps/manager] has finished in [37] ms
15-Nov-2024 12:11:18.754 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deploying web application directory [/usr/local/tomcat/webapps/host-manager]
15-Nov-2024 12:11:18.795 INFO [main] org.apache.catalina.startup.HostConfig.deployDirectory Deployment of web application directory [/usr/local/tomcat/webapps/host-manager] has finished in [40] ms
15-Nov-2024 12:11:18.802 INFO [main] org.apache.coyote.AbstractProtocol.start Starting ProtocolHandler ["http-nio-8080"]
15-Nov-2024 12:11:18.840 INFO [main] org.apache.catalina.startup.Catalina.start Server startup in [6079] milliseconds
```

Open a browser window and visit the Flight Booking System for Airline Reservations landing page at `http://localhost:8080/AirlinesReservationSample/`. Your browser should look similar to the following screenshot:

:::image type="content" source="../media/build-and-run.png" alt-text="Screenshot showing the running app.":::

You can optionally sign in with any user from **tomcat-users.xml** - for example, `someuser@azure.com: password`.

To stop the container, press <kbd>CTRL</kbd>+<kbd>C</kbd> inside the CLI.
