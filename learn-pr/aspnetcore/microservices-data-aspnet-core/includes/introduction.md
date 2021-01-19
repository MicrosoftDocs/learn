In a microservices app, you usually need some sort of database to support the business operations, and you have two basic options:

- Set up your database servers yourself using virtual machines or database clusters for high availability.
- Configure a managed database service.

The approach used in eShopOnContainers is using in-cluster data services, deployed as containers/pods, however, that's a valid option just for a demo or dev/test environment.

In this module, you will:

- Deploy a base version of eShopOnContainers to an AKS instance in your subscription.
- Create an Azure Cache for Redis instance.
- Create an Azure Cosmos DB instance
- Switch eShopOnContainers to use the above managed services instead of the Redis and MongoDB services in the initial cluster.

> [!IMPORTANT]
> This module uses your own Azure subscription. To avoid unnecessary charges in your Azure subscription, remember to de-provision your Azure resources when you're done with this module.

## Learning objectives

- Get to know some managed data services offered in Azure.
- Understand the creation of a basic Azure Cache for Redis instance.
- Understand the creation of a basic Azure Cosmos DB instance using the MongoDB API.
- Understand the configuration changes needed to use managed data services.

## Prerequisites

- Familiarity with ASP.NET Core apps
- Familiarity with basic data management concepts
- Access to an Azure subscription with **Owner** privilege
