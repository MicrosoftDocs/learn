Typically, you transition from the traditional software programming model to cloud-native applications when you need to improve the agility, availability, and resiliency of your workloads. As part of that transition, you divide the functionality that such workloads provide into separate components. You then delegate their implementation to distinct subsystems. This process, in turn, allows you to deploy and scale these subsystems independently of each other. You also benefit from the resiliency associated with the scaling capabilities and distributed architecture. A service is one of the core concepts that you rely on to decide how to design and implement these changes.

## What is a service?

The term *service* represents a collection of components that collectively deliver specific, workload-oriented functionality to your cloud-native application. Each service is part of a larger system that forms the application. For example, the smart refrigerator application you're developing might have an inventory service, an ordering service, a payment service, and a management interface, each with its own, independent set of technology choices. This gives you flexibility to choose any implementation method that you consider to be optimal based on your requirements or preferences.

## How can services use Azure capabilities?

In the context of cloud-native applications, you can optimize the use of services by using Azure capabilities. For example, it's common to implement services within containers. This automatically ensures their isolation by including all service dependencies within the container image. Deploying containers to Azure Kubernetes Service (AKS) allows you to increase scalability and resiliency, which are fundamental parts of container orchestration. It also offers minimized maintenance overhead inherent to the managed service. Offerings such as Azure SQL Database, Azure Cosmos DB, and Azure Database for PostgreSQL offer equivalent benefits for data persistence. With Azure API Management, you can control access to services' APIs.

:::image type="content" source="../media/2-services-leveraging-azure.png" alt-text="Services that use Azure capabilities, including Azure Database for PostgreSQL and Cosmos DB.":::

## What is Azure Database for PostgreSQL?

Azure Database for PostgreSQL is a Microsoft-managed implementation of the PostgreSQL Community Edition database engine. It offers a wide-range of capabilities that either eliminate or minimize common database management tasks. These capabilities include automatic backups, elastic scaling, enhanced monitoring and automation, and built-in high availability provisions.

PostgreSQL has gained a large following since its introduction in 1996. Its availability as a managed service in Azure facilitates the adoption of principles of cloud-native applications for existing workloads. For example, you can continue using popular, open-source object-role modeling libraries such as Sequelize or Prisma as you refactor or rearchitect your Node.js-based applications as part of their migration to Azure.

Azure Database for PostgreSQL is available in three deployment modes:

- Single Server. This mode is optimized for cloud-native applications that don't require granular control over custom PostgreSQL configuration settings but benefit from the minimized management overhead. It supports the community versions of PostgreSQL 9.5, 9.6, 10, and 11.
- Flexible Server. This mode offers more granular control of database management tasks and configuration settings. The flexible server architecture delivers support for availability zones and cost-optimization controls. The controls allow you to stop the server during idle periods and include the choice of the burstable compute tier, which automatically adjusts the compute resources based on demand. The flexible server supports the community versions of PostgreSQL 11 and PostgreSQL 12.
- Hyperscale. This mode implements sharding to horizontally scale data queries across multiple database instances to minimize response time for large datasets. It's intended for applications that require greater scale and performance, with datasets in the range of 100 GB.
