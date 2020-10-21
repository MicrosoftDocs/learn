We have described the most typical deployment types for Java applications. Let's now see which Azure service can work best, depending on the deployment type you need.

## Azure App Service

Azure App Service is the Platform as a Service (PaaS) solution provided by Azure. It offers an easy-to-use service for running Java Web applications, with automatic OS and JVM updates and patches, as well as auto-scaling or monitoring out-of-the-box.

App Service can run any executable Jar file, like the ones provided by Spring Boot, and can also deploy any application on top of popular application servers like Tomcat or JBoss.

For running a simple Java monolithic application, it would therefore be the best option.

If you need more control about what you are deploying, App Service also supports Docker images, offering you the possibility to include specific or custom solutions, as the cost of more maintenance on your side.

## Azure Functions

Azure Function is the serverless platform provided by Azure, and it supports running Java workloads.

Running a Java application on Azure Functions usually requires some minor configuration and setup. By nature, serverless functions will have very short lives (a few minutes usually), so some of the services that you would traditionally use (like an in-memory cache) might not as efficient or practical as with Azure App Service.

As a result, Azure Functions is taylored for applications that need a lot of scalability: they can be stopped regularly to reduce cost, and they can scale up to response to very high load.

## Azure Spring Cloud

Azure Spring Cloud is a unique Azure service that provides a Platform-as-a-Service solution for running Spring Boot microservices. It provides many tools like a discovery server or a configuration server, as well as specific auto-scaling and security mechanisms that will greatly simplify the usage of a microservice architecture based on Spring Boot. This offer is jointly created and managed by Microsoft and VMware, the company building the Spring Framework, and provides support for OS and JVM updates and patches (like Azure App Service), but also support for advanced Spring services.

This service can also be used to run other workloads, like Spring Boot monolithic applications or even .NET microservices (using Steeltoe), but its main usage and interest is for running Spring Boot microservices.

## Azure Kubernetes Service

Azure Kubernetes Service is a managed and secured Kubernetes solution provided by Azure. It can run any Docker image and benefits from the whole Kubernetes ecosystem, which makes it a great solution if you want to deliver cloud-native applications in any languages, including Java.

Therefore, Azure Kubernetes Service is a great solution if you have heterogenous workloads or if you want precise control on your environment. It will run Java workloads very well, but you will need to build and maintain your Docker images.

## Azure VMs

Running Virtual Machines on Azure is what provide you with the most flexibility and options. You can choose between a wide variety of OS, typically Windows and the main Linux distributions. And you can bring your own software, or use some of the provided images.

Concerning Java specifically, the main usages are usually:

- Installing and running a Java Web application manually on top of Windows or Linux
- Installing and running Docker (or even Kubernetes) to run an image containing a Java Web application
- Using one of the supported offers, for example the Oracle Weblogic, to run Java Web applications on it

There is no limit to what you can install and run here, as you have full control on your Virtual Machines. The main issues you will have, however, will be to maintain those machines and to secure them. On Virtual Machines, this is your full responsibility.
