Set up environment

    - Add steps to run scripts to create DB in sandbox subscription.

In this exercise we will compare the cost of running individual queries to return all the data needed for all products in a category with the cost of running a single query that returns all of the products for a single category with the data de-normalized to return everything we need in a single request.

In your sandbox open the Azure portal and find your Azure Cosmos DB account. Then open data explorer and expand **database-v2**. For each of the containers listed, click on New SQL Query, then paste and execute the query below. Next, click the query stats to see how much RU/s was consumed for *each query* and keep a running total.

> [!Note]
> The query for productTag needs to be run three times for each of the products returned.

    - **product**: `SELECT * FROM c where c.categoryId = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"`
    - **productCategory**: `SELECT * FROM c where c.type = 'category' and c.id = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"`
    - **productTag**: `SELECT * FROM c where c.type = 'tag' and c.id IN 
    ('A34D34F7-3286-4FA4-B4B0-5E61CCEEE197', 'BA4D7ABD-2E82-4DC2-ACF2-5D3B0DEAE1C1', 'D69B1B6C-4963-4E85-8FA5-6A3E1CD1C83B')`
    - **productTag**: `SELECT * FROM c where c.type = 'tag' and c.id IN ('87BC6842-2CCA-4CD3-994C-33AB101455F4', 'F07885AF-BD6C-4B71-88B1-F04295992176')`
    - **productTag**: `SELECT * FROM c where c.type = 'tag' and c.id IN ('18AC309F-F81C-4234-A752-5DDD2BEAEE83', '1B387A00-57D3-4444-8331-18A90725E98B', 'C6AB3E24-BA48-40F0-A260-CB04EB03D5B0', 'DAC25651-3DD3-4483-8FD1-581DC41EF34B', 'E6D5275B-8C42-47AE-BDEC-FC708DB3E0AC')')`

Next, navigate to **database-v3** in Data Explorer and click on the product container. Then click on New SQL Query, then paste and run the following query and measure it's RU/s.

    - **product**: `SELECT * FROM c where c.categoryId = "AB952F9F-5ABA-4251-BC2D-AFF8DF412A4A"`

    :::image type="content" source="../media/product-query-v2.png" alt-text="product query in exercise":::