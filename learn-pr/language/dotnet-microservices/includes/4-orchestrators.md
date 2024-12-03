Contoso loves the results of using a microservices architecture so far. The overall web application calls individual microservices to provide and manipulate data.

But as more services are added, the overall system becomes more complex to scale out and manage. Orchestrators can help.

## What is an orchestrator?

An orchestrator is a tool that helps you manage, scale, and maintain a containerized application.

Using orchestrators for production-ready applications is essential if your application is based on microservices or is split across multiple containers. As noted earlier, in a microservice-based approach, each microservice owns its model and data. The microservice is autonomous from a development and deployment point of view. These kinds of systems are complex to scale out and manage. Therefore, to have a production-ready and scalable multi-container application, you absolutely need an orchestrator.

A cluster is one type of orchestrator. The following diagram illustrates using a cluster to orchestrate the deployment of an application that's composed of multiple microservices.

:::image type="complex" source="../media/composed-docker-applications-cluster.png" border="false" alt-text="Diagram that shows Docker applications in a cluster.":::

You use one container for each service instance. Docker containers are *units of deployment*, and a container is an instance of a Docker image. A host handles many containers. It looks like a logical approach. An orchestrator helps deploy the containers and manage the hosts.

## Why would you use an orchestrator?

There are many benefits to using an orchestrator with a containerized microservices architecture.

The orchestrator helps you combine applications that are made of many microservices in one deployable unit. That unit is then moved to a host via deployment.

After the unit is deployed, the orchestrator helps manage the host. It can automatically start the containers, scale them out with multiple instances for each image, suspend them, or shut them down when needed. The orchestrator can also control how containers access resources like the network and data storage.

Orchestrators can perform tasks such as load-balancing and routing when multiple containers exist on multiple hosts in a complex distributed system. They can also monitor the containers' and hosts' health.

## Docker Compose

A fully featured orchestrator might be more than what's needed for Contoso's simple website. What the company needs is a tool that lets it build multiple Docker images as a single unit, and then deploy the unit.

Docker Compose is a tool that meets Contoso's needs.

With Docker Compose, Contoso can use a YAML file to configure an application's services. The Docker Compose tool then provides a way to build the individual services and a means to start them.

> [!NOTE]
> The Docker Compose tool is installed by default with Docker Desktop, so it's easier to run all containers and their dependencies locally. For production scenarios, we recommend that you use orchestrators that give finer control over the automatic deployment, scaling, and management of containers.

## Knowledge check
