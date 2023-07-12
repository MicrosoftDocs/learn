There are several ways to deploy Java applications to the cloud. This unit explores the various options so that, in the next unit, you can better understand the services that Azure provides.

## Virtual machines, containers, or platform as a service?

The main question is whether you want or need to deploy your application on a virtual machine (VM), inside a container, or as a platform as a service (PaaS) solution.

* With **virtual machines**, you're in a world similar to an on-premises or a classical datacenter environment. Azure provides a set of preconfigured VMs that run the main operating systems (Windows and Linux), and you'll need to configure and maintain those machines.

   We suggest that you adopt this solution initially, because it's the closest to what most enterprises are already using before they move to the cloud. They usually install their own configuration-management software, install their favorite version of Java, and can then run their Java workload in a way that's similar how they've done it in the past.

   The VM solution works well if you have an experienced operations team that will configure and maintain them, and if you have specific use cases. For example, you might be using some native libraries or some proprietary software, such as Oracle WebLogic Server or IBM WebSphere Application Server.

* With **containers**, you still have most of the control you have with VMs, but with less operations effort. You can install your own Java Virtual Machine (JVM) or some specific software, and your containers will run either locally or on any cloud provider.

   Because containers offer a lot of freedom, they suffer from some of the same issues as VMs. If you provide your own JVM, you'll need to update and patch it as necessary. As a result, Docker images require a good continuous integration and continuous delivery (CI/CD) toolchain to maintain containers properly. Because Docker images can run locally and are lighter than VMs, they also provide a great developer experience.

* With a **platform as a service** solution, the cloud provider handles most of the maintenance and operation burden. Operating system (OS) updates, Java patches, security, and compliance are all provided. As a result, this option is usually more secure and less costly. It also comes with some scalability features, which should allow your application to adapt better to your customers' needs. It also results in better performance under load and lower cost when there is less traffic.

    You can achieve more by using a PaaS solution. You can set up automatic configuration, manage and load secrets (for example, by using Azure Key Vault), monitor your application, launch a live profiling session, and enable zero-downtime deployment.

## Deployment options

Whether you use VMs, containers, or a PaaS solution, you can usually deploy your Java applications to the cloud in either of two ways:

* **Source-code deployment**: You commit your source code to a Git repository and the cloud provider runs a process that compiles, builds, and packages the application.
* **JAR, WAR, or EAR file deployment**: You package your application, usually as an executable JAR (Java ARchive) file, but WAR (Web Application ARchive), EAR (Enterprise Application ARchive), and other file formats are also possible. The cloud provider then runs the executable file.

These two deployment options are classical ways to run Java applications. For both options, the build process is usually similar, and the main difference is where that process is run. Letting the cloud provider do the build is simpler, and with this approach the cloud provider applies its own security checks and patches. By building the application locally or by using a CI/CD platform such as GitHub Actions, you get more flexibility and control.

## Serverless functions

Serverless functions, or more specifically Azure Functions, are a mix of various solutions we've seen and offer a very specific feature: serverless functions are meant to run for short periods of time. Usually, a function is awakened by an event, such as an HTTP request, and it stays "hot" for a few minutes until it goes back to sleep.

Functions share features with the PaaS solution we described earlier. In Azure, our PaaS solution (Azure App Service) and our serverless solution (Azure Functions) are technically similar and share some common code and services.

For deployment options, functions usually work with JAR files. Other options such as Docker are available, but they're less popular and usually don't perform as well. This is because the underlying platform can't optimize them in the same way that it can for JAR files.

By their nature, serverless functions need to be specifically coded. Their features depend on the cloud provider on which they run, and their short life makes it complicated to use traditional solutions such as caching or HTTP session replication.

Serverless functions can scale well, and they offer the best price for low-usage environments. At the same time, they can respond to the most demanding traffic loads.
