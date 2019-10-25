EF Core integrates automatically with the logging mechanisms of ASP.NET Core. Since ASP.NET Core apps emit logs as console output by default, the text file *:::no-loc text="ContosoPets.Api.log":::* contains the EF Core log output. EF Core masks parameter values in the generated SQL appearing in the logs.

```console
info: Microsoft.EntityFrameworkCore.Database.Command[20100]
      Executing DbCommand [Parameters=[@__id_0='?' (DbType = Int32)], CommandType='Text', CommandTimeout='30']
      SELECT TOP(1) [o].[Id], [o].[CustomerId], [o].[OrderFulfilled], [o].[OrderPlaced]
      FROM [Orders] AS [o]
      WHERE ([o].[Id] = @__id_0) AND @__id_0 IS NOT NULL
```

In the preceding output, note the `@__id_0` parameter in the query's `WHERE` clause. The `info` message in the output displays `?` as the parameter's value.

A developer on the team has enlisted a database administrator (DBA) to assist with performance tuning of the generated SQL. The DBA has requested that parameter values be displayed in the logs. Company policy prohibits logging customer data in production. Consequently, this feature should be enabled only in development mode. To support troubleshooting in production, there should be a configuration value to toggle parameter value logging on or off.

To ease production troubleshooting, the Operations Manager wants SQL queries to be tagged with the calling method's name. The tags should be visible in the Application Insights telemetry.

1. Modify the `Logging` section of *:::no-loc text="ContosoPets.Api/appsettings.Development.json":::* to include a property named `EnableSqlParameterLogging`. The property should have a value of `true`. Save your changes.

    [!code-json[](../code/7-appsettings.Development.json?range=2-9&highlight=2)]

1. In the `ConfigureServices` method of *:::no-loc text="Startup.cs":::*, chain the `EnableSensitiveDataLogging` call after the `UseSqlServer` call. Save your changes.

    [!code-csharp[](../code/7-enable-sensitive-logging.cs?highlight=3)]

    The preceding code reads a `Logging:EnableSqlParameterLogging` property value from the environment-specific application settings file. The property value determines whether parameter logging is enabled.

1. Modify the `GetOrderById` method of *:::no-loc text="Services/OrderService.cs":::* in the *:::no-loc text="ContosoPets.DataAccess":::* project to include the highlighted line. Save your changes.

    ::: zone pivot="linq"

    [!code-csharp[](../code/7-getorderbyid-linq.cs?highlight=3)]

    ::: zone-end

    ::: zone pivot="fluent"

    [!code-csharp[](../code/7-getorderbyid-fluent.cs?highlight=3)]

    ::: zone-end

    The preceding code added a `TagWith` call to emit a comment above the generated SQL in the logs. The resulting double-hyphen SQL comment (`--`) will contain the name of the method from which the generated SQL originated. This technique is supported only for read queries. It becomes useful when sifting through large log files containing several distinct queries.

1. Modify the `GetById` method of *:::no-loc text="Services/OrderService.cs":::* to include the highlighted line. Save your changes.

    ::: zone pivot="linq"

    [!code-csharp[](../code/7-getbyid-linq.cs?highlight=19)]

    ::: zone-end

    ::: zone pivot="fluent"

    [!code-csharp[](../code/7-getbyid-fluent.cs?highlight=17)]

    ::: zone-end

    The preceding code added another `TagWith` call. The resulting comment in the logs will resemble the following output:

    ```console
    -- GetOrderById

    -- GetById
    ```

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-no-restore-command.md)]

1. Run the following .NET Core CLI command to start the app:

    ```dotnetcli
    dotnet ./bin/Debug/netcoreapp3.0/ContosoPets.Api.dll \
        --environment Development \
        > $srcWorkingDirectory/ContosoPets.Api.log &
    ```

1. Run the following command to test the `GetById` method of the `OrderService` class:

    ```bash
    curl -k -s https://localhost:5001/Orders/2 | jq
    ```

    JSON representing an order is displayed. The output you see may differ.

    ```json
    {
      "orderId": 2,
      "orderPlaced": "3/30/19",
      "orderFulfilled": "",
      "customerName": "Hunt, Patrick",
      "orderLineItems": [
        {
          "productQuantity": 6,
          "productName": "Knotted Rope"
        }
      ]
    }
    ```

1. Run the following command to view the log file:

    ```bash
    cat $srcWorkingDirectory/ContosoPets.Api.log
    ```

    The following output is produced by the `GetById` method of the `OrderService` class. Notice the `@__id_0` parameter's value displays as `2`. EF Core's parameter value masking has been suppressed.

    ```console
    info: Microsoft.EntityFrameworkCore.Database.Command[20100]
        Executing DbCommand [Parameters=[@__id_0='2'], CommandType='Text', CommandTimeout='30']
        -- GetOrderById

        -- GetById

        SELECT [t].[Id], [t].[LastName], [t].[FirstName], [t].[c], [t].[OrderFulfilled], [t].[OrderPlaced], [t].[Id0], [t0].[Quantity], [t0].[Name], [t0].[Id], [t0].[Id0]
        FROM (
            SELECT TOP(1) [o].[Id], [c].[LastName], [c].[FirstName], CASE
                WHEN [o].[OrderFulfilled] IS NOT NULL THEN CAST(1 AS bit)
                ELSE CAST(0 AS bit)
            END AS [c], [o].[OrderFulfilled], [o].[OrderPlaced], [c].[Id] AS [Id0]
            FROM [Orders] AS [o]
            INNER JOIN [Customers] AS [c] ON [o].[CustomerId] = [c].[Id]
            WHERE ([o].[Id] = @__id_0) AND @__id_0 IS NOT NULL
        ) AS [t]
        LEFT JOIN (
            SELECT [p].[Quantity], [p0].[Name], [p].[Id], [p0].[Id] AS [Id0], [p].[OrderId]
            FROM [ProductOrders] AS [p]
            INNER JOIN [Products] AS [p0] ON [p].[ProductId] = [p0].[Id]
        ) AS [t0] ON [t].[Id] = [t0].[OrderId]
        ORDER BY [t].[Id], [t].[Id0], [t0].[Id], [t0].[Id0]
    ```

1. Run the following command to query Application Insights telemetry:

    ```bash
    curl -s "https://api.applicationinsights.io/v1/apps/$appId/events/dependencies?\$orderby=timestamp+desc&\$top=2" \
        -H "x-api-key: $apiKey" \
        | jq
    ```

    JSON containing dependency telemetry is displayed. This JSON contains the information Application Insights captured as the app executed the two most recent SQL queries.

    > [!NOTE]
    > Ingestion of telemetry information into Application Insights may take a short while. If the telemetry doesn't seem correct, wait a few minutes and try again.

1. Run the following command to filter the output from the previous step and display only the SQL queries:

    ```bash
    curl -s "https://api.applicationinsights.io/v1/apps/$appId/events/dependencies?\$orderby=timestamp+desc&\$top=2" \
        -H "x-api-key: $apiKey" \
        | jq '.value[].dependency.data' --raw-output
    ```

    The following output is produced:

    ```console
    -- GetOrderById

    -- GetById

    SELECT [t].[Id], [t].[LastName], [t].[FirstName], [t].[c], [t].[OrderFulfilled], [t].[OrderPlaced], [t].[Id0], [t0].[Quantity], [t0].[Name], [t0].[Id], [t0].[Id0]
    FROM (
        SELECT TOP(1) [o].[Id], [c].[LastName], [c].[FirstName], CASE
            WHEN [o].[OrderFulfilled] IS NOT NULL THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
        END AS [c], [o].[OrderFulfilled], [o].[OrderPlaced], [c].[Id] AS [Id0]
        FROM [Orders] AS [o]
        INNER JOIN [Customers] AS [c] ON [o].[CustomerId] = [c].[Id]
        WHERE ([o].[Id] = @__id_0) AND @__id_0 IS NOT NULL
    ) AS [t]
    LEFT JOIN (
        SELECT [p].[Quantity], [p0].[Name], [p].[Id], [p0].[Id] AS [Id0], [p].[OrderId]
        FROM [ProductOrders] AS [p]
        INNER JOIN [Products] AS [p0] ON [p].[ProductId] = [p0].[Id]
    ) AS [t0] ON [t].[Id] = [t0].[OrderId]
    ORDER BY [t].[Id], [t].[Id0], [t0].[Id], [t0].[Id0]
    SET NOCOUNT ON;
    UPDATE [Orders] SET [CustomerId] = @p0, [OrderFulfilled] = @p1, [OrderPlaced] = @p2
    WHERE [Id] = @p3;
    SELECT @@ROWCOUNT;
    ```

    The SQL query is tagged with `-- GetOrderById` and `-- GetById`. By design, Application Insights discards potentially sensitive data such as parameter values.

    > [!TIP]
    > Application Insights has captured detailed information at each step, including HTTP requests, their corresponding SQL queries, and performance metrics. Explore Application Insights telemetry by navigating to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) and logging in with the same identity used for this module. Quickly locate the Application Insights resource by searching for the string *appinsights*.
