Suppose that you've started a new job as a software developer at the world's most popular pizza joint - Contoso Pizza. Business is booming and the Contoso Pizza's website that indicates whether pizzas are in stock or not has recently been refactored into microservices hosted in Docker containers.

In a microservice-based development approach, each microservice owns its model and data so that it will be autonomous from a development and deployment point of view from other microservices. Hosting microservices inside of a container is a common way to achieve that. These kinds of systems are complex to scale out and manage. You need to consider the process of organizing, adding, removing, and updating many containers. This process is referred to as container management.

For example, you may find during specific times of the day you need to scale up the number of container instances that handle caching. Or you may have an update to the container instance that checks pizza inventory.

To help with container management tasks, you can use a container orchestrator. Kubernetes is one such orchestrator. It is an extensible open-source platform for managing and orchestrating containerized workloads.

This module will teach you about Kubernetes and the problems it solves and how to deploy a .NET web API and web app into a Kubernetes cluster.
