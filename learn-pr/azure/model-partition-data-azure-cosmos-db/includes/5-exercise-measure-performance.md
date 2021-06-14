In this exercise, you will measure the difference for our customer entities when we model entities as separate containers versus when we model for a NoSQL database where we embed entities in a single document.

## Set up environment

In Cloud Shell, copy and paste the following commands. These commands clone a GitHub repository, run a script which create a new Cosmos DB account, then build and start the app you use to populate the database and complete the exercises. This should take less than 10 minutes to complete.

```bash
git clone https://github.com/MicrosoftDocs/mslearn-model-partition-data-azure-cosmos-db.git
cd mslearn-model-partition-data-azure-cosmos-db
bash init-sandbox.sh
cd modeling
dotnet build
dotnet run --load-data
```

## Review query performance of entities in separate containers

In the Database-v1, where data is stored in individual containers, run queries to get the customer, customer address, and customer password. Review the request charge for each of those queries.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.
1. On the Azure portal menu, or from the **Home** page, select **Azure Cosmos DB**.
1. Select the Cosmos DB account with the name that starts with **cosmicworks**.
1. Select on **Data Explorer** on left-hand side.
1. Expand **Database-v1**.
1. Select the **customer** container.
1. At top of screen, select **New SQL Query**
1. Copy and paste the following SQL text and select **Execute Query**.

    ```sql
    SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"
   ```

1. Select the **Query Stats** tab to see how much RU/s was consumed.
1. Note the **Value** for **Request Charge**.
1. Select the **customerAddress** container.
1. At top of screen, select **New SQL Query**
1. Copy and paste the following SQL text and select **Execute Query**.

    ```sql
    SELECT * FROM c WHERE c.customerId = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"
   ```

1. Select the **Query Stats** tab to see how much RU/s was consumed.

    :::image type="content" source="../media/5-customer-query-v1.png" alt-text="Screenshot that shows the query stats results for customer address in the database v1.":::
1. Note the **Value** for **Request Charge**.
1. Select the **customerPassword** container.
1. At top of screen, select **New SQL Query**
1. Copy and paste the following SQL text and select **Execute Query**.

    ```sql
    SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"
   ```

1. Select the **Query Stats** tab to see how much RU/s was consumed.

## Review query performance of embedded entities

In the Database-v2, where the data is embedded into a single document, run a query to get the customer, customer address, and customer password data. Review the request charge for the query.

1. Select **Database-v2** database.
1. Select the **customer** container.
1. Run the following query.

    ```sql
    SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"
   ```

1. Observe that the data coming back is now a hierarchy of customer, address, and password data.

    :::image type="content" source="../media/5-customer-query-v2.png" alt-text="Screenshot that shows the query results for customer in the database v2.":::

1. Select the **Query Stats**.
1. Note the value of the **Value** for **Request Charge**.

## Compare the performance of the two models

When you compare the request charge (RU/s) for each of the queries you ran, you see that the last query where the customer entities are in a single document is much less expensive than the combined cost for running the three queries independently. Also the latency for returning this data is lower because the data is returned in a single operation.
