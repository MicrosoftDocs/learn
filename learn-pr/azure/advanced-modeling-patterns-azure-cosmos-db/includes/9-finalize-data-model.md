We are nearly complete in remodeling our database. We've taken nine relational database tables and transformed them into four containers for our NoSQL database. There is our customer container, which contains our customer and sales order data. A product container that contains our products and Many : Many product tags, and a container for product tag and product category.

:::image type="content" source="../media/9-design-near-final.png" alt-text="Diagram that shows the near final database design." border="false":::

## One final optimization

There is one final optimization we could make though. Notice that both productCategory and productTag share the same partition key? As you may have guessed, because they share the same partition key, we can also put both entities into the same container and give it a more generic name like 'productMeta'.

Now we can use queries like the ones shown to get all of our product tags and product categories. This pattern works for any kind of master or reference data you need to maintain. To maintain referential integrity across the entire database, Change Feed monitors this new container. So any change can be routed to specific update functions by inspecting the `type` property when the new data is read by Change Feed.

:::image type="content" source="../media/9-product-meta.png" alt-text="Diagram that shows product category and product tag containers combined into a single container called product meta.":::

## Our final design

Here then is our final design. With the merging of the product categories and tags, we have gone from nine relational tables to just three containers. All of them optimized to serve our e-commerce application efficiently and with the ability to scale to any size we need.

:::image type="content" source="../media/9-design-final.png" alt-text="Diagram with the final design of three containers: customer with customer and sales order data, product container, and product meta with product categories and product tags." border="false":::
