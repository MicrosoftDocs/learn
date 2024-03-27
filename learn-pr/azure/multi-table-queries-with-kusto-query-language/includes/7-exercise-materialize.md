In this exercise, you use the `materialize` function to optimize your queries.

Recall that the `materialize` function caches the results of a subquery when it runs, so that other parts of the query can reference the partial result.

## Use the `materialize` function

In our retail company scenario, your sales team asks you for the top customers in the top 10 states, by revenue and how much they contribute, as a percentage, to the states' sales.

To provide this information, you want to break down the query into stages so that you can see results at each stage, as follows:

1. Run the following query to get the top states, by revenue. Use the `let` statement to assign subqueries to the variables `USCustomers` and `USCustomerSales`.

    <a href="https://dataexplorer.azure.com/clusters/help/databases/ContosoSales?query=H4sIAAAAAAAAA22Q3QrCMAyF7/sUuXN7hrELGXgjiDj3AHULWm1TaDNlsoe3Lf5tLFcnkHPyJRoZmrrqPVuDzkMJPz3C44IO4YBnZamyPbEbdtIglCWsGlKMHdQsGf2qEHqSVEuNIU1AqKQ3suXUjeB7Y6RTTwzzR8tSz0xxIEt6beLSHE7DF2uLwzvmahXBTVFXKiJ0kzMs/RsKMQMTCxDpkA+BC3u7LHIsIeaJKBn2zt4VtRjf8gJ6isDhTAEAAA==" target="_blank">Run the query</a>

    ```kusto
    let USCustomers = Customers | where RegionCountryName == 'United States';
    let USCustomerSales =
        SalesFact
        | summarize USTotalCustomerSales = sum(SalesAmount) by CustomerKey
        | join kind=inner USCustomers on CustomerKey;
    USCustomerSales
    | summarize USTotalStateSales = round(sum(USTotalCustomerSales)) by StateProvinceName
    ```

    Take a look at the resulting list. Notice that the table contains columns for **StateProvinceName** and **USTotalStateSales**. You want to show the province name in the results, so you need to join the *Customers* table to the results.

    :::image type="content" source="../media/7-materialize-1.png" alt-text="Screenshot of the `materialize` function, showing the first block of the query.":::

1. Run the following query to add the province and the details about the top customers in the states to the results. You add this data by joining the `USCustomerSales` subquery to the results from the previous query.

    Now, optimize the query by using the `materialize` function in the *USCustomerSales* table `let` statement. Doing so runs the assigned subquery only once and caches the results.

    <a href="https://dataexplorer.azure.com/clusters/help/databases/ContosoSales?query=H4sIAAAAAAAAA3WQzU7DMBCE73mKvTVBHOBc5YAqcUFCiNAzWppVcWvvVpsNkKoPX9v8NqQ+WLbWM/ONPRksm0XfmQTSDmr4PR/g/ZWU4JHWTnghPZsO9xgI6hpmS3ZGLTSGRt1sXvgTpwY9JbcQp+rQuz2VBcSVB7e4snw7QNeHgBrHUfwkhn7sEB+U+XwTEkEFL8MP4x0NXzYbcQxbx23tmElPOgn/FVTzYoRZTFDkWt8IGoPbMoFMMVYZKQseVN4cryh9UnT1Itt+B5/Fx6Hj+qjr54AfkxGXcHEmJLlUeY8tpxhMdnB9lcT/mh0BN6LUufwBAAA=" target="_blank">Run the query</a>

    ```kusto
    let USCustomers = Customers | where RegionCountryName == 'United States';
    let USCustomerSales = materialize(
        SalesFact
        | summarize USTotalCustomerSales = sum(SalesAmount) by CustomerKey
        | join kind=inner USCustomers on CustomerKey);
    USCustomerSales
    | summarize USTotalStateSales = round(sum(USTotalCustomerSales)) by StateProvinceName
    | lookup (
        USCustomerSales
        | summarize arg_max(USTotalCustomerSales, *) by StateProvinceName
        )
        on StateProvinceName
    | top 10 by USTotalStateSales
    ```

    Your results should look like those in the following image:

    :::image type="content" source="../media/7-materialize-2.png" alt-text="Screenshot of the materialize function, showing the second block of the query.":::

1. Run the following query to output the columns for the report and calculate the top customers' contributions to their state's sales, as a percentage.

    <a href="https://dataexplorer.azure.com/clusters/help/databases/ContosoSales?query=H4sIAAAAAAAAA3VTy27CMBC85yv2RowiFXosyqFC4tKqQgXOlQsrMPgRbZy2tPTfazsklDjkEK29M+OZTSzRwnyN2kIOaWHICqMfgJDLDKyxXNYLBj9AptKbdDwawRDOSLirQRncM/idJNKprRbTqrRGIZVO81Kf4HOHhPCKW8ecOjFLxxeuEPIcBistLG5gYbnFctBVWnCJXk25LgkuxTemCbgnNGZ8bcPqBGWlFCfXduSld9ZVcIA01I/KO2Dwfmw9PuHxLLM3QsNB6E0utEa6yuRS/yOwSdKxmfS4CLEaC/UcvZE+jyxYCoQ5mQ+h1+iH5FSlMYeqgDp499BufE7bN8W/eo/IYHjjEK/Cwtul7PNgTQHjkSdHyVy3ILPH87eI2Nllu5lEpFFjlqZo/M4Elbb+SaCtI9Qzb0FNGWGup987+YgzR/JXg2+9crglN+YZBWF/Gs8rT1gDAAA=" target="_blank">Run the query</a>

    ```kusto
    let Pcent = (portion: real, total: real) { round(100 * portion / total, 2) };
    let USCustomers = Customers | where RegionCountryName == 'United States';
    let USCustomerSales = materialize(
        SalesFact
        | summarize USTotalCustomerSales = sum(SalesAmount) by CustomerKey
        | join kind=inner USCustomers on CustomerKey);
    USCustomerSales
    | summarize USTotalStateSales = round(sum(USTotalCustomerSales)) by StateProvinceName
    | lookup (
        USCustomerSales
        | summarize arg_max(USTotalCustomerSales, *) by StateProvinceName
        )
        on StateProvinceName
    | top 10 by USTotalStateSales
    | project
        StateProvinceName,
        StateSales = USTotalStateSales,
        TopCustomerFirstName = FirstName,
        TopCustomerLastName = LastName,
        TopCustomerSales = round(USTotalCustomerSales),
        TopCustomerPercentage = Pcent(USTotalCustomerSales, USTotalStateSales)
    ```

    Your results should look like those in the following image:

    :::image type="content" source="../media/7-materialize-3.png" alt-text="Screenshot of the materialize function, showing the entire query.":::
