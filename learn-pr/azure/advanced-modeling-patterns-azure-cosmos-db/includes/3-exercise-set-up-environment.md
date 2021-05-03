

In this exercise, we will compare the cost of running individual queries to return all the data needed for all products in a category with the cost of running a single query that returns all of the products for a single category with the data de-normalized to return everything we need in a single request.

## Set up environment

Add steps to create Cosmos DB account in sandbox subscription and populate the data.
<!--See example on how to write this section:
https://docs.microsoft.com/learn/modules/monitor-and-scale-cosmos-db/3-setup

See this other unit for comparing operations:
https://docs.microsoft.com/learn/modules/monitor-and-scale-cosmos-db/4-metrics
-->


## Get RU/s for database-v2 model

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.
1. On the Azure portal menu, or from the **Home** page, select **Azure Cosmos DB**.
1. **Add steps to navigate to data explorer**.
1. Expand **Database-v2**.
1. For each of the containers listed, click on New SQL Query, then paste and execute the query below. Next, click the query stats to see how much RU/s was consumed for *each query* and keep a running total.<!--Break these out into discrete steps for each of the containers. E.g. Select the product container > New SQL Query. Run the following command. -->

    The query for productTag needs to be run three times for each of the products returned. <!--I don't understand what you mean by this so be sure to make this a discrete step in the ordered list of steps.-->

- **product**: `SELECT * FROM c where c.categoryId = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"`
- **productCategory**: `SELECT * FROM c where c.type = 'category' and c.id = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"`
- **productTag**: `SELECT * FROM c where c.type = 'tag' and c.id IN 
    ('A34D34F7-3286-4FA4-B4B0-5E61CCEEE197', 'BA4D7ABD-2E82-4DC2-ACF2-5D3B0DEAE1C1', 'D69B1B6C-4963-4E85-8FA5-6A3E1CD1C83B')`
- **productTag**: `SELECT * FROM c where c.type = 'tag' and c.id IN ('87BC6842-2CCA-4CD3-994C-33AB101455F4', 'F07885AF-BD6C-4B71-88B1-F04295992176')`
- **productTag**: `SELECT * FROM c where c.type = 'tag' and c.id IN ('18AC309F-F81C-4234-A752-5DDD2BEAEE83', '1B387A00-57D3-4444-8331-18A90725E98B', 'C6AB3E24-BA48-40F0-A260-CB04EB03D5B0', 'DAC25651-3DD3-4483-8FD1-581DC41EF34B', 'E6D5275B-8C42-47AE-BDEC-FC708DB3E0AC')')`

## Compare RU/s between database models

1. In Data Explorer, select **database-v3**.
1. Select the product container > **New SQL Query**.
1. Run the following query.

- **product**: `SELECT * FROM c where c.categoryId = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"`

    :::image type="content" source="../media/3-product-query-v2.png" alt-text="product query in exercise":::

1. Select **Query Stats**.
1. Review the **Value for Request Charge**.
<!--Add steps around what field they should be looking at and comparing against previous results.-->