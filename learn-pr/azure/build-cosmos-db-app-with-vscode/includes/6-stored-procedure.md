Multiple documents in your database frequently need to be updated at the same time. This unit discusses how to create, register, and run stored procedures from your .NET console application.

## Create a stored procedure in your app

In this stored procedure, the **OrderId**, which contains a list of all the items in the order, is used to calculate an order total. The order total is calculated from the sum of the items in the order, less any dividends (credits) the customer has, and takes any coupon codes into account.

1. In Visual Studio Code, in the **Azure: Cosmos DB** tab, expand your Azure Cosmos DB account > **Users** > **WebCustomers** and then right-click **Stored Procedures** and then click **Create Stored Procedure**.

1. In the text box at the top of the screen, type `UpdateOrderTotal` and press Enter to give the stored procedure a name.

1. In the **Azure: Cosmos DB** tab, expand **Stored Procedures** and click **UpdateOrderTotal**.

    By default, a stored procedure that retrieves the first item is provided.

1. To run this default stored procedure from your application, add the following code to the **Program.cs** file.

    ```csharp
    public async Task RunStoredProcedure(string databaseName, string collectionName, User user)
    {
        await client.ExecuteStoredProcedureAsync<string>(UriFactory.CreateStoredProcedureUri(databaseName, collectionName, "UpdateOrderTotal"), new RequestOptions { PartitionKey = new PartitionKey(user.UserId) });
        Console.WriteLine("Stored procedure complete");
    }
    ```

1. Now copy the following code and paste it before the `await this.DeleteUserDocument("Users", "WebCustomers", yanhe);` line in the **BasicOperations** method.

    ```csharp
    await this.RunStoredProcedure("Users", "WebCustomers", yanhe);
    ```

1. In the integrated terminal, run the following command to run the sample with the stored procedure.

    ```bash
    dotnet run
    ```

The console displays output indicating that the stored procedure was completed.
