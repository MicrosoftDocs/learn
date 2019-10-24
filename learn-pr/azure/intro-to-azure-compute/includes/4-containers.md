:::row:::
  :::column:::
    ![Image representing Azure containers](../media/4-azure-containers.png)
  :::column-end:::
  :::column span="3":::
If you wish to run multiple instances of an application on a single host machine, containers are an excellent choice. The container orchestrator can start, stop, and scale out application instances as needed.
  :::column-end:::
:::row-end:::

A container is a modified runtime environment built on top of a host OS that executes your application. A container doesn't use virtualization, so it doesn't waste resources simulating virtual hardware with a redundant OS. This environment typically makes containers more lightweight than VMs. This design allows you to respond quickly to changes in demand or failure. Another benefit of containers is you can run multiple isolated applications on a single container host. Since containers are secured and isolated, you don't need separate servers for each app.

## VMs versus containers

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yuaq]

## Containers in Azure

Azure supports Docker containers (a standardized container model), and there are several ways to manage containers in Azure.

- Azure Container Instances (ACI)
- Azure Kubernetes Service (AKS)

### Azure Container Instances

Azure Container Instances (ACI) offers the fastest and simplest way to run a container in Azure. You don't have to manage any virtual machines or configure any additional services. It is a PaaS offering that allows you to upload your containers and execute them directly with automatic elastic scale.

### Azure Kubernetes Service

The task of automating, managing, and interacting with a large number of containers is known as orchestration. Azure Kubernetes Service (AKS) is a complete orchestration service for containers with distributed architectures with multiple containers.

#### What is Kubernetes?

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yEuX]

## Using containers in your solutions

Containers are often used to create solutions using a _microservice architecture_. This architecture is where you break solutions into smaller, independent pieces. For example, you may split a website into a container hosting your front end, another hosting your back end, and a third for storage. This split allows you to separate portions of your app into logical sections that can be maintained, scaled, or updated independently.

### What is a microservice?

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yual]

Imagine your website backend has reached capacity but the front end and storage aren't being stressed. You could scale the back end separately to improve performance, or you could decide to use a different storage service. Or you could even replace the storage container without affecting the rest of the application.

## Migrating apps to containers

You can move existing applications to containers and run them within AKS. You can control access via integration with Azure Active Directory (Azure AD) and access Service Level Agreement (SLA)–backed Azure services, such as Azure Database for MySQL for any data needs, via Open Service Broker for Azure (OSBA).

![Diagram that depicts moving existing applications to containers and running them within Azure Kubernetes Service, or AKS/](../media/4-kub-migration.png)

The preceding figure depicts this process as follows:

1. You convert an existing application to one or more containers and then publish one or more container images to the Azure Container Registry.
1. By using the Azure portal or the command line, you deploy the containers to an AKS cluster.
1. Azure AD controls access to AKS resources.
1. You access SLA-backed Azure services, such as Azure Database for MySQL, via OSBA.
1. Optionally, AKS is deployed with a virtual network.
