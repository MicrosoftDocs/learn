As illustrated below, both productCategory and productTag share the same partition key, type. When data shares the same partition key, it is possible for the entities to be stored in a single container.

In our model we will make a further design change and store the data from productCategory and productTag into a new container called productMeta. When we query for each type we will use the type property to distinguish between the two entities and now that there is a filter for these queries, they are both single-partition. One last benefit is if our design evolves in the future to include other look up data, we do not need to create new containers. We can simply use the same one and the data can have any schema it needs as long as it uses the same type property.

## Finalize the data model

We are nearly complete remodeling our database. So far we've created the following containers, taking our original nine relational database tables and made into four containers for our NoSQL database. There is our customer container which contains our customer and sales order data. A product container that contains our products and Many:Many product tags and a container for product tag and product category.

:::image type="content" source="../media/design-near-final.png" alt-text="near final design" border="false":::

There is one final optimization though we could make. Notice that both productCategory and productTag share the same partition key? As you may have guessed, because they share the same partition key, we can also put these into the same contain and give it a more generic name like 'productMeta'.

Now we can use queries like these to get all of our product tags and our product categories. In fact, this pattern works for any kind of master or reference data you need to maintain. With Change Feed monitoring this new container. Any change can be routed to specific functions by inspecting the 'type' property when the new data is recognized by Change Feed, to maintain referential integrity across the entire database.

Here then is our final design. With the merging of the product categories and tags we have gone from nine relational tables to just three containers. All of them optimized to serve our e-commerce application efficiently and with the ability to scale to any size we need.

:::image type="content" source="../media/design-final.png" alt-text="design final" border="false":::
