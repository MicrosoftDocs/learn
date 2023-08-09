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

1. Create a new shell variable named **suffix** with a random number and then output the number to the console.

    ```azurecli
    let suffix=$RANDOM*$RANDOM
    
    echo $suffix
    ```

1. Create another shell variable named **accountName** that appends the randomly generated suffix to `mslearn-` and then outputs the result.

    ```azurecli
    accountName="mslearn-$suffix"
    
    echo $accountName
    ```

1. Create two more shell variables for `resourceGroup` and `location` with the values prescribed here.

    ```azurecli
    resourceGroup="<rgn>[sandbox resource group name]</rgn>"
    location="westus"
    ```

    > [!IMPORTANT]
    > The sandbox will automatically create a resource group for you with the name specified in this code sample.

1. Create a new API for NoSQL account using the three shell variables you created.

    ```azurecli
    az cosmosdb create \
        --resource-group $resourceGroup \
        --name $accountName \
        --locations regionName=$location
    ```

1. Wait for the command to complete once the new account is created. Creating a new account can take a couple of minutes.

### Get account connection string

Now that you have an API for NoSQL account, you can use the `az cosmosdb keys list` command from the Azure CLI to get credentials. In this section, you filter the output of the command to only return a single connection string.

1. First, list all of the credentials available for this account. Use the `--type` parameter to only return connection strings.

    ```azurecli
    az cosmosdb keys list \
        --resource-group $resourceGroup \
        --name $accountName \
        --type connection-strings \
        --output table
    ```

1. Now, add the `--query` parameter to filter to specifically the `Primary SQL Connection String`.

    ```azurecli
    az cosmosdb keys list \
        --resource-group $resourceGroup \
        --name $accountName \
        --type connection-strings \
        --query "connectionStrings[?description=='Primary SQL Connection String'].connectionString" \
        --output tsv
    ```

1. Record the value of this connection string. You'll use the connection string later in this project to connect to this account.

### Configure dev environment

A [development container](https://containers.dev/) environment is available with all dependencies required to complete every exercise in this project. You can run the development container in GitHub Codespaces or locally using Visual Studio Code.

#### [GitHub Codespaces](#tab/github-codespaces)

[GitHub Codespaces](https://docs.github.com/codespaces) runs a development container managed by GitHub with [Visual Studio Code for the Web](https://code.visualstudio.com/docs/editor/vscode-web) as the user interface. For the most straightforward development environment, use GitHub Codespaces so that you have the correct developer tools and dependencies preinstalled to complete this training module.

> [!IMPORTANT]
> All GitHub accounts can use Codespaces for up to 60 hours free each month with 2 core instances. For more information, see [GitHub Codespaces monthly included storage and core hours](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).

1. Start the process to create a new GitHub Codespace on the `main` branch of the [`azure-samples/dotnet-env-azure-cosmos-db`](https://github.com/azure-samples/dotnet-env-azure-cosmos-db) GitHub repository.

    > [!div class="nextstepaction"]
    > [Open this project in GitHub Codespaces](https://github.com/codespaces/new?azure-portal=true&hide_repo_select=true&ref=main&repo=621314195)

1. On the **Create codespace** page, review the codespace configuration settings and then select **Create new codespace**

    :::image type="content" source="../media/codespace-configuration.png" alt-text="Screenshot of the confirmation screen before creating a new codespace.":::

1. Wait for the codespace to start. This startup process can take a few minutes.

1. Open a new terminal in the codespace.

    > [!TIP]
    > You can use the main menu to navigate to the **Terminal** menu option and then select the **New Terminal** option.
    >
    > :::image type="content" source="../media/open-terminal-option.png" lightbox="../media/open-terminal-option.png" alt-text="Screenshot of the codespaces menu option to open a new terminal.":::

1. Validate that .NET 7 is installed in your environment:

    ```bash
    dotnet --list-sdks
    ```

1. Close the terminal.

1. The remaining exercises in this project take place in the context of this development container.

#### [Visual Studio Code](#tab/visual-studio-code)

The [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for Visual Studio Code requires [Docker](https://docs.docker.com/) to be installed on your local machine. The extension hosts the development container locally using the Docker host with the correct developer tools and dependencies preinstalled to complete this training module.

1. Open **Visual Studio Code** in the context of an empty directory.

1. Ensure that you have the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) installed in Visual Studio Code.

1. Open a new terminal in the editor.

    > [!TIP]
    > You can use the main menu to navigate to the **Terminal** menu option and then select the **New Terminal** option.
    >
    > :::image type="content" source="../media/open-terminal-option.png" lightbox="../media/open-terminal-option.png" alt-text="Screenshot of the menu option to open a new terminal.":::

1. Clone the [`azure-samples/dotnet-env-azure-cosmos-db`](https://github.com/azure-samples/dotnet-env-azure-cosmos-db) GitHub repository into the current directory.

    ```bash
    git clone https://github.com/azure-samples/dotnet-env-azure-cosmos-db.git .
    ```

1. Open the folder into which you cloned the GitHub repository.
1. Open the **Command Palette**, search for the **Dev Containers** commands, and then select **Dev Containers: Reopen in Container**.

    :::image type="content" source="../media/reopen-container-command-palette.png" alt-text="Screenshot of the Command Palette option to reopen the current folder within the context of a development container.":::

    > [!TIP]
    > Visual Studio Code might automatically prompt you to reopen the existing folder within a development container. This is functionally equivalent to using the command palette to reopen the current workspace in a container.
    >
    > :::image type="content" source="../media/reopen-container-toast.png" alt-text="Screenshot of a toast notification to reopen the current folder within the context of a development container.":::

1. Validate that .NET 7 is installed in your environment:

    ```bash
    dotnet --list-sdks
    ```

1. Close the terminal.

1. The remaining exercises in this project take place in the context of this development container.

---
