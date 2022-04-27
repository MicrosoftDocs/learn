When you want to use a MongoDB-enabled application to Azure, you create a Cosmos DB API for MongoDB. 

## Cosmos DB API for MongoDB

The Azure Cosmos DB API for MongoDB makes it easy to use Cosmos DB as if it were a MongoDB database. 

* Leverage your MongoDB experience on the Azure Cloud
* Automatic and transparent sharding with the wire protocol for MongoDB.
* Free pricing tier.
* Serverless consumption.
* Compatible with several MongoDB server versions.

:::image type="content" source="../media/cosmosdb-mongodb.png" alt-text="Azure Cosmos DB's API for MongoDB":::

## Create a Cosmos DB resource

When you need to use your MongoDB app on Azure, create a Cosmos DB API for MongoDB. 

As part of the creation process, you need to answer a few questions such as:

* Version of MongoDB
* Azure location of resource
* Serverless or provisioned throughput
* Pricing tier 

### Version of MongoDB

CosmosDB supports several versions of the MongoDB API. You should select the version compatible with your MongoDB functionality.

### Azure location of resource

The Azure location indicates the geographical local for your database. You should select a location close to your primary customer usage.

### Serverless or provisioned throughput

When you select serverless or provisioned throughput, you are select the capacity mode for the resource. Use the following chart to help you decide which mode you need:


| Criteria | Provisioned throughput | Serverless |
| --- | --- | --- |
| Best suited for | Workloads with sustained traffic requiring predictable performance | Workloads with intermittent or unpredictable traffic and low average-to-peak traffic ratio |
| How it works | For each of your containers, you provision some amount of throughput expressed in [Request Units](/azure/cosmos-db/request-units) per second. Every second, this amount of Request Units is available for your database operations. Provisioned throughput can be updated manually or adjusted automatically with [autoscale](/azure/cosmos-db/provision-throughput-autoscale). | You run your database operations against your containers without having to provision any capacity. |
| Geo-distribution | Available (unlimited number of Azure regions) | Unavailable (serverless accounts can only run in 1 Azure region) |
| Maximum storage per container | Unlimited | 50 GB |
| Performance | < 10 ms latency for point-reads and writes covered by SLA | < 10 ms latency for point-reads and < 30 ms for writes covered by SLO |
| Billing model | Billing is done on a per-hour basis for the RU/s provisioned, regardless of how many RUs were consumed. | Billing is done on a per-hour basis for the amount of RUs consumed by your database operations. |

In some situations, it may be unclear whether provisioned throughput or serverless should be chosen for a given workload. To help with this decision, estimate your overall **expected consumption**, the total number of RUs, you may consume over a month.

### Pricing tier

The throughput selection in the previous section impacts the pricing tier options and service quota limits that generally affect Cosmos DB. 

Specific pricing tier information for Cosmos DB API for MongoDB include: 


Cosmos DB supports the MongoDB wire protocol for applications written against MongoDB. You can find the supported commands and protocol versions at [Supported MongoDB features and syntax](/azure/cosmos-db/mongodb/feature-support-32).

The following table lists the limits specific to MongoDB feature support. Other service limits mentioned for the SQL (core) API also apply to the MongoDB API.

| Resource | Default limit |
| --- | --- |
| Maximum MongoDB query memory size (This limitation is only for 3.2 server version) | 40 MB |
| Maximum execution time for MongoDB operations (for 3.2 server version)| 15 seconds|
| Maximum execution time for MongoDB operations(for 3.6 and 4.0 server version)| 60 seconds|
| Maximum level of nesting for embedded objects / arrays on index definitions | 6 |
| Idle connection timeout for server side connection closure* | 30 minutes |

\* The client application should set the idle connection timeout in the driver settings to 2-3 minutes because the [default timeout for Azure LoadBalancer is 4 minutes](/azure/load-balancer/load-balancer-tcp-idle-timeout).  This timeout will ensure that idle connections are not closed by an intermediate load balancer between the client machine and Azure Cosmos DB.

## Create database and container

Once the resource is created, you can access this resource in a variety of ways including: 

* Visual Studio Code - this is the method used in this Learn module
* Azure portal
* Azure CLI

The default resource doesn't have a database or a container. For this module, you need to create these before you import the sample data into the resource. 

In this module, you will load the data twice:
* First for your developer environment's use of the data emulator. You can play with the emulator data without affecting your cloud-based data.
* Second for your cloud environment's use. While you can import your data with any of the common tools (such as Visual Studio Code, Azure portal, or Azure CLI), in this module, the process uses the Visual Studio Code extension for Azure databases. 


