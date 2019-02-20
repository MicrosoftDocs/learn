To extract data from the database, we need to form a _database query_. This is a textual command expressed in one or more SQL statements. Microsoft's variant of SQL is referred to as T-SQL and, although T-SQL is a sophisticated programming language, the most commonly used data queries are very straightforward. The pattern of the query to read data is:

```sql
SELECT <column(s)> FROM <fact_table> 
  JOIN <dim_table> ON <condition(s)> 
  WHERE <source_filter_condition> 
  GROUP BY <dim_table_column(s)> 
    HAVING <result_filter_condition> 
  ORDER BY <source_or_result_column(s)>
```

Let's compose a T-SQL query step by step against an existing fact table **FactResellerSales**.

1. Expand the **demodw** database node in the SMSS Object Explorer. This will list all the tables available to you.

1. Find the fact table **FactResellerSales** and the dimension table **DimReseller**. 

1. Expand these two tables to see their columns. 

1. Right-click each of the the tables and select **Select Top 1000 Rows** in the context menu to view the data of the table.

    ![Screenshot showing how to issue query](../media/4-query-top-rows.png)

    > [!TIP]
    > The column view in Object Explorer provides complete details about the table structure. For example, from here you can see that the column **ResellerKey** in **FactResellerSales** and the column **ResellerKey** of **DimReseller** are the links on which the two tables can join together.

## Create a new query

Let's try a custom query. Let's start by querying the fact table, which holds the central data.

1. With the **FactResellerSales** table selected in the tree, click the **New Query** toolbar button to open a new query editor.
    - You may get a warning about unsupported features such as transactions. That's ok - just dismiss the warning.

1. Type the following SQL into the editor to retrieve the sales information.

    ```sql
    SELECT S.[SalesAmount] AS [Sales]
    FROM [FactResellerSales] AS S
    ```

    Notice the use of aliases in this query. The table `FactResellerSales` is aliased as `S` so that it is easier to reference in other parts of the query. The column `SalesAmount` is aliased as `Sales` to change its name in the output.

1. Click the Execute button in the toolbar (or press <kbd>F5</kbd>); the query will be sent to the ASDW server, executed, and results will be sent back and displayed in the bottom pane of the query window.

    ![Screenshot of Executing a query using the SMSS tool](../media/4-execute-query.png)

1. Next, let's bring the dimension table in using the shared column. Type the following query into the editor.

    ```sql
    SELECT S.[SalesAmount] AS [Sales], R.[BusinessType],R.[ResellerName]
    FROM [FactResellerSales] AS S
    JOIN [DimReseller] AS R ON S.[ResellerKey] = R.[ResellerKey]
    ```

    The fact table and dimension table are joined together by the `ResellerKey` columns which provides the relationship between them.

1. Execute the query. Here are the first few rows ..

    ```
    Sales      BusinessType          ResellerName
    90.8393    Warehouse             Bike Dealers Association
    173.0424   Warehouse             Retail Mall
    20.1865    Specialty Bike Shop   Professional Containers and Packaging Co.
    151.3989   Warehouse             Real Sporting Goods
    144.202    Value Added Reseller  Commerce Bicycle Specialists
    288.404    Warehouse             Original Bicycle Supply Company
    86.5212    Specialty Bike Shop   Roving Sports
    20.1865    Value Added Reseller  Frugal Bike Shop
    60.5596    Value Added Reseller  Great Bikes
    230.7232   Warehouse             Go-cart and Bike Specialists

    ... remainder omitted for length
    ```
    
    By observing the values in the `BusinessType` column, we find out the resellers fall into three types of businesses: **Specialty Bike Shop**, **Warehouse**, and **Value Added Reseller**. If you want to focus on _warehouse resellers_ you can add a `WHERE` condition to the source data.

1. Add a `WHERE` clause to the query, it should look something like this:

    ```sql
    SELECT S.[SalesAmount] AS [Sales], R.[BusinessType],R.[ResellerName]
    FROM [FactResellerSales] AS S
    JOIN [DimReseller] AS R ON S.[ResellerKey] = R.[ResellerKey]
    WHERE R.[BusinessType] = 'Warehouse'
    ```

1. Execute the query to limit the results. 

1. Since there are only _warehouse resellers_ left, we don't need the `BusinessType` column in the query result, go ahead and remove it.

    ```sql
    SELECT S.[SalesAmount] AS [Sales], R.[ResellerName]
    FROM [FactResellerSales] AS S
    JOIN [DimReseller] AS R ON S.[ResellerKey] = R.[ResellerKey]
    WHERE R.[BusinessType] = 'Warehouse'
    ```

## Performing aggregate calculations
    
Most of the data analysis tasks involve aggregation calculations, including min/max values, totals, summations, and averaging data.

For example, if you want to know the sales performance of each reseller, you would calculate the total sales amount for each of the resellers. In T-SQL, this can be done by the `GROUP BY` clause and the `SUM` aggregation function. 

1. Type the following query into the editor.

    ```sql
    SELECT SUM(S.[SalesAmount]) AS [Sales], R.[ResellerName]
    FROM [FactResellerSales] AS S
    JOIN [DimReseller] AS R ON S.[ResellerKey] = R.[ResellerKey]
    WHERE R.[BusinessType] = 'Warehouse'
    GROUP BY R.[ResellerName]
    ```
    
    This returns the following results:

    ```
    Sales          ResellerName
    284876.0711    Bike Boutique
    186217.0681    Excellent Bikes
    8406.4692      Unusual Bicycle Company
    373658.4657    Catalog Store
    17623.2972     Grown-up Bike Store
    1538.172       Good Bicycle Store
    3385.3678      Lots of Bikes Storehouse
    268209.286     Commercial Sporting Goods
    147887.682     Utilitarian Sporting Goods
    2917.9404      Expert Sports Store
    
    ... remainder omitted for length
    ```

## Filtering aggregated results

 Based on the aggregated data, you may want only to keep the resellers whose total sales amount are greater than $700,000. In this case, the `WHERE` clause won't help since it can only be used to filter the _source data_. While the aggregated total sales amount does not exist in the source data; it _is_ part of the query result. To filter the query result, we can add a `HAVING` clause to the query:

1. Adjust the query to include a `HAVING` clause. It should look like this:

    ```sql
    SELECT SUM(S.[SalesAmount]) AS [Sales], R.[ResellerName]
    FROM [FactResellerSales] AS S
    JOIN [DimReseller] AS R ON S.[ResellerKey] = R.[ResellerKey]
    WHERE R.[BusinessType] = 'Warehouse'
    GROUP BY R.[ResellerName]
    HAVING SUM(S.[SalesAmount]) > 700000
    ```

    > [!TIP]    
    > Notice that the `SUM(S.[SalesAmount])` aggregation appears twice - both in `SELECT` and `HAVING`. So far, T-SQL does not support using a column alias in the `HAVING` clause. 

## Sorting results

Notice that the results are not sorted - we need to fix that. 

To sort the query result, use the `ORDER BY` clause. With an optional `ASC` argument, the `ORDER BY` clause will sort the query result in ascending order. In contrast, using `ORDER BY` with the `DESC` argument will sort the query result descending. To highlight the high-performance resellers, let's sort the query result in descending order. 

1. Change the query to look like the following.

    ```sql
    SELECT SUM(S.[SalesAmount]) AS [Sales], R.[ResellerName]
    FROM [FactResellerSales] AS S
    JOIN [DimReseller] AS R ON S.[ResellerKey] = R.[ResellerKey]
    WHERE R.[BusinessType] = 'Warehouse'
    GROUP BY R.[ResellerName]
    HAVING SUM(S.[SalesAmount]) > 700000
    ORDER BY [Sales] DESC
    ```
    
1. Run the query; you will see the descended sorted result.

## Selecting the top section of data

What if you need to find the "Top 10" best resellers? In SQL, we can use the `TOP` argument of `SELECT`. 

1. Remove the `HAVING` clause, and add `TOP 10` just between the `SELECT` keyword and `SUM` function call. The query should look something like:

    ```sql
    SELECT TOP 10 SUM(S.[SalesAmount]) AS [Sales], R.[ResellerName]
    FROM [FactResellerSales] AS S
    JOIN [DimReseller] AS R ON S.[ResellerKey] = R.[ResellerKey]
    WHERE R.[BusinessType] = 'Warehouse'
    GROUP BY R.[ResellerName]
    ORDER BY [Sales] DESC
    ```
    
1. Execute the query, and you should see the top 10 best warehouse resellers are listed. Note, the `TOP` filtering occurs later than `ORDER BY`. This is why the result is the top 10 best warehouse resellers.

    ```output
    Sales          ResellerName
    841908.7708    Vigorous Exercise Company
    799277.8953    Retail Mall
    746317.5293    Outdoor Equipment Store
    730798.7139    Health Spa, Limited
    727272.6494    Fitness Toy Store
    643745.896     Metropolitan Equipment
    636226.4703    Eastside Department Store
    602559.8926    Top Sports Supply
    585516.433     Golf and Cycle Store
    580222.3286    Registered Cycle Store
    ```

## Exporting results

You can export results right from the query window.

- Copy as text
- Copy as text with headers
- Save results to a file (typically comma-delimited)

1. Right-click the data grid of the query result, and click the **Select All** menu item.
1. Then, right-click the data grid again, and click the **Copy with Headers** menu item.

You can then paste these results wherever necessary. For example, you could paste results to an Excel sheet. Then you can visualize the data either with a pie chart or a bar chart to get some business insight. You can even use PivotTable of Excel to go further. However, this is beyond the scope of this course.

:::row:::
  :::column:::
![Screenshot of Observing Pie Chart](../media/4-observe-pie-chart.png)
  :::column-end:::
  :::column:::
![Screenshot of Observing Pie Chart](../media/4-observe-bar-chart.png)
  :::column-end:::
:::row-end:::