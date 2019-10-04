Many distributed applications consist of components that run on different servers, virtual servers, or containers. For example, in a database application, you often need a web server that hosts a web user interface and a database server that persists data. If you are using containers to run these components, it is helpful to be able to configure and deploy these components in a single operation.

Suppose you have chosen to use containers to deploy a SQL Server 2017 image to test environments for your photo-sharing application. In the acceptance testing environment, you want to deploy both the SQL Server 2017 database server and the front-end web server that hosts the website for the application in a single operation.

In this unit, you will learn how Docker Compose can enable you to create a complete distributed application and deploy it in a single unit.

## What is Docker Compose?

Docker Compose is a tool that you can use to configure, start, and stop multiple Docker containers as a unit on the same Docker host.

For example, in your complete photo-sharing application, you have the following components:

- A database that you want to host in a SQL Server 2017 container.
- A web service, which implements the business logic for the application, that you want to host in an Apache container.
- A web front-end user interface, that you want to host in a separate Apache container.

You create an image Dockerfile for each of these components. To start and deploy them using Docker alone, you must issue three separate `docker run` commands, each with a different path to the correct Dockerfile.

To streamline this startup process, you can use Docker Compose. With this tool, you can create a text file named docker-compose.yml that defines all the containers in the complete application and their relationship to each other. Then, by issuing a `docker-compose up` command, you can build and start them all.

## How to create an application with Docker Compose

Start by defining all the images in the applications individually by developing and troubleshooting a Dockerfile for each one. Then you can proceed to define the complete application by creating a **docker-compose.yml** file.

A **docker-compose.yml** file defines a set of services. Each service is one or more containers created from a single Docker image. For each service, you can specify properties such as TCP or UDP port mappings, CPU resources, or memory resources. The syntax of this file is the YAML markup language.

The following code shows an example **docker-compose.yml** file that creates two services, a web server and a database server:

```yaml
version: "3"
services:
    webserver:
        build: ./photoshare-webserver-image
        ports: 
            - "5050:50"
        depends_on:
            - dbserver
    dbserver:
        build: ./photoshare-dbserver-image
        environment:
            SA_PASSWORD: "Pa$$w0rd"
            ACCEPT_EULA: "Y"
        ports:
            - "1500:1433
```

Once you have created the **docker-compose.yml** file, you can start all the services it defines by issuing the following command in the same folder:

```bash
sudo docker-compose up
```