The cloud drives today's application development and IT systems management. Modern cloud applications need to be fast, agile, massively scalable, and reliable. 

Using containers can help you deploy applications that meet all of those requirements. But putting an application into a container without following a strategic design pattern is like getting into a vehicle and hoping to find your way to a new city without using a map or GPS. You might end up at your destination, but the route probably won't be direct or the most efficient.

This is where a microservices architecture comes in. Microservices give you an approach to software development and deployment that's perfectly suited to the agility, scalability, and reliability requirements of modern cloud applications.

## What is a microservices architecture?

In a microservices architecture, a large application is split up into a set of smaller services. Each service runs in its own process and communicates with other processes by using protocols like HTTP/HTTPS, WebSocket, or Advanced Message Queuing Protocol (AMQP). Each microservice implements a specific, end-to-end domain or business capability within a certain context boundary. Each microservice must be developed autonomously and be independently deployable. Finally, each microservice should own its related domain data model and domain logic, and can be based on different data storage technologies (SQL, NoSQL) and different programming languages.

These are some key characteristics of microservices:

- They're small, independent, and loosely coupled.
- Each microservice has a separate code base that can be managed by a small development team.
- They're deployed independently. A team can update an existing microservice without rebuilding and redeploying the entire application.
- They persist their data or the external state in their respective databases. Unlike in a monolithic architecture, microservices don't share databases.
- They communicate with each other by using well-defined APIs. Internal implementation details of each service are hidden from other services.
- They support polyglot programming. For example, the microservices that make up a web application don't need to share the same technology stack, libraries, or frameworks.

> [!VIDEO https://aka.ms/docs/player?id=4c104952-cc11-4995-8de4-5fdc2ccc23bf]

## Why develop by using a microservices architecture?

Microservices typically encapsulate simpler customer-requirement functionality, which you can scale out or scale in, and test, deploy, and manage independently. One important benefit of a microservices approach is that teams are driven more by customer scenarios than by specific technology. Each small team develops a microservice based on a customer scenario and uses any technologies they want to use.

Microservices provide long-term agility. Microservices support maintainability in complex, large, and highly scalable systems by letting you create applications based on many independently deployable services that each have granular and autonomous lifecycles.

As another benefit, microservices can scale out independently. Instead of having a single, monolithic application that you must scale out as a unit, you can instead scale out specific microservices. That way, you can scale only the functional area that needs more processing power or network bandwidth to support demand, instead of scaling out other areas of the application that don't need to be scaled. That means cost savings because you need less hardware.

![Diagram that shows how microservices can scale across virtual machines.](../media/microservice-approach.png)

The microservices approach allows agile changes and rapid iteration of each microservice, because you can change specific, small areas of complex, large, and scalable applications.

Architecting fine-grained microservices-based applications enables continuous integration and continuous delivery practices. It also accelerates delivery of new functions into the application. You can run and test microservices in isolation, and evolve them autonomously while maintaining clear contracts between services. As long as you don't change the interfaces or contracts, you can change the internal implementation of any microservice or add new functionality without breaking other microservices.

## What role do containers play?

Containerization is an approach to software development in which an application or service, its dependencies, and its configuration (abstracted as deployment manifest files) are packaged together as a container image. You can test the containerized application as a unit and deploy it as a container image instance on the host operating system.

Just as shipping containers allow goods of all kinds to be transported by ship, train, or truck, software containers act as a standard unit of software deployment that can contain different code and dependencies. Developers and IT professionals can use containerized software to deploy code and dependencies across environments with little or no modification.

If it sounds like containerizing an application might be a great way to implement the microservices architecture pattern, it is. The benefits of using containers line up almost exactly to the benefits of using a microservices architecture.

![Diagram that shows multiple containers running on a single host.](../media/multiple-containers-single-host.png)

> [!NOTE]
> Containerizing an application is not the only way to deploy microservices. You could deploy microservices as individual services in Azure App Service, or via virtual machines, or any number of ways. However, containers are the deployment tool that we'll use for the rest of this module for our microservices.

Another benefit of containerization is scalability. You can scale out quickly by creating new containers for short-term tasks. From an application point of view, instantiating an image (creating a container) is similar to instantiating a process like a service or a web app.

In short, containers offer the benefits of isolation, portability, agility, scalability, and control across the whole application-lifecycle workflow.

The microservices you'll build in this module will run in a container, specifically a Docker container.

### Docker

[Docker](https://www.docker.com/) is an [open-source project](https://github.com/docker/docker) for automating the deployment of applications as portable, self-sufficient containers that can run in the cloud or on-premises. [Docker](https://www.docker.com/) is also a company that promotes and evolves this technology, working in collaboration with cloud, Linux, and Windows vendors, including Microsoft.

Docker containers can run anywhere: on-premises in the customer's datacenter, in an external service provider, or in the cloud. Docker image containers can run natively on Linux and Windows.

### What is an image?

When a developer uses Docker, they create an app or service and package it and its dependencies into a container image. An image is a static representation of the app or service and its configuration and dependencies.

It's this image that, when run, becomes our container. The container is the in-memory instance of an image.

A container image is immutable. Once you've built an image, the image can't be changed. Since you can't change an image, if you need to make changes, you'll create a new image. This feature is our guarantee that the image we use in production is the same image used in development and Quality Assurance (QA).

### What is a Dockerfile?

A Dockerfile is a text file that contains instructions on how to build a Docker image. Dockerfiles are written in a minimal scripting language designed for building and configuring images. They also document the operations required to build an image starting with a base image.

To create a Docker image containing your application, you'll typically begin by identifying a base image to which you add more files and configuration. The process of identifying a suitable base image usually starts with a search on Docker Hub for a ready-made image that already contains an application framework and all the utilities and tools of a Linux distribution like Ubuntu or Alpine. For example, if you have an ASP.NET application that you want to package into a container, Microsoft publishes an image called **mcr.microsoft.com/dotnet/aspnet** that already contains the ASP.NET runtime.

You can customize an image by starting a container with the base image and making changes to it. Changes usually involve activities like copying files into the container from the local filesystem, and running various tools and utilities to compile code.

In other words, a Dockerfile is a set of instructions that builds up a Docker image with the exact software you need in it to run your application - including your application itself.

## Why build microservices in .NET?

Starting with .NET Core and continuing all the way through the present iterations, .NET was built to be cloud native first. It runs cross-platform, so your Docker image could be based on a flavor of Linux and your .NET code will still run. In addition, there are already .NET images created for Docker by Microsoft. Plus, .NET is extremely fast, with ASP.NET's Kestrel web server routinely outperforming other web servers.
