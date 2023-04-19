You're updating an existing .NET solution that has an ASP.NET Blazor WebAssembly application as it's sole project. This project includes service classes for data storage and conversation that are minimally implemented with placeholders. Here, we discuss the overall goals of the project and how you are going to implement the data store and conversational functionality. Additionally, we cover how to set up the Azure resources that you need.

## Project overview

This project's goal is to implement two service classes for data storage and conversation. For the data storage service class, you will use the Azure Cosmos DB for NoSQL .NET SDK to create, update, query, and delete multiple items in a pre-existing container. You will

The key tasks you need to do are:

1. Deploy the finished ASP.NET Blazor sample solution to Azure.
1. Get the credentials for the deployed Azure Cosmos DB for NoSQL and Auzre OpenAI resources.
1. Open the starter solution in Visual Studio Code.
1. Use the .NET SDK to implement Azure Cosmos DB for NoSQL as a data storage service.
1. Use the .NET SDK to implement Azure OpenAI as a conversational interface.
1. Validate that the application works successfully.

## Setup

To complete this project, you need an Azure Cosmos DB for NoSQL account and an Azure OpenAI account. To streamline this process, you will deploy a Bicep template to Azure with both of these accounts and the final application running in Azure App Service.

### Deploy Bicep template

This project uses the [azure-samples/cosmosdb-chatgpt](https://github.com/Azure-Samples/cosmosdb-chatgpt) GitHub repository for both the Azure Resource Manager templated deployment and the application code. In this step, create a new deployment using the Bicep template from this repository.

1.

### Observe the running final application

After the deployment is complete, you can retrieve the output of the deployment to find the URI of the currently running application. Use this moment to learn how the application is intended to work after you are done with this project.

1.

### Get Azure Cosmos DB for NoSQL account credentials

Now that you have an Azure Cosmos DB for NoSQL account, use the `az cosmosdb` command group from the Azure CLI to get the account's credentials. In this section, you filter the output of the various commands to return your endpoint and connection string to use with the Azure Cosmos DB for NoSQL .NET SDK.

1.

### Get Azure OpenAI account credentials

Now that you have an Azure OpenAI account with a ChatGPT model deployed, use the `az rest` command from the Azure CLI to get the account's credentials. In this section, use the REST API to return your endpoint and connection string to use with the Azure OpenAI .NET SDK.

1.

### Configure dev environment

All steps in this project are designed to be completed within a [development container](https://containers.dev/). You can run the development container in GitHub Codespaces or locally using Visual Studio Code.

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
    > :::image type="content" source="../media/open-terminal-option.png" lightbox="../media/open-terminal-option.png" alt-text="Screenshot of the menu option to open a new terminal." border="false":::

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

1. Open the **Command Palette*, search for the **Dev Containers** settings, and then select **Dev Containers: Reopen in Container**.

    :::image type="content" source="../media/reopen-container-command-palette.png" alt-text="Screenshot of the Command Palette option to reopen the current folder within the context of a development container.":::

    > [!TIP]
    > Visual Studio Code may automatically prompt you to reopen the existing folder within a development container. This is functionally equivalent to using the command pallete to reopen the current workspace in a container.
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

---
