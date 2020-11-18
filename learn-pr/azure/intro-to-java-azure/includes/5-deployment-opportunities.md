Azure offers different deployment solutions for Java applications. In this unit, we'll discuss a few of them.

![Deployment Opportunities on Azure for different types of Java Applications](../media/5-java-on-azure-info-graphic.jpg)

## Virtual machines  

Azure Virtual Machines (VMs) are available for Windows and Linux. Linux VMs allow you to choose between different distributions like Ubuntu, Red Hat, or Suse.
VMs are usually the starting point for Lift and Shift. Life and Shift is the process to migrate existing machines into Azure.
You'll have to take care of OS updates, Java runtime, network settings, and port forwarding and Security.

## Containers

- **Azure Kubernetes Service** AKS is a managed Kubernetes Service. Kubernetes is the de-facto standard to orchestrate your containerized applications. It's perfect for microservice and mid-sized applications. AKS comes with service discovery, autoscaling, and monitoring. Microsoft is a collaborator in Kubernetes projects, such as Virtual Kubelet, Dapr, or OAM.

- **Azure RedHat OpenShift** is the RedHat managed flavor of Kubernetes.

- **Azure Container Instances** is a great solution for quick tests and proof of concepts and sidecar containers.

## Azure App Service

One of the easiest and straight forward deployment opportunities for Java applications on Azure are Azure App Service.
It comes with autoscaling, integrated monitoring, and security.

## Azure Spring Cloud

Azure Spring Cloud lets you focus on building Spring Boot Apps without managing infrastructure.
Deploy your JARs or code and it will automatically wire your apps with the Spring service runtime.
Once deployed they can easily monitor application performance, fix errors, and rapidly improve applications.
It's integrated into the Azure eco-system and it's ready to tackle enterprise workloads.

## Functions

You can deploy your Java code as Azure Functions as well. You'll benefit from great tooling and integration with other Azure Services.
Sample scenarios for Functions are

- Web, mobile and IoT-connected backends
- Bot or real-time file and stream processing
- Automation of scheduled tasks
