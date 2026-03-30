Virtual machines reduce costs compared to physical hardware, but they're still limited to a single operating system per VM. If you want to run multiple instances of an application on a single host machine, containers are an excellent choice.

## What are containers?

Containers are a virtualization environment. Much like running multiple virtual machines on a single physical host, you can run multiple containers on a single physical or virtual host. Unlike virtual machines, you don't manage the operating system for a container. Each virtual machine runs its own operating system that you can connect to and manage. Containers are lightweight and designed to be created, scaled out, and stopped dynamically. You can create and deploy virtual machines as application demand increases, but containers are a lighter-weight, more agile method. Containers help you respond to changes on demand and restart quickly after a crash or hardware interruption. One of the most popular container engines is Docker, and Azure supports Docker.

## Compare virtual machines to containers

The following video highlights several of the important differences between virtual machines and containers:

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=7aa48d3f-4304-4a18-9861-eaf9d4bebd26]

### Azure Container Instances

Azure Container Instances offer the fastest and simplest way to run a container in Azure, without managing any virtual machines or adopting extra services. Azure Container Instances are a platform as a service (PaaS) offering. You upload your containers and the service runs them for you.

### Azure Container Apps

Azure Container Apps are similar in many ways to a container instance. They let you get up and running right away, they remove the container management overhead, and they're a PaaS offering. Container Apps also include built-in load balancing and scaling, so your design can adapt to changing demand.

### Azure Kubernetes Service

Azure Kubernetes Service (AKS) is a container orchestration service. An orchestration service manages the lifecycle of containers. When you're deploying a fleet of containers, AKS can make fleet management simpler and more efficient.

:::image type="content" source="../media/containers-azure-container-services.svg" alt-text="Diagram showing Azure containers arranged from faster start on the left to deeper orchestration on the right.":::

### Use containers in your solutions

Containers are often used to create solutions that use a microservice architecture. In this architecture, you break solutions into smaller, independent pieces. For example, you might split a website into a container hosting your front end, another hosting your back end, and a third for storage. This split lets you maintain, scale, or update each part of your app independently.

Imagine your website back end reaches capacity, but the front end and storage aren't stressed. With containers, you can scale the back end separately to improve performance. You can also change the storage service or modify the front end without affecting the other components.

