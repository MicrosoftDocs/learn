There are several ways to deploy Java applications to the cloud. Let's first explore those different types of applications, 
so we can better understand what services are provided by Azure in the next section.

## Virtual Machines, containers and Platform-as-a-Service

The main question that needs to be answered is whether you want (and need!) to deploy your application on a Virtual Machine (VM), inside a container or on
a Platform-as-a-Service (PaaS) solution.

***With a Virtual Machine***, you're in a world similar to what you can do on-premise or in a classical data center. Azure provides you
with a set of pre-configured machines, running the main operating systems (Windows and Linux), and it's up to you to configure and maintain
those machines.

This solution is favored initially, as it's the closest to what enterprises are already using before moving to the cloud: they will
typically install their own configuration management software, install their favorite version of Java, and will be able to run their Java
workload in a similar way to what they were doing in the past.

Virtual Machines will work well if you have an experienced ops team who will take care of configuring and maintaining them, and if you have
specific use-cases: for example, if you're using some native libraries, or if you're using some proprietary software like Oracle WebLogic or IBM WebSphere.

***With containers***, you still have most of the control you have with Virtual Machines, but will have less operations work. You can install your own JVM, or some specific software, and your containers will run both locally or on any cloud provider. As they offer a lot of freedom, they suffer from some of the issues of Virtual Machines: if you provide your own JVM, you'll need to update it and patch it when it's necessary. As a result, Docker images require a good CI/CD toolchain to be able to maintain them properly. As Docker images can run locally, and are lighter than Virtual Machines, they also provide a great developer experience.

***With a Platform-as-a-Service*** solution, most of the maintenance and operation burden is taken care of by the cloud provider. OS updates, Java patches,
security and compliance are all provided. As a result, this option is usually more secure and less costly. It will also come with
some scalability features, which should allow your application to adapt better to your customer's needs, resulting in better
performance under load and lower prices when there is less traffic.

To benefit fully from a Platform-as-a-Service solution, applications sometimes need to be rearchitected. They can then enjoy cloud-native features like automatic configuration and secret management (using Azure Key Vault), monitoring and application profiling (using Azure Application Insights), and zero-downtime deployment.

## Deployment options

Whether you use Virtual Machines, containers or a Platform-as-a-Service, there are usually two ways to deploy your Java applications to the cloud:

- source code deployment: you commit your source code to a Git repository, and the cloud provider runs a process that will compile, build, and package the application
- Jar/War/Ear file deployment: you package your application (typically as an executable Jar file, but other formats like War and Ear are also possible), which is then run by the cloud provider

Those two deployment options are classical of Java applications. For both of them, the build process is usually similar, and the main difference is where that process is run. Letting the cloud provider do the build is simpler, and also let the cloud provider apply its own security checks and patches. Building the application locally (or using a CI/CD platform like GitHub Actions) provides more flexibility and control.

## Serverless

Serverless, and more specifically Azure Functions, is a mix of different solutions we've seen, with a very specific feature: serverless functions are meant to run for small period of times. Usually, a function is wakened up by an event (typically an HTTP request), and stays "hot" for a few minutes, until it goes back to sleep.

Functions share features with the Platform-as-a-Service solution we've described earlier. In fact, in Azure, our Platform-as-a-Service solution (Azure App Service), and our Serverless solution (Azure Functions) are technically very close and share some common code and services.

For deployment options, Functions will usually work with Jar files. Other options such as Docker are available, but are less popular and usually don't perform as well (as the underlying platform cannot optimize them the same way as it can for Jar files).

Due to its nature, Serverless functions need to be specifically coded: their features will depend on the cloud provider they run on, and their short life will make it complicated to use traditional solutions like caching or HTTP session replication.

Serverless functions can scale well, and offer the best price for low-usage environments, while still being able to answer the most demanding traffic loads.
