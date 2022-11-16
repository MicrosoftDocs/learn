In the last exercise, you used the `join` operator to find the total sales per product. In this exercise, you'll use the `lookup` operator to find the total sales per country.

## Use the `lookup` operator

Your sales team wants to know total sales per country. You could use a join to get the customer and product information. However, this kind of query performs best when using the `lookup` operator to get the information you need. Recall that the `lookup` operator enriches a fact table with data from a dimensions table. It's a bit like reading a book (fact table) and looking up unknown words in a dictionary (dimensions table).

For this query, you'll start with the *SalesFact* table and use the `lookup` operator to get *Customer* data and add it to the resultant table.

In the following steps, you'll build the query in stages so that you get a better understanding the result of using the `lookup` operator.

1. Run the following query to get 10 matching arbitrary rows from the *SalesFact* table and the *Customers* table. 

    <a href="https://dataexplorer.azure.com/clusters/help/databases/ContosoSales?query=H4sIAAAAAAAAAwtOzEktdktMLuGqUcjJz88uLVBwLi0uyc9NLSpWyM+Dc7xTK4EqShKzUxUMDQCq8uF9NQAAAA==" target="_blank">Run the query</a>

    ```kusto
    SalesFact
    | lookup Customers on CustomerKey
    | take 10
    ```

    Take a look at the resulting list. Notice that the resulting table contains columns from the *SalesFact* table followed by matching columns from the *Customers* table.

1. Run the following query to get the total sales per country.

    <a href="https://dataexplorer.azure.com/clusters/help/databases/ContosoSales?query=H4sIAAAAAAAAA03LPQqAMAwG0N1TZNRDOAkugoN6gViDiG0jSTtUPLztIo7fz5vRkvZoQvWAZT7jBV3UwI5Egf0XBkr5odE5lOMmWDignQuGFgxHH+oG1gQT7Qf7rhSSRnSUFctGUsYf2kjNC9nYPm18AAAA" target="_blank">Run the query</a>

    ```kusto
    SalesFact
    | lookup Customers on CustomerKey
    | summarize TotalSales = count() by RegionCountryName
    | order by TotalSales desc
    ```

    You should get results that look like the following image:

    :::image type="content" source="../media/5-lookup-1.png" alt-text="Screenshot of lookup operator with total sales per country query and results.":::

1. Take a look at the resulting list. You notice that the top sales are in the United States. Try modifying the query to show the total sales in the United States by state.

In the previous unit, you used a left outer join to get the total sales per product category. The query took 0.861 seconds to run. You'll now write a query to get the same result using the `lookup` operator and compare the execution time.

1. Run the following query.

    <a href="https://dataexplorer.azure.com/clusters/help/databases/ContosoSales?query=H4sIAAAAAAAAAwtOzEktdktMLuGqUcjJz88uLVAIKMpPKU0uKVbIz4OxvVMrgfLFpbm5iUWZVakKIfkliTnBIK0KtgrJ+aV5JRqaCkmVMOXOiSWp6flFlX6JualAfflFKalFIGkkbSmpxckAoEL9GXwAAAA=" target="_blank">Run the query</a>

    ```kusto
    SalesFact
    | lookup Products on ProductKey
    | summarize TotalSales = count() by ProductCategoryName
    | order by TotalSales desc
    ```

    You should get results that look like the following image:

    :::image type="content" source="../media/5-lookup-2.png" alt-text="Screenshot of lookup operator with total sales per product query and results.":::

1. Notice that you get the same results but the execution time is 0.398 second. The faster execution time is because the `lookup` operator is optimized for this type of query.
