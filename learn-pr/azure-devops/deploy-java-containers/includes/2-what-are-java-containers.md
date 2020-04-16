## What is Java?

**Java** is a general purpose programming language designed to be flexible in its deployment targets. Java includes strong native support for object-oriented programming, which enables developers to develop applications that scale in size and complexity, which makes it an ideal candidate for modern applications. You can learn more about the details on the [official Java site](https://www.java.org/?azure-portal=true).

## What is Docker?

**Docker** is a technology for automating the packaging and deployment of portable, self-sufficient containers. Docker containers can be run anywhere a Docker host is found, whether on a development machine, a departmental server, an enterprise datacenter, or in the cloud. Azure provides multiple ways to run container-based applications, including in app services or as part of clusters managed with orchestration technologies like Kubernetes. You can learn more about the details on the [official Docker site](https://www.docker.com/?azure-portal=true).

> [!NOTE]
> This module is based on a Java project that is deployed as a Docker container, although its contents should generally apply to non-Docker Java apps and non-Java Docker apps.

## What is Azure Database for MySQL?

**Azure Database for MySQL** is a fully managed MySQL database-as-a-service offering from Microsoft. Whether you're building new applications targeting MySQL, or migrating legacy applications via lift-and-shift, Azure Database for MySQL provides the enterprise-ready solution needed for modern applications. You can learn more about the details on the [official Azure Database for MySQL site](https://azure.microsoft.com/services/mysql/?azure-portal=true).

## Java and Azure

Azure provides first-class support for Java. This means that developers can take their existing codebase and, in most cases, deploy it to Azure as-is. As far as Azure is concerned, hosting Java solutions is comparable to hosting .NET solutions, assuming that the proper dependencies are configured. Azure also provides the means to configure environment variables for application settings, which means you can continue to load settings and secrets using standard Java mechanisms.

Once deployed to Azure, Java applications can connect to resources within Azure, across VPN connections, and anywhere else accessible via the internet. This includes consuming databases, document stores, and all the other resources and services Java developers rely on to be successful.

## Java and Azure DevOps

Java developers will find a welcoming environment in Azure DevOps. Although it provides a wide range of features for managing the entire software lifecycle, developers can optionally cherry pick the features desired to make their process as efficient as possible. Even if just using Azure Pipelines to build and deploy source code pulled in from GitHub or another repo, Java is supported via a variety of build, test, and deploy tasks. And if those aren't available, you can always execute arbitrary scripts to fill gaps as needed.