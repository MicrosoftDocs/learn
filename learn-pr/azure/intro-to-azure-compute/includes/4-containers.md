:::row:::
  :::column:::
    ![Image representing Azure containers](../media/4-azure-containers.png)
  :::column-end:::
  :::column span="3":::
If you wish to run multiple instances of an application on a single virtual machine, containers are an excellent choice. The container orchestrator can start, stop, and scale out application instances as needed.
  :::column-end:::
:::row-end:::

Containers are meant to be lightweight, created, scaled out, and stopped dynamically. This design allows you to respond quickly to changes in demand or failure.

Another benefit of containers is you can run multiple isolated applications on a single VM host. Since containers are secured and isolated, you don't need separate VMs for each app.

#### VMs versus containers

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yuaq]

## Containers in Azure

Azure supports Docker containers, and there are several ways to manage containers in Azure.

- Azure Container Instances (ACI)
- Azure Kubernetes Service (AKS)

### Azure Container Instances

Azure Container Instances (ACI) offers the fastest and simplest way to run a container in Azure. You don't have to manage any virtual machines or configure any additional services. It is a PaaS offering that allows you to upload your containers and execute them directly. 

### Azure Kubernetes Service

The task of automating and managing and interacting with a large number of containers is known as orchestration. Azure Kubernetes Service (AKS) is a complete orchestration service for containers with distributed architectures with multiple containers. 

#### What is Kubernetes?

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yEuX]

### Using containers in your solutions

Containers are often used to create solutions using a _microservice architecture_. This is where you break solutions into smaller, independent pieces. For example, you may split a website into a container hosting your front end, another hosting your back end, and a third for storage. This allows you to separate portions of your app into logical sections that can be maintained, scaled, or updated independently.

#### What is a microservice?

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yual]

Imagine your website backend has reached capacity but the front end and storage aren't being stressed. You could scale the back end separately to improve performance, or you could decide to use a different storage service. Or you could even replace the storage container without affecting the rest of the application.