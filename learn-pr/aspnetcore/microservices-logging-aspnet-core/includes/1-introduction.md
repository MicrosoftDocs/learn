Logging and monitoring have always been very important to ensure the application health and troubleshooting issues, but in a microservices application they can easily become critical, because of the sheer amount of components and "moving parts" involved.

This module focuses on diagnostics logging and performance monitoring in *eShopOnContainers*.

In this module, you will:

- Deploy an initial version of eShopOnContainers to an AKS cluster in your subscription.
- Review some important logging concepts and samples of the logging infrastructure already implemented in eShopOnContainers.
- Add Application Insights logging.
- Implement some basic application monitoring features with Application Insights.
- Enable Azure Monitor for containers in your AKS cluster.
- Implement a custom metric using [Prometheus](https://prometheus.io) endpoints to monitor on the Azure Portal using Azure Monitor for containers.

You'll use your own Azure subscription to deploy the resources in this module. To estimate the expected costs for these resources, see the [preconfigured Azure Calculator estimate](https://aka.ms/microservices-logging-aspnet-core-estimate?azure-portal=true) of the resources that you'll deploy. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/dotnet/?azure-portal=true) before you begin.

> [!IMPORTANT]
> This module uses your own Azure subscription. To avoid unnecessary charges in your Azure subscription, remember to de-provision your Azure resources when you're done with this module.

## Learning objectives

- Understand the key concepts of logging.
- Explore the included logs in eShopOnContainers.
- Learn how to implement Application Insights logging and monitoring.
- Learn how to create a custom metric using the Prometheus SDK.
- Learn how to enable Azure Monitor for containers in an AKS cluster.

## Prerequisites

- Familiarity with C# and ASP.NET Core development at the beginner level
- Familiarity with RESTful service concepts
- Familiarity with the Kusto query language at the beginner level
- Conceptual knowledge of containers and AKS at the intermediate level
- Access to an Azure subscription with **Owner** privilege
