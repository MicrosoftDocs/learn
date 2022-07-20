Although the application already meets all of the requirements, there's still one more change that can be made. C# developers use the language-integrated query (LINQ) syntax to perform queries over collections of data. The .NET SDK for Azure Cosmos DB SQL API comes with a built-in mechanism to build your SQL query using the LINQ query syntax.

There are two key requirements at this time:

1. Build a new query using LINQ syntax
1. Convert the query to a feed iterator to get results

[![Illustration of icons indicating data being queried using common search techniques.](../media/project-visual-query.png)](../media/project-visual-query.png)

After you complete this exercise, your queries will now use the LINQ syntax to make it easier for developers to maintain your application moving forward.

## Reinitialize your environment (optional)

It's possible, if you closed your Azure Cloud Shell terminal pane, for the terminal instance to no longer have access to the environment variable and code editor. Here, if needed, you'll set your environment variable again and open the code editor.

> [!NOTE]
> You can safely skip this section if your terminal is already open, your environment variable is still set, and you are already editing your project in the code editor.

1. Set the environment variable named ``COSMOS_CONNECTION_STRING`` to the value of this command, which gets a connection string to the first Azure Cosmos DB SQL API account in your sandbox subscription.

    ```azurecli
    export COSMOS_CONNECTION_STRING=$(az cosmosdb keys list \
        --name $(az cosmosdb list \
            --resource-group <rgn>[sandbox resource group name]</rgn> \
            --query [0].name \
            --output tsv) \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --type connection-strings \
        --query "connectionStrings[?description=='Primary SQL Connection String'].connectionString" \
        --output tsv)
    ```

1. Change to the ``~/clouddrive/inventorytool`` directory and open a code editor.

    ```bash
    cd ~/clouddrive/inventorytool && code .
    ```

## Query using LINQ expressions

Your team wants a unique query that returns all *products* within the container regardless of category. Recall that we used the **type** field to seperate our category items from the individual product items. Here, we are going to create a cross-partition query using the LINQ query syntax.

> [!TIP]
> Since we are querying across multiple categories, this will make our query cross-partition. This query could potentially use more RUs than a query that is scoped to a single logical partition key value.

1. Open the **Program.cs** file.

1. <!-- Step 1 -->

    ```csharp

    ```

1. <!-- Step 2 -->

    ```csharp

    ```

1. <!-- Step n -->

    ```csharp

    ```

1. **Save** the **Program.cs** file.

## Paginate LINQ query results

Since we are querying across multiple logical partitions, we need to make sure that we return all results even if a logical partition doesn't have any matching results. For example, the *helmets* category does not have any matching products. If we didn't return all possible pages, our application may inadvertently halt when it sees an empty page of results for the *helmets* category. Here, you will again use a *while* and *foreach* loop in C# to iterate over *all* result pages.

1. <!-- Step 1 -->

    ```csharp

    ```

1. <!-- Step 2 -->

    ```csharp

    ```

1. <!-- Step n -->

    ```csharp

    ```

1. **Save** the **Program.cs** file.

## Check your work

Your app now uses LINQ to build a cross-partition query that your developer team natively understands. Here, you will run the application one last time to ensure that all queries return the results you expected.

### [Run application](#tab/run-app)

1. Run the .NET application in the terminal

    ```dotnetcli
    dotnet run
    ```  

1. Observe the output of running the application. The output should match the example here.

    ```output

    ```

### [Review code](#tab/review-code)

1. Review the **Program.cs** code file to make sure that the code you added matches this sample.

    ```csharp

    ```

---
