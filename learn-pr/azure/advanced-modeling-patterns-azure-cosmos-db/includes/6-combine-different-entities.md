We're nearly done modeling our database for our e-commerce application. Next let's look at the sales order entities to demonstrate the next concept.

## Model sales order entities

Just like with the other entities, we want to look at our operations and then make a decision on whether to embed or reference our related data. In this scenario, sales order detail makes a great candidate for embedding because the items in the order are not unbounded and also the data is always inserted and read together. So we will embed sales order details as an array within our sales order entity. And we will store our data in a new container called, salesOrder.

:::image type="content" source="../media/6-sales-order-model.png" alt-text="Diagram that shows the relational model for sales orders and sales order detail tables with the new NoSQL model, and operations needed." border="false":::

Next, we will decide upon a partition key. Since we will always search for sales order by customer, `customerId` makes a suitable partition key for our container. The choice of `customerId` will give us single partition query for an operation that will be run frequently.

:::image type="content" source="../media/6-sales-order-partition-key.png" alt-text="Diagram of sales order container with customer ID as its partition key, a list of operations needed, and a SQL query to list all sales orders for a customer." border="false":::

At this point, we've modeled all of our relational entities for our NoSQL database. So let's look at where we can make further optimizations.

## Identify optimization opportunities

One thing you may have noticed with the salesOrder container is that it shares the same partition key as the customer container. The customer container has a partition key of ID and salesOrder has a partition key of `customerId`. When data share the same partition key and have similar access patterns, they are candidates for being stored in the same container. As a NoSQL database, Azure Cosmos DB is schema agnostic so mixing entities with different schema is not only possible, under these conditions it is another best practice. But to combine the data from these two containers, we will need to make more changes to our schema.

:::image type="content" source="../media/6-sales-orders-customers.png" alt-text="Diagram showing the sales orders and customer models and containers going to a single customer container with both the sales order and customer documents stored in it." border="false":::

First, we need to add a `customerId` property to each customer document. Customers will now have the same value for ID and `customerId`. Next, we need a way to distinguish a sales order from a customer in the container. So we will add a discriminator property we will call `type` that has a value of 'customer' and 'salesOrder' for each entity.

:::image type="content" source="../media/6-sales-orders-customers-query.png" alt-text="Diagram that shows logical partitions with sales order and customer documents, and a query for a sales order in the new customer container." border="false":::

With those changes, we can now store both the customer and sales order data in our new customer container. Each customer is in its own logical partition and will have one customer item with all of their sales orders. For our second operation here, we now have a query we can run to list all sales orders for a customer.
