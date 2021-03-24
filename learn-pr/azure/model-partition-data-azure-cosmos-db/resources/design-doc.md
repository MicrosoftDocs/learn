# Title

Model and partition your data in Azure Cosmos DB

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

## Summary

Identify key access patterns for a sample e-commerce application. Define the data model for each of the entities, containers to store the data with a partition key that will result in an efficient and scalable data store for this e-commerce application.

## Learning objectives

- Determine access patterns for data
- Apply data model and partitioning strategies to support an efficient and scalable NoSQL database

1. **Introduction**

    Scenario:

    Imagine that you work for a retail startup that's designing a database to manage online orders. You're working on a proposal for an efficient database design. You've been given a relational model to start from. To improve scalability and performance, you want to migrate the model to noSQL. But to do so the data needs to be modeled correctly to realize the best efficiency and performance.

    This is the model you will be starting from. The relational model has nine entities each in their own table.

    :::image type="content" source="../media/full-relational-model.png" alt-text="relational model for our application":::

1. **What's the difference between NoSQL and relational databases?**

    Azure Cosmos DB is a NoSQL database. In general, NoSQL databases are characterized as being both horizontally scalable and non-relational.

    Relational databases typically grow by increasing the size of the VM or compute they are hosted on. NoSQL databases, scale by adding additional servers to store increasing amounts of data. Data stored on additional servers needs to be organized so that it can be accessed later. Simply put data is partitioned by identifying a property of the document that will be used to route the it to the correct server. This property is known as a partition key and the servers are referred to as partitions. To ensure the most efficient operations, the partition key is passed with the data to route to the correct partition to be read or written.

    While this may appear to be constraining when accessing data, it has some enormous benefits. Typically an un-sharded relational databases can only grow to 4 TB in size. However, a NoSQL database can grow to unlimited size. It also does so without any change in response times when accessing data from a single partition. This means a NoSQL database can provide the same latency whether the database is 1 MB in size or 1 PB in size. Additionally, as partitions are added, so too is additional throughput capacity, meaning the amount of processing that can occur simultaneously grows as well.

    The second defining characteristic of a NoSQL database is there are no foreign keys, constraints, joins or enforced relationships of any kind between data that spans partitions. Since data in a NoSQL database is stored on different physical servers, enforcing constraints or relationships by placing locks on data could result in negative or unpredictable performance. Azure Cosmos DB is designed to provide high and predictable performance so does not put any locks on data. However, you can manage relational data and relationships in Azure Cosmos DB. It just uses different mechanisms to do it.

    :::image type="content" source="../media/horizontal-scale-non-relational.png" alt-text="horizontal scale and non-relational":::

    Understanding how the economics of computing has changed since relational databases were first introduced to today can help explain why these two types of databases are so different.

    When relational database was invented in 1970 the cost of storage relative to compute was relatively high. This is one reason why normalization seeks to reduce duplicate data within a database. Today the cost of storage relative to compute is cheap. Compute is expensive and it is compute which processes requests on data. For this reason, the objective when modeling data for a NoSQL database is read or write data in a compute efficient manner. Since relational operators like joins don't exist in a NoSQL database, data must be stored such as the application uses it. This often means data needs to be denormalized, duplicated or otherwise stored in a way that breaks most design goals for normalized data storage.

    At this point you may be wondering whether NoSQL databases are appropriate to use for relational workloads. And the answer is yes! NoSQL databases can absolutely be used for workloads where relationships between different entities exist. NoSQL databases are often used when a relational database cannot meet the desired performance or availability needs.

    The techniques used to design for a NoSQL database are very different than modeling data for a relational database. They are also not very intuitive. Best practices learned building for relational databases do not translate well and are often anti-patterns when designing for a NoSQL database.

    For the remainder of this module and in the advanced modeling module following this, we will go step by step demonstrating the techniques to model data that will result in a high-performance NoSQL database.

   **Knowledge check:**
   - What is the maximum size for a NoSQL database? (100GB, 4TB, 80TB, infinite)
   - What is the primary objective when designing a data model for a NoSQL database? (optimizing for storage, optimizing for compute, optimizing for both, none of the above)

1. **Identify access patterns for the app**

    The objective when designing a data model for a NoSQL database is to ensure operations on data are done in the fewest number of requests. To do this we need to understand the relationships between the data as well as how data will be accessed. The access patterns are important because it, along with the relationships, will determine how and where data is stored in Azure Cosmos DB.

    Let's start with the customer entities in our e-commerce database. Below there are three different entities and the relationships between them. The three entities are, Customer, CustomerAddress and CustomerPassword. Our Customer entity has a 1:Many  relationship to CustomerAddress and Customer has a 1:1 relationship to CustomerPassword.

    :::image type="content" source="../media/customer-relational-model.png" alt-text="relational model for customer entities":::

    In our application, there are three operations we will perform on the Customer entities.
    - **Create a customer**: When a new user first visits the e-commerce site a new customer will be created.
    - **Update a customer**: When an existing user updates their profile information their customer record will be updated.
    - **Retrieve a customer**: When an existing user visits the site, they login, requiring the password information. During that same session, they will need to access other customer data to purchase new items such as address.

    For each of these operations we need all this data at the same time. These entities could be modeled as separate documents but it would require multiple round trips to the server to create, update and retrieve the customer data.

    Azure Cosmos DB stores data as JSON, so we can model the 1:Many relationship between customer and customerAddress and embed the customer address data as an array. For the 1:1 relationship between customer and customerPassword, we can embed that as an object into our new single customer document. This will allow the e-commerce application to create, edit or retrieve customer data in a single request. Below is what our customer entity looks like.

    :::image type="content" source="../media/modeled-customer-document.png" alt-text="modeled customer document":::

1. **When to embed or reference data in a document**

    In the previous section we embedded the customer address and password data into a new customer document because it reduces the number of requests which improves performance and reduces cost. However you cannot always embed data. There are rules for when you should embed data in a document versus reference it in a different row.

    **When to embed**
      - *1:1 relationship*. For example, Customer and CustomerPassword have a 1:1 relationship.
      - *1:Few relationship*. In a NoSQL database it is necessary to distinguish 1:Many relationships as bounded or unbounded. Customer and CustomerAddress is a bounded 1:Many relationship because customers in an e-commerce application normally only have a handful of addresses to ship to. This is referred to as a 1:few relationship.
      - *Read or updated together*. In our scenario here, all of the customer entities are read or written together.

    **When to reference**
      - *1:Many relationship*. Especially if this relationship is unbounded. Azure Cosmos DB has a maximum document size of 2MB so in situations where the 1:Many relationship is unbounded or can grow extremely large, this is a scenario where data should be referenced, not embedded.
      - *Many:Many relationship*. We will explore an example of this later with Product Tags.
      - *Read or updated independently*. This is especially true with large documents. Updates in Cosmos DB require the entire item to be replaced. If a document has a small number of properties that are frequently updated alongside a large number of mostly static properties, it is much more efficient to shred the document into two, with one containing the smaller set of properties updated frequently, and another one that contains the static, unchanging values. This will reduce throughput consumption making it more efficient and reduce latency for better performance.

    **Knowledge check:**

    - When modeling data for a NoSQL database, unbounded 1:Many relationships should be: embedded in the same document, saved as separate rows and referenced, either is fine, none of the above.
    - Embedding data into the same document will: increase latency, reduce latency, increase latency and cost, reduce latency and cost.

1. **Exercise - Measure performance for the customer entities**

    Set up environment
    - Add steps to run scripts to create DB in sandbox subscription.

    In this exercise we will measure the difference for our new customer entities when we model data as a single document versus modeling them separately. In your sandbox open the Azure portal and find your Azure Cosmos DB account. Then open data explorer and expand **Database-v1**. For each of the containers listed below paste and execute the query listed. Then click the query stats to see how much RU/s was consumed for *each query* and keep a running total.

    - customer: `SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"`
    - customerAddress: `SELECT * FROM c WHERE c.customerId = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"`
    - customerPassword: `SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"`

    :::image type="content" source="../media/customer-query-v1.png" alt-text="query stats for customer v1 query":::

    Next navigate to the **Database-v2** database and in the customer container, run the following query.

    - customer: `SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"`

    First observe the data coming back is now a hierarchy of customer, address and password data. Next click on query stats and view the RU/s consumed to retrieve this data.

    :::image type="content" source="../media/customer-query-v2.png" alt-text="query results for customer v2 query":::

    As you can observe, the cost for this second query is much less expensive than the combined cost for running three queries independently. In addition, because this data is returned in a single operation, the latency for returning this data is also lower.

1. **Choosing a partition key**

    Azure Cosmos DB is a horizontally scalable database. Storage and throughput are increased by adding more physical servers (or partitions) to access and store data. The maximum storage size of a physical partition is 50 GB and the maximum throughput is 10,000 RU/s.

    :::image type="content" source="../media/physical-partitions.png" alt-text="physical partitions in Cosmos DB":::

    However, Cosmos DB abstracts this physical layer and introduces the concept of a logical partition that provides a uniform way to allow data from multiple partitions to be stored on the same physical server, as well as be moved around between servers or to new servers, as data grows. The maximum size for a logical partition is 20 GB.

    :::image type="content" source="../media/logical-partitions.png" alt-text="logical partitions":::

    A partition key provides a way to route data for a logical partition and is a property that exists within every document in your container that routes your data. A container is another abstraction and for all data stored with the same partition key. The partition key is defined when you create a container. In this example below the container has a partition key of `/username` so properties with the same value are stored in the same logical partition.

    :::image type="content" source="../media/container-partition-key.png" alt-text="create new container with partition key":::

   **Avoiding hot partitions**

    When modeling data for Azure Cosmos DB it is critically important the partition key chosen results in an even distribution of data and requests across partitions in your container. This is especially true when containers grow very large. If the design for a NoSQL database is not tested under load during development, a poor choice for partition key may not be revealed until the application is in production and significant data has been written. When data is not partitioned correctly, it can result in what is called "hot partitions" and can occur on both storage as well as throughput, preventing your database from being able to scale.

    **Storage**

    Containers in Azure Cosmos DB can have an unlimited number of logical partitions. However, each logical partition in Azure Cosmos DB cannot grow any larger than 20 GB. So it is important that the partition key provides high enough cardinality to avoid this 20 GB limit.

    A hot partition on storage occurs when you have a partition key that results in highly asymmetric storage patterns. As an example, consider a multi-tenant application that uses tenantId as it's partition key with three tenants, A, B and B. Tenants A and B are very small. Tenant C is massive and quickly hits the 20 GB limit for it's partition. In this scenario we need a different partition key that will spread the storage across more logical partitions.

    :::image type="content" source="../media/hot-partition-storage.png" alt-text="storage hot partition":::

    **Throughput**

    Throughput also can suffer from hot partitions. This occurs when most or all of the requests go to the same logical partition.

    Here as well it is important to understand the access patterns for your application to ensure that requests are spread as evenly as possible across partition key values. When throughput is provisioned in Azure Cosmos DB, it is allocated evenly across all the physical (and thus logical) partitions within a container.

    As an example, if you have a container with 30K RU/s, this would be spread across the 3 physical partitions for the same three tenants above. So each tenant gets 10K RU/s. If tenant C consumes all of it’s 10K RU/s it will be rate limited as it cannot consume the throughput allocated to the other partitions. This results in poor performance for tenant C and unused compute capacity for the other tenants. Ultimately, this partition key results in a database design that cannot scale.

    :::image type="content" source="../media/hot-partition-throughput.png" alt-text="throughput hot partition":::

    When data and requests are spread evenly, this ensures that as the database grows, it will do so in a way that best utilizes both the storage and throughput fully. This will result in the best possible performance and highest efficiency. In short, the database design will scale.

    :::image type="content" source="../media/partitions-even.png" alt-text="partitions even":::

    **Considerations for reads versus writes**

    There is one additional consideration that needs to be understood when choosing a partition key and that is whether the data is read heavy versus write heavy. For a write heavy data, you should seek to distribute data with a partition key that has high cardinality. For read-heavy workloads you want to ensure queries are answered with one or a bounded number of partitions. In scenarios where the data is both write and read heavy there is a solution. We will explore this in the next module.

    In a read heavy workload, the way to ensure you read data from a single partition is to use the partition key property in an equality filter on the WHERE clause for your queries. In this illustration below we have a container that is partitioned by username. With a query like the one below, we are assured this query will only hit a single logical partition so it's performance will always be good.

    :::image type="content" source="../media/in-partition-query.png" alt-text="in partition query":::

    However a query that filtered on a different property, such as favoriteColor would "fan out" to all partitions in the container. This is also known as a cross-partition query. Such a query will work fine when the container is small and only occupies a single partition. However, as the container grows larger with more and more physical partitions, this query will become slower and more expensive because it will need to check more and more partitions to get the results.

    :::image type="content" source="../media/cross-partition-query,png.png" alt-text="cross partition query":::

    **Choosing partition key for customers**

    Now that we have all this new knowledge about partitioning in Azure Cosmos DB we can now decide on a partition key for our customer data. As we covered earlier there are three operations we perform on customers: create a customer, update a customer, and retrieve a customer. In this case we will retrieve the customer by it's *id* and since that operation will be called the most, it makes sense to make the customer's id the partition key for the container.

    :::image type="content" source="../media/customer-partition-key.png" alt-text="customer partition key":::

    You may worry here that making the id the partition key means that we will have as many logical partitions as there are customers with each logical partition containing only a single document. Millions of customers, would result in millions of logical partitions.

    But this is perfectly fine! Logical partitions are a virtual concept and there is no upper limit to have many logical partitions you can have. Azure Cosmos DB will co-locate multiple logical partitions on the same physical partition. As logical partitions grow in size, Cosmos DB will move them to different physical partitions when needed.

    :::image type="content" source="../media/single-document-per-partition.png" alt-text="single document per partition":::

    **Knowledge check**

    - When choosing a partition key we want to avoid hot partitions that can occur for: storage, throughput, both.
    - When designing for write-heavy workloads you want to distribute writes across: as many partition key values as possible, as few partition keys as possible, both, neither.

1. **Modeling small lookup tables**

    Our relational model includes two small tables, ProductCategory and ProductTag that are reference tables used to lookup values then joined with other tables in a 1:Many relationship. For categories we will model the data with it's id and name columns as properties and put it into a new container called `productCategory`. Next we need to choose a partition key. Let's explore the operations we need to perform on this data. First we need to create a new product category, then edit a product category and finally we need to list all product categories. Creating and editing product categories are not frequently run operations. Our e-commerce application will however frequently list all product categories when customers visit our web site. So the last operation is the one we will run the most.

    The query for this last operation will look like this one below. Even though we want to try to optimize read-heavy operations to be single-partition this one is cross-partition. The data for product category will never grow near 20 GB in size. However, we are going to model this data in a way that will result in a single partition query to list all product categories. But we are doing this for a different reason which will be explained a bit later.

    :::image type="content" source="../media/product-category-model.png" alt-text="product category model":::

    The technique we are going to apply here is to add a *discriminator property* to our schema and give it a constant value for every document in our container. The name for our new property will be called, `type` and  the value set to "category" for each document. The container can now be created with a partition key of `type`.

    :::image type="content" source="../media/product-category-model-type.png" alt-text="product category model type":::

    Next up in our relational model is ProductTag. This table is nearly identical in function to product category. We will take the same approach here and model the id, name properties as well as create a discriminator property called `type` with a constant value of "tag". We will create a new container called, `productTag` and make `type` the new partition key.

    :::image type="content" source="../media/product-tag-model.png" alt-text="product tag model":::

    Most people find this technique for modeling small lookup tables strange. However, by modeling our data this way, it gives us an opportunity to make a further optimization which we will do in the next module.

    **Knowledge check**

    - When modeling small lookup tables in a NoSQL database, if the amount of data is small, designing for in-partition queries will: Improve performance, reduce performance, have no impact.
    - The technique of using a discriminator property when modeling small tables involves adding a new property and adding a value that: is a random value for each new row, is the same for each new row, is an incremental value for each new row.

1. **Summary**

    In this module we've started the process of taking a relational database and modeling it for a NoSQL database. We've designed the three customer entities and embedded all three into a single document, which resulted in an increase in performance by reducing the number of requests for our data. We have also modeled the product category and product tag entities and leveraged a unique technique to reduce overall storage and throughput required for small lookup tables.

## Notes

To learn more about these concepts in Azure Cosmos DB, see:

-[Understanding the differences between NoSQL and relational databases](https://docs.microsoft.com/azure/cosmos-db/relational-nosql)

-[Data modeling in Azure Cosmos DB](https://docs.microsoft.com/azure/cosmos-db/modeling-data)

-[How to model and partition data on Azure Cosmos DB using a real-world example](https://docs.microsoft.com/azure/cosmos-db/how-to-model-partition-example)

-[Partitioning and horizontal scaling in Azure Cosmos DB](https://docs.microsoft.com/cosmos-db/partitioning-overview)

-[Partitioning strategy and provisioned throughput costs](https://docs.microsoft.com/azure/cosmos-db/optimize-cost-throughput#partitioning-strategy-and-provisioned-throughput-costs)
