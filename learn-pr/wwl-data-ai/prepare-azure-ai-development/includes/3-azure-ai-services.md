Microsoft Azure provides a wide range of cloud services that you can use to develop, deploy, and manage an AI solution. The most obvious starting point for considering AI development on Azure is Azure AI services; a set of out-of-the-box prebuilt APIs and models that you can integrate into your applications. The following table lists some commonly used Azure AI services (for a full list of all available Azure AI services, see [Available Azure AI services](/azure/ai-services/what-are-ai-services#available-azure-ai-services?azure-portal=true)).

| Service | Description |
| ---- | ----------- |
| ![Azure OpenAi service icon.](../media/open-ai.png)<br>**Azure OpenAI**  | The Azure OpenAI service provides access to OpenAI generative AI models including the GPT family of large and small language models and DALL-E image-generation models within a scalable and securable cloud service on Azure. |
| ![Azure AI Vision service icon.](../media/vision.png)<br>**Azure AI Vision**  | The Azure AI Vision service provides a set of models and APIs that you can use to implement common computer vision functionality in an application. With the AI Vision service, you can detect common objects in images, generate captions, descriptions, and tags based on image contents, and read text in images. |
| ![Azure AI Speech service icon.](../media/speech-service.png)<br>**Azure AI Speech**  | The Azure AI Speech service provides APIs that you can use to implement *text to speech* and *speech to text* transformation, as well as specialized speech-based capabilities like speaker recognition and translation. |
| ![Azure AI Language service icon.](../media/language.png)<br>**Azure AI Language**  | The Azure AI Language service provides models and APIs that you can use to analyze natural language text and perform tasks such as entity extraction, sentiment analysis, and summarization. The AI Language service also provides functionality to help you build conversational language models and question answering solutions. |
| ![Azure AI Content Safety service icon.](../media/content-safety.png)<br>**Azure AI Content Safety**  | Azure AI Content Safety provides developers with access to advanced algorithms for processing images and text and flagging content that is potentially offensive, risky, or otherwise undesirable. |
| ![Azure AI Translator service icon.](../media/translator.png)<br>**Azure AI Translator**  | The Azure AI Translator service uses state-of-the-art language models to translate text between a large number of languages. |
| ![Azure AI Face service icon.](../media/face.png)<br>**Azure AI Face**  | The Azure AI Face service is a specialist computer vision implementation that can detect, analyze, and recognize human faces. Because of the potential risks associated with personal identification and misuse of this capability, access to some features of the AI Face service are restricted to approved customers. |
| ![Azure AI Custom Vision service icon.](../media/custom-vision.png)<br>**Azure AI Custom Vision**  | The Azure AI Custom Vision service enables you to train and use custom computer vision models for image classification and object detection. |
| ![Azure AI Document Intelligence service icon.](../media/document-intelligence.png)<br>**Azure AI Document Intelligence**  | With Azure AI Document Intelligence, you can use pre-built or custom models to extract fields from complex documents such as invoices, receipts, and forms. |
| ![Azure AI Content Understanding service icon.](../media/content-understanding.png)<br>**Azure AI Content Understanding**  | The Azure AI Content Understanding service provides multi-modal content analysis capabilities that enable you to build models to extract data from forms and documents, images, videos, and audio streams. |
| ![Azure AI Search service icon.](../media/search.png)<br>**Azure AI Search**  | The Azure AI Search service uses a pipeline of AI skills based on other Azure AI Services and custom code to extract information from content and create a searchable index. AI Search is commonly used to create vector indexes for data that can then be used to *ground* prompts submitted to generative AI language models, such as those provided in the Azure OpenAI service.|

## Considerations for Azure AI services resources

To use Azure AI services, you create one or more Azure AI resources in an Azure subscription and implement code in client applications to consume them. In some cases, AI services include web-based visual interfaces that you can use to configure and test your resources - for example to train a custom image classification model using the **Custom Vision** service you can use the visual interface to upload training images, manage training jobs, and deploy the resulting model.

> [!NOTE]
> You can provision Azure AI services resources in the Azure portal (or by using BICEP or ARM templates or the Azure command-line interface) and build applications that use them directly through various service-specific APIs and SDKs. However, as we'll discuss later in this module, in most medium to large-scale development scenarios it's better to provision Azure AI services resources as part of an Azure Foundry *hub* - enabling you to centralize access control and cost management, and making it easier to manage shared resource usage based on AI development *projects*.

### Single service or multi-service resource?

Most Azure AI services, such as **Azure AI Vision**, **Azure AI Language**, and so on, can be provisioned as standalone resources, enabling you to create only the Azure resources you specifically need. Additionally, standalone Azure AI services often include a free-tier SKU with limited functionality, enabling you to evaluate and develop with the service at no cost. Each standalone Azure AI resource provides an endpoint and authorization keys that you can use to access it securely from a client application.

Alternatively, you can provision a multi-service **Azure AI services** resource that encapsulates the following services in a single Azure resource:

- Azure OpenAI
- Azure AI Speech
- Azure AI Vision
- Azure AI Language
- Azure AI Content Safety
- Azure AI Translator
- Azure AI Document Intelligence
- Azure AI Content Understanding

Using a multi-service resource can make it easier to manage applications that use multiple AI capabilities.

> [!TIP]
> |Service | Icon |
> |--|--|
> | When you want to provision a multi-service Azure AI Services resource, be careful to select the **Azure AI services** resource type with the icon shown here.|![Azure AI services icon.](../media/ai-services.png)|
> | An older Azure AI services resource type with a different icon may also be listed in the Azure portal. The older service encapsulates a different set of AI services and isn't suitable for working with newer services like Azure OpenAI and Azure AI Content Understanding.| ![Azure Cognitive Services icon.](../media/cognitive-services.png)| 

### Regional availability

Some services and models and available in only a subset of Azure regions. Consider service availability and any regional quota restrictions for your subscription when provisioning Azure AI services. Use the [product availability table](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/table?azure-portal=true) to check regional availability of Azure services. Use the [model availability table](/azure/ai-services/openai/concepts/models#model-summary-table-and-region-availability?azure-portal=true) in the Azure OpenAI service documentation to determine regional availability for Azure OpenAI models.

### Cost

Azure AI services are charged based on usage, with different pricing schemes available depending on the specific services being used. As you plan an AI solution on Azure, use the [Azure AI services pricing](https://azure.microsoft.com/pricing/details/cognitive-services?azure-portal=true) documentation to understand pricing for the AI services you intend to incorporate into your application. You can use the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator?azure-portal=true) to estimate the costs your expected usage will incur.
