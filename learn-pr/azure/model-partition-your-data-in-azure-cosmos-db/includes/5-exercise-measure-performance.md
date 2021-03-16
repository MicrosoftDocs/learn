In this exercise, we will measure the difference for our new customer entities when we model data as a single document versus modeling them separately. 

## Set up environment

Add steps to run scripts to create DB in sandbox subscription and populate the data.

## Review performance of Database-v1

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.
1. On the Azure portal menu, or from the **Home** page, select **Azure Cosmos DB**.
1. **Add steps to navigate to data explorer**.
1. Expand **Database-v1**.
1. For each of the containers listed below paste and execute the query listed. 

    - customer: `SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"`
    - customerAddress: `SELECT * FROM c WHERE c.customerId = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"`
    - customerPassword: `SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"`

    :::image type="content" source="../media/customer-query-v1.png" alt-text="query stats for customer v1 query":::
1. Then click the query stats to see how much RU/s was consumed for *each query* and keep a running total.

## Review performance of Database-v2

1.  Select **Database-v2** database and in the customer container, run the following query.

    - customer: `SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"`

First observe the data coming back is now a hierarchy of customer, address and password data. Next click on query stats and view the RU/s consumed to retrieve this data.

    :::image type="content" source="../media/customer-query-v2.png" alt-text="query results for customer v2 query":::

As you can observe, the cost for this second query is much less expensive than the combined cost for running three queries independently. In addition, because this data is returned in a single operation, the latency for returning this data is also lower.