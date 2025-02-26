In this unit, you learn about creating a Quarkus application.

## Azure Container Apps

[Azure Container Apps](https://azure.microsoft.com/products/container-apps) is a fully managed serverless container service on Azure. It enables you to run containerized applications without worrying about orchestration or managing complex infrastructure like Kubernetes. You write code by using your preferred programming language or framework. (Here you use Java and Quarkus, but you can use anything.) And you can build microservices with full support for Distributed Application Runtime ([Dapr](https://dapr.io)). Your containers scale dynamically based on HTTP traffic or events powered by Kubernetes Event-Driven Autoscaling ([KEDA](https://keda.sh)).

You want to create a Quarkus application that hosts its logic in Container Apps and hosts its database in an Azure PostgreSQL database.

## Azure Database for PostgreSQL

[Azure Database for PostgreSQL](https://azure.microsoft.com/products/postgresql/) is a relational database service that's based on the open-source Postgres database engine. It's a fully managed database as a service that can handle mission-critical workloads with predictable performance, enhanced security, high availability, and dynamic scalability.

## Quarkus

[Quarkus](https://quarkus.io) is a Kubernetes Native Java stack that's tailored for OpenJDK HotSpot and GraalVM. It's created from the best-of-breed Java libraries and standards. Quarkus is an open source stack for writing Java applications. Quarkus isn't limited to microservices, even though it's highly suited for them.

From a developer's point of view, Quarkus provides a great developer experience: it gives you fast live reload and unified configuration and hides the complexity of GraalVM, enabling you to easily generate native executables. All without introducing a new programming model. Quarkus lets you use your experience in standard libraries that you might already know (like CDI, JPA, Bean Validation, and JAX-RS) and many popular frameworks (like Eclipse Vert.x and Apache Camel).

### Develop your Quarkus application

Quarkus is a great framework for running your applications. You just add certain Quarkus extensions and the runtime does everything for you. Thanks to [Dev Services](https://quarkus.io/guides/dev-services), you don't need to install a PostgreSQL database locally. Dev Services uses Docker to download a PostgreSQL database, configure it, and start it.

The Quarkus framework is self-hosted, and it provides support services to run your application.

## Create your resources by using the Azure CLI and Maven

You can use the Azure CLI to create and manage Azure resources.
It runs on Linux, macOS, and Windows. The CLI enables administrators and developers to run commands by using a terminal or command-line prompt (or script) instead of a web browser.

For example, to get the details of a subscription, you can use the following command:

```bash
az account show
```

In this module, you use the Azure CLI to create the Container Apps environment and the Azure Database for PostgreSQL instance. You can access Azure CLI from a terminal or through Visual Studio Code. Or you can access it from [Azure Cloud Shell](https://azure.microsoft.com/get-started/azure-portal/cloud-shell). This browser-based shell is hosted in the cloud. In Cloud Shell, the Azure CLI is configured for use with an Azure subscription.

You use the Maven package manager to bootstrap your project. Maven also provides the Quarkus and Dev Services dependencies to enable you to develop and easily test your Quarkus application.

You use Docker to run and test the application locally with a PostgreSQL database.
