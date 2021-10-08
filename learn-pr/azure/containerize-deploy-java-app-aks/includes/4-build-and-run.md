In this unit, you'll build and run the Docker image.

## Build a Docker image

Now that you have successfully constructed a Dockerfile, you can instruct Docker to build a Docker image for you. 

> [!NOTE]
> A running instance of a Docker image is called "container"

```docker build``` is the command used to build Docker images. The ```-t``` argument will be used to specify a container label and the ```.``` is the location for Docker to find the Dockerfile. Run the following command in your CLI:

```bash
docker build -t turkishairlines .
```

You will see an output similar to the following:

```bash
docker build -t turkishairlines .
Sending build context to Docker daemon  115.7MB
Step 1/5 : FROM tomcat
 ---> 921ef208ab56
Step 2/5 : COPY tomcat-users.xml /usr/local/tomcat/conf
 ---> Using cache
 ---> 138158e2cf0b
Step 3/5 : ADD target/*.war /usr/local/tomcat/webapps/TurkishAirlines.war
 ---> 98e0f3f487a8
Step 4/5 : EXPOSE 8080
 ---> Running in c24b57b9f62e
Removing intermediate container c24b57b9f62e
 ---> bf7fa6cc15a8
Step 5/5 : CMD ["catalina.sh", "run"]
 ---> Running in 78835beea340
Removing intermediate container 78835beea340
 ---> cda4f5b459f1
Successfully built cda4f5b459f1
Successfully tagged turkishairlines:latest
```

As you can see above, Docker has executed the instructions from the 5 lines that you have previously written in the prior unit. Each instruction is a step in sequential order. Rerun the ```docker build``` command again, notice the differences in the steps, you'll notice ```---> Using cache``` for layers that have not changed. If your not recompiling the application (before rerunning the ```docker build``` command), then you will notice all cached layers as the binaries are untouched and can be sourced from Docker cache). This is an important takeaway when optimizing your Docker images and the associated compute costs with time spent building them.

Docker can also display the available images that are resident. This is helpful for viewing what's available to run. Run the following command in your CLI:

```bash
docker image ls
```

You will see an output similar to the following:

```bash
docker image ls
REPOSITORY                                        TAG                 IMAGE ID            CREATED             SIZE
turkishairlines                                   latest              cda4f5b459f1        About an hour ago   692MB
```

## Run a Docker image

Now that you have successfully built a Docker image, you can run it.

```docker run``` is the command used to run a Docker image. The ```-p ####:####``` argument will be used to forward localhost HTTP (the first port before the colon) traffic to the container at runtime (the second port after the colon). Remember from the Dockerfile that the Tomcat application server is listening for HTTP traffic on port 8080 hence that is the container port that needs to be exposed. Lastly the image tag ```turkishairlines``` is needed to instruct Docker of what image to run. Run the following command in your CLI:

```bash
docker run -p 8080:8080 turkishairlines
```

You will see an output similar to the following:

```bash
docker run -p 8080:8080 turkishairlines
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
02-Aug-2021 20:50:24.039 INFO [main] org.apache.catalina.startup.HostConfig.deployWAR Deploying web application archive [/usr/local/tomcat/webapps/TurkishAirlines.war]
02-Aug-2021 20:50:27.164 INFO [main] org.apache.jasper.servlet.TldScanner.scanJars At least one JAR was scanned for TLDs yet contained no TLDs. Enable debug logging for this logger for a complete list of JARs that were scanned but no TLDs were found in them. Skipping unneeded JARs during scanning can improve startup time and JSP compilation time.
02-Aug-2021 20:50:30.887 INFO [main] com.sun.xml.ws.server.MonitorBase.createRoot Metro monitoring rootname successfully set to: com.sun.metro:pp=/,type=WSEndpoint,name=/TurkishAirlines-PriceAndSeats-PriceAndSeatsPort
02-Aug-2021 20:50:31.151 INFO [main] com.sun.xml.ws.transport.http.servlet.WSServletDelegate.<init> WSSERVLET14: JAX-WS servlet initializing
02-Aug-2021 20:50:32.662 INFO [main] com.sun.xml.ws.transport.http.servlet.WSServletContextListener.contextInitialized WSSERVLET12: JAX-WS context listener initializing
02-Aug-2021 20:50:32.663 INFO [main] com.sun.xml.ws.transport.http.servlet.WSServletContextListener.contextInitialized WSSERVLET12: JAX-WS context listener initializing
02-Aug-2021 20:50:32.735 INFO [main] org.apache.catalina.startup.HostConfig.deployWAR Deployment of web application archive [/usr/local/tomcat/webapps/TurkishAirlines.war] has finished in [8,695] ms
02-Aug-2021 20:50:32.746 INFO [main] org.apache.coyote.AbstractProtocol.start Starting ProtocolHandler ["http-nio-8080"]
02-Aug-2021 20:50:32.768 INFO [main] org.apache.catalina.startup.Catalina.start Server startup in [8990] milliseconds
```

Open up a browser and visit the Turkish Airlines landing page at [http://localhost:8080/TurkishAirlines](http://localhost:8080/TurkishAirlines)

You should see the following

![Screenshot showing the running application.](../media/build-and-run-1.png)

You can optionally log in with any user from tomcat-usrrs.xml for example someuser@azure.com:password

To stop the Docker container hold ctrl + c inside the CLI. 