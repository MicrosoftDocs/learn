As a Java developer working for a company seeking to expand its Azure cloud services, you're tasked with creating a new web-based ToDo list application. The application's data will be stored in a relational Azure database.

Your company has a history of successfully deploying business services on Red Hat OpenShift, leveraging its scalability, elasticity, resilience, and rapid time-to-market benefits.

To align with this established architecture, your team has chosen [Quarkus, a Kubernetes-native Java framework](https://quarkus.io/), for developing the ToDo service since Quarkus focuses on developer productivity, containerization, and seamless OpenShift integration makes it an ideal fit for this project.

This module guides you through creating a new Java project using the Quarkus CLI. The generated project includes sample code, a Maven wrapper, Dockerfile, and unit tests.

Next, you'll develop the business logic to store ToDo items in a relational database, such as PostgreSQL. This will involve implementing methods to retrieve specific ToDo items (entities) from the database.

Once you've thoroughly tested your ToDo list application locally, we'll move on to the deployment phase on the [Azure Red Hat OpenShift (ARO)](hhttps://azure.microsoft.com/en-us/products/openshift) platform.

As an optional challenge, we can explore the possibility of transforming your ToDo application into a serverless function. Serverless functions offer several advantages, including cost-efficiency, reliability, flexibility, and enhanced security. If you're interested in this option, we'll guide you through the process of deploying your application on [Red Hat OpenShift Serverless](https://www.redhat.com/en/technologies/cloud-computing/openshift/serverless).

By the end of this module, you'll not only have a well-functioning ToDo application deployed on ARO with [Azure Database for PostgreSQL](https://azure.microsoft.com/en-us/products/postgresql), but you'll also gain the knowledge and skills to potentially evolve it into a serverless function on Red Hat OpenShift Serverless.

This module requires you to deploy resources to your Azure subscription. If you haven't already, create a free Azure account using the following link: [Free Azure Account](https://azure.microsoft.com/free/java/?azure-portal=true).

> ⚠️ **IMPORTANT**:
> To avoid incurring unnecessary charges in your Azure subscription, remember to deprovision (clean up) the resources you create once you've finished working with them in this module.

## Learning objectives

By the end of this module, you'll be able to:

- Create a new ToDo application using Quarkus.
- Package and Run Locally to verify the functionalities.
- Deploy the Todo application to Azure Red Hat OpenShift with Azure Database for PostgreSQL.
- Evolve the ToDo application to OpenShift Serverless.

## Prerequisites

As a Java developer, you're already familiar with the fundamentals of Java applications. We'll guide you through Quarkus as we progress. For the exercises in this module, you'll need a personal Azure account. Ensure you have the following resources ready:
  
- An Azure subscription
- JDK 17+ installed with JAVA_HOME configured appropriately
- Apache Maven 3.9.8
- Azure CLI 2.64.0+
- Podman or Docker
- Quarkus CLI
