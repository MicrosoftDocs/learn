In this exercise, you'll learn how to use the `join` operator. Recall that the `join` operator merges the rows of two tables by matching values of the specified columns from each table. 

You'll use the results of the `join` operator to answer questions about sales.

## Use the `join` operator

In our retail company scenario, your team is asking you to list the three countries/regions that have the most sales.

As you begin inspecting the *SalesFact* table, you notice that the figures you need are available in the **SalesAmount** column, but the table doesn't contain any country data. Examining the other tables, you notice that the country data is available in the **RegionCountryName** column in the *Customers* table. You also notice that both tables have a **CustomerKey** column.

Because the data is spread over two tables, you'll need both the customer data and the sales data to write a query that provides the requested information. To write the query, you use the `join` operator and the **CustomerKey** column to match the rows from both tables.

Now you're ready to write the query. You'll use an *inner* `join` to get all matching rows from both tables. For best performance, you'll use the customers *dimension* table as the left table and the sales *fact* table as the right table.

In the following procedure, you'll build the query in stages to give yourself a better understanding of the result of using the `join` operator.

1. Run the following query to get 10 matching arbitrary rows from the *Customers* table and the *SalesFact* table.

    <a href="https://dataexplorer.azure.com/clusters/help/databases/ContosoSales?query=H4sIAAAAAAAAA3MuLS7Jz00tKuaqUcjKz8xTyM7MS7HNzMtLLVIITsxJLXZLTC5RyM9TcIYq9E6tBCotScxOVTA0AABvXAKoPgAAAA==" target="_blank">Run the query</a>

    ```kusto
    Customers
    | join kind=inner SalesFact on CustomerKey
    | take 10
    ```

    Take a look at the resulting list. Notice that the table contains columns from the *Customers* table, followed by matching columns from the *SalesFact* table.

1. Run the following query to summarize the joined tables to get the three countries/regions that have the most sales.

    <a href="https://dataexplorer.azure.com/clusters/help/databases/ContosoSales?query=H4sIAAAAAAAAA02MsQ7CMAxEdyT+4cZ2Zu6AIrEgMQA/4FILBWobOckQxMfTAAPTSe/dXSgpm7Cn9eqFm0XFPeo0RFV2nGjmtKNLhinCr7nn2rqpiJDHJ+NsmeatWNGMAb7k1C22+6y/vO8xVhz5Gk1DA14PJNx+sj2wafbv5g1dXsYVlQAAAA==" target="_blank">Run the query</a>

    ```kusto
    Customers
    | join kind=inner SalesFact on CustomerKey
    | summarize TotalAmount = round(sum(SalesAmount)) by RegionCountryName
    | top 3 by TotalAmount
    ```

    Your results should look like those in the following image:

    :::image type="content" source="../media/4-join-1.png" alt-text="Screenshot of the join operator query, showing the top three countries/regions by sales.":::

1. Take a look at the resulting list. Try modifying the query to also show the corresponding total cost and profit for these countries/regions.

Your team then asks you to identify the countries/regions with the lowest revenues in the last recorded year, by month. To do this, you use a similar query. But this time, you use the `startofmonth()` function to facilitate grouping by month. You also use the `arg_min()` aggregation function to find the countries/regions with the lowest revenues in each month.

1. Run the following query.

    <a href="https://dataexplorer.azure.com/clusters/help/databases/ContosoSales?query=H4sIAAAAAAAAA22NPQvCQAyG90L/Q8Y7cNG9g1RcRAd1l9jGetpL5C4dKv54ryp+gFlCkvfJU3ZRxVOIeXaDkziGs+O6cMwUYIMtxTlWCsJQvpIL6ods7LzH4K4EW1Fsp146ViggpF6bdDUP+rm3Ns8g1b6HpbAeUy4qBpWDH0YzQ6X0145gTY0TLgco9Cv09OvC0Oy8Y/Pl/MPYt2igVS4wnnzcNcXqDuvWwxL3AAAA" target="_blank">Run the query</a>

    ```kusto
    Customers
    | join kind=inner SalesFact on CustomerKey
    | summarize TotalAmount = round(sum(SalesAmount))
        by Month = startofmonth(DateKey), RegionCountryName
    | summarize arg_min(TotalAmount, RegionCountryName) by Month
    | top 12 by Month desc
    ```

    Your results should look like those in the following image:

    :::image type="content" source="../media/4-join-2.png" alt-text="Screenshot of the join operator query, showing the countries/regions with the lowest revenues.":::

1. Look at each row. Notice that the first column shows the months of the last year, in descending order, followed by columns that show the total sales for the country/region with the lowest sales numbers that month.

## Use the rightouter `join` kind

Your sales team wants to know the total sales by product category. When you start reviewing the available data, you realize that you'll need the *Products* table to get the list of product categories and the *SalesFact* table to get the sales data. You also realize that you want to count the sales for each category and list all product categories.

Having analyzed the request, you choose to use the *rightouter* `join`, because it returns all sales records from the right table, enriched with matching data product category from the left table. You write your query by using the *Products* table as the left dimension table, matching data from the *SalesFact* facts table, and grouping the result by product category, as follows:

1. Run the following query.

    <a href="https://dataexplorer.azure.com/clusters/help/databases/ContosoSales?query=H4sIAAAAAAAAA03MQQrCMBCF4b2neEt7iK4EN4VS0AuMydCmbTIwmSxSPLzBIrh+3/8mFV+c5csbq4SELSTfa5gXk2KseNDO+U7OIAnTiQeujecSI2k4GE8x2r8QPZyUZNcOr/rjNzKeRetIkVsn6ttvm/8yz9l9ABmJ5jWKAAAA" target="_blank">Run the query</a>

    ```kusto
    Products
    | join kind=rightouter SalesFact on ProductKey
    | summarize TotalSales = count() by ProductCategoryName
    | order by TotalSales desc
    ```

    Your results should look like those in the following image:

    :::image type="content" source="../media/4-join-3.png" alt-text="Screenshot of the join operator query, showing the total sales per product.":::

1. Notice that the execution time is 0.834 seconds, though this time might vary between runs. This query is one way to get this answer and is a good example of a query that isn't optimized for performance. Later, you'll compare this time with the execution time of an equivalent query by using the `lookup` operator, which is optimized for this type of data.

## Use the rightanti `join` kind

Similarly, your sales team wants to know the number of products that don't sell in each product category. You can use a *rightanti* `join` to get all the rows from the *Products* table that don't match any rows in the *SalesFacts* table, and then group the results by product category.

1. Run the following query.

    <a href="https://dataexplorer.azure.com/clusters/help/databases/ContosoSales?query=H4sIAAAAAAAAAzWLQQqDQAxF954iSz2EK6Gbggg9QToTptFOApnMYoqHVymu/oP/3gu/VB4YvNthVRbYWOJonD6O4gyLaazBC6jc/KR2yqXmjMY/gkmrOIwQru0HeLfbnNApqbUZM52JWiS77n8RqYQDxNGqTH8AAAA=" target="_blank">Run the query</a>

    ```kusto
    SalesFact
    | join kind=rightanti Products on ProductKey
    | summarize Count = count() by ProductCategoryName
    | order by Count desc
    ```

    Your results should look like those in the following image:

    :::image type="content" source="../media/4-join-4.png" alt-text="Screenshot of the join operator query, showing the number of products that don't sell in each product category.":::

    Look at each row. The results show the number of unsold products per product category. Notice that the rightanti `join` selects only products that have no sales facts, indicating that there were no sales for products that were returned by the `join` operator.
