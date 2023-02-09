
In this exercise, you'll compare storing and accessing data in a relational model, where data is stored in individual containers, with storing data in a NoSQL scenario, where the data is denormalized and stored in a single container.

The returned data is typical for a webpage that's returned to a user who selects a product category. The data includes the name of the category, all the products in that category, and all the product tags for each of the products.

## Set up the environment

In Azure Cloud Shell, run the following commands. The commands clone a GitHub repository, run a script that creates a new Azure Cosmos DB account, and then build and start the app you use to populate the database and complete the exercises. The build should take less than 10 minutes to finish.

```bash
git clone https://github.com/MicrosoftDocs/mslearn-model-partition-data-azure-cosmos-db.git
cd mslearn-model-partition-data-azure-cosmos-db
bash init-sandbox.sh
cd modeling
dotnet build
dotnet run --load-data
```

## Query for the product category name

In the **database-v2** container, where data is stored in individual containers, run a query to get the product category name, and then view the request charge for that query.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the same account you used to activate the sandbox.
1. On the left pane, select **Azure Cosmos DB**.
1. Select the Azure Cosmos DB account with the name that starts with **cosmicworks**.
1. On the left pane, select **Data Explorer**.
1. Expand **database-v2**.
1. Select the **productCategory** container.
1. At the top of the page, select **New SQL Query**.
1. On the **Query 1** pane, paste the following SQL code, and then select **Execute Query**.

    ```sql
    SELECT * FROM c where c.type = 'category' and c.id = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"
    ```

1. Select the **Results** tab to review the results. You see that this query returns the name of the product category, "Components, Headsets."

    :::image type="content" source="../media/3-product-category-results.png" alt-text="Screenshot that shows the results of the query to the product category container.":::

1. Select the **Query Stats** tab, and note the request charge of 2.93 RUs (request units).

    :::image type="content" source="../media/3-product-category-stats.png" alt-text="Screenshot of the query stats for the query you ran in Data Explorer.":::

## Query for the products in the category

Next, query the product container to get all the products in the "Components, Headsets" category.

1. Select the **product** container.
1. At the top of the page, select **New SQL Query**.
1. On the **Query 2** pane, paste the following SQL code, and then select **Execute Query**.

    ```sql
    SELECT * FROM c where c.categoryId = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"
    ```

1. Select the **Results** tab to review the results. You see there are three products returned, HL Headset, LL Headset, and ML Headset. Each product has a SKU, name, price, and an array of product tags.

1. Select the **Query Stats** tab, and note the request charge of 2.9 RUs.

    :::image type="content" source="../media/3-product-results.png" alt-text="Screenshot of Azure Cosmos DB Data Explorer that shows the results of the query to the product container.":::

## Query for each product's tags

Next, query the productTag container three times, once for each of the three products: HL Headset, LL Headset, and ML Headset.

### HL headset tags

First, run a query to return the tags for HL Headset.

1. Select the **productTag** container.
1. At the top of the page, select **New SQL Query**.
1. On the **Query 3** pane, paste the following SQL code, and then select **Execute Query**.

    ```sql
    SELECT * FROM c where c.type = 'tag' and c.id IN ('87BC6842-2CCA-4CD3-994C-33AB101455F4', 'F07885AF-BD6C-4B71-88B1-F04295992176')
    ```

    This query returns the two tags for the HL Headset product.

1. Select the **Query Stats** tab, and note the request charge of 3.06 RUs.

    :::image type="content" source="../media/3-product-tag-hl-stats.png" alt-text="Screenshot of the results of the query to the product tag container for hl headsets query stats.":::

### LL headset tags

Next, run a query to return the tags for LL Headset.

1. Select the **productTag** container.
1. At the top of the page, select **New SQL Query**.
1. On the **Query 4** pane, paste the following SQL code, and then select **Execute Query**.

    ```sql
    SELECT * FROM c where c.type = 'tag' and c.id IN ('18AC309F-F81C-4234-A752-5DDD2BEAEE83', '1B387A00-57D3-4444-8331-18A90725E98B', 'C6AB3E24-BA48-40F0-A260-CB04EB03D5B0', 'DAC25651-3DD3-4483-8FD1-581DC41EF34B', 'E6D5275B-8C42-47AE-BDEC-FC708DB3E0AC')
    ```

    This query returns the five tags for the LL Headset product.

1. Select the **Query Stats** tab, and note the request charge of 3.47 RUs.

    :::image type="content" source="../media/3-product-tag-ll-stats.png" alt-text="Screenshot of the results of the query to the product tag container for 'LL Headset' query stats.":::

### ML headset tags

Last, run a query to return the tags for ML Headset.

1. Select the **productTag** container.
1. At the top of the page, select **New SQL Query**.
1. On the **Query 5** pane, paste the following SQL code, and then select **Execute Query**.

    ```sql
    SELECT * FROM c where c.type = 'tag' and c.id IN ('A34D34F7-3286-4FA4-B4B0-5E61CCEEE197', 'BA4D7ABD-2E82-4DC2-ACF2-5D3B0DEAE1C1', 'D69B1B6C-4963-4E85-8FA5-6A3E1CD1C83B')
    ```

    This query returns the three tags for the ML Headset product.

1. Select the **Query Stats** tab, and note the request charge of 3.2 RUs.

    :::image type="content" source="../media/3-product-tag-ml-stats.png" alt-text="Screenshot of the results of our query to the product tag container for 'ML Headset' query stats.":::

## Add up the RU charges

Now, let's add up all the RU costs from each of the queries you ran.

| Query | RU cost |
| - | - | 
| Category name | 2.93 |
| Product | 2.9 | 
| HL product tags | 3.06 |
| LL product tags | 3.47 |
| ML product tags | 3.2 |
| **Total RU cost** | **15.56** |
| | |

## Run the same queries for your NoSQL design

Let's query for the same information but in the denormalized database.

1. In Data Explorer, select **database-v3**.
1. Select the **product** container.
1. At the top of the page, select **New SQL Query**.
1. On the **Query 6** pane, paste the following SQL code, and then select **Execute Query**.

    ```sql
   SELECT * FROM c where c.categoryId = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"
   ```

    The results will look something like the following screenshot:

    :::image type="content" source="../media/3-product-query-v2.png" alt-text="Screenshot of the results of the query to the product container in the newly modeled product container." lightbox="../media/3-product-query-v2.png":::

1. Review the data that's returned in this query. It contains all the information you need to render the products for this category, including the category name and tag names for each of the three products.

1. Select the **Query Stats** tab, and note the request charge of 2.9 RUs.

## Compare the performance of the two models

In the relational model, where data is stored in individual containers, you ran five queries to get the name of the category, all the products for that category, and all the product tags for each of the products. The request charge for the five queries totaled 15.56 RUs. 

To get the same information in the NoSQL model, you ran one query, and its request charge was 2.9 RUs.

The benefit isn't just the lower cost of a NoSQL design like this model. This type of design is also faster, because it requires only a single request. Further, the data is served in the way that it's likely to be rendered on a webpage. This means less code to write and maintain downstream in your e-commerce application.

When you denormalize data, you produce simpler, more efficient queries for your e-commerce application. You can store all the data that's needed by your application in a single container, and you can fetch it with a single query. When you're dealing with high-concurrency queries, this type of data modeling can provide huge benefits in simplicity, speed, and cost.
