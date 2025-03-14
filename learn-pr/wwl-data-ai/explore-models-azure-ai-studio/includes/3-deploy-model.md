When you develop a generative AI app, you need to integrate language models into your application. To be able to use a language model, you need to deploy the model. Let's explore how to deploy language models in the Azure AI Foundry, after first understanding why to deploy a model.

## Why to deploy a model

You train a model to generate output based on some input. To get value out of your model, you need a solution that allows you to send input to the model, which the model processes, after which the output is visualized for you.

With generative AI apps, the most common type of solution is a chat application that expects a user question, which the model processes, to generate an adequate response. The response is then visualized to the user as a response to their question.

:::image type="content" source="../media/request-endpoint.png" alt-text="Diagram of user question being processed by model deployed to endpoint.":::

You can integrate a language model with a chat application by deploying the model to an **endpoint**. An endpoint is a specific URL where a deployed model or service can be accessed. Each model deployment typically has its own unique endpoint, which allows different applications to communicate with the model through an **API** (**Application Programming Interface**).

When a user asks a question:

1. An API request is sent to the endpoint.
1. The endpoint specifies the model that processes the request.
1. The result is sent back to the app through an API response.

When you deploy a language model from the model catalog with the Azure AI Foundry, you get an endpoint, which consists of a **target URI** (Uniform Resource Identifier) and a unique **key**. For example, a target URI for a deployed GPT-3.5 model can be:

```
https://ai-aihubdevdemo.openai.azure.com/openai/deployments/gpt-35-turbo/chat/completions?api-version=2023-03-15-preview
```

The URI includes:

- Your **AI hub name**, for example `ai-aihubdevdemo`.
- Your deployed **model name**, for example `gpt-35-turbo`.
- The **task** for the model, for example `chat/completion`.

To protect your deployed models, each deployment comes with a key. You're only authorized to send and receive requests to and from the target URI, if you also provide the key to authenticate.

Now that you understand why you want to deploy a model, let's explore the deployment options with Azure AI Foundry.

## Deploy a language model with Azure AI Foundry

When you deploy a language model with Azure AI Foundry, you have several types available, which depend on the model you want to deploy.

:::image type="content" source="../media/model-deployment.png" alt-text="Diagram of relationship between model types and deployment options.":::

You can deploy:

- [Azure OpenAI models](/azure/ai-services/openai/concepts/models?azure-portal=true) like GPT-3.5 and GPT-4 with Azure OpenAI service and Azure AI model inference.
- Third-party models like DeepSeek-R1 as [Models as a Service](/azure/ai-foundry/model-inference/concepts/models?azure-portal=true) as part of Azure AI model inference or with [serverless APIs](/azure/ai-foundry/how-to/model-catalog-overview#content-safety-for-models-deployed-via-serverless-apis?azure-portal=true).
- Open and custom models like models from Hugging Face with your own [user-managed compute](/azure/ai-foundry/how-to/model-catalog-overview#availability-of-models-for-deployment-as-managed-compute?azure-portal=true).

The associated cost will depend on the type of model you deploy, which deployment option you choose, and what you are doing with the model:

|Activity|Azure OpenAI models|Azure AI model inference| Serverless APIs (pay-as-you-go)|Managed compute|
|---|---|---|---|---|
|Deploy the model|No cost|No cost|Minimal endpoint cost|Charged per minute|
|Call the endpoint|Token-based billing|Token-based billing|Token-based billing|No charge|
