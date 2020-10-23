Azure offers different deployment solutions for Java applications. We'll just look at a few of them here.

![Deployment Opportunities on Azure for different types of Java Applications](../media/4-deployment-options.png)

## Virtual Machines  

Just like in your own data center, Virtual Machines (VMs) are available on Azure. You can choose between different flavors on Windows also on Linux, such as Ubuntu, Red Hat, or Suse.
VMs are usually the starting point for the Lift and Shift approach.
Just like in your data center you have all the freedom. Attention! With great power comes great responsibility. Master OS updates, Java runtime, Network settings, as well as port forwarding and Security is on your side, if you chose this infrastructure as a service (IAAS) solution.

## Container

When you realize, that the OS didn't bring any business impact to our application we can abstract from it and use Containers instead.

- **Azure Kubernetes Service** AKS is the managed Kubernetes Service. Kubernetes is the de-facto standard to orchestrate your containerized applications. It is perfect for Microservices as well as mid-sized applications. It comes with service discovery, scalability, and monitoring.

- **Azure RedHat OpenShift** ARO is the managed by Redhat flavor of Kubernetes.

- **Azure Container Instances** ACI is a great solution for quick tests and proof of concepts as well as sidecars.

## Azure App Service

One of the easiest and straight forward deployment opportunities for Java applications on Azure are Azure App Service. However, when your system is growing.

It comes with Scalability, integrated Monitoring with Azure Monitoring out of the box.

## Azure Spring Cloud

Azure Spring Cloud is Spring Cloud with all its advantages plus all the greatness of Azure with the global scalability and high availability.

Azure Spring Cloud is a fully managed service for Spring Boot apps that lets you focus on building and running the apps that run your business without the hassle of managing infrastructure.

Customers can simply deploy their JARs or code and Azure Spring Cloud will automatically wire their apps with the Spring service runtime.

Once deployed they can easily monitor application performance, fix errors, and rapidly improve applications.

It is integrated into Azure eco-system and it is enterprise ready

In the first week of Sep, Microsoft and VMware announced the general availability of the service

## Functions

You can deploy your Java code as functions as well. So you'll benefit from great tooling and integration with other Azure Services.
Sample scenarios for Functions are

- Web, mobile and IoT-connected backends
- Bot or Real-time file and stream processing
- Automation of scheduled tasks

![Code and Events are Building the Azure Functions Logo](../media/5-functions.gif)
