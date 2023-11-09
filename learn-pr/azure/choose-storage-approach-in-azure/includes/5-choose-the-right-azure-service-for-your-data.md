Choosing the correct storage solution can lead to better performance, cost savings, and improved manageability. Each type of data has different storage requirements. It's your job to determine which storage solution is best for the types of data your company uses. Always consider the type of data, the operations required, expected latency, and the need for transactional support.

Here, you apply what you've learned about the data in your online retail scenario and find the best Azure service for each dataset. 

## Product catalog data

**Data classification**: Semi-structured because of the need to extend or modify the schema for new products.

**Operations**:

- Customers require a high number of read operations, with the ability to query many fields within the database.
- The business requires a high number of write operations to track its constantly changing inventory.

**Latency and throughput**: High throughput and low latency.

**Transactional support**: Because product data is tied to payment and inventory, transactional support is required.

### Recommended service: Azure Cosmos DB

Azure Cosmos DB supports semi-structured or NoSQL data by design. So, supporting new fields, such as the "Bluetooth-enabled" field or any new fields you need in the future, is something you can do with Azure Cosmos DB.

Azure Cosmos DB supports SQL for queries, and every property is indexed by default. You can create queries so that your customers can filter on any property in the catalog.

Azure Cosmos DB is also ACID-compliant, so you can be assured that your transactions are completed according to those strict requirements. An OLTP connector is available for Azure Cosmos DB.

As an added plus, you also can use Azure Cosmos DB to easily replicate your data anywhere in the world. So, if your e-commerce site has users concentrated in the US, France, and England, you can replicate your data to datacenters in those regions. Latency is reduced because you've physically moved the data closer to your users.

Even with data that's replicated around the world, you can choose from one of five consistency levels. By choosing the right consistency level, you can determine the tradeoffs to make between consistency, availability, latency, and throughput. You can scale up to handle higher customer demand during peak shopping times or scale down during slower times to conserve on cost.

#### Why not other Azure services?

Azure SQL Database would be an excellent choice for this dataset if you could identify the subset of properties that are common for most of the products and the variable properties that might not exist in some products. You can use Azure SQL Database to combine structured data in the columns and semi-structured data stored as JSON columns that can be easily extended. Azure SQL Database can provide many of the same benefits of Azure Cosmos DB, but it provides little benefit if the structure of your data is changing in different entities and you can't predefine a set of common properties that are repeated in most of the entities. Unlike Azure Cosmos DB, which indexes every property in the documents, in Azure SQL Database, you need to explicitly define what properties in semi-structured documents should be indexed. Azure Cosmos DB is a better choice for highly unstructured and variable data in which you can't predict what properties should be indexed. Azure SQL Database supports OLTP.

Other Azure services, like Azure Table storage, Apache HBase in Azure HDInsight, and Azure Cache for Redis, can also store NoSQL data. In this scenario, users will want to query on multiple fields, so Azure Cosmos DB is a better fit. Azure Cosmos DB indexes every field by default, whereas other Azure services are limited in the data they index. Querying on non-indexed fields results in reduced performance.

## Photos and videos

**Data classification**: Unstructured.

**Operations**:

- Retrieve only by ID.
- Customers require a high number of read operations with low latency.
- Create operations and update operations will be less frequent and can have higher latency than read operations.

**Latency and throughput**: Retrievals by ID need to support low latency and high throughput. Create operations and update operations can have higher latency than read operations.

**Transactional support**: Not required.

### Recommended service: Azure Blob Storage

Azure Blob Storage supports storing files like photos and videos. It also works with Azure Content Delivery Network by caching the most frequently used content, and then storing it on edge servers. Azure Content Delivery Network reduces latency when serving those images to your users.

In Azure Blob Storage, you can also move images from the hot storage tier to the cool storage tier or archive storage tier, to reduce costs and focus throughput on the most frequently viewed images and videos.

#### Why not other Azure services?

You could upload your images to Azure App Service, so that the same server that's running your app serves up your images. This solution would work if you didn't have many files. But if you have lots of files and a global audience, you'll get better performance by using Azure Blob Storage with Azure Content Delivery Network.

## Business data

**Data classification**: Structured.

**Operations**: Read-only, complex analytical queries across multiple databases.

**Latency and throughput**: Some latency in the results is expected based on the complex nature of the queries.

**Transactional support**: Not required.

### Recommended service: Azure SQL Database

Business data most likely will be queried by business analysts, who are more likely to know SQL than any other query language. You can use Azure SQL Database as a solution by itself, but if you pair it with Azure Analysis Services, data analysts can create a semantic model over the data in Azure SQL Database. Data analysts can then share the model with business users, who need only to connect to the model from any business intelligence (BI) tool to immediately explore the data and gain insights. Azure Analysis Services supports OLAP.

#### Why not other Azure services?

Azure Synapse Analytics supports OLAP solutions and SQL queries, but your business analysts will need to perform cross-database queries, which Azure Synapse Analytics doesn't support.

Azure Stream Analytics is a great way to analyze data and transform it into actionable insights, but its focus is on real-time data that is streaming in. In this scenario, the business analysts are looking at historical data only.
