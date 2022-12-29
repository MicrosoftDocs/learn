In this exercise, you'll measure the difference for customer entities when you model entities as separate containers versus when you model for a NoSQL database by embedding entities in a single document.

## Set up the environment

In Azure Cloud Shell, copy and paste the following commands.

```bash
git clone https://github.com/MicrosoftDocs/mslearn-model-partition-data-azure-cosmos-db.git
cd mslearn-model-partition-data-azure-cosmos-db
bash init-sandbox.sh
cd modeling
dotnet build
dotnet run --load-data
```

These commands:

1. Clone a GitHub repository.
1. Run a script that creates a new Azure Cosmos DB account.
1. Build and start the app that you use to populate the database and complete the exercises.

After pasting the commands, be sure to press <kbd>Enter</kbd> so that the final command is executed and the data is loaded.

This process should take less than 10 minutes to complete.

## Measure performance of entities in separate containers

In Database-v1, data is stored in individual containers. In that database, run queries to get the customer, customer address, and customer password. Review the request charge for each of those queries.

### Query for customer entity

In Database-v1, run a query to get the customer entity and review the request charge.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) by using the same account that you activated the sandbox with.
1. On the Azure portal menu, or from the **Home** page, select **Azure Cosmos DB**.
1. Select the Azure Cosmos DB account with the name that starts with **cosmicworks**.
1. Select **Data Explorer** on the left side.
1. Expand **database-v1**.
1. Select the **customer** container.
1. At the top of the screen, select **New SQL Query**.
1. Copy and paste the following SQL text and then select **Execute Query**.

    ```sql
    SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"
   ```

1. Select the **Query Stats** tab and note the request charge of 2.83 RUs.

    :::image type="content" source="../media/5-customer-query-v1.png" alt-text="Screenshot that shows the query stats for customer query in the database.":::

### Query for customer address

Run a query to get the customer address entity and review the request charge.

1. Select the **customerAddress** container.
1. At the top of the screen, select **New SQL Query**.
1. Copy and paste the following SQL text and then select **Execute Query**.

    ```sql
    SELECT * FROM c WHERE c.customerId = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"
   ```

1. Select the **Query Stats** tab and note the request charge of 2.83 RUs.

    :::image type="content" source="../media/5-customer-address-query-v1.png" alt-text="Screenshot that shows the query stats for customer address query in the database.":::

### Query for customer password

Run a query to get the customer password entity and review the request charge.

1. Select the **customerPassword** container.
1. At the top of the screen, select **New SQL Query**.
1. Copy and paste the following SQL text and then select **Execute Query**.

    ```sql
    SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"
   ```

1. Select the **Query Stats** tab and note the request charge of 2.82 RUs.

    :::image type="content" source="../media/5-customer-password-query-v1.png" alt-text="Screenshot that shows the query stats for customer password query in the database.":::

### Add up the request charges

Now that we've run all of our queries, let's add up all of the Request Unit costs for them.

|**Query**|**RU/s cost**|
|---------|---------|
|Customer|2.83|
|Customer Address|2.83|
|Customer Password|2.82|
|**Total RU/s**|**8.48**|

## Measure performance of embedded entities

Now we're going to query for the same information but with the entities embedded in a single document.

1. Select the **database-v2** database.
1. Select the **customer** container.
1. Run the following query.

    ```sql
    SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"
   ```

1. Observe that the data coming back is now a hierarchy of customer, address, and password data.

    :::image type="content" source="../media/5-customer-query-v2.png" alt-text="Screenshot that shows the query results for customer in the database.":::

1. Select **Query Stats**. Note the request charge of 2.83 RUs, versus the 8.48 RUs for the three queries that you ran earlier.

## Compare the performance of the two models

When you compare the RU/s for each query that you ran, you see that the last query where the customer entities are in a single document is much less expensive than the combined cost for running the three queries independently. The latency for returning this data is lower because the data is returned in a single operation.

When you're searching for a single item and know the partition key and ID of the data, you can retrieve this data via a *point-read* by calling `ReadItemAsync()` in the Azure Cosmos DB SDK. A point-read is even faster than our query. For the same customer data, the cost is just 1 RU/s, which is a nearly threefold improvement.
