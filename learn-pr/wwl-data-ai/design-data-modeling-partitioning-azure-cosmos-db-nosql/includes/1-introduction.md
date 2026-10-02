Imagine you're a developer at Contoso, moving an e-commerce application off a relational database. The current schema holds nine tables: customers, their addresses, their passwords, products, categories, tags, the junction table that links products to tags, sales orders, and order line items. A single product page assembles data from four of them with joins that Azure Cosmos DB doesn't offer. At the same time, Contoso is opening the platform to retail brands who run their own storefronts on it. Most brands list a few hundred products. One lists millions, and it grows faster than the rest combined.

That combination creates two related design problems. First, determine which data belongs together because it shares ownership, lifecycle, and consistency requirements. Then optimize that model so the application can perform its most important operations efficiently and distribute storage and traffic evenly.

Begin by identifying candidate aggregate roots. An aggregate root is the business object that controls the lifecycle and consistency of related data. For example, a sales order owns its line items: the line items have no useful independent existence, and changes to the order and its line items commonly need to succeed or fail together. A customer, however, exists independently of an order and should normally be modeled as a separate aggregate.

For Contoso, the initial candidates are:

- A Customer with its bounded addresses and credential data.
- A Sales Order with its line items.
- A Product.
- A Category.
- A Tag.

These boundaries are the starting point, not the finished Azure Cosmos DB design. Access patterns determine whether an aggregate maps to one item and whether separate items should share a logical partition. They also determine which values should be copied as denormalized projections and which partition key supports efficient routing and scale.

An aggregate, an item, a logical partition, and a container are different boundaries. One aggregate commonly maps to one JSON item, but this mapping isn’t an Azure Cosmos DB requirement. Separate aggregates can share a container or logical partition, and multiple items in one logical partition can participate in a transaction.

In this module, you identify aggregate boundaries and access patterns, decide when to embed or reference data, and add denormalized projections and pre-aggregated values where they improve important operations. You then select partition keys, use hierarchical or synthetic keys when necessary, and review the completed design for scalability and cost anti-patterns.

By the end of this module, you can:

- Identify candidate aggregate roots from ownership, lifecycle, and consistency requirements.
- Use access patterns to map aggregates to items, references, and denormalized projections.
- Select partitioning strategies that support query routing, transactions, and scale.
- Identify modeling and partitioning anti-patterns that increase cost or limit growth.
