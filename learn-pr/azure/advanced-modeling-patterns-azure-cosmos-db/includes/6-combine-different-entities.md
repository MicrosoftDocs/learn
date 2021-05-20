## Modeling sales order entities

We're nearly done modeling our database for our e-commerce application. We will next look at the sales order entities to demonstrate the next concept.

Just like with the other entities we want to look at our operations and then make a decision on whether to embed or reference our related data. In this scenario sales order details makes a great candidate for embedding because the items in the order is not unbounded and also the data is always inserted and read together. So we will embed this as an array within our sales order entity and we will store our data in a new container called, salesOrder.

:::image type="content" source="../media/6-sales-order-model.png" alt-text="Diagram showing the relational model for sales orders and sales order detail tables with the new NoSQL model, also includes the list of operations we ned to perform, and finally a container with a question mark for its partition key as we have not chosen one yet" border="false":::

Next we will decide upon a partition key. Since we will always search for sales order by customer, customer id makes a suitable partition key for our container. This will give us single partition query for an operation that will be run frequently, even with additional filters to narrow down which orders the customer wants to view.

:::image type="content" source="../media/6-sales-order-partition-key.png" alt-text="Diagram with a sales order container and customer id as its partition key, a list of operations we need to perform with a call out for list all sales orders for a customer with an arrow to the query we will write for this operation, then a group of documents organized by customer id to represent the logical partition of customer id for this container" border="false":::

At this point we've modeled all of our relational entities for our NoSQL database. So let's look at where we can make further optimizations.

## Additional optimizations

One thing you may have noticed with the salesOrder container is that it shares the same partition key as the customer container. The customer container has a partition key of id and salesOrder has a partition key of customerId. When data share the same partition key and have similar access patterns they are candidates for being stored in the same container. As a NoSQL database, Azure Cosmos DB is schema agnostic so mixing entities with completely different schema is not only possible, under these conditions it is another best practice. But combine the data from these two containers we will need to make some additional changes in our schema.

:::image type="content" source="../media/6-sales-orders-customers.png" alt-text="Diagram showing the sales orders model and container and customer model and container with an arrow to a single customer container and customer id partition key with both the sales order and customer documents stored in it" border="false":::

First we need to add a customerId property to each customer document. Customers will now have the same value for id and customerId. Next, we need a way to distinguish a sales order from a customer in the container. So we will add a discriminator property we will call `type` that has a value of 'customer' and 'salesOrder' for each entity.

:::image type="content" source="../media/6-sales-orders-customers-query.png" alt-text="Diagram showing logical partitions with both sales order and customer documents stored within them, a customer container with customer id as its partition key and a new query that is required to now query for a sales order in the new customer container that shows the descriminator property, type with a value of sales order" border="false":::

With those changes we can now store both the customer and sales order data in our new customer container. Each customer is in its own logical partition and will have one customer item with all of their sales orders. For our second operation here we now have a query we can run to list all sales orders for a customer.
