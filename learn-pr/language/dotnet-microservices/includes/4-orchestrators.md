Contoso Pizza loves the results the microservice architecture has been giving them so far. The overall web application calls individual microservices to provide and manipulate data.

As more services get added, however, the overall system becomes more complex to scale out and manage. Orchestrators can help.

## What is an orchestrator?

Using orchestrators for production-ready applications is essential if your application is based on microservices or split across multiple containers. As introduced previously, in a microservice-based approach, each microservice owns its model and data so it will be autonomous from a development and deployment point of view. These kinds of systems are complex to scale out and manage; therefore, you absolutely need an orchestrator if you want to have a production-ready and scalable multi-container application.

The following image illustrates deployment into a cluster of an application composed of multiple microservices (clusters).

:::image type="complex" source="../media/composed-docker-applications-cluster.png" alt-text="diagram showing docker applications in a cluster.":::
This diagram shows six docker images deployed as two applications. The applications are then deployed as several clusters. The diagram is meant to show how difficult it would be to perform the deployment without a tool to help.
:::image-end:::

You use one container for each service instance. Docker containers are "units of deployment," and a container is an instance of a Docker image. A host handles many containers. It looks like a logical approach. An orchestrator helps deploy the containers and manage the hosts.

## Why would you use an orchestrator?

There are many benefits to using an orchestrator with a containerized microservice architecture.

The orchestrator helps with composing applications consisting of many microservices into one deployable unit. That unit is then moved &mdash; or deployed &mdash; to a host.

Once deployed, the orchestrator then helps with managing the host. It can automatically start the containers, scale them out with multiple instances per image, suspend them, or shut them down when needed. The orchestrator can also control how containers access resources like the network and data storage.

Orchestrators can perform tasks such as load-balancing and routing in scenarios when multiple containers exist on multiple hosts in a complex distributed system. They can also monitor the containers' and hosts' health.

## Docker Compose

A full-featured orchestrator might be too much for the simple website that Contoso Pizza is dealing with. What they need is a tool that lets them build multiple Docker images together as a single unit and then deploy that unit.

Docker Compose is a great tool for their needs.

With Docker Compose, Contoso Pizza can use a YAML file to configure an application's services. The Docker Compose tool then provides a way to build the individual services, and a means to start them.

> [!NOTE]
> The Docker compose tool gets installed by default with the Docker for desktop which makes it easier to run all containers along with their dependencies locally. For production scenarios, we recommend using Orchestrators that give finer control over automatic deployment, scaling, and management of containers.

## Knowledge check
