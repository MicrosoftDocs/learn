There are several ways to deploy Java applications to the cloud. Let's first explore those different types of applications, 
so we can better understand what services are provided by Azure in the next section.

## Virtual Machines vs Platform-as-a-Service

The main question that needs to be answered is whether you want (and need!) to deploy your application on a Virtual Machine (VM) or on
a Platform-as-a-Service (PaaS) solution.

***With a Virtual Machine***, you are in a world similar to what you can do on-premise or in a classical data center. Azure provides you
with a set of pre-configured machines, running the main operating systems (Windows and Linux), and it's up to you to configure and maintain
those machines.

This solution is usually favored initially, as it's the closest to what enterprises are already using before moving to the cloud: they will
typically install their own configuration management software, install their favorite version of Java, and will be able to run their Java
workload in a similar way to what they were doing in the past.

Virtual Machines will work well if you have an experienced ops team who will take care of configuring and maintaining them, and if you have
specific use-cases: for example, if you are using some native libraries, or if you are using some proprietary software.

***With a Platform-as-a-Service*** solution, most of the maintenance and operation burden is taken care of by the cloud provider. OS updates, Java patches,
security and compliance are all provided out-of-the-box. As a result, this option is usually more secure and less costly. It will also come with
some out-of-the-box scalability features, which should allow your application to adapt better to your customer's needs, resulting in better
performance under load and lower prices when there is less traffic.

To benefit fully from a Platform-as-a-Service solution, applications usually need to be rearchitected. This option will cost more time and money initially, and
might also limit which options are available. For example, a caching mechanism that works in an on-premise environment might not work
well in a Platform-as-a-Service service, because the network will be hardened.

## Deployment options

Wether you use Virtual Machines or a Platform-as-a-Service, there are usually three ways to deploy your Java applications to the cloud:

- source code deployment: you simply commit your source code to a Git repository, and the cloud provider runs a process that will compile, build, and package the application
- Jar file deployment: you package your application as an executable Jar file, which is then run by the cloud provider
- Docker images: you package your application as a Docker image, which is then run by the cloud provider

The first two solutions are the easiest ones, and are classical of Java applications. They also probably don't differ too much: the build process is usually similar, and the main difference is where this process is run. Letting the cloud provider do the build is simpler, and also let the cloud provider apply its own security checks and patches. Building the application locally (or using a CI/CD platform like GitHub Actions) provides more flexibility and control.

Docker images are now more and more popular, as they provide even more control than Jar files. You can install your own JVM, or some specific software with them, and they run easily both locally and on any cloud provider. But as they offer more freedom, they suffer from some of the issues of Virtual Machines: if you provide your own JVM, you'll need to update it and patch it when it's necessary. As a result, Docker images require a good CI/CD toolchain to be able to maintain them properly, and they're more complex to operate than simple Jar files.

## Serverless

Serverless, and more specifically Azure Functions, is a mix of different solutions we've seen, with a very specific feature: serverless functions are meant to run for small period of times. Usually, a function is wakened up by an event (typically an HTTP request), and stays "hot" for a few minutes, until it goes back to sleep.

Functions share features with the Platform-as-a-Service solution we've described earlier. In fact, in Azure, our Platform-as-a-Service solution (Azure App Service) and our Serverless solution (Azure Functions) are technically very close and share some common code and services.

For deployment options, Functions will usually work with Jar files. Other options such as Docker are usually available, but are less popular and usually don't perform as well (as the underlying platform cannot optimize them the same way as it can for Jar files).

Due to its nature, Serverless functions need to be specifically coded: their features will depend on the cloud provider they run on, and their short life will make it complicated to use traditional solutions like caching or HTTP session replication.

Serverless functions can scale well, and offer the best price for low-usage environments, while still being able to answer the most demanding traffic loads.
