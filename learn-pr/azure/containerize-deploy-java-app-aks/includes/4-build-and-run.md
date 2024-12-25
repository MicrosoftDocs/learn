In this unit, you'll build and run the container image. As we learned earlier, a running instance of an image is a container.

## Build a container image

Now that you've successfully constructed a Dockerfile, you can instruct Docker to build a container image for you.

> [!NOTE]
> Ensure your Docker runtime is configured to build Linux containers. This is important because the Dockerfile we're using references container images (JDK/JRE) for the Linux architecture.

```docker build``` is the command you'll use to build container images. You'll use the ```-t``` argument to specify a container label, and the ```.``` is the location for Docker to find the Dockerfile. Run the following command in your CLI:

```bash
docker build -t flightbookingsystemsample .
```

You’ll get output similar to the following:

```output
docker build -t flightbookingsystemsample .
Sending build context to Docker daemon  101.3MB
Step 1/11 : FROM maven:3.6.0-jdk-11-slim AS build
3.6.0-jdk-11-slim: Pulling from library/maven
27833a3ba0a5: Pull complete
16d944e3d00d: Pull complete
6aaf465b8930: Pull complete
0684138f4cb6: Pull complete
67c4e741e688: Pull complete
933857515267: Pull complete
4f31e2918c2c: Pull complete
70a0a987b087: Pull complete
8369c7ef3731: Pull complete
7a73ce905393: Pull complete
c702b567a1e8: Pull complete
Digest: sha256:4f0face24d2f79439a8fa394555b09be99c9ad537b9b19983fb8cc358818a42d
Status: Downloaded newer image for maven:3.6.0-jdk-11-slim
 ---> c7428be691f8
Step 2/11 : WORKDIR /build
 ---> Running in f1656ab15874
Removing intermediate container f1656ab15874
 ---> d9bfeb518c86
Step 3/11 : COPY pom.xml .
 ---> a60aab61d487
Step 4/11 : COPY src ./src
 ---> 049803b88a20
Step 5/11 : COPY web ./web
 ---> 8d98ddb1fbc3
Step 6/11 : RUN mvn clean package
 ---> Running in 71a462c5b3ad
[INFO] Scanning for projects...

...

[INFO] Packaging webapp
[INFO] Assembling webapp [FlightBookingSystemSample] in [/build/target/FlightBookingSystemSample-0.0.1-SNAPSHOT]
[INFO] Processing war project
[INFO] Copying webapp webResources [/build/web] to [/build/target/FlightBookingSystemSample-0.0.1-SNAPSHOT]
[INFO] Copying webapp resources [/build/src/main/webapp]
[INFO] Building war: /build/target/FlightBookingSystemSample-0.0.1-SNAPSHOT.war
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  26.811 s
[INFO] Finished at: 2021-10-09T01:58:31Z
[INFO] ------------------------------------------------------------------------
Removing intermediate container 71a462c5b3ad
 ---> 3d40f8a4f631
Step 7/11 : FROM tomcat:8.5.72-jre11-openjdk-slim
8.5.72-jre11-openjdk-slim: Pulling from library/tomcat
bd897bb914af: Pull complete
0cc7fec72146: Pull complete
14c358bab58a: Pull complete
c12f81e19ff2: Pull complete
89238a07057c: Pull complete
46896a83c0d8: Pull complete
15f6001bf0c8: Pull complete
34374d37175f: Pull complete
Digest: sha256:807efbd54faa7342c1f75f1466889148fda1f299b81dc40404312352a2086a5f
Status: Downloaded newer image for tomcat:8.5.72-jre11-openjdk-slim
 ---> 77903b2cfd74
Step 8/11 : COPY tomcat-users.xml /usr/local/tomcat/conf
 ---> c540464832e7
Step 9/11 : COPY --from=build /build/target/*.war /usr/local/tomcat/webapps/FlightBookingSystemSample.war
 ---> 6d1eb5d1568c
Step 10/11 : EXPOSE 8080
 ---> Running in 753385de3d77
Removing intermediate container 753385de3d77
 ---> f744382dd869
Step 11/11 : CMD ["catalina.sh", "run"]
 ---> Running in 58a822ee7a4a
Removing intermediate container 58a822ee7a4a
 ---> a0b73d3f3f91
Successfully built a0b73d3f3f91
Successfully tagged flightbookingsystemsample:latest
```

As you noticed previously, Docker executed the instructions from the lines that you wrote in the prior unit. Each instruction is a step in sequential order. Rerun the ```docker build``` command again and notice the differences in the steps. You'll notice ```---> Using cache``` for layers that haven’t changed. If you're not making app changes before rerunning the ```docker build``` command, then you’ll notice all cached layers as the binaries are untouched and can be sourced from the Docker cache. This is an important takeaway when optimizing your container images and the associated compute costs with time spent building them.

Docker can also display the available images that are resident. This is helpful for viewing what's available to run. Run the following command in your CLI:

```bash
docker image ls
```

You’ll get output similar to the following:

```output
docker image ls
REPOSITORY                                        TAG                 IMAGE ID            CREATED             SIZE
flightbookingsystemsample                         latest              cda4f5b459f1        About an hour ago   268MB
```

## Run a container image

Now that you've successfully built a container image, you can run it.

```docker run``` is the command used to run a container image. The ```-p ####:####``` argument will forward localhost HTTP (the first port before the colon) traffic to the container at runtime (the second port after the colon). Remember from the Dockerfile that the Tomcat app server is listening for HTTP traffic on port 8080; hence, that's the container port that needs to be exposed. Lastly, the image tag ```flightbookingsystemsample``` is needed to instruct Docker of what image to run. Run the following command in your CLI:

```bash
docker run -p 8080:8080 flightbookingsystemsample
```

You’ll get output similar to the following:

```output
docker run -p 8080:8080 flightbookingsystemsample
NOTE: Picked up JDK_JAVA_OPTIONS:  --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.util.concurrent=ALL-UNNAMED --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED
02-Aug-2021 20:50:22.682 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server version name:   Apache Tomcat/9.0.50
02-Aug-2021 20:50:22.687 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server built:          Jun 28 2021 08:46:44 UTC
02-Aug-2021 20:50:22.687 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server version number: 9.0.50.0
02-Aug-2021 20:50:22.688 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log OS Name:               Linux
02-Aug-2021 20:50:22.688 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log OS Version:            5.10.16.3-microsoft-standard-WSL2
02-Aug-2021 20:50:22.689 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Architecture:          amd64
02-Aug-2021 20:50:22.690 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Java Home:             /usr/local/openjdk-11
02-Aug-2021 20:50:22.694 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log JVM Version:           11.0.12+7
02-Aug-2021 20:50:22.694 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log JVM Vendor:            Oracle Corporation
02-Aug-2021 20:50:22.695 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log CATALINA_BASE:         /usr/local/tomcat
02-Aug-2021 20:50:22.696 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log CATALINA_HOME:         /usr/local/tomcat
02-Aug-2021 20:50:22.729 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.lang=ALL-UNNAMED
02-Aug-2021 20:50:22.730 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.io=ALL-UNNAMED
02-Aug-2021 20:50:22.730 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.util=ALL-UNNAMED
02-Aug-2021 20:50:22.730 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.util.concurrent=ALL-UNNAMED
02-Aug-2021 20:50:22.731 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED
02-Aug-2021 20:50:22.731 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties
02-Aug-2021 20:50:22.733 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager
02-Aug-2021 20:50:22.735 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djdk.tls.ephemeralDHKeySize=2048
02-Aug-2021 20:50:22.735 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.protocol.handler.pkgs=org.apache.catalina.webresources
02-Aug-2021 20:50:22.735 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dorg.apache.catalina.security.SecurityListener.UMASK=0027
02-Aug-2021 20:50:22.735 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dignore.endorsed.dirs=
02-Aug-2021 20:50:22.735 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dcatalina.base=/usr/local/tomcat
02-Aug-2021 20:50:22.736 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dcatalina.home=/usr/local/tomcat
02-Aug-2021 20:50:22.736 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.io.tmpdir=/usr/local/tomcat/temp
02-Aug-2021 20:50:22.762 INFO [main] org.apache.catalina.core.AprLifecycleListener.lifecycleEvent Loaded Apache Tomcat Native library [1.2.30] using APR version [1.6.5].
02-Aug-2021 20:50:22.763 INFO [main] org.apache.catalina.core.AprLifecycleListener.lifecycleEvent APR capabilities: IPv6 [true], sendfile [true], accept filters [false], random [true], UDS [true].
02-Aug-2021 20:50:22.763 INFO [main] org.apache.catalina.core.AprLifecycleListener.lifecycleEvent APR/OpenSSL configuration: useAprConnector [false], useOpenSSL [true]
02-Aug-2021 20:50:22.776 INFO [main] org.apache.catalina.core.AprLifecycleListener.initializeSSL OpenSSL successfully initialized [OpenSSL 1.1.1d  10 Sep 2019]
02-Aug-2021 20:50:23.686 INFO [main] org.apache.coyote.AbstractProtocol.init Initializing ProtocolHandler ["http-nio-8080"]
02-Aug-2021 20:50:23.777 INFO [main] org.apache.catalina.startup.Catalina.load Server initialization in [1697] milliseconds
02-Aug-2021 20:50:23.977 INFO [main] org.apache.catalina.core.StandardService.startInternal Starting service [Catalina]
02-Aug-2021 20:50:23.978 INFO [main] org.apache.catalina.core.StandardEngine.startInternal Starting Servlet engine: [Apache Tomcat/9.0.50]
02-Aug-2021 20:50:24.039 INFO [main] org.apache.catalina.startup.HostConfig.deployWAR Deploying web app archive [/usr/local/tomcat/webapps/FlightBookingSystemSample.war]
02-Aug-2021 20:50:27.164 INFO [main] org.apache.jasper.servlet.TldScanner.scanJars At least one JAR was scanned for TLDs yet contained no TLDs. Enable debug logging for this logger for a complete list of JARs that were scanned but no TLDs were found in them. Skipping unneeded JARs during scanning can improve startup time and JSP compilation time.
02-Aug-2021 20:50:30.887 INFO [main] com.sun.xml.ws.server.MonitorBase.createRoot Metro monitoring rootname successfully set to: com.sun.metro:pp=/,type=WSEndpoint,name=/FlightBookingSystemSample-PriceAndSeats-PriceAndSeatsPort
02-Aug-2021 20:50:31.151 INFO [main] com.sun.xml.ws.transport.http.servlet.WSServletDelegate.<init> WSSERVLET14: JAX-WS servlet initializing
02-Aug-2021 20:50:32.662 INFO [main] com.sun.xml.ws.transport.http.servlet.WSServletContextListener.contextInitialized WSSERVLET12: JAX-WS context listener initializing
02-Aug-2021 20:50:32.663 INFO [main] com.sun.xml.ws.transport.http.servlet.WSServletContextListener.contextInitialized WSSERVLET12: JAX-WS context listener initializing
02-Aug-2021 20:50:32.735 INFO [main] org.apache.catalina.startup.HostConfig.deployWAR Deployment of web app archive [/usr/local/tomcat/webapps/FlightBookingSystemSample.war] has finished in [8,695] ms
02-Aug-2021 20:50:32.746 INFO [main] org.apache.coyote.AbstractProtocol.start Starting ProtocolHandler ["http-nio-8080"]
02-Aug-2021 20:50:32.768 INFO [main] org.apache.catalina.startup.Catalina.start Server startup in [8990] milliseconds
```

Open a browser window and visit the Flight Booking System for Airline Reservations landing page at `http://localhost:8080/FlightBookingSystemSample`.

You should see the following:

![Screenshot showing the running app.](../media/build-and-run.png)

You can optionally sign in with any user from t`omcat-users.xml`; for example, `someuser@azure.com: password`.

To stop the container, press <kbd>CTRL</kbd> + <kbd>c</kbd> inside the CLI.
