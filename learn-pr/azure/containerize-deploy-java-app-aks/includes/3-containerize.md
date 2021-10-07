In this unit, you'll containerize a Java application.

As mentioned earlier, containers run directly on top of the host operating system, kernel and hardware, as essentially just another process. Because of this, containers require less system resources, resulting in a smaller footprint with substantially less overhead, faster application startup times, and a great use case for scaling on demand. 

There are multiple container runtimes. In this module, you’ll leverage the widely used Docker runtime to build a Docker image that will ultimately, in the next unit, deploy to the host operating system of your local machine and within the Azure Kubernetes Service.

## Docker overview

The Docker runtime is used to build, pull, run, and push Docker images. The below image depicts these use cases followed by a description of each use case/Docker command.

![Screenshot showing the running application.](../media/containerize-1.png)

| Docker command | Description |
|-|-|
| docker build | Build a Docker image, essentially the instructions/layers needed for Docker to ultimately create a running container from an image. The result of this command is an image. |
| docker pull  | Containers are initialized from images, which are pulled from registries, such as Azure Container Registry, and this is where Azure Kubernetes Service will pull from. The result of this command is a network pull of an image that will occur in Azure. Note, you can optionally pull images locally, this is common when building images that require dependencies/layers for which your application may need, such as an application server. |
| docker run   | A running instance of a Docker image is a container, all of the layers needed to run and interact with the running container application are executed with this command. The result of this command is a running application process on the host operating system. |
| docker push | Azure Container Registry will store the images so they are readily available and network close for Azure deployments and scale. |

## Clone the Java Application

First you'll clone the Turkish Airlines repo. 

> [!NOTE]
> If the Azure Kubernetes Service creation has successfully completed in your CLI tab, use that one, otherwise if its still running, open a new tab and cd to the location of where you prefer to clone Turkish Airline.

Run the following command in your CLI:

```bash
gh repo clone chtrembl/Flight-Booking-System-JavaServlets_App
```

Run the following command in your CLI:

```bash
cd Flight-Booking-System-JavaServlets_App/Project/TurkishAirlines
```

Run the following command in your CLI:

```bash
mvn clean install
```

Maven should have successfully built the Turkish Airlines Web Application Archive artifact TurkishAirlines-0.0.1-SNAPSHOT.war, as seen below:

```bash
[INFO] Building war: /mnt/c/Users/chtrembl/dev/git/Flight-Booking-System-JavaServlets_App/Project/TurkishAirlines/target/TurkishAirlines-0.0.1-SNAPSHOT.war
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  17.698 s
[INFO] Finished at: 2021-09-28T15:18:07-04:00
[INFO] ------------------------------------------------------------------------
```

Imagine you’re that Java developer and you have just built this TurkishAirlines-0.0.1-SNAPSHOT.war, you're next step is to probably work with the operation engineers to get this artifact deployed to an on-premises server and/or virtual machine. This effort requires that the servers and/or virtual machines, are to be available and configured with the required dependencies for Turkish Airlines to start and run successfully. Both of which are challenging and time consuming, especially on demand when increased load is hitting your application.

## Construct a Docker file

At this point, your ready to construct a Docker file. A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image, each of which are a layer that build on top of each other.

For example, Turkish Airlines needs to deploy to and run inside of an Application Server, to process HTTP Requests and manage user sessions. This Application Server is not packaged inside of the TurkishAirlines-0.0.1-SNAPSHOT.war, it is an external dependency needed at runtime by the TurkishAirlines-0.0.1-SNAPSHOT.war. If this was a traditional, non containerized deployment, operation engineers would install the Application Server on the server and/or virtual machine, before deploying the TurkishAirlines-0.0.1-SNAPSHOT.war to it.

With a Docker file, you can write the instructions needed to accomplish this, by layering in the steps needed to ensure Turkish Airlines has all of the dependencies needed to deploy to any container runtime. This is very compelling when you start to think about on demand scale at unplanned intervals.

Within the root of your project, Flight-Booking-System-JavaServlets_App/Project/TurkishAirlines, Create a file called Dockerfile:

```bash
vi Dockerfile
```

Add the following contents to Dockerfile and then save and exit:

```dockerfile
FROM tomcat
COPY tomcat-users.xml /usr/local/tomcat/conf
ADD target/*.war /usr/local/tomcat/webapps/TurkishAirlines.war
EXPOSE 8080

CMD ["catalina.sh", "run"]
```

> [!NOTE]
> Optionally, the Dockerfile_Solution contains the contents needed.

As you can see, this Docker file has 5 instructions.

| Docker command | Description |
|-|-|
| FROM   | FROM tomcat will be the base layer that this Docker image will be built on top of. The Turkish Airlines Docker image will be an image built on top of the tomcat image. The Docker runtime will attempt to locate the tomcat image locally, if it does not have the latest, it will pull one down from the registry. If you were to inspect the tomcat image thats being referenced here, you would see its built using many other layers, all of which make it reusable as one packaged application server Docker image for the world to use when deploying their Java application. |
| COPY   | COPY tomcat-users.xml will copy the tomcat-users.xml file that manages the Turkish Airlines users (managed within source control using Tomcat identity, typically this would be in an external identity management system) into the tomcat Docker image so that its present in the Docker image each and evert time a Dcoker image is created |
| ADD    | ADD target/*.war /usr/local/tomcat/webapps/TurkishAirlines.war will copy the maven compiled TurkishAirlines-0.0.1-SNAPSHOT.war to the tomcat images webapps folder to ensure that when Tomcat is initialize, it will in fact find the TurkishAirlines-0.0.1-SNAPSHOT.war to be installed on the application server. |
| EXPOSE | EXPOSE 8080 is needed as Tomcat is configured to listen to traffic on port 8080, this ensures the Docker process will listen on this port. |
| CMD | CMD ["catalina.sh", "run"], Last but not least, you need to instruct Docker what to do for initialization. Generally this is a startup script. In this case you can use the tomcat Docker image catalina.sh shell script, and instruct Docker to "run" it, the default behavior for a Tomcat Application Server. |

For more information on Dockerfile construction please visit [https://docs.docker.com/engine/reference/builder/](https://docs.docker.com/engine/reference/builder/)