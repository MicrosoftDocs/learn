Azure Cosmos DB is a globally distributed, multimodel database. You can deploy it by using  several API models:

- SQL API
- MongoDB API
- Cassandra API
- Gremlin API
- Table API

Because of the multimodel architecture of Azure Cosmos DB, you benefit from each model's inherent capabilities. For example, you can use MongoDB for semistructured data, Cassandra for wide columns, or Gremlin for graph databases. When you move your data from SQL, MongoDB, or Cassandra to Azure Cosmos DB, applications that are built using the SQL, MongoDB, or Cassandra APIs will continue to operate.

> [!NOTE]
>
> For more information about the APIs that are available in Azure Cosmos DB, see [Choose the appropriate API for Azure Cosmos DB storage](https://docs.microsoft.com/learn/modules/choose-api-for-cosmos-db/).

## When to use Azure Cosmos DB

Deploy Azure Cosmos DB when you need a NoSQL database of the supported API model, at planet scale, and with low latency performance. Currently, Azure Cosmos DB supports five-nines uptime (99.999 percent). It can support response times below 10 ms when it's provisioned correctly.

Consider this example where Azure Cosmos DB helps resolve a business problem. Contoso is an e-commerce retailer based in Manchester, UK. The company sells children's toys. After reviewing Power BI reports, Contoso's managers notice a significant decrease in sales in Australia. Managers review customer service cases in Dynamics 365 and see many Australian customer complaints that their site's shopping cart is timing out.

Contoso's network operations manager confirms the problem. It's that the company's only data center is located in London. The physical distance to Australia is causing delays. Contoso applies a solution that uses the Microsoft Australia East datacenter to provide a local version of the data to users in Australia. Contoso migrates their on-premises SQL Database to Azure Cosmos DB by using the SQL API. This solution improves performance for Australian users. The data can be stored in the UK and replicated to Australia to improve throughput times.

## Key features

Azure Cosmos DB supports 99.999 percent uptime. You can invoke a regional failover by using programing or the Azure portal. An Azure Cosmos DB database will automatically fail over if there's a regional disaster. 

By using multimaster replication in Azure Cosmos DB, you can often achieve a response time of less than one second from anywhere in the world. Azure Cosmos DB is guaranteed to achieve a response time of less than 10 ms for reads and writes.

To maintain the consistency of the data in Azure Cosmos DB, your engineering team should introduce a new set of consistency levels that address the unique challenges of planet-scale solutions. Consistency levels include strong, bounded staleness, session, consistent prefix, and eventual.

## Data ingestion

To ingest data into Azure Cosmos DB, use Azure Data Factory, create an application that writes data into Azure Cosmos DB through its API, upload JSON documents, or directly edit the document.

## Queries

As a data engineer, you can create stored procedures, triggers, and user-defined functions (UDFs). Or use the JavaScript query API. You'll also find other methods to query the other APIs within Azure Cosmos DB. For example, in the Data Explorer component, you can use the graph visualization panel.

## Data security

Azure Cosmos DB supports data encryption, IP firewall configurations, and access from virtual networks. Data is encrypted automatically. User authentication is based on tokens, and Azure Active Directory provides role-based security. 

Azure Cosmos DB meets many security compliance certifications, including HIPAA, FedRAMP, SOCS, and HITRUST.
