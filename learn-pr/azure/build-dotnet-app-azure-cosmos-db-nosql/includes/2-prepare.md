You're building a .NET application that imports and queries data in an Azure Cosmos DB for NoSQL container. Here, we discuss the overall goals of the project and how you implement the import and query functionality. Additionally, we cover how to set up the API for NoSQL account that you need.

:::image type="content" source="../media/project-visual-account.svg" alt-text="Illustration of the icon of an Azure Cosmos DB account." border="false":::

## Project overview

This project's goal is to build and validate a .NET console application that uploads and queries items in an API for NoSQL container. The .NET application uses the .NET SDK for Azure Cosmos DB for NoSQL to interact with a service instance in Azure. The project code uses transactional batches to create multiple related items simultaneously. The project code also uses queries, represented as strings, to validate that the items were successfully uploaded.

The following flowchart shows the business logic the app needs to perform:

:::image type="complex" source="../media/diagram-flowchart.png" alt-text="Diagram of a flowchart showing steps to create and submit client batches." lightbox="../media/diagram-flowchart.png" border="false":::
Diagram of a flowchart showing steps to authenticate the client. The flowchart then shows a batch creation step that combines the creation of four individual items. Finally, the flow chart shows the sequence to create, execute, and observe the results of a query.
:::image-end:::

The key tasks you need to do are:

01. Create an Azure Cosmos DB account and retrieve the connection string.
01. Create a .NET console application and add a package reference to the [Microsoft.Azure.Cosmos](https://www.nuget.org/packages/Microsoft.Azure.Cosmos) SDK.
01. Create database and container resources.
01. Add a single item as a simple operation.
01. Create a transactional batch to add four items.
01. Execute and observe the results of a query.

> [!IMPORTANT]
> All steps in this project are designed to be completed within Visual Studio Code either locally or through GitHub Codespaces.

## Setup

To complete this project, you need an API for NoSQL account.

### Create Azure Cosmos DB for NoSQL account

The API for NoSQL account is used to store the data you create in this project and to execute queries. This section guides you through the steps to creating a new account using the Azure CLI directly in the Azure Cloud Shell terminal.

01. Create a new shell variable named **suffix** with a random number and then output the number to the console.

    ```azurecli
    let suffix=$RANDOM*$RANDOM
    
    echo $suffix
    ```

01. Create another shell variable named **accountName** that appends the randomly generated suffix to `mslearn-` and then outputs the result.

    ```azurecli
    accountName="mslearn-$suffix"
    
    echo $accountName
    ```

01. Create two more shell variables for `resourceGroup` and `location` with the values prescribed here.

    ```azurecli
    resourceGroup="<rgn>[sandbox resource group name]</rgn>"
    location="westus"
    ```

    > [!IMPORTANT]
    > The sandbox will automatically create a resource group for you with the name specified in this code sample.

01. Create a new API for NoSQL account using the three shell variables you created.

    ```azurecli
    az cosmosdb create \
        --resource-group $resourceGroup \
        --name $accountName \
        --locations regionName=$location
    ```

01. Wait for the command to complete once the new account is created. Creating a new account can take a couple of minutes.

### Get account connection string

Now that you have an API for NoSQL account, you can use the `az cosmosdb keys list` command from the Azure CLI to get credentials. In this section, you filter the output of the command to only return a single connection string.

01. First, list all of the credentials available for this account. Use the `--type` parameter to only return connection strings.

    ```azurecli
    az cosmosdb keys list \
        --resource-group $resourceGroup \
        --name $accountName \
        --type connection-strings \
        --output table
    ```

01. Now, add the `--query` parameter to filter to specifically the `Primary SQL Connection String`.

    ```azurecli
    az cosmosdb keys list \
        --resource-group $resourceGroup \
        --name $accountName \
        --type connection-strings \
        --query "connectionStrings[?description=='Primary SQL Connection String'].connectionString" \
        --output tsv
    ```

01. Record the value of this connection string. You use the connection string later in this project to connect to this account.

### Configure dev environment

All your development work in this project is done directly in [Visual Studio Code](https://code.visualstudio.com). You have the option of using Visual Studio Code locally or with GitHub Codespaces.

#### [GitHub Codespaces](#tab/github-codespaces)

GitHub Codespaces runs your development environment in a container hosted by GitHub. For the most straightforward development environment, use GitHub Codespaces so that you have the correct developer tools and dependencies preinstalled on your machine to complete this training module.

1. Create a new GitHub Codespace on the `main` branch of the [`azure-samples/dotnet-env-azure-cosmos-db`](https://github.com/azure-samples/dotnet-env-azure-cosmos-db) GitHub repository.

    > [!div class="nextstepaction"]
    > [Open this project in GitHub Codespaces](https://github.com/azure-samples/dotnet-env-azure-cosmos-db/codespaces)

1. Wait for the codespace to start. This startup process can take a few minutes.

1. Open a new terminal in the codespace.

    > [!TIP]
    > You can use the main menu to navigate to the **Terminal** menu option and then select the **New Terminal** option.
    >
    > :::image type="content" source="media/open-terminal-option.png" lightbox="media/open-terminal-option.png" alt-text="Screenshot of the codespaces menu option to open a new terminal.":::

#### [Visual Studio Code](#tab/visual-studio-code)

Optionally, you can walk through this training module using Visual Studio Code installed on your local machine. To run this project locally, you must have the following software installed:

- [.NET 7 or later](https://dotnet.microsoft.com/download)

---
