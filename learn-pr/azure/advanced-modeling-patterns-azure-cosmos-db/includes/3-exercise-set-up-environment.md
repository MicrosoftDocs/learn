
In this exercise, you'll compare the difference between storing and accessing data in a relational model where data is stored in individual containers versus NoSQL where the data is denormalized and stored in a single container.

The data returned is typical for a web page returned to a user who selects a product category and will include the name of the category, all the products for that category, and all of the product tags for each of the products.

## Set up environment

In Cloud Shell, copy and paste the following commands. These commands clone a GitHub repository, run a script which creates a new Cosmos DB account, then builds and starts the app you use to populate the database and complete the exercises. The build should take less than 10 minutes to complete.

```bash
git clone https://github.com/MicrosoftDocs/mslearn-model-partition-data-azure-cosmos-db.git
cd mslearn-model-partition-data-azure-cosmos-db
bash init-sandbox.sh
cd modeling
dotnet build
dotnet run --load-data
```

## Query for the product category name

In the Database-v2, where data is stored in individual containers, run a query to get the product category name and view the request charge for that query.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.
1. On the Azure portal menu, or from the **Home** page, select **Azure Cosmos DB**.
1. Select the Cosmos DB account with the name that starts with, **cosmicworks**
1. Select **Data Explorer** on left-hand side.
1. Expand **Database-v2**.
1. Select **productCategory** container.
1. At top of screen, select **New SQL Query**
1. Copy and paste the following SQL text and select **Execute Query**.

    ```sql
    SELECT * FROM c where c.type = 'category' and c.id = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"
    ```

1. Review the results. You see that this query returns the name of the product category, "Component, Headsets".

    :::image type="content" source="../media/3-product-category-results.png" alt-text="Screenshot that shows the results of the query to the product category container.":::

1. Select **Query Stats** and note the request charge of 2.93 RUs.

    :::image type="content" source="../media/3-product-category-stats.png" alt-text="Screenshot of the query stats for the query you ran in the Data Explorer.":::

## Query for the products in the category

Next query the product container to get all of the products for the "Components, Headsets"category.

1. Select **product** container.
1. At top of screen, select **New SQL Query**
1. Copy and paste the followingSQL text and select **Execute Query**.

    ```sql
    SELECT * FROM c where c.categoryId = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"
    ```

1. Review the results. You see there are three products returned, "HL Headset", "LL Headset", and "ML Headset". Each product has a sku, name, price and an array of product tags.
1. Next select **Query Stats** and note the request charge of 2.9 RUs.

    :::image type="content" source="../media/3-product-results.png" alt-text="Screenshot of the Cosmos DB Data Explorer that shows the results of our query to the product container.":::

## Query for each product's tags

Next query the productTag container three times for each of the three products: "HL Headset", "LL Headset", and "ML Headset".

### HL headset tags

First, run a query to return the tags for "HL Headset".

1. Select the **productTag** container.
1. At top of screen, select **New SQL Query**
1. Copy and paste the followingSQL text and select **Execute Query**.

    ```sql
    SELECT * FROM c where c.type = 'tag' and c.id IN ('87BC6842-2CCA-4CD3-994C-33AB101455F4', 'F07885AF-BD6C-4B71-88B1-F04295992176')
    ```

    This query returns the two tags for the "HL Headset" product.
1. Next select **Query Stats** and note the request charge of 3.06 RUs.

    :::image type="content" source="../media/3-product-tag-hl-stats.png" alt-text="Screenshot of the results of our query to the product tag container for hl headsets query stats.":::

### LL headset tags

Next, run a query to return the tags for "LL Headset".

1. Select the **productTag** container.
1. Hover over the icons across the top until you see, **New SQL Query**, then select it.
1. Copy and paste the followingSQL text and select **Execute Query**.

    ```sql
    SELECT * FROM c where c.type = 'tag' and c.id IN ('18AC309F-F81C-4234-A752-5DDD2BEAEE83', '1B387A00-57D3-4444-8331-18A90725E98B', 'C6AB3E24-BA48-40F0-A260-CB04EB03D5B0', 'DAC25651-3DD3-4483-8FD1-581DC41EF34B', 'E6D5275B-8C42-47AE-BDEC-FC708DB3E0AC')
    ```

    This query returns the five tags for the "LL Headset" product.
1. Next select **Query Stats** and note the request charge of 3.47 RUs.

    :::image type="content" source="../media/3-product-tag-ll-stats.png" alt-text="Screenshot of the results of our query to the product tag container for ll query stats.":::

### ML headset tags

Last, run a query to return the tags for "ML Headset".

1. Select the **productTag** container.
1. Hover over the icons across the top until you see, **New SQL Query**, then select it.
1. Copy and paste the following SQL text and select **Execute Query**.

    ```sql
    SELECT * FROM c where c.type = 'tag' and c.id IN ('A34D34F7-3286-4FA4-B4B0-5E61CCEEE197', 'BA4D7ABD-2E82-4DC2-ACF2-5D3B0DEAE1C1', 'D69B1B6C-4963-4E85-8FA5-6A3E1CD1C83B')
    ```

    This query returns the three tags for the "ML Headset" product.
1. Next select **Query Stats** and note the request charge of 3.2 RUs.

    :::image type="content" source="../media/3-product-tag-ml-stats.png" alt-text="Screenshot of the results of our query to the product tag container for ml query stats.":::

## Add up the RU/s charges

Now, let's add up all of the RUs costs from each of the queries you ran.

|Query|RU/s Cost|
|-|-|
|Category Name|2.93|
|Products|2.9|
|HL Product Tags|3.06|
|LL Product Tags|3.47|
|ML Product Tags|3.2|
|**Total RU/s**|**15.56**|

## Run the same queries for our NoSQL design

Now you'll query for the same information but in the denormalized database.

1. In Data Explorer, select **database-v3**.
1. Select the **product** container.
1. Hover over the icons across the top until you see, **New SQL Query**, then select it.
1. Copy and paste the following SQL text and select **Execute Query**.

    ```sql
   SELECT * FROM c where c.categoryId = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"
   ```

    The results will look something like the following image.

    :::image type="content" source="../media/3-product-query-v2.png" alt-text="Screenshot of the results of our query to the product container in our newly modeled product container." lightbox="../media/3-product-query-v2.png":::

1. Review the data returned in this query. It contains all of the information needed to render the products for this category including the category name and tag names for each of the three products.
1. Select **Query Stats**.
1. Notice the request charge of 2.9 RUs.

## Compare the performance of the two models

In the relational model, where data is stored in individual containers, you ran five queries to get the name of the category, all the products for that category, and all of the product tags for each of the products. The request charge for the five queries totaled 15.56 RUs. To get the same information in the NoSQL model, you ran one query where the request charge was 2.9 RUs.

It's not just the cost that is less with a NoSQL design like this model. This type of design is also faster because it only requires a single request. Lastly, the data itself is served in the shape that it's likely to be rendered in on a web page. This means less code to write and maintain downstream in our e-commerce application.

When you denormalize data, you produce simpler, more efficient queries for your e-commerce application. All of the data needed by our application is stored in a single container and can be fetched with a single query. This type of data modeling can provide huge benefits in both simplicity, speed and cost when dealing with high concurrency queries.
