Relational schemas divide data into normalized tables and reconstruct business objects with joins. Those table boundaries don’t necessarily represent business ownership. An order and its line items might occupy separate tables even though the line items exist only as part of the order.

A document model can preserve these natural business boundaries. Before deciding which data to embed, reference, or partition together, identify the objects that own related data and enforce the rules that must remain consistent.

## Start with candidate aggregate boundaries

For this module, an aggregate root is the business object through which related data is created, changed, and deleted. Use these questions to identify candidate boundaries:

| Question | Design signal |
|:---------|:--------------|
| If the parent is deleted, should the related data disappear? | If yes, the related data might belong inside the aggregate. |
| Must changes to the data succeed or fail together? | If yes, the data might share a consistency boundary. |
| Can the related data exist or change independently? | If yes, it is probably a separate aggregate. |
| Can the collection grow without a practical bound? | If yes, don’t embed the entire collection in one item. |
| Is the data shared or authoritative for multiple business objects? | If yes, keep an independent source of truth. |

Applying these questions to Contoso produces five candidates:

| Aggregate root | Owned data | Reason |
|:---------------|:-----------|:-------|
| Customer | Addresses and credential data | They belong to one customer and are bounded in this scenario. |
| SalesOrder | Order line items | Line items exist only as part of their order. |
| Product | Product-specific data | A product has an independent identity and lifecycle. |
| Category | Category data | Many products share a category, and it can change independently. |
| Tag | Tag data | Many products share a tag, and it can change independently. |

The relational ProductTags table represents a relationship. It isn’t itself an aggregate root.

These candidate boundaries establish ownership, but they don’t finish the physical model. The application’s operations determine how those aggregates should be represented and co-located in Azure Cosmos DB.

## Inventory the access patterns

An access pattern is one operation the application performs: a screen it renders, a form it submits, or a background process it runs. Record the operation, whether it reads or writes, its frequency, its filter properties, and the result shape it needs.

Access patterns don’t replace aggregate boundaries. They test and optimize them. They reveal which aggregates can be stored as single items, which separate items should share a logical partition, and which values should be copied into read-optimized projections.

| Operation | Type | Frequency | Filters on |
|:----------|:-----|:----------|:-----------|
| Create a customer | Write | Low | None |
| Update a customer profile | Write | Low | Customer identifier |
| Sign in and load the customer | Read | High | Customer identifier |
| List all product categories | Read | Highest | None |
| List products in a category | Read | Highest | Category identifier |
| Show a product page | Read | Highest | Product identifier |
| Create a sales order | Write | Medium | Customer identifier |
| List a customer's orders | Read | Medium | Customer identifier |
| Rank customers by order count | Read | Low | None |

Two patterns fall out immediately.

The workload is read-heavy, and the reads concentrate on a handful of operations. Category browsing and the product page account for most traffic, so the model has to make those two operations cheap even if it makes order creation slightly more expensive.

Second, the same identifiers appear over and over in the filter column. Customer identifier scopes four operations. Category identifier scopes the busiest read. Those repetitions are the first signal of where partition boundaries belong, a decision you make later in this module.

## Use boundaries and access patterns together

The Customer aggregate contains bounded address and credential data that the application reads and updates through the customer. This ownership boundary and the sign-in access pattern both support embedding the data in one customer item.

A customer’s order history is different. An order has its own lifecycle, might need to be retained independently, and can grow without bound. Customer and SalesOrder should therefore remain separate aggregate roots and separate items. Later, they can share a logical partition so customer-scoped queries route efficiently and related operations can use a transactional batch.

Product, Category, and Tag are also separate aggregate roots. The product page reads their values together, but that doesn’t transfer ownership of Category or Tag to Product. Instead, the model can copy selected category and tag values onto the Product item as denormalized projections while preserving Category and Tag as the authoritative sources.

Finally, identify operations that no individual aggregate can answer efficiently. Ranking customers by order count spans many customers and partitions. A pre-aggregated counter can make that read cheaper, but it introduces a synchronization obligation that the design must handle explicitly.

## Write down the patterns before you model

The aggregate-boundary map and the access-pattern inventory are paired design artifacts. The first records ownership and consistency decisions; the second records how the application uses the data. Review both when requirements or traffic patterns change.

The inventory is a design artifact, not a warm-up exercise. Use this information to review the model and explain the container design. Review it again when you release a new feature or when traffic patterns change.

Two rules keep it useful:

- **Capture the operations you have, not the ones you might have.** A model built for hypothetical queries pays for them in storage and write cost forever.
- **Record measured frequencies where you have them.** Estimates drift toward what the team finds interesting rather than what users do.

**Guiding question:** Write the same five columns for the three operations your own application runs most often. For each one, count how many separate requests the current design needs to answer it. Any operation that takes more than one request is a candidate for the modeling techniques in the next two units, and the count itself is the baseline you measure improvement against.
