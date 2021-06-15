In the previous unit, we embedded the customer address and password data into a new customer document. That action reduces the number of requests, which improves performance and reduces cost. However, you can't always embed data. There are rules for when you should embed data in a document instead of referencing it in a different row.

## When should you embed data?

Embed data in a document when the following criteria apply to your data:

- **1:1 relationship**: For example, Customer and CustomerPassword have a 1:1 relationship.
- **1:Few relationship**: In a NoSQL database, it's necessary to distinguish 1:Many relationships as bounded or unbounded. Customer and CustomerAddress is a bounded 1:Many relationship because customers in an e-commerce application normally only have a handful of addresses to ship to. When the relationship is bounded, this is referred to as a 1:few relationship.
- **Read or updated together**: Data that is read or updated together is nearly always modeled as a single document. This is especially true since our objective for our NoSQL model is to reduce the number of requests to our database. In our scenario, all of the customer entities are read or written together.

## When should you reference data?

Data should be referenced as separate documents when the following criteria applies to your data:

- **1:Many relationship**: Especially if this relationship is unbounded. Azure Cosmos DB has a maximum document size of 2 MB. So in situations where the 1:Many relationship is unbounded or can grow extremely large, data should be referenced, not embedded.
- **Many:Many relationship**: We will explore an example of this relationship in a later unit with Product Tags.
- **Read or updated independently**: This is especially true with large documents. Updates in Cosmos DB require the entire item to be replaced. If a document has a few properties that are frequently updated alongside a large number of mostly static properties, it's much more efficient to shred the document into two. So one document contains the smaller set of properties that are updated frequently. The other document contains the static, unchanging values. 

  Separating these properties reduces throughput consumption, which makes it more efficient, and reduces latency for better performance.
