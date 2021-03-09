Set up environment
    - Add steps to run scripts to create DB in sandbox subscription.

In this exercise we will measure the difference for our new customer entities when we model data as a single document versus modeling them separately. In your sandbox open the Azure portal and find your Azure Cosmos DB account. Then open data explorer and expand **Database-v1**. For each of the containers listed below paste and execute the query listed. Then click the query stats to see how much RU/s was consumed for *each query* and keep a running total.

    - customer: `SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"`
    - customerAddress: `SELECT * FROM c WHERE c.customerId = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"`
    - customerPassword: `SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"`

    :::image type="content" source="../media/customer-query-v1.png" alt-text="query stats for customer v1 query":::

Next navigate to the **Database-v2** database and in the customer container, run the following query.

    - customer: `SELECT * FROM c WHERE c.id = "FFD0DD37-1F0E-4E2E-8FAC-EAF45B0E9447"`

First observe the data coming back is now a hierarchy of customer, address and password data. Next click on query stats and view the RU/s consumed to retrieve this data.

    :::image type="content" source="../media/customer-query-v2.png" alt-text="query results for customer v2 query":::

As you can observe, the cost for this second query is much less expensive than the combined cost for running three queries independently. In addition, because this data is returned in a single operation, the latency for returning this data is also lower.