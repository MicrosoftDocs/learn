The CTO has asked you to design databases for Azure to meet all of the needs of existing structured data on premises and suggestion solutions for any new relational data workloads that Tailwinds might need. Structured data includes relational data and has a shared schema. Structured data is often stored in database tables with rows, columns, and keys. Structured data is often used for application storage like an ecommerce website.

Within the umbrella of the Azure SQL platform, there are many deployment options and choices that you need to make to meet your needs. These options give you the flexibility to get and pay for exactly what you need. Here, we'll cover some of the considerations you need to make when you choose various Azure SQL deployment options. We'll also cover some of the technical specifications for each of these options. The deployment options discussed here include SQL Server on virtual machines, Azure SQL Managed Instance, Azure SQL Database, Azure SQL Managed Instance pools, and Azure SQL Database elastic database pools.

 

## Analyze Azure SQL deployment options

As displayed in the following graphic, Azure offers SQL Server in the following ways:

- SQL Server on Azure VMs

- Managed instances:

	- Single instances

	- Instance pool

- Databases:

	- Single database

	- Elastic pool

:::image type="content" source="../media/azure-deployment-options.png" alt-text="Diagram of the Azure SQL deployment options.":::


 

 

## Azure SQL Database

Azure SQL Database is a PaaS deployment option of Azure SQL that abstracts both the OS and the SQL Server instance. It is a highly scalable, intelligent, relational database service built for the cloud with the industry's highest availability SLA.

SQL Database is also the only deployment option that supports scenarios that require:

- Very large databases (currently up to 100TB)

- Autoscaling for unpredictable workloads (serverless)

In the following image, AccuWeather provides an example of using SQL Database.

AccuWeather has been analyzing and predicting the weather for more than 55 years. The company wanted to access Azure for its big data, machine learning, and AI capabilities. AccuWeather wants to focus on building new models and applications, not on managing databases. The company chose SQL Database to use with other services, like Azure Data Factory and Azure Machine Learning to quickly and easily deploy new internal applications to make sales and customer predictions.

:::image type="content" source="../media/azure-sql-database.png" alt-text="How AccuWeather used SQL databases to solve business problems.":::



## What are SQL elastic pools?

When you create your Azure SQL database, you can create a SQL elastic pool. They enable you to buy a set of compute and storage resources that are shared among all the databases in the pool. Each database can use the resources they need, within the limits you set, depending on current load.

Read more about [SQL elastic pools](/azure/azure-sql/database/elastic-pool-overview).

## Analyze Azure purchasing models

The next decision to be made after deciding on deployment option is the purchasing model.

Azure SQL Database has two purchasing models as shown in the following graphic:

- DTU

- vCore


:::image type="content" source="../media/select-azure-sql-database-pricing-model.png" alt-text="Diagram of the SQL database pricing options.":::

 


- vCores stands for Virtual cores and lets you choose the number of vCores which gives you greater control over the compute and storage resources that you create and pay for.

- DTU (Database Transaction Unit) is a combined measure of compute, storage, and IO resources. DTU model is a simple, preconfigured purchase option. This is unavailable on SQL managed Instance.

- Serverless model is a compute tier for single databases in Azure SQL Database. It automatically scales compute, based on workload demand and bills only for the amount of compute used. 



The vCore-based model is recommended because it allows you to independently select compute and storage resources. The DTU-based model is a bundled measure of compute, storage, and I/O resources.

The vCore model also allows you to use Azure Hybrid Benefit for SQL Server and/or reserved capacity (pay in advance) to save money. Neither of these options is available in the DTU model.

In the table below, each purchasing model is recommended based on the requirements.

| **Recommendation**| **Requirement** |
| - | - |
| DTU Model| When you need a bundled measure of compute, storage and I/O resources |
| vCore Model| When you need the flexibility of selecting compute and storage resources independently |


 

## Analyze Azure database service tiers

Based on performance, availability and storage needs, Azure offers three database service tiers, within the vCore module discussed in the following table.

Azure SQL Database and Azure SQL Managed Instance ensure 99.99% availability, even in the cases of infrastructure failures.

Service tiers available to Azure SQL Database and SQL Managed Instance are - General Purpose and Business Critical. Azure SQL Database also has Hyperscale service tier that is unavailable for Azure SQL Managed Instance.

:::image type="content" source="../media/general-purpose-architecture.png" alt-text="Diagram of General Purpose service tier where the primary replica uses locally attached SSD for the tempdb.":::



In the preceding image, with **General Purpose** **service tier**, the primary replica uses locally attached SSD for the tempdb. The data and log files are stored in Azure Premium Storage. The backup files are then stored in Azure Standard Storage. When failover occurs, the Azure service fabric will identify a node with spare capacity and spin up a new SQL Server instance. The database files will then be attached, recovery will be run, and gateways will be updated to point applications to the new node.

**Business critical architecture** is meant for mission-critical applications that need low latency and minimal downtime. Business Critical is like deploying an Always On availability group (AG) behind the scenes, the way the data and log files are stored differs from General purpose, in that they are stored on the direct attached SSD.

 

In the Business Critical scenario, the data and log files are all running on direct-attached SSD, which significantly reduces network latency. In this architecture group, there are three secondary replicas. If any type of failure occurs, failing over to a secondary replica is fast because the replica already exists and has the data attached to it.

**Azure SQL Database Hyperscale** is a fully managed service that adapts to changing requirements by rapidly scaling storage up to 100 TB. Flexible, cloud-native architecture allows storage to grow as needed and enables you to back up data almost instantaneously and restore your database in minutes—regardless of the size of the data operation.

**Hyperscale** provides fast database restores, rapid scale outs, and scale ups. A Hyperscale database grows as needed - and you are billed only for the capacity you use.

:::image type="content" source="../media/hyperscale-architecture.png" alt-text="Diagram of SQL hyperscale illustrates the different types of nodes in Hyperscale architecture.":::

 

The image above illustrates the different types of nodes in Hyperscale architecture. The compute node is where the relational engine lives and where language, query, and transaction processing occur. Compute nodes have SSD-based caches (labeled RBPEX - Resilient Buffer Pool Extension). There are one or more secondary compute nodes that act as hot standby nodes for failover purposes, as well as act as read-only compute nodes. Page servers are systems representing a scaled-out storage engine. The job of a page server is to serve database pages out to the compute nodes on demand. Page servers also maintain covering SSD-based caches to enhance performance. The log service accepts log records from the primary compute replica, persists them in a durable cache, and forwards the log records to the rest of compute replicas (so they can update their caches) as well as the relevant page server(s), so that the data can be updated there. In this way, all data changes from the primary compute replica are propagated through the log service to all the secondary compute replicas and page servers.

The following table compares the different scenarios when the three service tiers can be selected based on your specific needs.

| **Recommendation**| **Requirement** |
| - | - |
| General Purpose| When you need balanced compute and storage options for business workloads |
| Business Critical| When you need low latency requirements and highest resilience to failures for business applications |
| Hyperscale| When you need highly scalable storage and have read-scale requirements for business workloads |