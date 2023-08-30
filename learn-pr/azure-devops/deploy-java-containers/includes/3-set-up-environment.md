In this unit, you learn some of the ways Azure and Azure DevOps support Java applications.

## Java

Java is a general purpose programming language that's designed to be flexible in its deployment targets. Java includes strong native support for object-oriented programming. You can use Java to develop applications that scale in size and complexity, which makes it an ideal candidate for modern applications. Learn more at [go.java](https://go.java/?azure-portal=true).

## Docker

Docker automates packaging and deploying portable, self-sufficient containers. Docker containers can run on any Docker host, including a development machine, a departmental server, an enterprise datacenter, or in the cloud. Azure provides multiple ways to run container-based applications, including in app services or as part of clusters managed with orchestration technologies like Kubernetes. Learn more at [docker.com](https://www.docker.com/?azure-portal=true).

> [!NOTE]
> This module is based on a Java project that's deployed as a Docker container, but the general process also applies to non-Docker Java apps and non-Java Docker apps.

## Azure Database for MySQL

The Java app that you deploy in this module connects to a MySQL database. Azure Database for MySQL is a fully managed MySQL database service. Whether you're building new applications that target MySQL or migrating legacy applications, Azure Database for MySQL provides the enterprise-ready solution you need for modern applications. To learn more, see [Azure Database for MySQL](https://azure.microsoft.com/services/mysql/?azure-portal=true).

## Java and Azure

Azure provides first-class support for Java. In Azure, hosting Java solutions is the same as hosting .NET solutions, assuming that the proper dependencies are configured. In most cases, developers can deploy their existing Java codebase to Azure without modifications. Azure also provides the means to configure environment variables for application settings, so you can continue to load settings and secrets by using standard Java mechanisms.

Java applications that are deployed to Azure can connect to resources within Azure, across virtual private network (VPN) connections, and to anywhere else on the internet. Java applications can consume databases, document stores, and all the other resources and services that Java developers rely on.

## Java and Azure DevOps

Azure DevOps provides a wide range of features for managing the entire software lifecycle for Java developers. Developers can pick the features they want to make their processes as efficient as possible.

If you need to build and deploy source code from GitHub or another source control system, Azure Pipelines provides various build, test, and deployment tasks for Java apps. If Azure Pipelines doesn't provide the specific task you need, you can write scripts to fill in the gaps.

