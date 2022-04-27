You've nearly finished remodeling your database. You've transformed nine relational database tables into four containers for your NoSQL database. Your customer container contains your customer and sales order data. The product container contains your products and many-to-many product tags. And the other two are the productTag and productCategory containers.

:::image type="content" source="../media/9-design-near-final.png" alt-text="Diagram that shows the near final database design.":::

## One final optimization

There's one final optimization you could make. Have you noticed that the productCategory and productTag containers share the same partition key? As you might have guessed, because they share this key, you can put both entities into the same container and give it a more generic name, such as productMeta.

Now you can use queries like the ones you've learned about earlier to get all your product tags and product categories. This pattern works for any kind of master or reference data you need to maintain. Because all of this data is in the same container, you can also use just a single host for Change Feed to maintain referential integrity across the entire database, rather than one for each individual container. Any change that comes in to change feed for any entity can then be routed to a corresponding function by inspecting the type property when the new data is read by change feed. This provides for more efficient usage of compute for change feed as well as efficient storage for the data.

:::image type="content" source="../media/9-product-meta.png" alt-text="Diagram that shows the productCategory and productTag containers combined into a single container called productMeta.":::

## Your final design

Here then is your final design. With the merging of the product categories and tags, you've gone from nine relational tables to just three containers. Each one is optimized to serve your e-commerce application efficiently and scale to any size you need.

:::image type="content" source="../media/9-design-final.png" alt-text="Diagram of the final design of three containers: customer with customer and sales order data, product container, and product meta with product categories and product tags.":::
