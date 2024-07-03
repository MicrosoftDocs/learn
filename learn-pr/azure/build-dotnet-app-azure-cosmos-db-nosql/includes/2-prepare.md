You're building a .NET application that imports and queries data in an Azure Cosmos DB for NoSQL container. Here, we discuss the overall goals of the project and how you implement the import and query functionality. Additionally, we cover how to set up the API for NoSQL account that you need.

:::image type="content" source="../media/project-visual-account.svg" alt-text="Illustration of the icon of an Azure Cosmos DB account." border="false":::

## Project overview

This project's goal is to build and validate a .NET console application that uploads and queries items in an API for NoSQL container. The .NET application uses the .NET SDK for Azure Cosmos DB for NoSQL to interact with a service instance in Azure. The project code uses transactional batches to create multiple related items simultaneously. The project code also uses queries, represented as strings, to validate that the items were successfully uploaded.

The following flowchart shows the business logic the app needs to perform:

:::image type="complex" source="../media/diagram-flowchart.png" alt-text="Diagram of a flowchart showing steps to create and submit client batches." lightbox="../media/diagram-flowchart.png" border="false":::
Diagram of a flowchart showing steps to authenticate the client. The flowchart then shows a batch creation step that combines the creation of four individual items. Finally, the flow chart shows the sequence to create, execute, and observe the results of a query.
:::image-end:::

The key tasks you need to do are:

1. Create an Azure Cosmos DB account and retrieve the connection string.
1. Create a .NET console application and add a package reference to the [Microsoft.Azure.Cosmos](https://www.nuget.org/packages/Microsoft.Azure.Cosmos) SDK.
1. Create database and container resources.
1. Add a single item as a simple operation.
1. Create a transactional batch to add four items.
1. Execute and observe the results of a query.

## Setup

To complete this project, you need an API for NoSQL account.

### Create Azure Cosmos DB for NoSQL account

The API for NoSQL account is used to store the data you create in this project and to execute queries. This section guides you through the steps to creating a new account using the Azure CLI directly in the Azure Cloud Shell terminal.

1. Create a new shell variable named **suffix** with a random number. Create a new API for NoSQL account within the **<rgn>[sandbox resource group name]</rgn>** resource group.

    ```azurecli
    let suffix=$RANDOM*$RANDOM

    az cosmosdb create \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --name "mslearn-$suffix" \
        --locations "regionName=westus"
    ```

    > [!IMPORTANT]
    > This resource group was already created by the sandbox.

1. Wait for the command to complete once the new account is created. Creating a new account can take a couple of minutes.

    > [!TIP]
    > You can navigate to your new API for NoSQL account using the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

### Get account connection string

Now that you have an API for NoSQL account, you can use the `az cosmosdb keys list` command from the Azure CLI to get the account's credentials. In this section, you filter the output of the command to only return a single connection string.

1. First, get the name of the most recently created API for NoSQL accounts.

    ```azurecli
    let resourceGroup="<rgn>[sandbox resource group name]</rgn>"
    
    az cosmosdb list \
        --resource-group $resourceGroup \
        --query "sort_by([].{name:name,created:systemData.createdAt}, &created)" \
        --output table
    ```

1. Now, get the `Primary SQL Connection String` credential for the first account from the list of recently created accounts.

    ```azurecli
    let resourceGroup="<rgn>[sandbox resource group name]</rgn>"

    az cosmosdb keys list \
        --resource-group $resourceGroup \
        --name $(az cosmosdb list \
            --resource-group $resourceGroup \
            --query "sort_by([].{name:name,created:systemData.createdAt}, &created)[0].name" \
            --output tsv) \
        --type connection-strings \
        --query "connectionStrings[?description=='Primary SQL Connection String'].connectionString" \
        --output tsv
    ```

1. Record the value of this connection string. You use the connection string later in this project to connect to this account.

### Configure dev environment

A development container environment is available with all dependencies required to complete every exercise in this project. You can run the development container in GitHub Codespaces or locally using Visual Studio Code.

#### [Develop in browser](#tab/github-codespaces)

GitHub Codespaces runs a development container managed by GitHub with Visual Studio Code for the Web as the browser-based user interface. For the most straightforward development environment, use GitHub Codespaces so that you have the correct developer tools and dependencies preinstalled to complete this training module.

> [!IMPORTANT]
> All GitHub accounts can use Codespaces for up to 60 hours free each month with 2 core instances.

1. Create a new GitHub Codespace using the `azure-samples/cosmos-db-dotnet` template.

    [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/azure-samples/cosmos-db-dotnet?quickstart=1&azure-portal=true)

1. On the **Create codespace** page, review the codespace configuration settings, and then select **Create new codespace**.

1. Wait for the codespace to start. This startup process can take a few minutes.

1. Open a new terminal in the codespace.

1. Validate that .NET 8 is installed in your environment:

    ```bash
    dotnet --list-sdks
    ```

1. Close the terminal.

The remaining exercises in this project take place in the context of this development container.

#### [Develop locally](#tab/visual-studio-code)

The Dev Containers extension for Visual Studio Code requires Docker to be installed on your local machine. The extension hosts the development container locally using the Docker host with the correct developer tools and dependencies preinstalled to complete this training module.

1. Open the `azure-samples/cosmos-db-dotnet` template repository from GitHub within Visual Studio Code.

    [![Open in Dev Container](https://img.shields.io/static/v1?style=for-the-badge&label=Open+in+Visual+Studio+Code&message=Dev+container&color=blue&logo=visualstudiocode)](vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/azure-samples/cosmos-db-dotnet)

1. Open a new terminal.

1. Validate that .NET 8 is installed in your environment:

    ```bash
    dotnet --list-sdks
    ```

1. Close the terminal.

The remaining exercises in this project take place in the context of this development container.

---
