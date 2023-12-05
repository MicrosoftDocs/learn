Azure OpenAI service provides REST API access to OpenAI's powerful language models including the GPT-4, GPT-35-Turbo, and Embeddings model series. 

To use these models, you must provision an Azure OpenAI service in your Azure subscription. You can do this by using the Azure portal or the Azure CLI.

After you provision the resource, you can use its **endpoint** and one of its keys to call the Azure OpenAI APIs from your code, or, try it out first in the **playground**.

## High-level deployment plan

1. Provision a resource.

1. Create a deployment, with a chosen large language model.

1. Use your large language model

## Provisioning options

There are two ways you can provision an Azure OpenAI resource. Which one you use is up to you.

- **Azure portal**: Azure portal offers a graphical user interface and can be a good option when you’re just starting out and want to learn more about cloud computing, and Azure OpenAI in particular.

- **Azure CLI**: If you run a business, the Azure CLI might be the preferred option because you can store, version control, and parameterize deployment scripts so you can reuse them elsewhere.

## Provision a resource by using Azure portal

Follow these steps to create a provision of Azure OpenAI in the Azure portal:

1.**Locate the cloud template** for Azure OpenAI via the top search bar of the Azure portal by typing "OpenAI."

1. **Create provisioning** from the Azure OpenAI landing page. You can manage other provisioned instances and create new ones.

1. **Inspect the provisioned resource** via the detail page of your provisioned resource. Here, you find the web endpoint and keys that you need to interface with your resource programmatically.

## Provision a resource in the Azure CLI

> [!NOTE]
> Before you proceed with this option, ensure that you have the [Azure CLI]( /cli/azure/install-azure-cli) installed.

A CLI tool has a few different advantages over the Azure portal and a graphical interface. Some of these advantages are:

- **Speed**: It's faster to create and manage your resources with a command line tool.

- **Repeatability**: The scripts you write to manage your cloud resources can be stored in a text file for later reuse.

- **Can be versioned**: Storing deployment scripts in a text file allows you to understand deployment history. By using version control, you can also see how your deployments change over time.

To create an Azure OpenAI service from the CLI, you need the following resources:

- **Resource group**: Think of resource groups as a logical bucket; all resources for the same app, or some other logical grouping, should be created within the same resource group to keep things in order.

- **Cognitive service account**: To create the needed resource for Azure OpenAI, you need a cognitive service account.

Here’s an example of how to create a resource group:

The following command creates a resource group called “resourceGroupName” in the East US location. You can change the name and location as you want, but the name needs to be unique to your subscription.

``` azurecli
az group create --name resourceGroupName --location eastus 
```

To create a cognitive services account, you need to mention the resource group you created, give it a name, a location, a type, a stock keeping unit (SKU) and your subscription ID.  

The following code is an example of how to create your cognitive service account. Change these values to fit your circumstances.

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
> SKUs governs the way you're billed for the resources you create. Currently, Azure OpenAI offers one SKU but the billing is based on the number of tokens you use. To learn more about pricing, see [Azure OpenAI Service – Pricing](https://azure.microsoft.com/pricing/details/cognitive-services/openai-service/). If you want to plan ahead to estimate and manage costs for Azure OpenAI resources, see [Plan to manage costs for Azure OpenAI Service](/azure/ai-services/openai/how-to/manage-costs).
