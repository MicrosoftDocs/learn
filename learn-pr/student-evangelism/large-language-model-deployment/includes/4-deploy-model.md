After you create an Azure OpenAI resource, you must deploy a model to kickstart your API calls and text generation. Use the deployment APIs to choose and deploy your model.

## Deployments

Deployment provides an endpoint to the Azure OpenAI base model, or model of your choice, that's tailored to meet your needs, including the content moderation model, version handling, and deployment size.

> [!IMPORTANT]
> After deployment, you'll receive two key items:
>
> - An endpoint, which is a link that you can use to call your model or make HTTP requests.
> - An API key, which acts like a password to authenticate requests to the endpoint and grant access to your account.

## Azure OpenAI Studio

Azure OpenAI Studio is a web-based interface that allows you to interact with Azure OpenAI Service. You can use the playground to experiment with service capabilities by submitting prompts and generating completions. You can also use Azure OpenAI Studio to manage your deployments and models. To sign in to Azure OpenAI Studio:

- Navigate directly to the interface, select your subscription, and select your cloud resource.<br>
Or<br>
- Navigate to the site via the cloud resource blade in the Azure portal.

## What you can do with Azure OpenAI Studio

- Create and manage deployments.
- Test functionality in the playground.
- Handle data files for training.
- Manage quotas.
- Filter content.

## Provision a model deployment by using the Azure CLI

The Azure CLI can be used instead of the Azure portal to deploy cloud resources. You can also use the Azure CLI to create a model deployment by specifying:

- **The resource name** to identify the account for which you're creating the model deployment.
- **The resource group name**, which acts as the logical bucket to store the created resource.
- **A deployment name (optional)** to help identify different deployments from the same model. For example, you must have a deployment name when you send requests programmatically. The default is the chosen model's name if a deployment name isn't specified.
- **The model type name**. Enter the specific model type, depending on what you're trying to do. For example, enter _text generation_, _chat_, or _generating images_.
- **The model format**.
- **The SKU capacity value (optional)**.
- **The SKU name (optional)**.

Here's an example of how to create your model deployment. Change the code to fit your needs.

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
> To use the newly created deployment from the CLI, you need to retrieve the endpoint URL and API key. For more information, see [Create and deploy an Azure OpenAI Service resource]( /azure/ai-services/openai/how-to/create-resource?pivots=cli).
