Azure OpenAI Service provides REST API access to powerful language models, including the GPT-4, GPT-3.5-Turbo, and the Embeddings model series. 

To get started using these models, you must provision an Azure OpenAI Service resource in your Azure subscription. You can provision resources by using the Azure portal or the Azure CLI.

After you provision the resource, you can use its **endpoint** and one of its keys to call the Azure OpenAI APIs from your code. You can also test the resource in the **playground** before integrating it into your workflow.

## High-level deployment plan

To get started with your LLM, follow these basic steps:

1. Provision a resource.

1. Create a deployment with your chosen LLM.

1. Use your LLM.

## Provisioning options

You can set up an Azure OpenAI resource in two ways. The method you choose is up to you:

- **Azure portal**: The Azure portal offers a graphical user interface and is a good option for beginners who want to learn more about cloud computing and Azure OpenAI.

- **Azure CLI**:  The Azure CLI is ideal for businesses because it allows you to store, version-control, and parameterize deployment scripts, making it easy to reuse them elsewhere.

## Provision a resource by using the Azure portal

Follow these steps to provision an Azure OpenAI resource in the Azure portal:

1. **Locate the Azure OpenAI cloud template** in the portal by typing **OpenAI** in the top search bar.

1. **Initiate provisioning** from the Azure OpenAI landing page, where you can also manage existing instances and create new ones.

1. **Inspect the provisioned resource** via the detail page. You can find the web endpoint and keys that you need to interface with your resource programmatically on the detail page.

## Provision a resource by using the Azure CLI

> [!NOTE]
> Before you proceed, ensure that you have the [Azure CLI]( /cli/azure/install-azure-cli) installed.

A CLI tool has a few advantages over the Azure portal graphical interface. Some of these advantages are:

- **Speed**: Create and manage resources more quickly by using a command line tool.

- **Repeatability**: Store your cloud resource management scripts in text files for future use.

- **Versioning**: Keep track of deployment history and changes over time by using version control.

To create an Azure OpenAI Service resource from the CLI, ensure you have a **resource group**. Think of a resource group as a logical bucket. To stay organized, create all resources for the same app or logical grouping within the same resource group.

Here's an example of how to create a resource group:

- The following command creates a resource group called _resourceGroupName_ in the East US location. You can change the name and location as you want, but the name needs to be unique to your subscription.

    ``` azurecli
    az group create --name resourceGroupName --location eastus 
    ```

- The following code is an example of how to create an Azure OpenAI resource in the resource group. You must specify the resource group, name, location, type, SKU, and your subscription ID. Change the values to fit your needs.

    ``` azurecli
    
    az cognitiveservices account create \ 
    --name cognitiveServiceAccountName \ 
    --resource-group resourceGroupName \ 
    --location eastus \ 
    --kind OpenAI \ 
    --sku s0 \ 
    --subscription <subscriptionID> 
    
    ```

> [!IMPORTANT]
> SKUs determine billing, and Azure OpenAI currently offers one SKU based on token usage. To learn more about pricing, see [Azure OpenAI Service pricing](https://azure.microsoft.com/pricing/details/cognitive-services/openai-service/). For proactive cost management, see [Plan to manage costs for Azure OpenAI Service](/azure/ai-services/openai/how-to/manage-costs).
