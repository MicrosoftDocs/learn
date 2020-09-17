:::row:::
  :::column span="3":::
Over the years, Tailwind Traders has acquired several smaller companies. Each of these companies had teams of developers who used different database services and various APIs to work with their data. While a long term plan might be to eventually move all of the disparate data to a common database service, for now you'd like to enable each of these teams to work with an environment where they can leverage their existing skillsets. Fortunately for you, Azure's Cosmos DB can help out.
  :::column-end:::
  :::column:::
    :::image type="icon" source="../media/icon-service-Azure-Cosmos-DB.png" border="false":::
  :::column-end:::
:::row-end:::

Azure Cosmos DB is Microsoft's globally distributed, multi-model database service. With a click of a button, Cosmos DB enables you to elastically and independently scale throughput and storage across any number of Azure regions worldwide. You can elastically scale throughput and storage, and take advantage of fast, single-digit-millisecond data access using any one of several popular APIs. Cosmos DB provides comprehensive service level agreements (SLAs) for throughput, latency, availability, and consistency guarantees, something no other database service offers.  

Azure Cosmos DB supports schema-less data, which lets you build highly responsive and Always On applications to support constantly changing data. You can use this feature to store data that is updated and maintained by users around the world.

For example, Tailwind Traders provides a public training portal that is used by customers across the globe to learn about the different tools that Tailwind Traders creates, and the data is maintained and updated by Tailwind Traders' developers. The following illustration shows a sample Azure Cosmos DB database that's used to store data for Tailwind Traders training portal website.

[![Azure Cosmos DB databases in a training portal website.](../media/azure-cosmos-db.png)](../media/azure-cosmos-db-expanded.png#lightbox)

Azure Cosmos DB makes a great choice in a variety of scenarios because it is flexible. At the lowest level, Azure Cosmos DB stores data in atom-record-sequence (ARS) format. The data is then abstracted and projected as an API, which you specify when you are creating your database. Your choices include SQL, MongoDB, Cassandra, Tables, and Gremlin. This level of flexibility means that as you migrate your company's databases to Azure Cosmos DB, your developers can stick with the API where they're most comfortable.
