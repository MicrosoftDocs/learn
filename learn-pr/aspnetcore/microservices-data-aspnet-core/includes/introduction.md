In a microservices app, you need a database to support the business operations. You have two basic options:

1. Provision database servers yourself using virtual machines or database clusters for high availability.
1. Configure a managed database service.

The *:::no-loc text="eShopOnContainers":::* app uses in-cluster data services, deployed as containers/pods; however, that's a valid option just for a demo or dev/test environment.

In this module, you will:

- Deploy a base version of *:::no-loc text="eShopOnContainers":::* to an AKS instance in your subscription.
- Create an Azure Cache for Redis instance.
- Create an Azure Cosmos DB instance.
- Modify *:::no-loc text="eShopOnContainers":::* to use the above managed services instead of the Redis and MongoDB services in the initial cluster.

> [!IMPORTANT]
> This module uses your own Azure subscription. To avoid unnecessary charges in your Azure subscription, remember to de-provision your Azure resources when you're done with this module.

## Learning objectives

- Review some managed data services offered in Azure.
- Understand the creation of a basic Azure Cache for Redis instance.
- Understand the creation of a basic Azure Cosmos DB instance using the MongoDB API.
- Understand the configuration changes needed to use managed data services.

## Prerequisites

- Familiarity with C# and ASP.NET Core development at the beginner level
- Familiarity with basic data management concepts
- Access to an Azure subscription with **Owner** privilege
