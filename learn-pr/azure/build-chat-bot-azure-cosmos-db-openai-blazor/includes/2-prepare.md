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

### Observe the running final application

After the deployment is complete, you can retrieve the output of the deployment to find the URI of the currently running application. Use this moment to learn how the application is intended to work after you are done with this project.

### Get Azure Cosmos DB for NoSQL account credentials

Now that you have an Azure Cosmos DB for NoSQL account, use the `az cosmosdb` command group from the Azure CLI to get the account's credentials. In this section, you filter the output of the various commands to return your endpoint and connection string to use with the Azure Cosmos DB for NoSQL .NET SDK.

### Get Azure OpenAI account credentials

Now that you have an Azure OpenAI account with a ChatGPT model deployed, use the `az rest` command from the Azure CLI to get the account's credentials. In this section, use the REST API to return your endpoint and connection string to use with the Azure OpenAI .NET SDK.

### Configure dev environment

All steps in this project are designed to be completed within a [development container](https://containers.dev/). You can run the development container in GitHub Codespaces or locally using Visual Studio Code.

#### [GitHub Codespaces](#tab/github-codespaces)

#### [Visual Studio Code](#tab/visual-studio-code)

---
