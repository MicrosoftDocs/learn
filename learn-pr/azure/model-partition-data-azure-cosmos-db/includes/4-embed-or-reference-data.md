In the previous unit, we embedded the customer address and password data into a new customer document. By doing that, we reduce the number of requests which improves performance and reduces cost. However, you can't always embed data. There are rules for when you should embed data in a document versus reference it in a different row.

## When should you embed data?

You should embed data into a document when the following criteria applies to your data:

- **1:1 relationship** -  For example, Customer and CustomerPassword have a 1:1 relationship.
- **1:Few relationship** - In a NoSQL database it is necessary to distinguish 1:Many relationships as bounded or unbounded. Customer and CustomerAddress is a bounded 1:Many relationship because customers in an e-commerce application normally only have a handful of addresses to ship to. This is referred to as a 1:few relationship.
- **Read or updated together** - In our scenario here, all of the customer entities are read or written together.

## When should you reference data?

You should reference data into a document when the following criteria applies to your data:

- **1:Many relationship** - Especially if this relationship is unbounded. Azure Cosmos DB has a maximum document size of 2MB so in situations where the 1:Many relationship is unbounded or can grow extremely large, this is a scenario where data should be referenced, not embedded.
- **Many:Many relationship** - We will explore an example of this in a later unit with Product Tags.
- **Read or updated independently** - This is especially true with large documents. Updates in Cosmos DB require the entire item to be replaced. If a document has a small number of properties that are frequently updated alongside a large number of mostly static properties, it is much more efficient to shred the document into two, with one containing the smaller set of properties updated frequently, and another one that contains the static, unchanging values. This will reduce throughput consumption making it more efficient and reduce latency for better performance.