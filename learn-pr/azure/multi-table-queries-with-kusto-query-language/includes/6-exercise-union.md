In this exercise, you'll use the `union` operator to combine sales facts that were collected from various countries/regions.

## Use the `union` operator

Your sales team asks you to create a single table that combines 10 arbitrary sales results from each of the following countries/regions: Australia, the United Kingdom, and the United States.

You'll use the `let` statement to create three tabular expressions, each with 10 records from a specific country/region, in the *SalesFact* table, to represent sales data from three countries/regions. You can think of them as three separate tables.

Examining these tables, you can see that they have the same columns. The only difference is the data in the `RegionCountryName` column that represents the country. You'll use the `union` operator to combine the sales facts tables for the United Kingdom and the United States with the sales facts table for Australia.

1. Run the following query.

    <a href="https://dataexplorer.azure.com/clusters/help/databases/ContosoSales?query=H4sIAAAAAAAAA62RwQrCMBBE7/2KvfUiVM/SgxS8FDxY+gHBrjU0yUqyQQr9eIMplVIRheaQMGFmeJsoZDh4x1YoKSqh0EEOr/MoLgxZFgVcgwq7Jf22JxDWAIqo83cowjVptA7ITKLEfnQ9bmgRzthKMgV5w7Y/CY2Q55BOjeloZtEh7Lb7RAW82kjGppSmbUj/hhgjMGZW45zXfoGtWDC6v1hjZG3U2Lognf94MoA3oePDS2+WAz0Bgv25ZzICAAA=" target="_blank">Run the query</a>

    ```kusto
    let AustraliaSales = SalesFact // Sales facts from Australia
        | lookup Customers on CustomerKey
        | where RegionCountryName == 'Australia'
        | take 10;
    let UnitedKingdomSales = SalesFact // Sales facts from United Kingdom
        | lookup Customers on CustomerKey
        | where RegionCountryName == 'United Kingdom'
        | take 10;
    let UnitedStatesSales = SalesFact // Sales facts from United States
        | lookup Customers on CustomerKey
        | where RegionCountryName == 'United States'
        | take 10;
    AustraliaSales
    | union UnitedKingdomSales, UnitedStatesSales
    ```

    Your results should look like those in the following image:

    :::image type="content" source="../media/6-union-1.png" alt-text="Screenshot of the union operator with tables that have the same columns, query, and results.":::

1. Notice that you get all the rows from the three tables. Try modifying the query to add simulated data for France and combining it with the data from the other countries/regions.

In the following sections, you use the `let` statement to create ad hoc tables that simulate data, with the columns required for the scenarios.

## Use the `union` operator with tables that have different columns

The next month, your sales team again asks you to create the sales data from the three countries/regions. When you examine the tables this time, you notice that they have different columns. The nice thing about the `union` operator is that it will combine tables even if they have different columns. For this query, you use the alternative syntax for the `union` operator, which doesn't require piped input.

1. Run the following query.

    <a href="https://dataexplorer.azure.com/clusters/help/databases/ContosoSales?query=H4sIAAAAAAAAA7WSwQrCMAyG7z5Fbl560LPsMCZeBBWnDxBqmNWuGW2qCD68dRsizqP20qT8yc+X1JJAHoN4tAZLtBQgg/ZeoJYRpHMHy3yODRRJxzX5AOxeyZJuvep6JE+wpcqwKzg68bcV1gRZBuOXxbgXC54JppM+azyfSEtnnNfPYgU7FrQFhxTOUSgZqWF3BYWRNpqNbGLZOyN0WBpXHbj+H09nA73P76HWWscGJT2/Y5WSSsLfqTqb30O1fTeeL8Zp6lYWXRJ9fED1ZYlqOIEHRlC12roCAAA=" target="_blank">Run the query</a>

    ```kusto
    let AustraliaSales = SalesFact
        | lookup Customers on CustomerKey
        | where RegionCountryName == 'Australia'
        | take 10
        | project SalesAmount, TotalCost, DateKey, RegionCountryName, CityName;
    let UnitedKingdomSales = SalesFact
        | lookup Customers on CustomerKey
        | where RegionCountryName == 'United Kingdom'
        | take 10
        | project SalesAmount, TotalCost, DateKey, RegionCountryName, Occupation;
    let UnitedStatesSales = SalesFact
        | lookup Customers on CustomerKey
        | where RegionCountryName == 'United States'
        | take 10
        | project SalesAmount, TotalCost, DateKey, RegionCountryName, StateProvinceName;
    union AustraliaSales, UnitedKingdomSales, UnitedStatesSales
    ```

    Your results should look like those in the following image:

    :::image type="content" source="../media/6-union-2.png" alt-text="Screenshot of the union operator, with tables that have different columns, query, and results.":::

1. Notice that you get all the rows from the three tables and all the columns that occur in any of the tables. Cells that weren't defined by an input row are set to null. Try modifying the query to add more columns and see how their values are populated in the results.

## Use the `union` operator with tables that have different columns and return only the columns that occur in all tables

The following month, your sales team again asks you to create the sales data from the three countries/regions, but this time they only want the columns that are common to all three tables. Previously, you saw that the `union` operator returns all the columns that occur in any of the tables. This is the default behavior of the `union` operator, called an outer union, though it's best practice to always explicitly specify the union kind for clarity.

To only return the columns that occur in all tables, you'll use an inner union on the same simulated data by specifying the `kind=inner` argument, as follows:

1. Run the following query.

    <a href="https://dataexplorer.azure.com/clusters/help/databases/ContosoSales?query=H4sIAAAAAAAAA7WSsY7CMAyGd57CG0sGmFEHVMSCBAjuHsBKLQhN7SpxOCHdwxPaCiFghCyxo9/+9dnxpDBPUQN6h3v0FKGA7l6i1RHk8w9epE4tlFknDYUIwvdkRZdB9XekQLCjgxMuJbGGyxobgqKA8d1iPIgVa4LpZMjaICey2hvPm1uxgR9R9KXEHC5QKRuZ1+4GSqddNBv5zPLLTqlaOT5U0nyPp7eBwefzUBtrU4uanx+x9ppL4tepepvPQ3V9t0HOji31K0ucRVA7rgrHTOHpL5o3+zSvw7gCuE4kN8UCAAA=" target="_blank">Run the query</a>

    ```kusto
    let AustraliaSales = SalesFact
        | lookup Customers on CustomerKey
        | where RegionCountryName == 'Australia'
        | take 10
        | project SalesAmount, TotalCost, DateKey, RegionCountryName, CityName;
    let UnitedKingdomSales = SalesFact
        | lookup Customers on CustomerKey
        | where RegionCountryName == 'United Kingdom'
        | take 10
        | project SalesAmount, TotalCost, DateKey, RegionCountryName, Occupation;
    let UnitedStatesSales = SalesFact
        | lookup Customers on CustomerKey
        | where RegionCountryName == 'United States'
        | take 10
        | project SalesAmount, TotalCost, DateKey, RegionCountryName, StateProvinceName;
    union kind=inner AustraliaSales, UnitedKingdomSales, UnitedStatesSales
    ```

    Your results should look like those in the following image:

    :::image type="content" source="../media/6-union-3.png" alt-text="Screenshot of the union operator, returning common columns from tables that have different columns, query, and results.":::

    Notice that you get all the rows from the three tables and only the columns that occur in all of the tables. 
    
1. Now try modifying the query to add more common columns by extending each table with a column of the same name, and then see how their values are populated in the results.
