You've nearly finished modeling your database for your e-commerce application. To demonstrate the next concept, let's look at the sales order entities.

## Model sales order entities

As with the other entities, you want to look at your operations and then decide whether to embed or reference your related data. In this scenario, sales order detail makes a great candidate for embedding. This is because the items in the order aren't unbounded and the data is always inserted and read together. So you'll embed sales order details as an array within your sales order entity. And you'll store your data in a new container, called salesOrder.

:::image type="content" source="../media/6-sales-order-model.png" alt-text="Diagram that shows the relational model for sales orders and sales order detail tables with the new NoSQL model, and the operations needed." border="false":::

Next, you'll choose a partition key. Because you'll always search for sales order by customer, `customerId` makes a suitable partition key for your container. Your choice of `customerId` will give you a single partition query for an operation that will be run frequently.

:::image type="content" source="../media/6-sales-order-partition-key.png" alt-text="Diagram of a sales order container with 'customerId' as its partition key, a list of operations needed, and a SQL query to list all sales orders for a customer." border="false":::

At this point, you've modeled all your relational entities for your NoSQL database. So let's look at where you can make further optimizations.

## Identify optimization opportunities

One thing you might have noticed with the salesOrder container is that it shares the same partition key as the customer container. The customer container has a partition key of ID and salesOrder has a partition key of `customerId`. When data share a partition key and have similar access patterns, they're candidates for being stored in the same container. As a NoSQL database, Azure Cosmos DB is schema agnostic, so mixing entities with different schema isn't only possible but, under these conditions, it's also another best practice. But to combine the data from these two containers, you'll need to make more changes to your schema.

:::image type="content" source="../media/6-sales-orders-customers.png" alt-text="Diagram showing the sales orders and customer models and containers going to a single customer container with both the sales order and customer documents stored in it." border="false":::

First, you need to add a `customerId` property to each customer document. Customers will now have the same value for ID and `customerId`. Next, you need a way to distinguish a sales order from a customer in the container. So you'll add a discriminator property you'll call `type` that has a value of `customer` and `salesOrder` for each entity.

:::image type="content" source="../media/6-sales-orders-customers-query.png" alt-text="Diagram that shows logical partitions with sales order and customer documents, and a query for a sales order in the new customer container." border="false":::

With these changes, you can now store both the customer data and sales order data in your new customer container. Each customer is in its own logical partition and will have one customer item with all its sales orders. For your second operation here, you now have a query you can run to list all sales orders for a customer.
