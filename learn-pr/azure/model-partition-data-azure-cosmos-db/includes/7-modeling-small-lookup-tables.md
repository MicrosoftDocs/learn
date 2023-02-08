Our relational model includes two small tables, `ProductCategory` and `ProductTag`. These reference tables are used to look up values and are then joined with other tables in a 1:Many relationship. 

:::image type="content" source="../media/7-product-relational-model.png" alt-text="Diagram that shows the relationship of the product category, product, product tags, and product tag tables." border="false":::

In this unit, we'll model `ProductCategory` and `ProductTag` tables.

## Model product categories

For categories, we'll model the data with its ID and name columns as properties and put it in a new container called `ProductCategory`.

Next we need to choose a partition key. Let's explore the operations that we need to perform on this data. 

We'll create a new product category, edit a product category, and then list all product categories. Creating and editing product categories aren't frequently run operations. But our e-commerce application will often list all product categories when customers visit the website. So the last operation is the one we'll run the most.

The query for this last operation will look like the following one. Even though we want to try to optimize read-heavy operations to have a single partition, this one is cross-partition. The data for product category will never grow near 20 GB in size. However, we're modeling this data in a way that will result in a single partition query to list all product categories. But we're doing this for a different reason that will be explained a bit later.

:::image type="content" source="../media/7-product-category-model.png" alt-text="Diagram that shows the cross-partition query for listing all product categories." border="false":::

The technique we're applying here is to add a *discriminator property* to our schema and give it a constant value for every document in the container. The name for the new property is `type`, and the value is `category` for each document. The container can now be created with a partition key of `type`.

:::image type="content" source="../media/7-product-category-model-type.png" alt-text="Diagram that shows the product category modeled with the partition key as type and the value as category." border="false":::

## Model product tags

Next up in our relational model is `ProductTag`. This table is nearly identical in function to `ProductCategory`. Let's take the same approach here and model the ID, name properties, and create a discriminator property called `type` with a constant value of `tag`. Let's create a new container called `ProductTag` and make `type` the new partition key.

:::image type="content" source="../media/7-product-tag-model.png" alt-text="Diagram that shows the modeled product tag container with the partition key as type and the value as tag." border="false":::

Some people find this technique for modeling small lookup tables strange. However, modeling our data this way gives us an opportunity to make a further optimization in the next module.
