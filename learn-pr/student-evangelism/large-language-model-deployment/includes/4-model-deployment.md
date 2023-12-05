Once you create an Azure OpenAI Resource, you must deploy a model before you can start making API calls and generating text. You can use the Deployment APIs to specify and deploy the model you wish to use.

## Deployments

Deployments provide endpoints that are configured to meet your needs, including the content moderation model, version handling, and deployment size, to the Azure OpenAI base models.

> [!IMPORTANT]
> You should receive two things from the deployment:
>
> - An Endpoint, which is a link that you can use to call your model or make HTTP requests.
> - An API Key, which is used to make authenticated requests to the endpoint. Think of the API Key as a password that gives you access to your account.

## Azure OpenAI Studio

Azure OpenAI Studio is a web-based interface that allows you to interact with Azure OpenAI Service. You can use the Studio Playground to experiment with the service's capabilities by submitting prompts and generating completions. You can also use the Studio to manage your deployments and models. To log in to Azure OpenAI Studio:

- Navigate directly to the interface, select your subscription, and select your cloud resource.
Or
- Navigate to the site via the cloud resource blade in the Azure portal.

## What can I do with Azure OpenAI Studio

- Create and manage deployments.
- Use the playground to test functionality.
- Work with data files for training.
- Manage quotas.
- Filter content.

## Provision a model deployment by using Azure CLI

The Azure CLI can be used instead of the Azure portal to deploy cloud resources, specifically a resource group and a cognitive services account. You can also use the Azure CLI to create a deployment on a cognitive services account by specifying the following fields:

- **The cognitive service account name** to identify what account you're creating the model deployment for.
- **The resource group name**, which acts as the logical bucket to store the created resources inside.
- **A deployment name (optional)** to help identify different deployments from the same model. For example, you need a deployment name when sending requests programmatically. It defaults to the chosen model's name if it isn't specified.
- **The model type name**. You'll need a specific model type depending on what you're trying to do like text generation, chat, generating images and so on.
- **The model version**.
- **The model format**.
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
> In order to use the newly created deployment from the CLI, you need to retrieve the deployment's endpoint URL and key using other commands, which you can learn more about in [Create and deploy an Azure OpenAI Service resource]( /azure/ai-services/openai/how-to/create-resource?pivots=cli).
