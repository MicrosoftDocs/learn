## Maintaining referential integrity between entities

In the last section we showed how denormalizing data can drastically improve performance and lower cost by providing the data needed by our e-commerce application in a single request. However when data is denormalized like this, we need a way to maintain referential integrity between the master data in the productCategory and productTag containers and the product container.

:::image type="content" source="../media/4-product-category-tag-sync.png" alt-text="Diagram showing how data from product category and product tag is denormalized and stored in the product container" border="false":::

## Introducing Change Feed

Luckily, Cosmos DB has a feature that can manage this called, Change Feed. Change Feed is an API that lives within every Cosmos DB container. Whenever data is inserted or updated to Cosmos DB, Change Feed streams these changes to an API that you can listen to. Then when an event is triggered, you can use that to execute code to respond to the data that was changed. In our e-commerce application here, we would use Change Feed to listen to the productCategory and propagate changes to the product container. Then have a second Change Feed listening to the productTag container and doing the same thing.

:::image type="content" source="../media/4-change-feed.png" alt-text="Diagram showing Change Feed responding to changes in both the product category and product tag containers and copying those changes to the product container to keep it in sync." border="false":::
