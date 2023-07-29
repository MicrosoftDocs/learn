
There are container images for Azure Cognitive Services in the Microsoft Container Registry that you can use to deploy a containerized service that encapsulates an individual cognitive service API.

To deploy and use a Cognitive Services container, the following three activities must occur:

1. The container image for the specific Cognitive Services API you want to use is downloaded and deployed to a container host, such as a local Docker server, an Azure Container Instance (ACI), or Azure Kubernetes Service (AKS).
2. Client applications submit data to the endpoint provided by the containerized service, and retrieve results just as they would from a Cognitive Services cloud resource in Azure.
3. Periodically, usage metrics for the containerized service are sent to a Cognitive Services resource in Azure in order to calculate billing for the service.

![A Cognitive Services container deployed to a container host and consumed by a client application](../media/cognitive-services-container.png)

Even when using a container, you must provision a Cognitive Services resource in Azure for billing purposes. Client applications send their requests to the containerized service, meaning that potentially sensitive data is not sent to the Cognitive Services endpoint in Azure; but the container must be able to connect to the Cognitive Services resource in Azure periodically to send usage metrics for billing.

## Cognitive Services container images

Each container provides a subset of Cognitive Services functionality. For example, not all features of the Language service are in a single container. Language detection, translation, and sentiment analysis are each separate container images. However, the setup steps are similar for each container.

For the Language service, each of the three core features maps to a separate image:

| Feature | Image |
|---|---|
|Key Phrase Extraction | mcr.microsoft.com/azure-cognitive-services/textanalytics/keyphrase |
| Language Detection | mcr.microsoft.com/azure-cognitive-services/textanalytics/language |
| Sentiment Analysis v3 (English) |	mcr.microsoft.com/azure-cognitive-services/textanalytics/sentiment:3.0-en |

> [!NOTE]
> Sentiment Analysis supports other languages by replacing the *en* in the image with the correct language code

You can use the Docker *pull* command to download container images to work with them directly from your machine. Some of the containers are in a "Gated" public preview state, and you need to explicitly request access to use them. Otherwise the containers are available for anyone to use with their Azure Cognitive Services deployment.

For a full list of currently available Cognitive Services container images, and specific notes for each one, see [Azure Cognitive Services container image tags and release notes](/azure/cognitive-services/containers/container-image-tags).

## Cognitive Services container configuration

When you deploy a Cognitive Services container image to a host, you must specify three settings.

| Setting | Description |
|---|---|
| ApiKey | Key from your deployed Azure Cognitive Service; used for billing. |
| Billing | Endpoint URI from your deployed Azure Cognitive Service; used for billing. |
| Eula | Value of **accept** to state you accept the license for the container. |

## Consuming Cognitive Services from a Container

After your Cognitive Services container is deployed, applications consume the containerized Cognitive Services endpoint rather than the default Azure endpoint. The client application must be configured with the appropriate endpoint for your container, but does not need to provide a subscription key to be authenticated. You can implement your own authentication solution and apply network security restrictions as appropriate for your specific application scenario.
