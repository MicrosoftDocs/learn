While virtual machines are an excellent way to reduce costs versus the investments that are necessary for physical hardware, they're still limited to a single operating system per virtual machine. If you want to run multiple instances of an application on a single host machine, containers are an excellent choice.

## What are containers?

Containers are a virtualization environment. Much like running multiple virtual machines on a single physical host, you can run multiple containers on a single physical or virtual host. Unlike virtual machines, you don't manage the operating system for a container. Virtual machines appear to be an instance of an operating system that you can connect to and manage, but containers are lightweight and designed to be created, scaled out, and stopped dynamically. While it's possible to create and deploy virtual machines as application demand increases, containers are designed to allow you to respond to changes on demand. With containers, you can quickly restart in case of a crash or hardware interruption. One of the most popular container engines is Docker, which is supported by Azure.

## Compare virtual machines to containers

The following video highlights several of the important differences between virtual machines and containers.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yuaq]

## Manage containers

Containers are managed through a container orchestrator, which can start, stop, and scale out application instances as needed. There are two ways to manage both Docker and Microsoft-based containers in Azure: Azure Container Instances and Azure Kubernetes Service (AKS).

:::row:::
  :::column span="2":::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column span="2":::
    

**Azure Container Instances**


[Azure Container Instances](https://azure.microsoft.com/services/container-instances?azure-portal=true) offers the fastest and simplest way to run a container in Azure without having to manage any virtual machines or adopt any additional services. It's a platform as a service (PaaS) offering that allows you to upload your containers, which it runs for you.


  :::column-end:::
  :::column:::
    :::image type="content" source="../media/icon-container-instance-7b714f67.png" alt-text="Icon representing Azure Container Instances.":::

  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    :::image type="content" source="../media/icon-kubernetes-a0946004.png" alt-text="Icon representing Azure Kubernetes Service.":::

  :::column-end:::
  :::column span="2":::
    

**Azure Kubernetes Service**

The task of automating, managing, and interacting with a large number of containers is known as orchestration. [Azure Kubernetes Service](https://azure.microsoft.com/services/kubernetes-service?azure-portal=true) is a complete orchestration service for containers with distributed architectures and large volumes of containers.


  :::column-end:::
:::row-end:::


### What is Kubernetes?

The following video discusses some important details about Kubernetes container orchestration.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yEuX]

## Use containers in your solutions

Containers are often used to create solutions by using a *microservice architecture*. This architecture is where you break solutions into smaller, independent pieces. For example, you might split a website into a container hosting your front end, another hosting your back end, and a third for storage. This split allows you to separate portions of your app into logical sections that can be maintained, scaled, or updated independently.

Imagine your website back-end has reached capacity but the front end and storage aren't being stressed. You could:

 -  Scale the back end separately to improve performance.
 -  Decide to use a different storage service.
 -  Replace the storage container without affecting the rest of the application.

### What is a microservice?

The following video discusses some important details about microservices.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yual]
