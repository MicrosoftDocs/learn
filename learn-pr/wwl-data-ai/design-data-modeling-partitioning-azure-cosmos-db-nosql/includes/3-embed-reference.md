The previous unit identified candidate aggregate roots and the operations the model must support. The next step is to map those business boundaries to Azure Cosmos DB items.

Embedding places related data inside one item. Referencing keeps data in separate items connected by identifiers. Access patterns influence this choice, but ownership, lifecycle, consistency, and boundedness come first.

One aggregate commonly maps to one item because an item can be read and written atomically. This mapping is a useful default, not an Azure Cosmos DB requirement.

## Understand the trade-off

Embedding places related data inside the root item. One read returns the complete aggregate, and changes to the item are atomic. The trade-offs are item size and write cost. A Replace operation writes the entire item, even when only one value changes.

The Patch API modifies specified paths without requiring a read-modify-write round trip and reduces the data sent over the network. However, Patch uses the same request-unit accounting model as other operations, so it doesn't necessarily provide a significant reduction in request-unit charges. Measure the charge for your workload.

Azure Cosmos DB items have a maximum size of 2 megabytes (MB). An item can become expensive to read and update well before reaching that limit.

Referencing stores related data in separate items. Each item remains independently readable and writable, but the application might need more database operations and application-side assembly. Azure Cosmos DB queries can return multiple items from one container, but they don't perform joins between separate items or containers.

Make the embed-or-reference decision in this order:

1. Determine whether the related data belongs to the same ownership and lifecycle boundary.
1. Determine whether changes must succeed or fail together.
1. Check whether the relationship is bounded.
1. Consider independent update frequency and item size.
1. Optimize the representation for the highest-frequency access patterns.

## Embed data owned by the aggregate

Embedding is favored when:

- The related data has no meaningful lifecycle outside the parent.
- Deleting the parent should also delete the related data.
- The relationship is one-to-one or bounded one-to-few.
- Business rules commonly read or update the values together.
- The resulting item remains reasonably sized and doesn't grow without bound.

The Contoso Customer aggregate meets these conditions. An address belongs to one customer, and the address collection has a practical limit. In this scenario, the stored credential data is also managed through the customer and isn't used independently.

The relational schema separates this data into *Customer*, *CustomerAddress*, and *CustomerPassword* tables. In the document model, it becomes one Customer item:

```json
{
  "id": "C0000000-0000-0000-0000-000000000001",
  "firstName": "Dalton",
  "lastName": "Perez",
  "emailAddress": "dalton37@adventure-works.com",
  "phoneNumber": "559-555-0115",
  "creationDate": "2013-07-01T00:00:00",
  "addresses": [
    {
      "addressLine1": "6083 San Jose",
      "city": "Haney",
      "state": "BC",
      "countryOrRegion": "CA",
      "zipCode": "V2W 1W2"
    }
  ],
  "password": {
    "hash": "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAE=",
    "salt": "F7605D40"
  }
}
```

One item read now returns the customer information needed by the application. An update to the customer and its embedded values is atomic because it affects one item.

SalesOrder follows the same reasoning. Its line items have no meaningful existence outside the order. Deleting an order deletes its line items, and an order must remain internally consistent with the products, quantities, and prices recorded at checkout.

The line items therefore become an embedded details array:

```json
{
  "id": "C0000000-0000-0000-0000-000000000008",
  "customerId": "C0000000-0000-0000-0000-000000000001",
  "orderDate": "2014-03-30T00:00:00",
  "details": [
    {
      "sku": "TI-R982",
      "name": "HL Road Tire",
      "price": 32.6,
      "quantity": 1
    }
  ]
}
```

The product name and price in the order detail represent the values captured when the order was placed. They aren't live references to the current Product data.

## Reference independently owned or unbounded data

Keep related data in separate items when:

- It has an independent identity or lifecycle.
- It can exist after the parent is deleted.
- Multiple aggregate roots share it.
- The relationship can grow without a practical bound.
- It changes independently or much more frequently than the parent.
- It acts as an authoritative source for values copied elsewhere.

A customer's order history shouldn't be embedded in the Customer item. Each SalesOrder is an independent business record, and the number of orders can continue growing for as long as the customer remains active.

Customer and SalesOrder should therefore remain separate aggregate roots and separate items. Each order carries a customerId reference to the customer that placed it. A later unit colocates these items by customerId, but sharing a logical partition doesn't make them one aggregate.

Product, Category, and Tag are also independently owned. A category can be renamed without changing the lifecycle of its products. A tag can be applied to many products, and a product can have multiple tags.

The relational schema represents the Product-to-Tag many-to-many relationship with a ProductTags junction table. A JSON item can instead hold a bounded array of tag identifiers:

```json
{
  "id": "C0000000-0000-0000-0000-000000000002",
  "categoryId": "C0000000-0000-0000-0000-000000000003",
  "sku": "SE-R581",
  "name": "LL Road Seat/Saddle",
  "price": 27.12,
  "tagIds": [
    "C0000000-0000-0000-0000-000000000004",
    "C0000000-0000-0000-0000-000000000005"
  ]
}
```

The array belongs on Product because the number of tags assigned to one product is bounded. Storing every product identifier on a Tag item could create an array that grows without bound.

The tag identifiers are references, not foreign keys. Azure Cosmos DB doesn't verify that the referenced Tag items exist or automatically update Product when a Tag changes. The application is responsible for maintaining the relationship.

## Distinguish references from copied values

A reference stores the identifier of another aggregate. A copied value stores selected data from that aggregate to make a read more efficient.

For example, Product can reference Category through categoryId. If the product page also needs the category’s display name, the model can copy categoryName onto Product. The copied name is a denormalized projection; Category remains the authoritative source.

This distinction prevents two common mistakes:

- Treating copied data as though Product owns it.
- Treating every value read together as though it belongs in the same aggregate.

The next unit evaluates when these copied values are worth their synchronization cost.

## Don’t equate aggregates with containers

An aggregate root, item, logical partition, and container represent different boundaries.

An aggregate root defines business ownership and lifecycle. An item is a JSON document and the scope of a single-item atomic operation. A logical partition groups items by partition-key value and defines the scope of multi-item transactions. A container supplies the partitioning and operational configuration for its items.

Separate aggregate types can share a container when they need compatible partitioning, throughput, indexing, time-to-live, and change-feed behavior. Sharing a container doesn't merge their ownership or lifecycle boundaries.

At this point, Contoso can begin with a separate container for each aggregate type. Later units combine compatible item types where doing so improves routing, transactions, or operational management.

## Where the model stands

The nine relational tables now describe five candidate aggregate roots:

| Aggregate root | Representation |
|:---------------|:---------------|
| Customer | One item with addresses and credential data embedded |
| SalesOrder | One item with order details embedded and a reference to Customer |
| Product | One item with references to Category and Tag |
| Category | An independently managed item |
| Tag | An independently managed item |

The CustomerAddress, CustomerPassword, and SalesOrderDetail tables are now embedded data. The ProductTags junction table is now a bounded array of tag identifiers on Product.

These choices preserve ownership and lifecycle boundaries, but the model isn't finished. Rendering a product page still requires separate lookups for the category and tag display names. The next unit uses denormalization and preaggregation to optimize those reads without changing which aggregate owns the authoritative data.
