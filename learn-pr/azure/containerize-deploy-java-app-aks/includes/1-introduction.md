Imagine you're a Java developer, building and deploying apps to run on on-premises servers. It's a challenging process to orchestrate these servers and manage dependencies, scaling, and other considerations.

Unlike virtual machines that emulate hardware, containers run directly on top of the host operating system, kernel, and hardware as ordinary processes. Because of this simplicity, containers require fewer system resources. The result is a smaller footprint with substantially less overhead, faster app startup times, and a great use case for scaling on demand.

With containers, you ensure that your apps and dependencies are always isolated in container images and ready for deployment at scale.

In this module, you first containerize an existing Java app. From the open internet and shared under the [MIT license](https://github.com/git/git-scm.com/blob/gh-pages/MIT-LICENSE.txt), [Flight Booking System for Airline Reservations](https://github.com/Azure-Samples/containerize-and-deploy-Java-app-to-Azure) is a fully responsive, sample web-based Flight Booking System based on a sample airline, built with the Model View Controller (MVC) architecture made using Java Servlets and Java Server Pages (JSPs). The original web application was designed to run on Java SE 8 and Tomcat 8.5. However, it was updated to modernize the application, enabling it to run on Java SE 17 and Tomcat 10.1.

After you containerize the app, you construct a Dockerfile and write the Docker instructions needed to build a container image. Next, you run the container image locally and test the app. You then push the container image into Azure Container Registry and deploy it to Azure Kubernetes Service.

By the end of this module, you'll be able to containerize a Java app, push the container image to Azure Container Registry, and then deploy to Azure Kubernetes Service.

You use your own Azure subscription - with access to create, update, and remove resources - to deploy the resources in this module. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/java/?azure-portal=true&WT.mc_id=java-10785-chtrembl) before you begin.

> [!IMPORTANT]
> To avoid unnecessary charges in your Azure subscription, remember to deprovision your Azure resources when you finish this module.

## Learning objectives

By the end of this module, you'll be able to do the following tasks:

- Containerize a Java app.
- Build a container image for the Java app.
- Run the container image locally.
- Push the container image to Azure Container Registry.
- Deploy the container image to Azure Kubernetes Service.

## Prerequisites

As a Java developer, you're already familiar with building apps. As you complete the exercises in this module, you use a personal Azure account. Make sure that you have the following resources:

- An Azure subscription with access to create, update, and remove resources.
- Local installations of Docker CLI, Git CLI, and the Azure CLI, version 2.66 or later.
