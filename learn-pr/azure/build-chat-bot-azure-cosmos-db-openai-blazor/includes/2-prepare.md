You're updating an existing .NET solution that has an ASP.NET Blazor application as it's sole project. This project includes service classes for data storage and conversation that are implemented with placeholders. Here, we discuss the overall goals of the project and how you're going to implement the data store and conversational functionality. Additionally, we cover how to set up the Azure resources that you need.

## Project overview

This project's goal is to implement two service classes for data storage and completions. For the data storage service class, use the Azure Cosmos DB for NoSQL .NET SDK to create, update, query, and delete multiple items in a pre-existing container. For chat completion, use the Azure OpenAI .NET SDK to send requests and parse responses.

The key tasks you need to do are:

1. Deploy Azure Cosmos DB for NoSQL and Azure OpenAI resources to Azure.
1. Get the credentials for the deployed Azure Cosmos DB for NoSQL and Azure OpenAI resources.
1. Open the starter solution in Visual Studio Code.
1. Use the .NET SDK to implement Azure Cosmos DB for NoSQL as a data storage service.
1. Use the .NET SDK to implement Azure OpenAI as a conversational interface.
1. Validate that the application works successfully.

## Setup

To complete this project, you need an Azure Cosmos DB for NoSQL account and an Azure OpenAI account. To streamline this process, deploy a Bicep template to Azure with both of these accounts.

> [!TIP]
> This "zero-touch" Bicep template also includes the final application running in Azure App Service. You can always check this out if you want to see a fully working solution.

### Deploy Bicep template

This project uses the [azure-samples/cosmosdb-chatgpt](https://github.com/Azure-Samples/cosmosdb-chatgpt) GitHub repository for both the Azure Resource Manager templated deployment and the application code. In this step, create a new deployment using the Bicep template from this repository.

1. Create a new shell variable named **resourceGroupName** with the name of the Azure resource group that has already been created on your behalf.

    ```azurecli
    resourceGroupName="<rgn>[sandbox resource group name]</rgn>"
    ```

1. Deploy the [azuredeploy.json](https://github.com/Azure-Samples/cosmosdb-chatgpt/blob/main/azuredeploy.json) template file to the resource group using [`az group deployment create`](/cli/azure/group/deployment#az-group-deployment-create).

    ```azurecli
    az deployment group create \
      --resource-group $resourceGroupName \
      --name zero-touch-deployment \
      --template-uri https://raw.githubusercontent.com/Azure-Samples/cosmosdb-chatgpt/main/azuredeploy.json
    ```

1. Wait for the deployment to complete before proceeding with this project.

    > [!NOTE]
    > On average, this deployment can take five to ten minutes.

### Get Azure Cosmos DB for NoSQL and Azure OpenAI account credentials

Your template deployed Azure Cosmos DB for NoSQL and Azure OpenAI accounts and then stored their credentials in the Azure App Service web app's configuration. Now, you have the choice of using the Azure portal or Azure CLI to retrieve the credentials for each service.

#### [Azure portal](#tab/azure-portal)

Use the [Azure portal](/azure/azure-portal) to get the credentials from the Azure OpenAI and Azure Cosmos DB resources.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. Select **Resource Groups** and then select the `<rgn>[sandbox resource group name]</rgn>` resource group.

    :::image type="content" source="../media/portal-resource-group.png" lightbox="media/portal-resource-group.png" alt-text="Screenshot of the resource group page with an Azure Cosmos DB and Azure OpenAI resource.":::

1. On the **Resource Groups** page, expand the **Essentials** panel and observe the **Deployments** header. The status for the deployment should be **Succeeded** at this point.

1. Now, select the **Azure Cosmos DB** account to navigate to the resource's page.

    :::image type="content" source="../media/portal-database-account.png" alt-text="Screenshot of the Azure Cosmos DB for NoSQL resource page.":::

1. Select the **Keys** option in the **Settings** section of the resource navigation menu. Record the value of the **URI** and **PRIMARY KEY** fields. You use these values later.

    :::image type="content" source="../media/portal-database-account-credentials.png" alt-text="Screenshot of the credentials for an Azure Cosmos DB for NoSQL account.":::

1. Return to the **Resource Groups** page. Select the **Azure OpenAI** account.

    :::image type="content" source="../media/portal-openai-account.png" alt-text="Screenshot of the Azure OpenAI resource page.":::

1. In the **Settings** section of the resource navigation menu, select **Keys and Endpoint**. Record the value of the **ENDPOINT** and **KEY 1** fields. You also use these values later.

    :::image type="content" source="../media/portal-openai-account-credentials.png" alt-text="Screenshot of the credentials for an Azure OpenAI account.":::

#### [Azure CLI](#tab/azure-cli)

Use `az webapp config` from the Azure CLI to get the Azure OpenAI and Azure Cosmos DB credentials to use in your local development environment. In this section, you filter the output of the various commands to return your endpoint and connection string to use with the .NET SDKs of both Azure OpenAI and Azure Cosmos DB for NoSQL.

1. First, get a list of all running web applications in your resource group using [`az webapp list`](/cli/azure/webapp#az-webapp-list)

    ```azurecli
    az webapp list \
      --resource-group $resourceGroupName \
      --query "[?state=='Running'].name"
    ```

    Assuming the name of the Azure App Service web app is **nybncrsna76fo-web**, an example output would be:

    ```output
    [
      "nybncrsna76fo-web"
    ]
    ```

1. Now, run the same query again but only return the first result from the array in tab-separated value (`tsv`) format.

    ```azurecli
    webAppName=$( \
      az webapp list \
        --resource-group $resourceGroupName \
        --query "[?state=='Running'].name | [0]" \
        --output tsv \
    )
    ```

    > [!TIP]
    > If you're not sure that your variable has the correct value, simply run `echo $webAppName` in the terminal to check the value.

1. Use [`az webapp config appsettings list`](/cli/azure/webapp/config/appsettings#az-webapp-config-appsettings-list) to get a list of application settings for the web app.

    ```azurecli
    az webapp config appsettings list \
      --name $webAppName \
      --resource-group $resourceGroupName
    ```

    Here's a truncated example of the output assuming the name of the Azure Cosmos DB for NoSQL account is **nybncrsna76fo-cosmos-nosql** and the name of the Azure OpenAI account is **nybncrsna76fo-openai**. The keys in this example are fictitious.

    ```output
    [
      {
        "setting": "COSMOSDB__ENDPOINT",
        "value": "https://nybncrsna76fo-cosmos-nosql.documents.azure.com:443/"
      },
      {
        "setting": "COSMOSDB__KEY",
        "value": "Aj2OSQqWhXfFzkITIi4MIbocWAAoBCUWnSPzHlQbDYA3TiyZCJlk8A6R1l6WqD45BxAG5vrsyQ4SCXEkPS1pLh=="
      },
      ...
      {
        "setting": "OPENAI__ENDPOINT",
        "value": "https://nybncrsna76fo-openai.openai.azure.com/"
      },
      {
        "setting": "OPENAI__KEY",
        "value": "4bf98cb194cdf0f9001eae3259a76ed8"
      },
      ...
    ]
    ```

1. Record the value of the endpoint and key for both the Azure Cosmos DB for NoSQL and Azure OpenAI accounts. You use these credentials later in this project to connect to each account.

---

### Configure dev environment

A [development container](https://containers.dev/) environment is available with all dependencies required to complete every exercise in this project. You can run the development container in GitHub Codespaces or locally using Visual Studio Code.

#### [GitHub Codespaces](#tab/github-codespaces)

[GitHub Codespaces](https://docs.github.com/codespaces) runs a development container managed by GitHub with [Visual Studio Code for the Web](https://code.visualstudio.com/docs/editor/vscode-web) as the user interface. For the most straightforward development environment, use GitHub Codespaces so that you have the correct developer tools and dependencies preinstalled to complete this training module.

> [!IMPORTANT]
> All GitHub accounts can use Codespaces for up to 60 hours free each month with 2 core instances. For more information, see [GitHub Codespaces monthly included storage and core hours](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).

1. Start the process to create a new GitHub Codespace on the `start` branch of the [`azure-samples/cosmosdb-chatgpt`](https://github.com/azure-samples/cosmosdb-chatgpt) GitHub repository:

    > [!div class="nextstepaction"]
    > [Open this project in GitHub Codespaces](https://github.com/codespaces/new?azure-portal=true&hide_repo_select=true&ref=start&repo=612006455)

1. On the **Create codespace** page, review the codespace configuration settings and then select **Create new codespace**

    :::image type="content" source="../media/codespace-configuration.png" alt-text="Screenshot of the confirmation screen before creating a new codespace.":::

1. Wait for the codespace to start. This startup process can take a few minutes.

1. Open a new terminal in the editor.

    > [!TIP]
    > You can use the main menu to navigate to the **Terminal** menu option and then select the **New Terminal** option.
    >
    > :::image type="content" source="../media/open-terminal-option.png" lightbox="../media/open-terminal-option.png" alt-text="Screenshot of the menu option to open a new terminal.":::

1. Validate that .NET 7 is installed in your environment:

    ```bash
    dotnet --list-sdks
    ```

    ```output
    7.0.203 [/usr/share/dotnet/sdk]
    ```

1. Build the .NET project

    ```bash
    dotnet build
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

1. Clone the [`azure-samples/cosmosdb-chatgpt`](https://github.com/azure-samples/cosmosdb-chatgpt) GitHub repository into the current directory.

    ```bash
    git clone https://github.com/Azure-Samples/cosmosdb-chatgpt.git .
    ```

1. Switch to the `start` branch of the repository.

    ```bash
    git checkout start
    ```

1. Open the **Command Palette**, search for the **Dev Containers** commands, and then select **Dev Containers: Reopen in Container**.

    :::image type="content" source="../media/reopen-container-command-palette.png" alt-text="Screenshot of the Command Palette option to reopen the current folder within the context of a development container.":::

    > [!TIP]
    > Visual Studio Code may automatically prompt you to reopen the existing folder within a development container. This is functionally equivalent to using the command palette to reopen the current workspace in a container.
    >
    > :::image type="content" source="../media/reopen-container-toast.png" alt-text="Screenshot of a toast notification to reopen the current folder within the context of a development container.":::

1. Validate that .NET 7 is installed in your environment:

    ```bash
    dotnet --list-sdks
    ```

    ```output
    7.0.203 [/usr/share/dotnet/sdk]
    ```

1. Build the .NET project

    ```bash
    dotnet build
    ```

1. Close the terminal.

1. The remaining exercises in this project take place in the context of this development container.

---
