In this exercise, we will measure the difference for our customer entities when we model entities as separate containers versus when we model for a NoSQL database by embedding entities as 

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

## Measure performance of entity per container

First we will query customer entities in our database with three separate queries.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.
1. On the Azure portal menu, or from the **Home** page, select **Azure Cosmos DB**.
1. Select the Cosmos DB account with the name that starts with, **cosmicworks**.
1. Click on **Data Explorer** on left-hand side.

### Query for customer entity

1. Expand **Database-v1**.
1. Select the **customer** container.
1. At top of screen, click **New SQL Query**
1. Copy and past the following sql text and click **Execute Query**.

    ```sql
    SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"
   ```

1. Select the **Query Stats** tab and note the request charge of 2.83.

:::image type="content" source="../media/5-customer-query-v1.png" alt-text="Screenshot that shows the query stats for customer query in the database v1.":::

### Query for customer address

1. Select the **customerAddress** container.
1. At top of screen, click **New SQL Query**
1. Copy and past the following sql text and click **Execute Query**.

    ```sql
    SELECT * FROM c WHERE c.customerId = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"
   ```

1. Select the **Query Stats** tab and note the request charge of 2.83.

    :::image type="content" source="../media/5-customer-address-query-v1.png" alt-text="Screenshot that shows the query stats for customer address query in the database v1.":::

### Query for customer password

1. Select the **customerPassword** container.
1. At top of screen, click **New SQL Query**
1. Copy and past the following sql text and click **Execute Query**.

    ```sql
    SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"
   ```

1. Select the **Query Stats** tab and note the request charge of 2.83.

:::image type="content" source="../media/5-customer-password-query-v1.png" alt-text="Screenshot that shows the query stats for customer password query in the database v1.":::

### Adding up RU/s charges

Now that we've run all of our queries, let's add up all of the RU/s cost for them.

|**Query**|**RU/s Cost**|
|Customer|2.83|
|Customer Address|2.83|
|Customer Password|2.83|
|**Total RU/s**|**8.49**|

## Measure performance of embedding entities in a single document

Now we're going to query for the same information but with our entities embedded into a single document.

1. Select **Database-v2** database.
1. Select the **customer** container.
1. Run the following query.

    ```sql
    SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"
   ```

1. Observe that the data coming back is now a hierarchy of customer, address, and password data.

    :::image type="content" source="../media/5-customer-query-v2.png" alt-text="Screenshot that shows the query results for customer in the database v2.":::

1. Select on the **Query Stats** and note the request charge of 2.83, versus the 8.49 RU/s for the three queries we ran earlier.
1. However, it's not just the cost that is less with a NoSQL design like this. This type of design is also faster because it only requires a single request.
1. Lastly, because we are only searching for a single item and know the partition key and id of the data we can retrieve this data via a *point-read* using the Cosmos DB SDK by calling `ReadItemAsync()`. This is even faster than our query and for the same customer data the cost is just 1 RU/s; a nearly three-fold improvement.

## Compare the performance of the two models

When you compare the request charge (RU/s) for each of the queries you ran, you see that the last query where the customer entities are in a single document is much less expensive than the combined cost for running the three queries independently. The latency for returning this data is lower because the data is returned in a single operation and when data can be returned as a single item, it allows you to achieve even greater efficiency by issuing a *point-read* using the Cosmos DB SDK.
