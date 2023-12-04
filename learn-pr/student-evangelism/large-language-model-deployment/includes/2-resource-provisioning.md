Azure OpenAI service provides REST API access to OpenAI's powerful language models including the GPT-4, GPT-35-Turbo, and Embeddings model series.

To use these models, you must provision an Azure OpenAI service in your Azure subscription. You can do this using the Azure portal or the Azure CLI.

After you provision the resource, you can use its **endpoint** and one of its **keys** to call the Azure OpenAI APIs from your code or try it out first in the **playground**.

## High-level deployment plan

1. Provision a resource
1. Create a deployment, with a chosen large language model
1. Use your large language model

## Provisioning options

There are two major options we'll describe how you can provision an Azure OpenAI resource. Which one you use is up to you.

- **Azure portal**. Here you use Azure portal to provision a resource. Azure portal offers a graphical user interface and can be a good option when you’re starting out and want to learn more about cloud computing and Azure OpenAI in particular.
- **Azure CLI.** The idea behind this approach is that you use a command line tool called Azure CLI to provision your cloud resources. When you run a business, this might be the preferred option, as these deployment scripts are something you can store, put under version control and parameterize so you can reuse them elsewhere.

### Provision a resource using Azure portal

At the high level, what you do is take the following steps to create a provision of Azure OpenAI:

1. **Locate the cloud template** for Azure OpenAI via the top search bar of the Azure portal by typing **OpenAI** inside it.
1. **Create provisioning** from the Azure OpenAI landing page. You can both manage other provisioned instances as well as create new ones.
1. **Inspect the provisioned resource** via the detail page of your provisioned resource. Here, you will find the web endpoint and keys that you need to interface with your resource programmatically.

### Provision a resource in the Azure CLI

> [!NOTE]
> Before you proceed with this option, should you choose to use it, check out the install page to install the [Azure CLI]( /cli/azure/install-azure-cli).

A CLI tool has a few different advantages over using the Azure portal and a graphical interface:

- **Fast**: It’s usually faster to create and manage your resources with a command line tool.
- **Repeatable**: The scripts you write to manage your cloud resources are something you can store in a text file for later reuse.
- **Can be versioned**: A huge benefit is that storing deployment scripts in a text file allows you to understand what’s been deployed. By putting it under version control, you can also see how your deployments changes over time.

To create an Azure OpenAI service from the CLI, you need the following resources at high level:

- **Resource group**: Think of resource groups as a logical bucket; all resources for the same app, or some other logical grouping, should be created within that same resource group for the sake of keeping things in order.
- **Cognitive service account**: To create the needed resource for Azure OpenAI we need a cognitive service account.

Here’s an example of how to create a resource group:

``` azurecli

az group create --name resourceGroupName --location eastus

```

The second part you need is a cognitive service account. To create it, you need to mention the resource group you’ve created, give it a name, a location, a type, a stock keeping unit (SKU) and your subscription ID.

The following code is an example of how to create your cognitive service account. Change these values to fit your circumstances.

``` azurecli

az cognitiveservices account create \
--name cognitiveServiceAccountName \
--resource-group resourceGroupName \
--location eastus \
--kind OpenAI \
--sku s0 \
--subscription \<subscriptionID>

```

> [!IMPORTANT]
> Stock keeping unit or SKU governs the way you are billed for the resources you create. Currently, Azure OpenAI offers one SKU but the billing is based on the number of tokens you use. To learn more about pricing, see the [Azure OpenAI Service – Pricing](https://azure.microsoft.com/pricing/details/cognitive-services/openai-service/). If you want to plan ahead to estimate and manage costs for Azure OpenAI resources, see the [Plan to manage costs for Azure OpenAI Service](/azure/ai-services/openai/how-to/manage-costs).
