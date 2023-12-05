Once you create an Azure OpenAI Resource, you must deploy a model before you can start making API calls and generating text. This action can be done by using the Deployment APIs. These APIs allow you to specify the model you wish to use.

## Deployments

Deployments provide endpoints configured with settings to meet your needs, including the content moderation model, version handling, and deployment size, to the Azure OpenAI base models.

> [!IMPORTANT]
> You get two things from the deployment:
>
> - An Endpoint which is a link that you can use to call your model or make HTTP requests.
> - An API Key which is used to make authenticated requests to the endpoint. Think of the API Key as a password that gives you access to your account.

## Azure OpenAI Studio

Azure OpenAI Studio is a web-based interface that allows you to interact with Azure OpenAI Service. You can use the Playground to experiment with the service's capabilities by submitting prompts and generating completions. You can also use the Studio to manage your deployments and models. To log in to Azure OpenAI Studio:

- Navigate directly to the interface, select your subscription, and select your cloud resource.
- Navigate to the site via the cloud resource blade in the Azure portal.

## What can I do with Azure OpenAI Studio

- Create and manage deployments.
- Use the playground to test functionality.
- Work with data files for training.
- Manage quotas.
- Filter content.

## Provision a model deployment by using Azure CLI

You know that the Azure CLI can be used instead of the Azure portal to deploy cloud resources, specifically a resource group and a cognitive services account. You can also use the Azure CLI to create a deployment on a cognitive services account by specifying the following fields:

- **The cognitive service account name**: to identify what account you're creating the model deployment for.
- **The resource group name**: logical bucket to store the created resources inside.
- **A deployment name (optional)**: to help identify different deployments from the same model. For example, you need a deployment name when sending requests programmatically. It defaults to the chosen model's name if it isn't specified.
- **A model name**: The name of your chosen model type. You need a specific type depending on what you're trying to do like text generation, chat, generating images and so on.
- **The model version**: Models come in different versions.
- **The model format**: Models also come in different formats.
- **A SKU capacity (optional)** for the cognitive service deployment.
- **A SKU name (optional)** for the cognitive service deployment.

Here's an example of how to create your cognitive service deployment. Change the code to fit your circumstances.

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
> In order to use the newly created deployment from the CLI, you need to retrieve the deployment's endpoint URL and key using other commands, which you can learn more about in [the documentation]( /azure/ai-services/openai/how-to/create-resource?pivots=cli).
