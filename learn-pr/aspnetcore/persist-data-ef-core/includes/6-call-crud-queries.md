In this unit, the Azure SQL database's tables will be populated with data. You'll then modify an ASP.NET Core web API project to consume the EF Core queries written in the previous unit. Finally, you'll test the queries.

1. Run the following command to populate the Azure SQL database's tables:

    ```bash
    db -i $setupWorkingDirectory/seeddata.sql
    ```

1. Remove the following code from *:::no-loc text="ContosoPets.Api.csproj":::*. Save your changes.

    ```xml
    <ItemGroup>
      <Compile Remove="Controllers\OrdersController.cs" />
    </ItemGroup>
    ```

    With the preceding change, the `OrdersController` class will compile the next time the project is built. `OrdersController` is the facade that will be used for testing data access via the `OrderService` class.

1. In the `ConfigureServices` method of *:::no-loc text="Startup.cs":::*, replace the `// Add the OrderService DI registration code` comment with the following code. Save your changes.

    ```csharp
    services.AddScoped<OrderService>();
    ```

    The preceding code registers `OrderService` as a scoped service in the DI system. The scoped lifetime was selected because `ContosoPetsContext` was also registered as scoped. Because `OrderService` relies on `ContosoPetsContext`, it shouldn't be registered with a shorter lifetime than `ContosoPetsContext`.

1. In *:::no-loc text="Startup.cs":::*, replace the `// Add the ContosoPets.DataAccess.Services using statement` comment with the following code. Save your changes.

    ```csharp
    using ContosoPets.DataAccess.Services;
    ```

    Inclusion of the preceding namespace resolves the reference to `OrderService` in the previous step.

1. Run the following .NET Core CLI command to run the app in development mode:

    ```bash
    dotnet run --environment Development > $srcWorkingDirectory/ContosoPets.Api.log &
    ```

    The preceding command:

    * Restores the project's NuGet packages.
    * Builds the project code.
    * Sets the hosting environment to *:::no-loc text="Development":::*.
    * Hosts the web API with ASP.NET Core's Kestrel web server.
    * Displays the background task's process ID.

    .NET Core emits logging information and blocks command shell input. The command shell needs to be usable to test the running app. Therefore, the `dotnet run` output is redirected to a *:::no-loc text="ContosoPets.Api.log":::* text file. Additionally, the `&` runs the app as a background task to unblock command shell input.

    The web API is hosted at both `http://localhost:5000` and `https://localhost:5001`. This module uses the secure URL beginning with `https`.

    > [!IMPORTANT]
    > Run `cat $srcWorkingDirectory/ContosoPets.Api.log` to view the log if you encounter any unexpected behavior. If the build fails or other errors occur, the log file's information helps troubleshoot. If you make code changes, run `kill $(pidof dotnet)` to stop all .NET Core processes before attempting to build and run again.

1. Run the following command to test retrieval of a distinct order:

    ```bash
    curl -k -s https://localhost:5001/api/Orders/2 | jq
    ```

    The preceding command sends an HTTP GET request to the `GetById` action of `OrdersController` in *:::no-loc text="ContosoPets.Api":::*. The order corresponding to ID 2 is displayed in JSON format.

1. Run the following command to test updating an order:

    ```bash
    curl -k -i -X PUT \
        -H "Content-Length: 0" \
        https://localhost:5001/api/Orders/2
    ```

    The order from the previous step has shipped to the customer. The preceding code sends an HTTP PUT request to the `SetFulfilled` action of `OrdersController`. The `SetFulfilled` action calls `OrderService.SetFulfilled` in *:::no-loc text="ContosoPets.DataAccess":::*. An HTTP status code of 204 indicates success:

    ```console
    HTTP/1.1 204 No Content
    ```

1. Run the following command to confirm the order was marked as fulfilled:

    ```bash
    db -Q "SELECT OrderFulfilled FROM dbo.Orders WHERE Id = 2"
    ```

    The result set consists of the `OrderFulfilled` column. Its value was set to the current timestamp.

1. *Optional*: Analyze the completed data flow between the web API and the database. The following are commands you can try:

    * Retrieve and display all orders:

        ```bash
        curl -k -s https://localhost:5001/api/Orders | jq
        ```

    * Retrieve and display the specified order:

        ```bash
        curl -k -s https://localhost:5001/api/Orders/1 | jq
        ```

    * Set the fulfillment date on the specified order:

        ```bash
        curl -k -i -X PUT \
            -H "Content-Length: 0" \
            https://localhost:5001/api/Orders/1
        ```

    * Create a new order:

        ```bash
        curl -k -i -X POST \
            -H "Content-Type: application/json" \
            https://localhost:5001/api/Orders \
            -d '{"CustomerId":2,"ProductOrder":[{"ProductId":1,"Quantity":3},{"ProductId":2,"Quantity":1}]}'
        ```

        The preceding example assumes the customer, as represented by `CustomerId`, already exists.

    * Delete the specified order:

        ```bash
        curl -k -i -X DELETE https://localhost:5001/api/Orders/1
        ```

    * Observe changes in the database:

        ```bash
        db -Q "SELECT * FROM dbo.Products" -y 20 && \
            db -Q "SELECT * FROM dbo.Orders" -y 20 && \
            db -Q "SELECT * FROM dbo.ProductOrders" && \
            db -Q "SELECT * FROM dbo.Customers" -y 15
        ```

1. [!INCLUDE[kill command](../../includes/kill-dotnet-processes.md)]

In this unit, you saw that `OrderService` is modifying the database as expected. It's unnecessary to test every method. You may experiment with `curl` and `sqlcmd` to further investigate the end-to-end relationships. You can see the SQL generated by EF Core in the logs by running the following command:

```bash
cat $srcWorkingDirectory/ContosoPets.Api.log
```
