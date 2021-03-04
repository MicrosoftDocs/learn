While virtual machines are an excellent way to reduce costs versus the investments that are necessary for physical hardware, they're still limited to a single operating system per virtual machine. If you want to run multiple instances of an application on a single host machine, containers are an excellent choice.

## What are containers?

Containers are a virtualization environment. Much like running multiple virtual machines on a single physical host, you can run multiple containers on a single physical or virtual host. Unlike virtual machines, you don't manage the operating system for a container. Virtual machines appear to be an instance of an operating system that you can connect to and manage, but containers are lightweight and designed to be created, scaled out, and stopped dynamically. While it's possible to create and deploy virtual machines as application demand increases, containers are designed to allow you to respond to changes on demand. With containers, you can quickly restart in case of a crash or hardware interruption. One of the most popular container engines is Docker, which is supported by Azure.

## Compare virtual machines to containers

The following video highlights several of the important differences between virtual machines and containers.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yuaq]

## Manage containers

Containers are managed through a container orchestrator, which can start, stop, and scale out application instances as needed. There are two ways to manage both Docker and Microsoft-based containers in Azure: Azure Container Instances and Azure Kubernetes Service (AKS).

:::row:::
  :::column span="3":::

### Azure Container Instances

[Azure Container Instances](https://azure.microsoft.com/services/container-instances?azure-portal=true) offers the fastest and simplest way to run a container in Azure without having to manage any virtual machines or adopt any additional services. It's a platform as a service (PaaS) offering that allows you to upload your containers, which it runs for you.

  :::column-end:::
  :::column:::
    :::image type="icon" source="../media/icon-container-instance.png" border="false":::
  :::column-end:::
:::row-end:::

:::row:::
  :::column:::
    :::image type="icon" source="../media/icon-kubernetes.png" border="false":::
  :::column-end:::
  :::column span="3":::

### Azure Kubernetes Service

The task of automating, managing, and interacting with a large number of containers is known as orchestration. [Azure Kubernetes Service](https://azure.microsoft.com/services/kubernetes-service?azure-portal=true) is a complete orchestration service for containers with distributed architectures and large volumes of containers. Orchestration is the task of automating and managing a large number of containers and how they interact.

  :::column-end:::
:::row-end:::

### What is Kubernetes?

The following video discusses some important details about Kubernetes container orchestration.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yEuX]

## Use containers in your solutions

Containers are often used to create solutions by using a _microservice architecture_. This architecture is where you break solutions into smaller, independent pieces. For example, you might split a website into a container hosting your front end, another hosting your back end, and a third for storage. This split allows you to separate portions of your app into logical sections that can be maintained, scaled, or updated independently.

Imagine your website back-end has reached capacity but the front end and storage aren't being stressed. You could:

* Scale the back end separately to improve performance.
* Decide to use a different storage service.
* Replace the storage container without affecting the rest of the application.

### What is a microservice?

The following video discusses some important details about microservices.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yual]

[//]: # (NOTE: REMOVED THE FOLLOWING)
[//]: # (## Migrate applications to containers)
[//]: # (You can move existing applications to containers and run them within AKS. You can control access via integration with Azure Active Directory and access Service Level Agreement-backed Azure services, such as Azure Database for MySQL for any data needs, via Open Service Broker for Azure OSBA.)
[//]: # (![Diagram that depicts moving existing applications to containers and running them within Azure Kubernetes Service, or AKS/]../media/kubernetes-migration.png)
[//]: # (The preceding figure depicts this process as follows:)
[//]: # (1. You convert an existing application to one or more containers, and then publish one or more container images to the Azure Container Registry.)
[//]: # (1. By using the Azure portal or the command line, you deploy the containers to an AKS cluster.)
[//]: # (1. Azure AD controls access to AKS resources.)
[//]: # (1. You access SLA-backed Azure services, such as Azure Database for MySQL, via OSBA.)
[//]: # (1. Optionally, AKS is deployed with a virtual network.)
