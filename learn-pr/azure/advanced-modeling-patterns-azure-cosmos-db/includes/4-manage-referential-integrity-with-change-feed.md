In the last unit, you saw how denormalizing data can drastically improve performance and lower RU cost by providing the data needed by your e-commerce application in a single request. However, when data is denormalized like this, you need a way to maintain referential integrity between the primary data in the productCategory and productTag containers, and the product container.

:::image type="content" source="../media/4-product-category-tag-sync.png" alt-text="Diagram showing how data from a product category and product tag is denormalized and stored in the product container." border="false":::

Fortunately, Azure Cosmos DB has a feature called *change feed* that can manage referential integrity. Change feed is an API that lives within every Azure Cosmos DB container. Whenever you insert or update to Azure Cosmos DB, the change feed feature streams these changes to an API that you can listen to. When an event is triggered, you can use change feed to execute code that responds to the changed data.

In your e-commerce application, you would use change feed to listen to the productCategory and propagate changes to the product container. Then, a second change feed listens to the productTag container and does the same thing.

:::image type="content" source="../media/4-change-feed.png" alt-text="Diagram of change feed responding to changes in the productCategory and productTag containers and copying them to the product container to keep it in sync." border="false":::
