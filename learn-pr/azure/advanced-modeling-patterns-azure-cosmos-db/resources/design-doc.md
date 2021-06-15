# Title

Optimize your database by using advanced modeling patterns for Azure Cosmos DB

## Role(s)

- developer
- solution architect

## Level

- intermediate

## Product(s)

- Azure Cosmos DB

## Prerequisites

- Familiarity with Azure Cosmos DB concepts like databases, containers, documents and throughput (RU/s)
- Familiarity navigating Azure Cosmos DB resources and data using Data Explorer in Azure Portal, running queries, viewing query stats in results
- Familiarity with basic modeling and partitioning strategies like embedding or referencing data in entities
- Familiarity with Azure Cosmos DB .NET SDK v3
- Familiarity with Azure Cosmos DB Change Feed

## Summary

Identify strategies to manage relationships between data entitles like customers and sales data. Improve performance and scaling of your data model by pre-aggregating  and denormalizing data. Use Change Feed to maintain referential integrity of your data.

## Learning objectives

- Manage relationship between data entities by using advanced modeling and partitioning strategies
- Maintain referential integrity of your data by using Change Feed
- Implement pre-aggregating and denormalizing data strategies to improve performance and scaling of your data model

1. **Introduction**

    Imagine that you work for a retail startup that's designing a database to manage online orders. You're working on a proposal for an efficient database design. You've been given a relational model to start from. To improve scalability and performance, you want to migrate the model to noSQL. But to do so the data needs to be modeled correctly to realize the best efficiency and performance. You've modeled most of the entities so far but there are additional entities and further optimizations to make.

1. **Denormalizing data in your model**

    In this section we are going to look at our product table from our relational database and model it for a NoSQL database. While we do this we are also going to look at the Many:Many relationship our Product table has with ProductTags.

    :::image type="content" source="../media/product-model.png" alt-text="product model":::

    Our initial model for Product just includes the fields from our relational table. However, our e-commerce application needs to display the product tags when we display a product page. We also will want to be able to query for products by product tags. This can be accommodated in one of two ways. We can store products in a product tags container or we could embed our tags in the product container.

    Given there are far fewer tags per product than products per tags, it makes more sense to embed the product tags in the product table. There is a 1:few relationship between each product and tags so this makes it a good candidate for embedding. We will also store our product data with embedded tags in our new product container. So our new product model will look like this.

    :::image type="content" source="../media/product-tags-model-container.png" alt-text="product tags model container":::

    Next we will select a partition key for the product container. Again, we need to look at the operations to be performed to decide on a partition key. This includes created and edit a product. As customers navigate the e-commerce site they will often do so by product category. This requires a query that filters products to display by category id. In order to make this a single-partition query with all products by category we will use `categoryId` as our partition key for our product container.

    :::image type="content" source="../media/product-container-categoryId.png" alt-text="product container with category id":::

    So `categoryId` is a good partition key that will allow us to retrieve all products in a category very efficiently and embedding tag ids allows us get the id's in our Many:Many relationship between products and tags easily. However, when we query for products, I not only need the product data but I also want to display the category name and we also need to display the tag names as well. How can we return the category name for each product, as well as the names for the product tags when we query for products?

    In order to achieve this we first need to do the following:
    - Run our original query to return products for a category.
    - Run a second query to return the product category's name.
    - Then for every product returned by the first query, run a third query to get each product tag's name.

    :::image type="content" source="../media/product-category-and-tags-queries.png" alt-text="product category and tags queries":::

    Now this could work for us. However, it is not very scalable. Remember that in a NoSQL database there are no joins between containers so these are not an option for us. Also remember, for a NoSQL database, the objective is to reduce the number of requests by modeling data such that all the data needed by the application can be fetched in as few requests as possible.

    The solution for us is to *denormalize* our data. With denormalization we are able to optimize our data models to make sure that all the required data for our application is ready to be served by our queries.

    To denormalize our data here we will add additional properties including the name of the category as well as the name for each tag in our tags array. By doing this we now are able to retrieve all of the data we need to return to our clients in just a single request.

    :::image type="content" source="../media/product-denormalized.png" alt-text="product denormalized":::

    1. **Exercise - Set up environment and measure performance and cost when denormalizing data**

    Set up environment
    - Add steps to run scripts to create DB in sandbox subscription.

    In this exercise we will compare the cost of running individual queries to return all the data needed for all products in a category with the cost of running a single query that returns all of the products for a single category with the data de-normalized to return everything we need in a single request.

    In your sandbox open the Azure portal and find your Azure Cosmos DB account. Then open data explorer and expand **database-v2**. For each of the containers listed, click on New SQL Query, then paste and execute the query below. Next, click the query stats to see how much RU/s was consumed for *each query* and keep a running total.

    Note: The query for productTag needs to be run three times for each of the products returned.

    - **product**: `SELECT * FROM c where c.categoryId = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"`
    - **productCategory**: `SELECT * FROM c where c.type = 'category' and c.id = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"`
    - **productTag**: `SELECT * FROM c where c.type = 'tag' and c.id IN 
    ('A34D34F7-3286-4FA4-B4B0-5E61CCEEE197', 'BA4D7ABD-2E82-4DC2-ACF2-5D3B0DEAE1C1', 'D69B1B6C-4963-4E85-8FA5-6A3E1CD1C83B')`
    - **productTag**: `SELECT * FROM c where c.type = 'tag' and c.id IN ('87BC6842-2CCA-4CD3-994C-33AB101455F4', 'F07885AF-BD6C-4B71-88B1-F04295992176')`
    - **productTag**: `SELECT * FROM c where c.type = 'tag' and c.id IN ('18AC309F-F81C-4234-A752-5DDD2BEAEE83', '1B387A00-57D3-4444-8331-18A90725E98B', 'C6AB3E24-BA48-40F0-A260-CB04EB03D5B0', 'DAC25651-3DD3-4483-8FD1-581DC41EF34B', 'E6D5275B-8C42-47AE-BDEC-FC708DB3E0AC')')`

    Next, navigate to **database-v3** in Data Explorer and click on the product container. Then click on New SQL Query, then paste and run the following query and measure it's RU/s.

    - **product**: `SELECT * FROM c where c.categoryId = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"`

    :::image type="content" source="../media/product-query-v2.png" alt-text="product query in exercise":::

1. **Manage referential integrity by using Change feed**

    In the last section we showed how denormalizing data can drastically improve performance and lower cost by providing the data needed by our e-commerce application in a single request. However when data is denormalized like this we need a way to maintain referential integrity between the master data in the productCategory and productTag containers and the product container.

    :::image type="content" source="../media/product-category-tag-sync.png" alt-text="product category tag sync":::

    Luckily Cosmos DB has a feature that can manage this called, Change Feed. Change Feed is an API that lives within every Cosmos DB container. Whenever data is inserted or updated to Cosmos DB, Change Feed streams these changes to an API that you can listen to. Then when an event is triggered, you can use that to execute code to respond to the data that was changed. In our e-commerce application here, we would use Change Feed to listen to the productCategory and propagate changes to the product container. Then have a second Change Feed listening to the productTag container and doing the same thing.

    :::image type="content" source="../media/change-feed.png" alt-text="change feed":::

    1. **Exercise - Manage referential integrity** (Why we're doing it + what we're doing)

    In this exercise we will show how Change Feed can maintain referential integrity between two containers in Azure Cosmos DB. This scenario will involve the following steps:

    **To Do: Will complete this when the exercise is written**

    - Describe the flow here:
        - Query the products to get a count of products.
        - Then Update the product category name.
        - See Change Feed pick up the name change.
        - Update the product table.
        - Query products again to get a count of products in that category with new name.

    - Show the code that updates the product category container.
    - Show the change feed code that listens to the product category container.
    - Show the code that updates the product container.

1. **Combine different entities in same container**

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

1. **Denormalizing aggregates in same container**

    There is one last operation we need to look at before our new model is complete. Our last operation is to query our top 10 customers by the number of sales orders. In our current model we first need to do a group by on each customer and sum for sales orders in our customer container, then sort in descending order and take the top 10 results. Even though customers and sales orders sit in the same container, this is not something you can currently do.

    The solution here is to denormalize and create a new property in the customer document, 'salesOrderCount'. This will allow us to now write a query like this one below to get this data.

    :::image type="content" source="../media/sales-order-count.png" alt-text="sales order count by customer":::

    Next we now need a way where every time a customer creates a new sales order and a new sales order is inserted into our customer container, we update the customer document and increment the salesOrderCount property by one. To do this we need a transaction. Azure Cosmos DB supports transactions when the data sits within the same logical partition. Since the customer and sales order all reside in the same logical partition we can take advantage of this and put the insert of the new sales order and update of the customer document within a transaction. There are two choices for implementing transactions in Azure Cosmos DB, stored procedures or using a feature called Transactional Batch available in both .NET or Java SDKs.

    :::image type="content" source="../media/sales-order-customer-transaction.png" alt-text="sales order and customer transaction":::


    1. **Exercise - Denormalizing aggregates and Transactions**

    In this exercise we will create a new sales order and update the 'salesOrderCount' property in the customer container using Transactional Batch.

    **To Do: Will complete this when the exercise is written**

    - Describe the flow here:
        - Query the customer container for a customer id and return the customer object and all their sales orders. Inspect the value for 'salesOrderCount'.
        - Also show how when querying for multiple entities we deserialize into a dynamic type and then inspect the 'type' property to determine which POCO to deserialize our data into.
        - Start a new sales order by doing a point read for a customer that will create a new sales order for.
        - Call customer.salesOrderCount++ to increment its value.
        - Create a new sales order object and add a couple of products to it.
        - Call transactional batch with an insert for the new sales order and update on the customer.
        - Query the customer container again using the first query to see the updated 'salesOrderCount' value and the newly added sales order.
        - Optionally, can also show how this works if the customer cancels the sales order by showing Transactional Batch with an update and delete.

1. **Finalize the data model**

    As illustrated below, both productCategory and productTag share the same partition key, type. When data shares the same partition key, it is possible for the entities to be stored in a single container.

    In our model we will make a further design change and store the data from productCategory and productTag into a new container called productMeta. When we query for each type we will use the type property to distinguish between the two entities and now that there is a filter for these queries, they are both single-partition. One last benefit is if our design evolves in the future to include other look up data, we do not need to create new containers. We can simply use the same one and the data can have any schema it needs as long as it uses the same type property.

1.  **Finalize the data model**

    We are nearly complete remodeling our database. So far we've created the following containers, taking our original nine relational database tables and made into four containers for our NoSQL database. There is our customer container which contains our customer and sales order data. A product container that contains our products and Many:Many product tags and a container for product tag and product category.

    :::image type="content" source="../media/design-near-final.png" alt-text="near final design":::

    There is one final optimization though we could make. Notice that both productCategory and productTag share the same partition key? As you may have guessed, because they share the same partition key, we can also put these into the same contain and give it a more generic name like 'productMeta'.

    Now we can use queries like these to get all of our product tags and our product categories. In fact, this pattern works for any kind of master or reference data you need to maintain. With Change Feed monitoring this new container. Any change can be routed to specific functions by inspecting the 'type' property when the new data is recognized by Change Feed, to maintain referential integrity across the entire database.

    Here then is our final design. With the merging of the product categories and tags we have gone from nine relational tables to just three containers. All of them optimized to serve our e-commerce application efficiently and with the ability to scale to any size we need.

    :::image type="content" source="../media/design-final.png" alt-text="design final":::

1.  **Summary**

    At the beginning of the first module we started with a relational database model that had nine tables. Throughout both of the modules we learned about the importance of understanding the usage patterns for data for determining how to model and partition data. We also explored when you would embed versus reference data in a NoSQL model. We explored partitioning, and made sure data was partitioned to ensure both requests and storage were even and high volume queries were served by one logical partition, allowing for infrequently run queries to run as cross partition. We demonstrated how using features like Change Feed can help maintain referential integrity across containers and transactions can be used to materialize aggregates for in-partition data.

    All of these concepts and techniques explored in both of the modules for this lab ensure that our final database design is efficient in terms of compute and can scale as either the size of the database grows or the amount of throughput is increased to handle a higher volume of operations.

## Notes

To learn more about these concepts in Azure Cosmos DB, see:

-[Understanding the differences between NoSQL and relational databases](https://docs.microsoft.com/azure/cosmos-db/relational-nosql)

-[Data modeling in Azure Cosmos DB](https://docs.microsoft.com/azure/cosmos-db/modeling-data)

-[How to model and partition data on Azure Cosmos DB using a real-world example](https://docs.microsoft.com/azure/cosmos-db/how-to-model-partition-example)

-[Change Feed in Azure Cosmos DB](https://docs.microsoft.com/azure/cosmos-db/change-feed)

-[Transactional batch operations in Azure Cosmos DB using the .NET SDK](https://docs.microsoft.com/azure/cosmos-db/transactional-batch)
