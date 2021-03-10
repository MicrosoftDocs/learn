We're nearly done modeling our database for our e-commerce application. We will next look at the sales order entities to demonstrate the next concept.

Just like with the other entities we want to look at our operations and then make a decision on whether to embed or reference our related data. In this scenario sales order details makes a great candidate for embedding because the items in the order is not unbounded and also the data is always inserted and read together. So we will embed this as an array within our sales order entity and we will store our data in a new container called, salesOrder.

    :::image type="content" source="../media/sales-order-model.png" alt-text="sales order model":::

Next we will decide upon a partition key. Since we will always search for sales order by customer, customer id makes a suitable partition key for our container. This will give us single partition query for an operation that will be run frequently, even with additional filters to narrow down which orders the customer wants to view.

    :::image type="content" source="../media/sales-order-partition-key.png" alt-text="sales order partition key":::

At this point we've modeled all of our relational entities for our NoSQL database. So let's look at where we can make further optimizations.

One thing you may have noticed with the salesOrder container is that it shares the same partition key as the customer container. The customer container has a partition key of id and salesOrder has a partition key of customerId. When data share the same partition key and have similar access patterns they are candidates for being stored in the same container. As a NoSQL database, Azure Cosmos DB is schema agnostic so mixing entities with completely different schema is not only possible, under these conditions it is another best practice. But combine the data from these two containers we will need to make some additional changes in our schema.

    :::image type="content" source="../media/sales-orders-customers.png" alt-text="sales orders and customers":::

First we need to add a customerId property to each customer document. Customers will now have the same value for id and customerId. Next, we need a way to distinguish a sales order from a customer in the container. So we will add a "type" property that has a value of 'customer' and 'salesOrder' for each entity.

    :::image type="content" source="../media/sales-orders-customers-query.png" alt-text="sales orders query":::

With those changes we can now store both the customer and sales order data in our new customer container. Each customer is in its own logical partition and will have one customer item with all of their sales orders. For our second operation here we now have a query we can run to list all sales orders for a customer.

**Knowledge check**

- When characteristics must entities share that make them good candidates to store in the same container?
        - a. Same partition key
        - b. Similar access patterns
        - c. Same schema
        - d. A and B
        - e. All of the above
    
- When mixing entities into the same container, what is required to distinguish the different entities when querying them?
        - a. A different id
        - b. It's not possible. You have to look at the query results.
        - c. A 'type' property with a static value per entity.
