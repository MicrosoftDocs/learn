Imagine you’re a Java developer, building and deploying applications that will run on on-premises servers. Orchestrating these servers, dependencies, and scale, to name a few, are all challenging processes. 

Unlike virtual machines that emulate hardware, containers run directly on top of the host operating system, kernel and hardware, as essentially just another process. Because of this, containers require less system resources, resulting in a smaller footprint with substantially less overhead, faster application startup times, and a great use case for scaling on demand.

With Containers, you’ll ensure your applications, and dependencies, are always isolated in container image(s) and ready for deployment at scale.

In this module, you’ll first containerize a Java application using Docker. For convenience, we’ve selected an existing Java application for you to use, from the open internet. [A sample Flight Booking System for Airline Reservations](https://github.com/chtrembl/Flight-Booking-System-JavaServlets_App), a fully responsive, sample web-based Flight Booking System based on Turkish Airlines built with the Model View Controller (MVC) Architecture made using Java Servlets, Java Server Pages (JSPs).

You’ll then construct a Dockerfile and write the Docker instructions needed to build a Docker image.

You’ll then run the Docker image locally and test the application.

You’ll then push the Docker image into Azure Container Registry and deploy it to Azure Kubernetes Service.

By the end of this module, you'll be able to containerize a Java application, push the Docker image to Azure Container Registry, and then deploy to Azure Kubernetes Service.

You'll use your own Azure subscription (with access to create, update & remove resources) to deploy the resources in this module. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/java/?azure-portal=true&WT.mc_id=java-10785-chtrembl) before you begin.

> [!IMPORTANT]
> To avoid unnecessary charges in your Azure subscription, remember to deprovision your Azure resources when you finish this module.

## Learning objectives

By the end of this module, you'll be able to:

- Containerize a Java application using Docker
- Build a Docker image for the Java application
- Run the Docker image locally
- Push the Docker image to Azure Container Registry
- Deploy the Docker image to Azure Kubernetes Service

## Prerequisites

As a Java developer, you're already familiar with building applications. As you complete the exercises in this module, you'll use a personal Azure account. Make sure that you have the following resources:
  
- An Azure subscription with access to create, update & remove resources.
- Local installations of Java JDK (1.8 or later), Maven (3.0 or later), Docker CLI, Git CLI, and the Azure CLI (2.12 or later).