There are several ways to deploy Java applications to the cloud. This unit explores the various options so that, in the next unit, you can better understand the services that Azure provides.

## Virtual machines, containers, or platform as a service?

The main question is whether you want or need to deploy your application on a virtual machine (VM), inside a container, or as a platform as a service (PaaS) solution.

* With **virtual machines**, you're in a world similar to an on-premises or a classical datacenter environment. Azure provides a set of preconfigured VMs that run the main operating systems (Windows and Linux), and you'll need to configure and maintain those machines.

   Choose VMs when your application needs that level of control. For example, you might need OS-level configuration, specific native libraries, proprietary middleware, or an existing operations process that your team already understands. With VMs, you can install your own configuration-management software, choose your Java version, and run the workload in a way that's similar to how you've done it in the past.

   The VM solution works well if you have an experienced operations team that will configure, patch, and maintain the OS, JVM, and middleware. It can also be a good fit for enterprise application servers or proprietary software, such as Oracle WebLogic Server or IBM WebSphere Application Server.

* With **containers**, you still have most of the control you have with VMs, but with less operations effort. You can install your own Java Virtual Machine (JVM) or some specific software, and your container images will run either locally or on any cloud provider.

   Because containers offer a lot of freedom, they suffer from some of the same issues as VMs. If you provide your own JVM, you'll need to update and patch it as necessary. As a result, container images require a good continuous integration and continuous delivery (CI/CD) toolchain to maintain them properly. Because container images can run locally and are lighter than VMs, they also provide a great developer experience.

* With a **platform as a service** solution, the cloud provider handles much of the maintenance and operation burden. Depending on the service and deployment model, the platform can provide operating system (OS) updates, built-in Java runtime patches, security features, and compliance controls. As a result, this option is usually more secure and less costly. It also comes with some scalability features, which should allow your application to adapt better to your customers' needs. It also results in better performance under load and lower cost when there is less traffic.

    You can achieve more by using a PaaS solution. You can set up automatic configuration, manage and load secrets (for example, by using Azure Key Vault), monitor your application, launch a live profiling session, and enable zero-downtime deployment.

## Deployment options

Whether you use VMs, containers, or a PaaS solution, you can usually deploy your Java applications to the cloud in several ways:

* **Source-code deployment**: You commit your source code to a Git repository and the cloud provider runs a process that compiles, builds, and packages the application.
* **Packaged artifact deployment**: You package your application, usually as an executable JAR (Java ARchive) file, but WAR (Web Application ARchive), EAR (Enterprise Application ARchive), and other file formats are also possible. The cloud provider then runs the packaged file.
* **Container-image deployment**: You build a container image that includes your application and runtime dependencies, and then deploy that image to a container service. Some services can also build the container image for you from a Dockerfile.
* **CI/CD deployment**: You use a CI/CD platform, such as GitHub Actions or Azure Pipelines, to build, test, package, scan, and deploy the application. A CI/CD pipeline can deploy source code, a packaged artifact, or a container image.

These deployment options can overlap. For example, a CI/CD pipeline might build a JAR file and deploy it to a PaaS service, or it might build a container image and deploy that image to a container platform. Letting the cloud provider do the build is simpler, and with this approach the cloud provider applies its own security checks and patches. By building the application locally or by using a CI/CD platform, you get more flexibility and control.

## Serverless functions

Serverless functions, or more specifically Azure Functions, are a mix of various solutions we've seen and offer a very specific feature: they're event driven. A function runs in response to a trigger, such as an HTTP request, a queue message, a timer, or another event. The platform manages scaling and the host process for you.

Functions share features with the PaaS solution we described earlier. In Azure, our PaaS solution (Azure App Service) and our serverless solution (Azure Functions) are technically similar and share some common code and services.

For Java applications, Azure Functions supports current Java runtime stacks across hosting plans. Supported versions depend on the plan and runtime, and can include Java 8, Java 11, Java 17, Java 21, and Java 25. Java 25 isn't available on the Linux Consumption plan; Java 21 is the latest supported version on that plan. Always choose a supported Java version for the hosting plan that you use.

Azure Functions offers several hosting choices. Flex Consumption is the recommended serverless hosting plan for Azure Functions and runs on Linux. Premium and Dedicated plans provide more control over scaling, networking, and always-ready capacity. Azure Functions can also run on Azure Container Apps when you want Functions programming with Container Apps features.

For deployment options, Java functions commonly use packaged artifacts such as JAR files and are often deployed from CI/CD pipelines. Custom containers are appropriate when the built-in Java runtime stack doesn't meet your needs, such as when you require specific OS packages, native libraries, a custom JVM, or an existing container-image standard. Custom containers aren't available on every hosting plan, so choose a plan that supports them.

By their nature, serverless functions need to be specifically coded. Their features depend on the cloud provider on which they run. Design functions to be stateless, and store shared data in external services instead of relying on local memory or HTTP session replication.

Serverless functions can scale well, and they offer the best price for low-usage environments. At the same time, they can respond to the most demanding traffic loads.
