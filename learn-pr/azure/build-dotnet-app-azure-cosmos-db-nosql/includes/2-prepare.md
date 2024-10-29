You're building a .NET application that imports and queries data in an Azure Cosmos DB for NoSQL container. Here, we discuss the overall goals of the project and how you implement the import and query functionality. Additionally, we cover how to set up the API for NoSQL account that you need.

:::image type="content" source="../media/project-visual-account.svg" alt-text="Illustration of the icon of an Azure Cosmos DB account." border="false":::

## Project overview

This project's goal is to build and validate a .NET console application that uploads and queries items in an API for NoSQL container. The .NET application uses the .NET SDK for Azure Cosmos DB for NoSQL to interact with a service instance in Azure. The project code uses transactional batches to create multiple related items simultaneously. The project code also uses queries, represented as strings, to validate that the items were successfully uploaded.

The following flowchart shows the business logic the app needs to perform:

:::image type="complex" source="../media/diagram-flowchart.png" alt-text="Diagram of a flowchart showing steps to create and submit client batches." lightbox="../media/diagram-flowchart.png" border="false":::
Diagram of a flowchart showing steps to authenticate the client. The flowchart then shows a batch creation step that combines the creation of four individual items. Finally, the flow chart shows the sequence to create, execute, and observe the results of a query.
:::image-end:::

The key tasks you need to do are:

1. Create an Azure Cosmos DB account and configure authentication.
1. Set up a .NET console application and add a package reference to the Azure SDK for .NET ([`Microsoft.Azure.Cosmos`](https://www.nuget.org/packages/Microsoft.Azure.Cosmos)).
1. Create database and container resources.
1. Add a single item as a simple operation.
1. Create four items using a transactional batch.
1. Execute and observe the results of a query.

## Setup

To complete this project, you need an API for NoSQL account.

### Sign in to Azure CLI

If you want to complete this exercise, you need to create an Azure subscription before you begin.

1. Verify that the Azure CLI is installed in your development environment.

    ```azurecli
    az --version
    ```

1. Sign in to the Azure CLI.

    ```azurecli
    az login
    ```

### Create Azure Cosmos DB for NoSQL account

The API for NoSQL account is used to store the data you create in this project and to execute queries. This section guides you through the steps to creating a new account using the Azure CLI directly in the Azure Cloud Shell terminal.

1. Create a new resource group named **learn-cosmos-db-dotnet-app**.

    ```azurecli
    az group create \
        --name "learn-cosmos-db-dotnet-app" \
        --location "westus"
    ```

    > [!TIP]
    > You can replace this location with any region available in your Azure subscription.

1. Create a new API for NoSQL account using a unique suffix within the resource group.

    ```azurecli
    az cosmosdb create \
        --resource-group "learn-cosmos-db-dotnet-app" \
        --name "mslearn-nosql-$((RANDOM*RANDOM))"
    ```

    > [!IMPORTANT]
    > This resource group was already created by the sandbox.

1. Wait for the command to complete once the new account is created. Creating a new account can take a couple of minutes.

    > [!TIP]
    > You can navigate to your new API for NoSQL account using the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

### Enable Microsoft Entra authentication for the endpoint

Now that you have an API for NoSQL account, you can use the `az cosmosdb` group of commands from the Azure CLI to get the account's information. In this section, you enable Microsoft Entra authentication for the account and get its endpoint.

1. First, get the name of the most recently created API for NoSQL accounts using `az cosmosdb list`. Record the name as you'll need it in the next step.

    ```azurecli
    az cosmosdb list \
        --resource-group "learn-cosmos-db-dotnet-app" \
        --query "sort_by([].{name:name,created:systemData.createdAt}, &created)[0].name"
    ```

1. Now, use `az cosmosdb show` to get the `documentEndpoint` for the account you created. Use the value of the account name you recorded in the previous step. Record this endpoint as you also use it to connect from the .NET SDK.

    ```azurecli
    az cosmosdb show \
        --resource-group "learn-cosmos-db-dotnet-app" \
        --name "<nosql-account-name>" \
        --query "documentEndpoint"
    ```

1. Next, use `az cosmosdb sql role definition show` to get the fully qualified unique identifier of the built-in **Cosmos DB Built-in Data Contributor** data plane role for your account. Record this value as it is used in an upcoming step.

    ```azurecli
    az cosmosdb sql role definition show \
        --resource-group "learn-cosmos-db-dotnet-app" \
        --account-name "<nosql-account-name>" \
        --id "00000000-0000-0000-0000-000000000002" \
        --query "id"
    ```

1. Then, use `az ad signed-in-user show` to get your current logged-in account's identifier. Record this value as it will be used in the next step.

    ```azurecli
    az ad signed-in-user show \
      --query "id"
    ```

1. Finally, assign the role to your currently logged-in account using `az cosmosdb sql role assignment create`. Use the role definition identifier, the principal identifier, and the account name recorded earlier in this section.

    ```azurecli
    az cosmosdb sql role assignment create \
        --resource-group "learn-cosmos-db-dotnet-app" \
        --account-name "<nosql-account-name>" \
        --role-definition-id "<fully-qualified-role-definition-id>"  \
        --principal-id "<principal-id>" \
        --scope "/"
    ```

### Create database and container resources

The Microsoft Entra authentication is only configured for items (or the data plane). You need to manually create your database and container resources using the Azure CLI. Use the account name you recorded in the previous section for these commands.

1. Use `az cosmosdb sql database create` to create your database.

    ```azurecli
    az cosmosdb sql database create \
        --resource-group "learn-cosmos-db-dotnet-app" \
        --account-name "<nosql-account-name>" \
        --name "cosmicworks"    
    ```

1. Next, use `az cosmosdb sql container create` to create your container.

    ```azurecli
    az cosmosdb sql container create \
        --resource-group "learn-cosmos-db-dotnet-app" \
        --account-name "<nosql-account-name>" \
        --database-name "cosmicworks" \
        --name "products" \
        --partition-key-path "/categoryId"
    ```
