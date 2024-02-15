Containers give you a way to package and run applications across diverse environments on-premises and in the cloud. They provide a lightweight, isolated environment that makes apps easier to develop, deploy, and manage. 

Containers share the same operating system kernel as their host, but don't have unfettered access to it. They have their own file system, network, and processes that are isolated from the host's user mode environment. This isolation poses challenges when it comes to managing your applications data.

By default, containers have temporary and ephemeral storage, which means that any data written inside the container is lost when the container is stopped or deleted. This stoppage or deletion isn't suitable for applications that need persist data across container instances or share data with other containers or hosts. To solve this problem, containers need to use external storage mechanisms that provide data persistence and sharing. The persistent storage solution you use depends on your environment.  

For example, if you're a developer using containers in a local environment, you can use the persistent storage through bind mounts and named volumes with Windows containers. However, if you're managing a production-scale environment with containers and microservices, you'll require a container orchestrator like Kubernetes or a managed orchestrator like Azure Kubernetes Service (AKS) or AKS Hybrid. These container orchestrators use persistent storage solutions like persistent volumes (PVs), persistent volume claims (PVCs), and Container Storage Interface (CSI) drivers.  

In this module, you'll learn about these storage concepts and how they apply to Windows containers running on Azure Kubernetes Service (AKS) and AKS Hybrid. 
