Containers are isolated units of software that run on a shared operating system (OS) kernel. A container packages an application with its dependencies and abstracts it from the host OS where it runs. The result is a lightweight runtime environment where applications can be run and easily shared during development. 

A container is isolated from the host OS and from other containers. Virtual network adapters attached to virtual switches allow containers to communicate with each other and with external networks.

## Container runtime: Docker

In this module, we examine networking options for **Docker** containers on Windows. Docker is a collection of open-source tools, solutions, and cloud-based services that provide a common model for packaging, or *containerizing*, app code into a standardized unit called a *Docker container*. Docker containers provide security features to run multiple containers simultaneously on the same host without affecting each other.

## Container isolation with virtual switches

Different types of virtual switches provide different levels of isolation and performance for containers. An internal virtual switch isn't directly connected to a physical NIC on the container host, only an external virtual switch is directly connected.

Three of the most common virtual switch types include NAT, Transparent, and Overlay.

- A container with a **NAT** virtual switch uses network address translation (NAT) to access external networks. The NAT virtual switch is easy to set up, but it limits the portability and scalability of your container.
- A **transparent** virtual switch allows your container to connect directly to the physical network. This virtual switch offers high performance and flexibility, but you need to manually configure the IP addresses and routing rules.
- The **overlay** virtual switch creates a virtual network layer on top of the physical network. You gain cross-host communication and network segmentation for your container, but there’s an increase in overhead and complexity.

## Container management

Commonly containers are thought of as VMs, but you need to keep in mind that they aren't. A container has a distinct life cycle. It's deployed, started, stopped, and destroyed as requested. This lifecycle makes containers disposable and affects how developers and IT operations plan for the management of large container deployments.

## Container network interface (CNI) plugins

To manage the allocation and configuration of IP addresses and virtual network adapters for your containers, you need to use a container network interface (**CNI**) plugin. A CNI plugin is a software component that implements the CNI specification that defines a standard way for orchestrators such as Kubernetes to interact with network providers like Azure.

There are different CNI plugins available for Windows containers, such as:

- **WinNAT** CNI plugins use NAT virtual switches for container networking. WinNAT is the default CNI plugin for Docker on Windows.
- **WinCNI** plugins use transparent virtual switches for container networking. WinCNI is compatible with Kubernetes, but it requires manual IP address management.
- **Azure CNI** plugins use overlay virtual switches for container networking. Azure CNI integrates with Azure Virtual Network and provides advanced features like network policies, service discovery, and load balancing.

## Containers and microservices

A microservices application is a cloud-native architectural approach where a single app consists of many loosely coupled and independently deployable components or services. Each component or service can be represented by a container.

Containers don't necessarily implement a micro-services architecture. They can host a monolithic application, but they aren’t designed for that purpose. By default, the container runtime (such as Docker) and the container orchestrator assumes a container can always be safely deleted or removed and another container can take its place as needed.

## Containers, Kubernetes, and networking

The process of deploying, updating, monitoring, and removing containers introduces many challenges. In this module, we examine container management solutions for networking for Windows containers with Kubernetes and Azure Kubernetes Service (AKS). These options support the use of CNI plugins for container networking.
