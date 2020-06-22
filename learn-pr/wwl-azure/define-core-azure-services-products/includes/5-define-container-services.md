If you wish to run multiple instances of an application on a single host machine, containers are an excellent choice. The container orchestrator can start, stop, and scale out application instances as needed.

**Containers** are a virtualization environment.

+ Containers reference the operating system of the host environment that runs the container. 
+ Unlike virtual machines you do not manage the operating system.
+ Containers are lightweight and are designed to be created, scaled out, and stopped dynamically. 
+ Containers allows you to respond to changes on demand and quickly restart in case of a crash or hardware interruption.
+ Azure supports Docker containers.

## Virtual machines versus Containers

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yuaq]

There are two ways to manage both Docker and Microsoft-based containers in Azure.

## Azure Container Instances

![Image representing Azure Container Instances](../media/icon-container-instance.png)

[Azure Container Instances](https://azure.microsoft.com/services/container-instances?azure-portal=true) offers the fastest and simplest way to run a container in Azure without having to manage any virtual machines or adopt any additional services. It is a PaaS offering that allows you to upload your containers, which it will run for you. 

## Azure Kubernetes Service

![Image representing Azure Kubernetes Service (AKS)](../media/icon-kubernetes.png)

#### What is Kubernetes?

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yEuX]

The task of automating, managing, and interacting with a large number of containers is known as orchestration. [Azure Kubernetes Service (AKS)](https://azure.microsoft.com/services/kubernetes-service?azure-portal=true) is a complete orchestration service for containers with distributed architectures and large volumes of containers. Orchestration is the task of automating and managing a large number of containers and how they interact. 

## Use containers in your solutions

Containers are often used to create solutions using a _microservice architecture_. This architecture is where you break solutions into smaller, independent pieces. For example, you may split a website into a container hosting your front end, another hosting your back end, and a third for storage. This split allows you to separate portions of your app into logical sections that can be maintained, scaled, or updated independently.

### What is a microservice?

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yual]

Imagine your website backend has reached capacity but the front end and storage aren't being stressed. You could scale the back end separately to improve performance, or you could decide to use a different storage service. Or you could even replace the storage container without affecting the rest of the application.

## Migrate apps to containers

You can move existing applications to containers and run them within AKS. You can control access via integration with Azure Active Directory (Azure AD) and access Service Level Agreement (SLA)–backed Azure services, such as Azure Database for MySQL for any data needs, via Open Service Broker for Azure (OSBA).

![Diagram that depicts moving existing applications to containers and running them within Azure Kubernetes Service, or AKS/](../media/4-kubernetes-migration.png)

The preceding figure depicts this process as follows:

1. You convert an existing application to one or more containers and then publish one or more container images to the Azure Container Registry.
1. By using the Azure portal or the command line, you deploy the containers to an AKS cluster.
1. Azure AD controls access to AKS resources.
1. You access SLA-backed Azure services, such as Azure Database for MySQL, via OSBA.
1. Optionally, AKS is deployed with a virtual network.



