Multiple documents in your database frequently need to be updated at the same time, and stored procedures are a useful method of automating tasks for those types of situations. This unit discusses how to create, register, and run stored procedures from your .NET console application.

## Create a stored procedure in your app

1. In Visual Studio Code, in the **Azure: Cosmos DB** tab, expand your Azure Cosmos DB account > **Users** > **WebCustomers** and then right-click **Stored Procedures** and then click **Create Stored Procedure**.

1. In the text box at the top of the screen, type `UpdateOrderTotal` and press Enter to give the stored procedure a name.

1. In the **Azure: Cosmos DB** tab, expand **Stored Procedures** and select **UpdateOrderTotal**.

    By default, a stored procedure that retrieves the first item is provided.

1. To run this default stored procedure from your application, add the following code to the **Program.cs** file.

    ```csharp
    async Task RunStoredProcedure(string databaseName, string collectionName, User user)
    {
        await client.ExecuteStoredProcedureAsync<string>(UriFactory.CreateStoredProcedureUri(databaseName, collectionName, "UpdateOrderTotal"), new RequestOptions { PartitionKey = new PartitionKey(user.UserId) });
        Console.WriteLine("Stored procedure complete");
    }
    ```

1. Now copy the following code and paste it before the `await DeleteUserDocument("Users", "WebCustomers", yanhe);` line in the **BasicOperations** method.

    ```csharp
    await RunStoredProcedure("Users", "WebCustomers", yanhe);
    ```

1. In the integrated terminal, run the following command to run the sample with the stored procedure.

    ```bash
    dotnet run
    ```

The console displays output indicating that the stored procedure was completed.
