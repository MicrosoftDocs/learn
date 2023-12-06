We've described the most typical deployment types for Java applications. Let's now see which Azure service can work best, depending on the deployment type you need.

## Azure App Service

Azure App Service is a platform as a service (PaaS) solution provided by Azure. It offers an easy-to-use service for running Java web applications with automatic OS and Java Virtual Machine (JVM) updates and patches, as well as autoscaling or monitoring.

App Service can run any executable JAR file—such as the files provided by Spring Boot—and it can deploy any WAR application on top of popular application servers such as Apache Tomcat or Red Hat JBoss.

For running a simple Java monolithic application, App Service is therefore the best option.

If you need more control over your deployments, App Service also supports Docker images. This benefit makes it possible for you to include specific or custom solutions, but at the cost of more maintenance at your end.

## Azure Functions

Azure Functions is the serverless platform provided by Azure, and it supports running Java workloads.

Running a Java application on Azure Functions usually requires some minor configuration and setup. By their nature, serverless functions have short lives (usually only a few minutes), so some of the services that you'd traditionally use might not be as efficient or practical as Azure App Service.

As a result, Azure Functions is tailored for applications that need a lot of scalability. You can stop them regularly to reduce cost, and you can scale them up to respond to high loads.

## Azure Spring Apps

Azure Spring Apps is a unique Azure service that provides a platform as a service solution for running Spring Boot microservices. Spring Cloud provides many tools, such as a service registry or a configuration server. It also provides specific autoscaling and security mechanisms that greatly simplify the use of a microservice architecture that's based on Spring Boot.

The Spring Cloud offering is created and managed jointly by Microsoft and VMware, the company that builds the Spring Framework. Spring Cloud provides support both for OS and JVM updates and patches, such as Azure App Service, and for advanced Spring services.

You can also use the Azure Spring Apps service to run other workloads, such as Spring Boot monolithic applications or even .NET microservices that use Steeltoe, but the service is mainly used to run Spring Boot microservices.

## Azure Kubernetes Service

Azure Kubernetes Service (AKS) is a managed and secured Kubernetes solution provided by Azure. It can run any Docker image, and it benefits from belonging to the whole Kubernetes ecosystem. AKS works well if you want to deliver cloud-native applications in any language, including Java.

Azure Kubernetes Service is a great solution if you have heterogenous workloads or if you want precise control over your environment. AKS runs Java workloads well, but you'll need to build and maintain your Docker images.

## Azure VMs

Running VMs on Azure gives you the greatest flexibility and variety of options. You can choose between multiple operating systems, typically Windows and the main Linux distributions. You can bring your own software or use some of the provided images.

For Java specifically, you mainly use VMs to:

- Install and run a Java web application manually on top of Windows or Linux.
- Install and run Docker or even AKS to run an image that contains a Java web application.
- Use one of the supported offers, such as Oracle WebLogic, to run Java web applications on your VMs.

When you use Azure VMs, there's no limit to what you can install and run, because you have full control over them. The main drawback with VMs, though, is that you'll need to maintain and secure them. For VMs, this maintenance work is your responsibility.
