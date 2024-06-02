
There are container images for Azure AI services in the Microsoft Container Registry that you can use to deploy a containerized service that encapsulates an individual Azure AI services service API.

To deploy and use an Azure AI services container, the following three activities must occur:

1. The container image for the specific Azure AI services API you want to use is downloaded and deployed to a container host, such as a local Docker server, an Azure Container Instance (ACI), or Azure Kubernetes Service (AKS).
2. Client applications submit data to the endpoint provided by the containerized service, and retrieve results just as they would from an Azure AI services cloud resource in Azure.
3. Periodically, usage metrics for the containerized service are sent to an Azure AI services resource in Azure in order to calculate billing for the service.

:::image type="content" source="../media/ai-services-container.png" alt-text="A diagram of an Azure AI services container deployed to a container host and consumed by a client application.":::

Even when using a container, you must provision an Azure AI services resource in Azure for billing purposes. Client applications send their requests to the containerized service, meaning that potentially sensitive data is not sent to the Azure AI services endpoint in Azure; but the container must be able to connect to the Azure AI services resource in Azure periodically to send usage metrics for billing.

## Azure AI services container images

Each container provides a subset of Azure AI services functionality. For example, not all features of the Azure AI Language service are in a single container. Language detection, translation, and sentiment analysis are each separate container images. However, the setup steps are similar for each container.

### Language containers

For the AI Language service, the core features map to separate images:

| Feature | Image |
|---|---|
| Key Phrase Extraction | mcr.microsoft.com/azure-cognitive-services/textanalytics/keyphrase |
| Language Detection | mcr.microsoft.com/azure-cognitive-services/textanalytics/language |
| Sentiment Analysis |	mcr.microsoft.com/azure-cognitive-services/textanalytics/sentiment |
| Named Entity Recognition | mcr.microsoft.com/product/azure-cognitive-services/textanalytics/language/about |
| Text Analytics for health | mcr.microsoft.com/product/azure-cognitive-services/textanalytics/healthcare/about |
| Translator | mcr.microsoft.com/product/azure-cognitive-services/translator/text-translation/about |
| Summarization | mcr.microsoft.com/azure-cognitive-services/textanalytics/summarization |

> [!NOTE]
> Sentiment Analysis supports other languages by replacing the *en* in the image with the correct language code

### Speech containers

| Feature | Image |
|---|---|
| Speech to text | mcr.microsoft.com/product/azure-cognitive-services/speechservices/speech-to-text/about |
| Custom Speech to text | mcr.microsoft.com/product/azure-cognitive-services/speechservices/custom-speech-to-text/about |
| Neural Text to speech | mcr.microsoft.com/product/azure-cognitive-services/speechservices/neural-text-to-speech/about |
| Speech language detection | mcr.microsoft.com/product/azure-cognitive-services/speechservices/language-detection/about |

### Vision containers

| Feature | Image |
|---|---|
| Read OCR | mcr.microsoft.com/product/azure-cognitive-services/vision/read/about |
| Spatial analysis | mcr.microsoft.com/product/azure-cognitive-services/vision/spatial-analysis/about |

You can use the Docker *pull* command to download container images to work with them directly from your machine. Some of the containers are in a "Gated" public preview state, and you need to explicitly request access to use them. Otherwise the containers are available for anyone to use with their Azure AI services deployment.

For a full list of currently available Azure AI services container images, and specific notes for each one, see [Azure AI services container image tags and release notes](/azure/ai-services/cognitive-services-container-support#containers-in-azure-ai-services).

## Azure AI services container configuration

When you deploy an Azure AI services container image to a host, you must specify three settings.

| Setting | Description |
|---|---|
| ApiKey | Key from your deployed Azure AI service; used for billing. |
| Billing | Endpoint URI from your deployed Azure AI service; used for billing. |
| Eula | Value of **accept** to state you accept the license for the container. |

## Consuming Azure AI services from a Container

After your Azure AI services container is deployed, applications consume the containerized Azure AI services endpoint rather than the default Azure endpoint. The client application must be configured with the appropriate endpoint for your container, but does not need to provide a subscription key to be authenticated. You can implement your own authentication solution and apply network security restrictions as appropriate for your specific application scenario.
