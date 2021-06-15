Our relational model includes two small tables, ProductCategory and ProductTag. These tables are reference tables used to look up values then joined with other tables in a 1:Many relationship. 

:::image type="content" source="../media/7-product-relational-model.png" alt-text="Diagram that shows the relationship of the product category, product, product tags, and product tag tables." border="false":::

In this unit, we'll model ProductCategory and ProductTag tables.

## Model product categories

For categories, we will model the data with its ID and name columns as properties and put it into a new container called `productCategory`.

Next we need to choose a partition key. Let's explore the operations we need to perform on this data. First we need to create a new product category, then edit a product category and finally we need to list all product categories. Creating and editing product categories are not frequently run operations. Our e-commerce application will however frequently list all product categories when customers visit our web site. So the last operation is the one we will run the most.

The query for this last operation will look like this one below. Even though we want to try to optimize read-heavy operations to be single-partition, this one is cross-partition. The data for product category will never grow near 20 GB in size. However, we are going to model this data in a way that will result in a single partition query to list all product categories. But we are doing this for a different reason that will be explained a bit later.

:::image type="content" source="../media/7-product-category-model.png" alt-text="Diagram that shows the cross partition query for listing all product categories." border="false":::

The technique we are going to apply here is to add a *discriminator property* to our schema and give it a constant value for every document in our container. The name for our new property will be called, `type` and  the value set to "category" for each document. The container can now be created with a partition key of `type`.

:::image type="content" source="../media/7-product-category-model-type.png" alt-text="Diagram that shows the product category modeled with the partition key as type and type = category." border="false":::

## Model product tag

Next up in our relational model is ProductTag. This table is nearly identical in function to product category. We will take the same approach here and model the ID, name properties and create a discriminator property called `type` with a constant value of "tag". We will create a new container called `productTag` and make `type` the new partition key.

:::image type="content" source="../media/7-product-tag-model.png" alt-text="Diagram that shows the modeled product tag container with the partition key as type and type = tag. " border="false":::

Most people find this technique for modeling small lookup tables strange. However, by modeling our data this way, it gives us an opportunity to make a further optimization that we will do in the next module.
