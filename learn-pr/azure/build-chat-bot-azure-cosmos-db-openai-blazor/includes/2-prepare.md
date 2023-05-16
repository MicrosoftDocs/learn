You're updating an existing .NET solution that has an ASP.NET Blazor application as it's sole project. This project includes service classes for data storage and conversation that are implemented with placeholders. Here, we discuss the overall goals of the project and how you're going to implement the data store and conversational functionality. Additionally, we cover how to set up the Azure resources that you need.

## Project overview

This project's goal is to implement two service classes for data storage and completions. For the data storage service class, use the Azure Cosmos DB for NoSQL .NET SDK to create, update, query, and delete multiple items in a pre-existing container.

The key tasks you need to do are:

1. Deploy the finished ASP.NET Blazor sample solution to Azure.
1. Get the credentials for the deployed Azure Cosmos DB for NoSQL and Azure OpenAI resources.
1. Open the starter solution in Visual Studio Code.
1. Use the .NET SDK to implement Azure Cosmos DB for NoSQL as a data storage service.
1. Use the .NET SDK to implement Azure OpenAI as a conversational interface.
1. Validate that the application works successfully.

## Setup

To complete this project, you need an Azure Cosmos DB for NoSQL account and an Azure OpenAI account. To streamline this process, deploy a Bicep template to Azure with both of these accounts and the final application running in Azure App Service.

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

### Observe the deployed application

After the deployment is complete, you can retrieve the output of the deployment to find the URI of the currently running application. Use this moment to learn how the application is intended to work after you're done with this project.

1. Use [`az group deployment show`](/cli/azure/group/deployment#az-group-deployment-show) to get the output from the previous deployment. The output should include the URL for the deployed web application.

    ```azurecli
    az deployment group show \
      --resource-group $resourceGroupName \
      --name zero-touch-deployment \
      --query "{ApplicationURL: properties.outputs.deployedUrl.value}" \
      --output table
    ```

    Assuming the name of the Azure App Service web app is **nybncrsna76fo-web**, an example output would be:

    ```output
    ApplicationURL
    -----------------------------------
    nybncrsna76fo-web.azurewebsites.net
    ```

1. In a new browser window, open the deployed web application. Take this moment to try to ask the AI assistant a few questions. Create at least two chat conversations. You come back to these conversations later in this project.

    :::image type="content" source="../media/running-final-application.png" lightbox="../media/running-final-application.png" alt-text="Screenshot of the deployed web application using Azure OpenAI.":::

1. Optionally, navigate to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) to view your resource group, data store (Azure Cosmos DB), AI model (Azure OpenAI), and running web application (Azure App Service).

### Get Azure Cosmos DB for NoSQL and Azure OpenAI account credentials

Your template deployed Azure Cosmos DB for NoSQL and Azure OpenAI accounts and then stored their credentials in the Azure App Service web app's configuration. Now, use `az webapp config` from the Azure CLI to get these credentials to use in your local development environment. In this section, you filter the output of the various commands to return your endpoint and connection string to use with the .NET SDKs of both Azure OpenAI and Azure Cosmos DB for NoSQL.

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

### Configure dev environment

A [development container](https://containers.dev/) environment is available with all dependencies required to complete every exercise in this project. You can run the development container in GitHub Codespaces or locally using Visual Studio Code.

#### [GitHub Codespaces](#tab/github-codespaces)

[GitHub Codespaces](https://docs.github.com/codespaces) runs a development container managed by GitHub with [Visual Studio Code for the Web](https://code.visualstudio.com/docs/editor/vscode-web) as the user interface. For the most straightforward development environment, use GitHub Codespaces so that you have the correct developer tools and dependencies preinstalled to complete this training module.

1. Create a new GitHub Codespace on the `start` branch of the [`azure-samples/cosmosdb-chatgpt`](https://github.com/azure-samples/cosmosdb-chatgpt) GitHub repository.

    > [!div class="nextstepaction"]
    > [Open this project in GitHub Codespaces](https://github.com/codespaces/new?azure-portal=true&hide_repo_select=true&ref=start&repo=612006455)

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
