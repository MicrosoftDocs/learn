:::row:::
  :::column span="3":::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column span="2":::
    Over the years, Tailwind Traders has acquired several smaller companies. Each of these companies had teams of developers who used different database services and various APIs to work with their data. A long-term plan might be to eventually move all of the disparate data to a common database service. For now, though, you'd like to set up each of these teams to work with an environment where they can use their existing skills. Fortunately for you, Azure Cosmos DB can help out.
  :::column-end:::
  :::column:::
    :::image type="content" source="../media/icon-service-Azure-Cosmos-DB-871edf07.png" alt-text="Icon":::

  :::column-end:::
:::row-end:::


Azure Cosmos DB is a globally distributed, multi-model database service. You can elastically and independently scale throughput and storage across any number of Azure regions worldwide. You can take advantage of fast, single-digit-millisecond data access by using any one of several popular APIs. Azure Cosmos DB provides comprehensive service level agreements for throughput, latency, availability, and consistency guarantees.<br>

Azure Cosmos DB supports schemaless data, which lets you build highly responsive and "Always On" applications to support constantly changing data. You can use this feature to store data that's updated and maintained by users around the world.

For example, Tailwind Traders provides a public training portal that is used by customers across the globe to learn about the different tools Tailwind Traders creates. Tailwind Traders developers maintain and update the data. The following illustration shows a sample Azure Cosmos DB database that's used to store data for the Tailwind Traders training portal website.

:::image type="content" source="../media/azure-cosmos-db-1c115364.png" alt-text="Diagram of Azure Cosmos DB databases in a training portal website.":::


Azure Cosmos DB is flexible. At the lowest level, Azure Cosmos DB stores data in atom-record-sequence (ARS) format. The data is then abstracted and projected as an API, which you specify when you're creating your database. Your choices include SQL, MongoDB, Cassandra, Tables, and Gremlin. This level of flexibility means that as you migrate your company's databases to Azure Cosmos DB, your developers can stick with the API with which they're the most comfortable.
