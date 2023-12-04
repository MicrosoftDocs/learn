Once you create an Azure OpenAI Resource, you must deploy a model before you can start making API calls and generating text. This action can be done using the Deployment APIs. These APIs allow you to specify the model you wish to use.

## Deployments

Deployments provide endpoints to the Azure OpenAI base models, or your fine-tuned models, configured with settings to meet your needs, including the content moderation model, version handling, and deployment size.

> [!IMPORTANT]
> You get two things from the deployment.
>
> - An Endpoint which is a link that you can use to call your model. (Make HTTP requests) 
> - An API Key which is used to make authenticated requests to the endpoint think of it as a password that gives you access to your account.

## Azure OpenAI Studio

Azure OpenAI Studio is a web-based interface that allows you to interact with Azure OpenAI Service. You can use the Playground to experiment with the service's capabilities by submitting prompts and generating completions. You can also use the Studio to manage your deployments and models. 

### Logging in

Two ways:

- Navigate directly to it, select your subscription, and select your cloud resource.
- Navigate to it via the cloud resource blade in the Azure portal.

### What can I do with Azure OpenAI Studio

- Create and manage deployments
- Use the playground to test functionality
- Work with data files for training
- Manage quotas
- Content filtering

## Provision a model deployment using Azure CLI

You’ve seen in a former concept unit that the Azure CLI can be used instead of the Azure portal to deploy cloud resources, specifically a resource group and a cognitive services account. You can also use Azure CLI to create a deployment on a cognitive services account. However, to make such provisioning, you need to specify the following fields:

- **The cognitive service account name**: to identify what account you’re creating the model deployment for.
- **The resource group name**: logical bucket to store the created resources inside.
- **A deployment name (optional)**: to help identify different deployments from the same model. For example, you will need it when sending requests programmatically. It will default to the chosen model’s name if this is not specified. It’s worth choosing a name depending on what you’re trying to do.
- **A model name**: This is the name of your chosen model type. You need a different type depending on what you’re trying to do like text generation, chat, generating images and so on.
- **The model version**: Models come in different versions.
- **The model format**: Models also come in different formats.
- **A SKU capacity (optional)** for the cognitive service deployment
- **A SKU name (optional)** for the cognitive service deployment.

Here is an example of how to create your cognitive service deployment. Change the code to fit your circumstances.

``` azurecli

az cognitiveservices account deployment create \
--name cognitiveServiceAccountName \
--resource-group resourceGroupName \
--deployment-name deploymentName \
--model-name gpt-35-turbo \
--model-version "0301" \
--model-format OpenAI \
--sku-capacity "1" \
--sku-name "Standard"

```

> [!NOTE]
> In order to use the newly created deployment from the CLI, you need to retrieve the deployment’s endpoint URL and key using other commands, which you can learn more about in [the documentation]( /azure/ai-services/openai/how-to/create-resource?pivots=cli).
