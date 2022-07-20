You'll be building a .NET application that imports and queries data in an Azure Cosmos DB SQL API container. Here, we'll discuss the overall goals of the project and how you'll implement the import and query functionality. We'll also cover how to set up the SQL API account that you'll need.

## Project overview

This project's goal is to build and validate a .NET console application that uploads and queries items in a SQL API container. The .NET application will use the .NET SDK for Azure Cosmos DB SQL API to interact with a service instance in Azure. The project code will use transactional batches to create multiple related items simultaneously. The project code will also use SQL queries, represented as strings, to validate that the items were successfully uploaded.

The following flowchart shows the business logic the app needs to perform:

[![Diagram of a flowchart showing steps to authenticate the client. The flowchart then shows a batch creation step that combines the creation of four individual items. Finally, the flow chart shows the sequence to create, execute, and observe the results of a SQL query.](../media/diagram-flowchart.png)](../media/diagram-flowchart.png)

The key tasks you'll need to do are:

1. Create an Azure Cosmos DB account and retrieve the connection string.
1. Create a .NET console application and import the **Microsoft.Azure.Cosmos** SDK library.
1. Authenticate the SDK client using the connection string.
1. Create database and container resources.
1. Add a single item as a simple operation.
1. Create a transactional batch to add four items.
1. Execute and observe the results of a SQL query.

> [!IMPORTANT]
> All steps in this project are designed to be completed within the Azure Cloud Shell terminal.

## Setup

To complete this project, you'll need a SQL API account.

### Create Azure Cosmos DB SQL API account

The SQL API account will be used to store the data you create in this project and to execute queries. All your work in this project will be done directly in the Azure Cloud Shell terminal. This section guides you through the steps to creating a new account using the Azure CLI directly in the terminal.

1. Create a new shell variable named **suffix** with a random number and then output the number to the console.

    ```azurecli
    let suffix=$RANDOM*$RANDOM
    
    echo $suffix
    ```

1. Create another shell variable named **accountName** that appends the randomly generated suffix to ``mslearn-`` and then outputs the result.

    ```azurecli
    accountName="mslearn-$suffix"
    
    echo $accountName
    ```

1. Create two more shell variables for ``resourceGroup`` and ``location`` with the values prescribed here.

    ```azurecli
    resourceGroup="<rgn>[sandbox resource group name]</rgn>"
    location="westus"
    ```

    > [!IMPORTANT]
    > The sandbox will automatically create a resource group for you with the name specified in this code sample.

1. Create a new SQL API account using the three shell variables you created.

    ```azurecli
    az cosmosdb create \
        --resource-group $resourceGroup \
        --name $accountName \
        --locations regionName=$location
    ```

1. Wait for the command to complete once the new account is created. Creating a new account can take a couple of minutes.

### Get account connection string

Now that you have a SQL API account, you can use the ``az cosmosdb keys list`` command from the Azure CLI to get credentials. In this section, you'll filter the output of the command to only return a single connection string.

1. First, list all of the credentials available for this account. Use the ``--type`` parameter to only return connection strings.

    ```azurecli
    az cosmosdb keys list \
        --resource-group $resourceGroup \
        --name $accountName \
        --type connection-strings \
        --output table
    ```

1. Now, add the ``--query`` parameter to filter to specifically the ``Primary SQL Connection String``.

    ```azurecli
    az cosmosdb keys list \
        --resource-group $resourceGroup \
        --name $accountName \
        --type connection-strings \
        --query "connectionStrings[?description=='Primary SQL Connection String'].connectionString" \
        --output tsv
    ```

1. Observe the value of this connection string. You'll use the connection string later in this project.
