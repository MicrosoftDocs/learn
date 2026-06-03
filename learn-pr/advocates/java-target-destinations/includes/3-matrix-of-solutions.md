We described the most typical deployment types for Java applications. Let's now see which Azure service can work best, depending on the deployment type you need.

## Azure Container Apps

Azure Container Apps enables you to focus on building containerized Java applications, whether monolithic or microservices, without the need to manage servers or Kubernetes infrastructure. Container images are the main deployment unit. For Java, direct JAR and WAR deployment are preview capabilities. Java automatic memory fitting is also in preview. For eligible source-code or JAR deployments that run a single Java application, memory fitting is enabled by default to help tune JVM memory use. You can disable memory fitting, and Azure Container Apps might automatically disable it in documented cases, such as when you configure JVM memory settings yourself. The service also scales your applications based on demand and includes Java diagnostics, such as dynamic logger level changes (preview), to help troubleshoot Java applications.

Azure Container Apps also supports managed Java components for Spring apps, including Eureka Server for Spring, Config Server for Spring, and Admin for Spring. Gateway for Spring is available as a preview managed component, so evaluate preview support and production-readiness requirements before using it. As part of the Azure ecosystem, Azure Container Apps can handle enterprise workloads with cost-effective scaling, making it useful for both traditional and modern application architectures.

## Azure App Service

Azure App Service is a platform as a service (PaaS) solution provided by Azure. It offers an easy-to-use service for running Java web applications with automatic OS and Java Virtual Machine (JVM) updates and patches, as well as autoscaling or monitoring.

App Service can run executable JAR files that fit the supported Java SE runtime stacks, which makes it an alternative to Azure Container Apps for some simple Java monolithic applications. On Linux, prefer Ubuntu-based Java stacks, such as Java 17, Java 21, or Java 25, for new apps; Java 8 and Java 11 use Alpine 3.16, the last supported Alpine distribution in App Service.

It can also deploy WAR applications on supported application servers such as Apache Tomcat or JBoss EAP. For Tomcat, choose an actively maintained version listed in the App Service language support policy; older versions such as Tomcat 8.5 and Tomcat 10.0 are still available but no longer receive security updates. JBoss EAP is available on supported Linux App Service plans and can run WAR or EAR packages; for new apps, review the current App Service version list and prefer a current Red Hat-supported version, such as JBoss EAP 8.0. When you use built-in runtime stacks, review the App Service language support policy and plan upgrades as runtimes change. If you need a runtime that isn't built in, you can use a custom container, but then you're responsible for the runtime contents in that container.

## Azure Functions

Azure Functions is the serverless platform provided by Azure, and it supports running Java workloads.

Running a Java application on Azure Functions usually requires some minor configuration and setup. For new serverless Java function apps, start with the Flex Consumption plan. Flex Consumption is the recommended serverless hosting plan for Azure Functions and provides pay-as-you-go hosting with flexible scaling options. Other hosting choices include the legacy Consumption plan, Premium plan, and Dedicated plan. If you use an existing Consumption plan app, review the current retirement dates: Linux Consumption retires on September 30, 2028, and function apps that still run the end-of-life v3 runtime on Linux Consumption stop running after September 30, 2026. Windows Consumption apps aren't currently affected by the Linux Consumption retirement.

By their nature, serverless functions are best for event-driven work that starts quickly, scales out, and can stop when there's no work to do. Long-running web applications or applications that need full control over the web server are usually a better fit for Azure App Service, Azure Container Apps, or AKS.

## Azure Kubernetes Service

Azure Kubernetes Service (AKS) is a managed Kubernetes service provided by Azure. It can run container images, and it benefits from belonging to the whole Kubernetes ecosystem. AKS works well if you want to deliver cloud-native applications in any language, including Java.

Azure Kubernetes Service is a great solution if you have heterogeneous workloads or if you want precise control over your Kubernetes environment. AKS runs Java workloads well. With any AKS option, you build and maintain your container images and Kubernetes workload configuration. Standard AKS gives you more cluster configuration control; AKS Automatic adds production-ready defaults and automated node provisioning and upgrades while still giving you access to the Kubernetes API.

## Azure VMs

Running VMs on Azure gives you the greatest flexibility and variety of options. You can choose between multiple operating systems, typically Windows and the main Linux distributions. You can bring your own software or use some of the provided images.

For Java specifically, you mainly use VMs to:

- Install and run a Java web application manually on top of Windows or Linux.
- Install and operate a container runtime, or self-manage a Kubernetes distribution, to run container images when you need that level of control.
- Use one of the supported offers, such as Oracle WebLogic Server or IBM WebSphere Application Server, to run Java web applications on your VMs.

When you use Azure VMs, there's no limit to what you can install and run, because you have full control over them. The main drawback with VMs, though, is that you need to maintain and secure the operating system, JVM, and middleware. For VMs, this maintenance work is your responsibility.
