In this unit, you learn how to create a Quarkus application, connect it to a PostgreSQL database, and run everything locally. Then you create an Azure Container Apps environment and deploy the application remotely.

## Introduction to Azure Container Apps

[Azure Container Apps](https://azure.microsoft.com/products/container-apps) is a fully managed serverless container service on Azure. It allows you to run containerized applications without worrying about orchestration or managing complex infrastructure such as Kubernetes. You write code using your preferred programming language or framework (here it's Java and Quarkus, but it can be anything). And you can build microservices with full support for Distributed Application Runtime ([Dapr](https://dapr.io)). Then, your containers scale dynamically based on HTTP traffic or events powered by Kubernetes Event-Driven Autoscaling ([KEDA](https://keda.sh)).

You want to create a Quarkus application that hosts its logic in Azure Container Apps and hosts its database in an Azure PostgreSQL database.

### Introduction to Azure Database for PostgreSQL

[Azure Database for PostgreSQL](https://azure.microsoft.com/products/postgresql/) is a relational database service based on the open-source Postgres database engine. It's a fully managed database-as-a-service that can handle mission-critical workloads with predictable performance, security, high availability, and dynamic scalability.

## Introduction to Quarkus

[Quarkus](https://quarkus.io) is A Kubernetes Native Java stack tailored for OpenJDK HotSpot & GraalVM, crafted from the best of breed Java libraries and standards. In practice, Quarkus is an Open Source stack for writing Java applications. So Quarkus isn't limited to microservices, even though it's highly suited for them.

From a developer's point of view, Quarkus proposes a nice developer experience: it gives you fast live reload, unified configuration and hides the complexity of GraalVM, allowing you to easily generate native executables. All without reinventing the wheel by proposing a new programming model. Quarkus uses your experience in standard libraries that you already know (for example, CDI, JPA, Bean Validation or JAX-RS) and many popular frameworks (such as Eclipse Vert.x or Apache Camel).

## Develop your Quarkus application

Quarkus is a great framework to execute your applications. You just wire certain Quarkus extensions and the runtime does everything for you. Thanks to [Dev Services](https://quarkus.io/guides/dev-services), you don't need to install a PostgreSQL database locally on your machine. Dev Services uses Docker to download a PostgreSQL database, configure it and start it.

You've decided to use Quarkus. This framework is self-hosted, and it provides support services to run your application.

## Create your resources by using the Azure CLI and Maven

You can use the Azure CLI to create and manage Azure resources.
It runs on Linux, macOS, and Windows. The CLI allows administrators and developers to run commands by using a terminal or command-line prompt (or script) instead of a web browser.

For example, to get the details of a subscription, you can use the following command:

```bash
az account show
```

In this module, you use the Azure CLI to spin up the Azure Container Apps and the Azure Database for PostgreSQL instance. Access the Azure CLI from a terminal or through Visual Studio Code. Or you can access it from [Azure Cloud Shell](https://azure.microsoft.com/get-started/azure-portal/cloud-shell). This browser-based shell experience is hosted in the cloud. In Cloud Shell, the Azure CLI is configured for use with your Azure subscription.

You use the Maven package manager to bootstrap your project and pull in dependencies. Maven also provides the Quarkus and Dev Services dependencies to develop and easily test your Quarkus application.

You use Docker to run and test the application locally with a PostgreSQL database.
