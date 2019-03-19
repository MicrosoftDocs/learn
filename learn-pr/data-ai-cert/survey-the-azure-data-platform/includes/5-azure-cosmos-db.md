Azure Cosmos DB is a globally distributed, multi-model database. It can be deployed using several API models including:

- SQL API
- Mongo DB API
- Cassandra DB API
- Gremlin DB API
- Table API

This multi-model architecture allows the Database Engineer to leverage the inherent capabilities of each model such as MongoDB for semi-structured data, Cassandra for wide columns or Gremlin for graph databases. Using Gremlin, the Data Engineer could create graph entities and perform graph query operations to perform traversals across vertices and edges, achieving sub-second response time for complex scenarios like Natural Language Processing (NLP) or social networking associations. Additionally, applications built upon SQL, MongoDB or Cassandra will continue to operate without changes to the application despite the database server being moved from either SQL, MongoDB, or Cassandra to Azure Cosmos DB.

## When to Use It

Data Engineers should deploy Azure Cosmos DB when a NoSQL database of the supported API model is required, at planet-scale, and when low latency performance is required. At the time of writing, Azure Cosmos DB supports five 9s uptime (99.999%) and can support sub 10ms response times when provisioned correctly.

For example, Contoso, an eCommerce retailer based in Manchester, UK sells children's toys. After reviewing some Power BI reports, Contoso's managers noticed a significant uptick in sales in Australia. A review of their customer service cases in Dynamics 365 demonstrated that there were a significant number of customer complaints about the site's shopping cart functionality timing out leaving Australian customers frustrated.

Contoso's network operations manager confirmed that with the company's only data center located in London, the physical distance to Australia was causing the problem. Contoso implements a new solution that provides a local version of the data to users in Australia using the Microsoft Australia East data canter. Migrating their existing on-premises SQL Database to Azure Cosmos DB using the SQL API improves performance for the Australian users, as the data can be stored in the UK and replicated to Australia to improve throughput times for Australian customers.

## Key Features

Cosmos DB supports 99.999% uptime plus Data Engineers can programmatically (or via the Azure Portal) invoke a regional failover. A Cosmos database will automatically failover if there is a regional disaster. Additionally, using Azure Cosmos DB's multi-master replication, it's common to be able to achieve less than one second response time from anywhere in the world. Microsoft Azure Cosmos DB is guaranteed to achieve less than 10ms response time for reads and writes.

To maintain the consistency of the data in Azure Cosmos DB, the engineering team introduces a new set of consistency levels that address the unique challenges facing planet-scale solutions. Consistency levels include Strong, Bounded Staleness, Session, Consistent Prefix, and Eventual.

## Ingesting Data

To ingest data into Azure Cosmos DB, Data Engineers can use Azure Data Factory, create an application that writes data into Azure Cosmos DB through its API, upload JSON documents, or directly edit the document.

## Querying Data

Data Engineers can create stored procedures, triggers, and user-defined functions (UDF's) or leverage the JavaScript query API. Additionally, there are other methods available to query the other APIs within Cosmos DB. For example, there is a Graph visualization pane in the Data Explorer component of Cosmos DB.

## Securing Data

Azure Cosmos DB supports data encryption, IP Firewall configurations, and access from virtual networks. Encryption is applied automatically. User authentication is token based, and Azure Active Directory provides role-based security. Azure Cosmos DB meets many security compliance certifications including HIPAA, FedRAMP, SOCS, and HITRUST.