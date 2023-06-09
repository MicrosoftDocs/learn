MongoDB app developers don't have to learn new ways to communicate with the Azure Cosmos DB for MongoDB. The Azure Cosmos DB for MongoDB uses existing MongoDB [client drivers](https://www.mongodb.com/docs/drivers/) by adhering to the MongoDB [wire protocol](https://www.mongodb.com/docs/manual/reference/mongodb-wire-protocol/). 

Azure Cosmos DB for MongoDB is compatible with multiple MongoDB Server versions: versions [4.2](/azure/cosmos-db/mongodb/feature-support-42), [4.0](/azure/cosmos-db/mongodb/feature-support-40), [3.6](/azure/cosmos-db/mongodb/feature-support-36) and [3.2](/azure/cosmos-db/mongodb/feature-support-32).

## Protocol Support

By adhering to the MongoDB wire protocol, you should be able to use any client driver that uses these protocols to connect to Azure Cosmos API for MongoDB. The Azure Cosmos DB for MongoDB accounts will have different endpoint formats depending on the server version used.
- 3.6+ versions - have the endpoint format *(*.mongo.cosmos.azure.com)*
- 3.2 version - has the endpoint format *(*.documents.azure.com)*

Functions utilizing supported server commands are compatible with the Azure Cosmos DB for MongoDB.

> [!NOTE] 
> ***To take advantage of better data compression to save on query and storage costs, we recommend using versions 4.0+.***
