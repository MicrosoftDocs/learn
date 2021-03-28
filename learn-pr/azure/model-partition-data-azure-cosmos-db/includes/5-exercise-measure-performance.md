In this exercise, we will measure the difference for our new customer entities when we model data as a single document versus modeling them separately. 

## Set up environment

Add steps to create Cosmos DB account in sandbox subscription and populate the data.

## Review performance of single document model

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.
1. On the Azure portal menu, or from the **Home** page, select **Azure Cosmos DB**.
1. **Add steps to navigate to data explorer**.
1. Expand **Database-v1**.
1. Select the **customer** container.
1. Run the following query.

    ```sql
    SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"
   ```

1. Select the **Query Stats** tab to see how much RU/s was consumed.
1. Make a note of the **Value** for **Request Charge**.
1. Select the **customerAddress** container.
1. Run the following query.

    ```sql
    SELECT * FROM c WHERE c.customerId = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"
   ```

1. Select the **Query Stats** tab to see how much RU/s was consumed.

    :::image type="content" source="../media/5-customer-query-v1.png" alt-text="Screenshot that shows the query stats results for customer address in the database v1.":::
1. Make a note of the **Value** for **Request Charge**.

## Review performance of separate documents model

1. Select **Database-v2** database.
1. Select the **customer** container.
1. Run the following query.

    ```sql
    SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"
   ```

1. Observe that the data coming back is now a hierarchy of customer, address and password data.

    :::image type="content" source="../media/5-customer-query-v2.png" alt-text="Screenshot that shows the query results for customer in the database v2.":::

1. Select on the **Query Stats**.
1. Make a note of the **Value** for **Request Charge**.

## Compare the performance of the two models

When you compare the request charge (RU/s) for each of the queries you ran, you see that the last query where the customer entities are in a separate document is much less expensive than the combined cost for running the three queries independently. Also the latency for returning this data is lower because the data is returned in a single operation.
