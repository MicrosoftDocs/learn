Suppose that you started a new job as a software developer at the Contoso outdoor company, which sells clothes and gifts. Business is booming and Contoso's website that indicates whether or not items are in stock has recently been refactored into microservices hosted in Docker containers.

In a microservice-based development approach, each microservice owns its model and data so that it will be autonomous from other microservices from a development and deployment point of view. Hosting microservices inside of a container is a common way to achieve that. These kinds of systems are complex to scale out and manage. You need to consider the process of organizing, adding, removing, and updating many containers. This process is called *container management*.

For example, you might find during specific times of the day you need to scale up the number of container instances that handle caching, or you might have an update to the container instance that checks merchandise inventory.

To help with container-management tasks, you can use a container orchestrator. Kubernetes is one such orchestrator. It's an extensible, open-source platform for managing and orchestrating containerized workloads.

This module teaches you about Kubernetes and the problems it solves, and how to deploy a .NET web API and web app into a Kubernetes cluster.

## Learning objectives

In this module, you will:

- Learn the concepts behind orchestrators and why you might need them.
- Take an existing .NET microservice hosted in a Docker container and push it to Docker Hub.
- Deploy the microservice from Docker Hub to a local Kubernetes instance.
- Learn how to scale a container instance in a Kubernetes cluster.
