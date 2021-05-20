
# Compare relational versus NoSQL queries

In this exercise we are going to compare the difference between storing and accessing data in a relational model where data is stored in individual containers versus NoSQL where the data is denormalized and stored in a single container.

The data returned is typical for a web page returned to a user who clicks on a product category and will include the name of the category, all the products for that category, and all of the product tags for each of the products.

## Set up environment

In Cloud Shell copy and paste the following commands. These commands will clone a GitHub repository, run a script which will create a new Cosmos DB account, then build and start the app you will use to populate the database and complete the exercises. This should take less than 10 minutes to complete.

```bash
git clone https://github.com/MicrosoftDocs/mslearn-model-partition-data-azure-cosmos-db.git
cd mslearn-model-partition-data-azure-cosmos-db
bash init-sandbox.sh
cd modeling
dotnet build
dotnet run --load-data
```

## Querying for the product category name

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.
1. On the Azure portal menu, or from the **Home** page, select **Azure Cosmos DB**.
1. Select the Cosmos DB account with the name that starts with, **cosmicworks**
1. Click on **Data Explorer** on left-hand side.
1. Expand **Database-v2**.
1. Click on **productCategory** container.
1. At top of screen, click **New SQL Query**
1. Copy and paste the following sql text and click **Execute Query**.

    ```sql
    SELECT * FROM c where c.type = 'category' and c.id = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"
    ```

1. Looking at the results we can see this query returns the name of the product category, *Component, Headsets*, which will be displayed on the page returned to the user.

    :::image type="content" source="../media/3-product-category-results.png" alt-text="Cosmos DB Data Explorer showing the results of our query to the product category container":::

1. Next click on **Query Stats** and note the request charge of 2.93 RUs.

    :::image type="content" source="../media/3-product-category-stats.png" alt-text="Query stats for the query we just ran in Data Explorer":::

## Querying for the products in the category

Next we will query the product container to get all of the products for the *Components, Headsets* category.

1. Click on **product** container.
1. At top of screen, click **New SQL Query**
1. Copy and paste the following sql text and click **Execute Query**.

    ```sql
    SELECT * FROM c where c.categoryId = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"
    ```

1. Looking at the results we see there are three products returned, *HL Headset*, *LL Headset*, and *ML Headset*. Each product has a sku, name, price and an array of product tags.
1. Next click on **Query Stats** and note the request charge of 2.9 RUs.

    :::image type="content" source="../media/3-product-results.png" alt-text="Cosmos DB Data Explorer showing the results of our query to the product container":::

## Querying for each product's tags

Next we will query the productTag container three times for each of the three products returned in the first query. First is the query for the tags for *HL Headset*.

1. Click on **productTag** container.
1. At top of screen, click **New SQL Query**
1. Copy and paste the following sql text and click **Execute Query**.

    ```sql
    SELECT * FROM c where c.type = 'tag' and c.id IN ('87BC6842-2CCA-4CD3-994C-33AB101455F4', 'F07885AF-BD6C-4B71-88B1-F04295992176')
    ```

1. This query returns the two tags for the *HL Headset* product.
1. Next click on **Query Stats** and note the request charge of 3.06 RUs.

    :::image type="content" source="../media/3-product-tag-hl-stats.png" alt-text="Cosmos DB Data Explorer showing the results of our query to the product tag container for hl headsets query stats":::

Next we will query for the tags for *LL Headset*.

1. Click on **productTag** container.
1. Hover over the icons across the top until you see, **New SQL Query**, then click it.
1. Copy and paste the following sql text and click **Execute Query**.

    ```sql
    SELECT * FROM c where c.type = 'tag' and c.id IN ('18AC309F-F81C-4234-A752-5DDD2BEAEE83', '1B387A00-57D3-4444-8331-18A90725E98B', 'C6AB3E24-BA48-40F0-A260-CB04EB03D5B0', 'DAC25651-3DD3-4483-8FD1-581DC41EF34B', 'E6D5275B-8C42-47AE-BDEC-FC708DB3E0AC')
    ```

1. This query returns the two tags for the *LL Headset* product.
1. Next click on **Query Stats** and note the request charge of 3.47 RUs.

    :::image type="content" source="../media/3-product-tag-ll-stats.png" alt-text="Cosmos DB Data Explorer showing the results of our query to the product tag container for ll query stats":::

Last we will query for the tags for *ML Headset*.

1. Click on **productTag** container.
1. Hover over the icons across the top until you see, **New SQL Query**, then click it.
1. Copy and paste the following sql text and click **Execute Query**.

    ```sql
    SELECT * FROM c where c.type = 'tag' and c.id IN ('A34D34F7-3286-4FA4-B4B0-5E61CCEEE197', 'BA4D7ABD-2E82-4DC2-ACF2-5D3B0DEAE1C1', 'D69B1B6C-4963-4E85-8FA5-6A3E1CD1C83B')
    ```

1. This query returns the two tags for the *ML Headset* product.
1. Next click on **Query Stats** and note the request charge of 3.2 RUs.

    :::image type="content" source="../media/3-product-tag-ml-stats.png" alt-text="Cosmos DB Data Explorer showing the results of our query to the product tag container for ml query stats":::

## Adding up RU/s charges

Now that we've run all of our queries, let's add up all of the RUs costs from them.

|Query|RU/s Cost|
|-|-|
|Category Name|2.93|
|Products|2.9|
|HL Product Tags|3.06|
|LL Product Tags|3.47|
|ML Product Tags|3.2|
|**Total RU/s**|**15.56**|

## Same queries for our NoSQL design

Now we're going to query for the same information but in our denormalized database.

1. In Data Explorer, select **database-v3**.
1. click on the **product** container.
1. Hover over the icons across the top until you see, **New SQL Query**, then click it.
1. Copy and paste the following sql text and click **Execute Query**.

    ```sql
   SELECT * FROM c where c.categoryId = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"
   ```

1. The results will look something like the following image.

    :::image type="content" source="../media/3-product-query-v2.png" alt-text="Cosmos DB Data Explorer showing the results of our query to the product container in our newly modeled product container":::

1. Note the data returned in this query. It contains all of the information needed to render the products for this category including the category name and tag names for each of the three products.
1. Next click on **Query Stats** and note the request charge of 2.9 RUs versus the 15.56 RUs for the five queries we ran earlier.
1. However, it's not just the cost that is less with a NoSQL design like this. This type of design is also faster because it only requires a single request.
1. Lastly, the data itself is served in the shape that it is likely to be rendered in on a web page. This means less code to write and maintain downstream in our ecommerce application.

## Summary

In this exercise we showed how denormalizing data can produce simpler, more efficient queries for our e-commerce application. All of the data needed by our application is stored in a single container and can be fetched with a single query. This type of data modeling can provide huge benefits in both simplicity, speed and cost when dealing with high concurrency queries.
