<!-- ## What is Azure OpenAI Service? -->

Azure OpenAI Service is a result of the partnership between Microsoft and OpenAI. The service combines Azure's enterprise-grade capabilities with OpenAI's generative AI model capabilities. With Azure OpenAI, customers get the security capabilities of Azure while running the same models as OpenAI. Azure OpenAI offers private networking, regional availability, and responsible AI content filtering.

Azure OpenAI Service provides REST API access to OpenAI's powerful language models, including the o1 series, GPT-4o series, and other legacy models such as GPT-3.5 Turbo. You can easily adapt these models to your specific task, including—but not limited to—content generation, summarization, image understanding, semantic search, and natural language-to-code translation. Users can access the service through REST APIs, Python SDK, or a web-based interface in the Azure OpenAI Foundry.

Azure OpenAI Service is powered by a diverse set of models with different capabilities and price points. Model availability varies by region and cloud service. Azure OpenAI Service gives customers advanced language AI with OpenAI GPT-4, GPT-3, Codex, DALL-E, Whisper, and text-to-speech models augmented with the security and enterprise features of Azure. Azure OpenAI co-develops the application program interfaces (APIs) with OpenAI, which helps ensure compatibility and a smooth transition from one product to the other.

> [!NOTE]
> Generative models such as the ones available in Azure OpenAI have significant potential benefits. However, without careful design and thoughtful mitigations, such models have the potential to generate incorrect or even harmful content. Microsoft has made significant investments to help guard against abuse and unintended harm, which includes incorporating Microsoft's principles for responsible AI use, adopting a Code of Conduct for use of the service, building content filters to support customers, and providing responsible AI information and guidance that customers should consider when using Azure OpenAI.

## How does Azure OpenAI process the content?

The completions endpoint is the core component of the API service. This API provides access to the model's text-in, text-out interface. Users simply need to provide an input prompt containing an English text command, and the model will generate a text completion.

Azure OpenAI processes text by breaking it down into tokens. *Tokens* can be words or just chunks of characters. For example, a short and common word such as "pear" is a single token, while the word "hamburger" gets broken up into three tokens: "ham," "bur," and "ger." Many tokens start with a whitespace—for example, "hello," and "bye." Each token is approximately four characters for typical English text.

Token costs are for both input and output. For example, suppose you have a 1,000-token JavaScript code sample that you request an Azure OpenAI model to convert to Python. You would be charged approximately 1,000 tokens for the initial input request sent, and 1,000 more tokens for the output that is received in response, for a total of 2,000 tokens.

The total number of tokens processed in a request depends on the length of your input, output, and request parameters. The quantity of tokens being processed will also affect your response latency and throughput for the models.

The token cost of an input image depends on two main factors: the size of the image, and the detail setting (low or high) used for each image.

APIs return faster responses and consume fewer input tokens for low-detailed images in use cases that don't require high detail. These images cost 85 tokens each, regardless of the image size. For example, let's use a 4096 x 8192 image (low detail). The cost is a fixed 85 tokens, because it's a low-detail image, and the size doesn't affect the cost in this mode.

A high-detail image lets the API review the image in more detail by cropping it into smaller squares. Each square uses more tokens to generate text.

## How to start with Azure OpenAI

Similar to other Azure products, you can start with Azure OpenAI by creating a resource or an instance of the service in your Azure Subscription. Once you create an Azure OpenAI Resource, you must deploy a model before you can start making API calls and generating text. You can do this by using Deployment APIs, which allows you to specify the model you wish to use. In the Azure OpenAI Foundry, you can build AI models and deploy them for public consumption in software applications.

## Summary

In this unit, you learned what Azure OpenAI is, how it works and what are the main characteristics and features of this service.
