Azure OpenAI (AOAI) offers both C# and Python SDKs and a REST API that developers can use to add AI functionality to their applications. Generative AI capabilities in Azure OpenAI are provided through *models*. The models available in the Azure OpenAI service belong to different families, each with their own focus. To use one of these models, you need to deploy through the Azure OpenAI Service.

> [!IMPORTANT]
> Azure OpenAI has been released with limited access to support the responsible use of the service. Users need to [apply for access](/azure/cognitive-services/openai/overview#how-do-i-get-access-to-azure-openai?azure-portal=true) and be approved before they can create an AOAI resource.

## Create an Azure OpenAI resource

An AOAI resource can be deployed through both the Azure command line interface (CLI) and the Azure portal. Creating the AOAI resource through the Azure portal is similar to deploying individual Cognitive Services resources, and is part of the Cognitive Services services.

1. Navigate to the [Azure portal](https://portal.azure.com/?azure-portal=true)
1. Search for **Azure OpenAI**, select it, and click **Create**
1. Enter the appropriate values for the empty fields, and create the resource.

The possible regions for an AOAI are currently limited. Choose the region closest to your physical location.

Once the resource has been created, you'll have keys and an endpoint that you can use in your app.

## Choose and deploy a model

Each model family excels at different tasks, and there are different capabilities of the models within each family. Model families break down into three main families:

- **Text** or **Generative Pre-trained Transformer (GPT)** - Models that understand and generate natural language and some code. These models are best at general tasks, conversations, and chat formats.
- **Code** - Code models are built on top of GPT models, and trained on millions of lines of code. These models can understand and generate code, including interpreting comments or natural language to generate code.
- **Embeddings** - These models can understand and use embeddings, which are a special format of data that can be used by machine learning models and algorithms.

This module focuses on general GPT models, with other models being covered in other modules.

The model family and capability is indicated in the name of the base model, such as `text-davinci-003`, which specifies that it's a text model, with `davinci` level capability, and identifier `3`. Details on models, capability levels, and naming conventions can be found on the [AOAI Models documentation](/azure/cognitive-services/openai/concepts/models?azure-portal=true) page.

To deploy a model for you to use, navigate to the [Azure OpenAI Studio](https://oai.azure.com/?azure-portal=true) and go to the **Deployments** page. The lab later in this module covers exactly how to do that.

## Authentication and specification of deployed model

When you deploy a model in AOAI, you choose a deployment name to give it. When configuring your app, you need to specify your resource endpoint, key, and deployment name to specify which deploy model to send your request to. This enables you to deploy various models within the same resource, and make requests to the appropriate model depending on the task.

## Prompt engineering

How the input prompt is written plays a large part in how the AI model will respond. For example, if prompted with a simple request such as "What is Azure OpenAI", you often get a generic answer similar to using a search engine.

However, if you give it more details about what you want in your response, you get a more specific answer. For example, given this prompt: 

```text
Classify the following news headline into 1 of the following categories: Business, Tech, Politics, Sport, Entertainment

Headline 1: Donna Steffensen Is Cooking Up a New Kind of Perfection. The Internet’s most beloved cooking guru has a buzzy new book and a fresh new perspective
Category: Entertainment

Headline 2: Major Retailer Announces Plans to Close Over 100 Stores
Category:
```

You'll likely get the "Category:" under headline filled out with "Business".

Several examples similar to this one can be found in the Azure OpenAI Studio Playground, under the **Examples** dropdown. Try to be as specific as possible about what you want in response from the model, and you may be surprised at how insightful it can be!

> [!NOTE]
> It is never safe to assume that answers from an AI model are factual or correct. Teams or individuals tasked with developing and deploying AI systems should work to identify, measure, and mitigate harm. It is your responsibility to verify any responses from an AI model, and to use AI responsibly. Check out [Microsoft's Transparency Notes on Azure OpenAI](/legal/cognitive-services/openai/transparency-note?azure-portal=true) for further guidelines on how to use Azure OpenAI models responsibly.

Further details can be found at the [Prompt engineering](/azure/cognitive-services/openai/concepts/prompt-engineering?azure-portal=true) documentation page.

## Available endpoints

AOAI can be accessed via a REST API or an SDK currently available for Python and C#. The endpoints available for interacting with a deployed model are used differently, and certain endpoints can only use certain models. The available endpoints are:

- **Completion** - model takes an input prompt, and generates one or more predicted completions
- **ChatCompletion** - model takes input in the form of a chat conversation (where roles are specified with the message they send), and the next chat completion is generated
- **Embeddings** - model takes input and returns a vector representation of that input

For example, the input for `Completion` might be a prompt like "What is Azure OpenAI", or it might include some role tags or other prompt engineering elements.

```code
<|im_start|>user
What is Azure OpenAI?
<|im_end|>
```

In contrast, the input for `ChatCompletion` is a conversation with clearly defined roles for each message:

```json
{"role": "system", "content": "You are a helpful assistant, teaching people about AI."},
{"role": "user", "content": "Does Azure OpenAI support multiple languages?"},
{"role": "assistant", "content": "Yes, Azure OpenAI supports several languages, and can translate between them."},
{"role": "user", "content": "Do other Azure Cognitive Services support translation too?"}
```

When you give the AI model a real conversation, it can generate a better response with more accurate tone, phrasing, and context. The `ChatCompletion` endpoint enables the ChatGPT model to have a more realistic conversation by sending the history of the chat with the next user message.

`ChatCompletion` also allows for non-chat scenarios, such as summarization or entity extraction that you can do with the `Completion` endpoint. This can be accomplished by providing a short conversation, specifying the system information and what you want, along with the user input. For example, if you want to generate a job description, provide `ChatCompletion` with something like the following conversation input.

```json
{"role": "system", "content": "You are an assistant designed to write intriguing job descriptions. "},
{"role": "user", "content": "Write a job description for the following job title: 'Business Intelligence Analyst'. It should include responsibilities, required qualifications, and highlight benefits like time off and flexible hours."}
```

> [!NOTE]
> `Completion` is available for all `gpt-3` generation models, while `ChatCompletion` is the only supported option for `gpt-4` models and is the preferred endpoint when using the `gpt-35-turbo` model. The lab in this module uses `gpt-35-turbo` with the `ChatCompletion` endpoint.
