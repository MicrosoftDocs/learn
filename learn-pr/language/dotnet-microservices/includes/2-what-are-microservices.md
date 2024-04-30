The cloud drives today's application development and IT systems management. Modern cloud applications need to be fast, agile, massively scalable, and reliable. 

Using containers can help you deploy applications that meet all of those requirements. But putting an application into a container without following a strategic design pattern is like getting into a vehicle and hoping to find your way to a new city without using a map or GPS. You might end up at your destination, but the route probably won't be direct or the most efficient.

A microservices architecture is useful in this scenario. Microservices give you an approach to software development and deployment that's perfectly suited to the agility, scalability, and reliability requirements of modern cloud applications.

## What is a microservices architecture?

In a microservices architecture, a large application is split up into a set of smaller services. Each service runs in its own process and communicates with other processes by using protocols like HTTP/HTTPS, WebSocket, or Advanced Message Queuing Protocol (AMQP). Each microservice implements a specific, end-to-end domain or business capability within a certain context boundary. Each microservice must be developed autonomously and must be independently deployable. Finally, each microservice should own its related domain data model and domain logic. Microservices can be based on different data storage technologies (SQL, NoSQL) and different programming languages.

Here are some key characteristics of microservices:

- They're small, independent, and loosely coupled.
- Each microservice has a separate code base that a small development team can manage.
- They're deployed independently. A team can update an existing microservice without rebuilding and redeploying the entire application.
- They persist their data or the external state in their respective databases. Unlike in a monolithic architecture, microservices don't share databases.
- They communicate with each other by using well-defined APIs. Internal implementation details of each service are hidden from other services.
- They support *polyglot* programming. For example, the microservices that make up a web application don't need to share the same technology stack, libraries, or frameworks.

> [!VIDEO https://aka.ms/docs/player?id=4c104952-cc11-4995-8de4-5fdc2ccc23bf]

## Why develop by using a microservices architecture?

Microservices typically encapsulate simpler customer-requirement functionality, which you can scale out or scale in. You can test, deploy, and manage them independently. An important benefit of a microservices approach is that teams are driven more by customer scenarios than by using specific technology. Each small development team develops a microservice based on a customer scenario. The team chooses the technologies it uses.

Microservices provide long-term agility. Microservices support maintainability in complex, large, and highly scalable systems by letting you create applications based on many independently deployable services that each have granular and autonomous lifecycles.

As another benefit, microservices can scale out independently. Instead of having a single, monolithic application that you must scale out as a unit, you can instead scale out specific microservices. You can scale only the functional area that needs more processing power or network bandwidth to support demand instead of scaling out other areas of the application that don't need to be scaled. That means cost savings because you need less hardware.

:::image type="content" source="../media/microservice-approach.png" border="false" alt-text="Diagram that shows how microservices can scale across virtual machines.":::

The microservices approach allows agile changes and rapid iteration of each microservice because you can change specific, small areas of complex, large, and scalable applications.

Architecting fine-grained microservices-based applications enables continuous integration and continuous delivery practices. It also accelerates delivery of new functions into the application. You can run and test microservices in isolation and evolve them autonomously while maintaining clear contracts between services. As long as you don't change the interfaces or contracts, you can change the internal implementation of any microservice or add new functionality without breaking other microservices.

## What role do containers play?

Containerization is an approach to software development in which an application or service, its dependencies, and its configuration (abstracted as deployment manifest files) are packaged together as a container image. You can test the containerized application as a unit and deploy it as a container image instance on the host operating system.

Just as shipping containers allow goods of all kinds to be transported by ship, train, or truck, software containers act as a standard unit of software deployment that can contain different code and dependencies. Developers and IT professionals can use containerized software to deploy code and dependencies across environments with little or no modification.

If it sounds like containerizing an application might be a great way to implement the microservices architecture pattern, it is. The benefits of using containers line up almost exactly with the benefits of using a microservices architecture.

:::image type="content" source="../media/multiple-containers-single-host.png" border="false" alt-text="Diagram that shows multiple containers running on a single host.":::

> [!NOTE]
> Containerizing an application is not the only way to deploy microservices. You can deploy microservices as individual services in Azure App Service, on virtual machines, or in any number of ways. Containers are the deployment tool that we'll use for our microservices for the rest of this module.

Another benefit of containerization is scalability. You can scale out quickly by creating new containers to use for short-term tasks. From an application point of view, instantiating an image (creating a container) is similar to instantiating a process like a service or web app.

In short, containers offer the benefits of isolation, portability, agility, scalability, and control across the entire application lifecycle workflow.

The microservices you build in this module will run in a Docker container, published using .NET CLI.

## .NET SDK container publishing

In .NET 7, the .NET SDK gained the ability to create container images via the `dotnet publish` command. The tools to do this do a bunch of inference based on the properties of your project and its outputs. .NET then creates the same image that a Dockerfile would create. It can take as few as two commands to create a new application and publish it as an image:

```donetcli
dotnet new webapi
dotnet publish --os linux --arch x64 /t:PublishContainer -c Release
```

The preceding .NET CLI commands create a new web API and publishes the app as a container:

* Targeting Linux as the OS (--os linux).
* Specifying an x64 architecture (--arch x64).
* Using the release configuration (-c Release).

You can control many aspects of the generated container through MSBuild properties. In general, if you can use a command in a _Dockerfile_ to set some configuration, you can do the same via MSBuild.

### Why build microservices in .NET?

Starting with .NET Core and continuing to current iterations, .NET is built to be cloud-native first. It runs cross-platform, so your Docker image can be based on a flavor of Linux, and your .NET code still runs. Microsoft has already created .NET images for Docker. Also, .NET is extremely fast. The ASP.NET Kestrel web server routinely outperforms other web servers.

## Docker

[Docker](https://www.docker.com/) is an [open-source platform](https://github.com/docker/docker) that you can use to automate the deployment of applications as portable, self-sufficient containers that can run in the cloud or on-premises. Docker is also the company that promotes and evolves this technology. Docker as an organization works in collaboration with cloud, Linux, and Windows vendors, including Microsoft.

Docker containers can run anywhere: on-premises in the customer's datacenter, in an external service provider, or in the cloud. Docker image containers can run natively on Linux and Windows.

### What is an image?

When a developer uses Docker, they create an app or service, and then they package the app or service and its dependencies in a container image. An image is a static representation of the app or service and its configuration and dependencies.

The image, when it runs, becomes the container. The container is the in-memory instance of an image.

A container image is immutable. After you build an image, the image can't be changed. Because you can't change an image, if you need to make changes to the app or service and its dependencies, create a new image. This feature guarantees that the imageF you use in production is the same image that's used in development and testing.

### What is a Dockerfile?

A Dockerfile is a text file that contains instructions for how to build a Docker image. Dockerfiles are written in a minimal scripting language that's designed for building and configuring images. Dockerfiles also document the operations that are required to build an image, starting with a base image.

To create a Docker image that contains your application, you typically begin by identifying a base image. Then you add more files and configuration to the base image. The process of identifying a suitable base image usually starts with a search on Docker Hub for a ready-made image that already contains an application framework and all the utilities and tools of a Linux distribution like Ubuntu or Alpine. For example, if you have an ASP.NET application that you want to package into a container, Microsoft publishes an image called *mcr.microsoft.com/dotnet/aspnet* that already contains the ASP.NET runtime.

You can customize an image by starting a container with a base image, and then make changes to it. Changes usually involve activities like copying files into the container from the local file system and running various tools and utilities to compile code.

A Dockerfile is a set of instructions that create a Docker image that has the exact software that you need in it to run your application, including the application itself.

