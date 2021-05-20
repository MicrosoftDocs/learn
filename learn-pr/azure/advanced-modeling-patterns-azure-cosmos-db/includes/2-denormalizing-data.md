## Modeling the product entities

In this section, we are going to look at our product table from our relational database and model it for a NoSQL database. We are also going to look at the Many : Many relationship our Product table has with ProductTags.

:::image type="content" source="../media/2-product-model.png" alt-text="Diagram that shows the relationship between the product and product tags entities." border="false":::

Our initial model for Product only includes the fields from our relational table. However, our e-commerce application needs to display the product tags when we display a product page. We also will want to query for products by product tags that can be accommodated in one of two ways. We can store products in a product tags container or we could embed our tags in the product container.

Given there are far fewer tags per product than products per tags, it makes more sense to embed the product tags in the product table. There is a 1 : few relationship between each product and tags so this makes it a good candidate for embedding. We will also store our product data with embedded tags in our new product container. So our new product model will look like this.

:::image type="content" source="../media/2-product-tags-model-container.png" alt-text="Diagram that shows the relationship between the product and product tags entities but also includes a product container where we haven't yet picked a partition key" border="false":::

## Selecting a partition key

Next we will select a partition key for the product container. Again, we need to look at the operations to be performed to decide on a partition key. Our operations are, create a product and edit a product. As customers navigate the e-commerce site, they will often do so by product category. This requires a query that filters products to display by `categoryId`. In order to make this a single-partition query with all products by category, we will use `categoryId` as our partition key for our product container.

:::image type="content" source="../media/2-product-container-categoryid.png" alt-text="Diagram with our product container with a partition key of `categoryId` that includes a list of all operations we need to perform and a SQL statement for our List all products from a category and groups of documents for each `categoryId` to represent each logical partition." border="false":::

So `categoryId` is a good partition key that will allow us to retrieve all products in a category efficiently. Embedding tag IDs also allows us get the ID's in our Many : Many relationship between products and tags as well. However, when we query for products, I not only need the product data but I also want to display the category name and the tag names as well. How can we return the category name for each product, and the names for the product tags when we query for products?

In order to achieve this, we need to run the following queries:

- Query product container to return all the products in a category.
- Query productCategory container to return the product category's name.
- Then for every product returned by the first query, run a third query on productTag container to get each product tag's name.

:::image type="content" source="../media/2-product-category-and-tags-queries.png" alt-text="A diagram of the product, product category, and product tags containers with each of the queries we need to run to satisfy our list all products from a category operation." border="false":::

## Denormalizing product entities

Now running all these queries above could work for us. However, it is not very scalable. Remember that in a NoSQL database there are no joins between containers so these are not an option for us. Also remember, for a NoSQL database, the objective is to reduce the number of requests by modeling data such that all the data needed by the application can be fetched in as few requests as possible.

The solution for us is to *denormalize* our data. With denormalization, we are able to optimize our data models to make sure that all the required data for our application is ready to be served by our queries.

To denormalize our data here, we will add more properties including the name of the category and the name for each tag in our tags array. By doing this, we now are able to retrieve all of the data we need to return to our clients in just a single request.

:::image type="content" source="../media/2-product-denormalized.png" alt-text="Diagram showing our product container its partition key of `categoryId` and our fully modeled product document schema with category name denormalized as well as our fully denormalized product tag array" border="false":::