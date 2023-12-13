In the previous module, you created a simple canvas app, however, not all the features are working. For example, selecting the **Translate** button didn't change anything because there's no service yet for speech recognition and translation. In this exercise, you set up Microsoft Azure AI Speech, Azure Blob Storage, and Microsoft Translator, which will address this need.

## About Microsoft Azure AI Speech

Azure AI Speech provides speech-to-text and text-to-speech capabilities with a speech resource. You can transcribe speech to text with high accuracy, produce natural-sounding text-to-speech voices, translate spoken audio, and use speaker recognition during conversations.

:::image type="content" source="../media/speech-to-text-service.png" alt-text="Screenshot showing available speech to text services." lightbox="../media/speech-to-text-service.png":::

Azure AI Speech is the back-end engine that completes the solution we're building.

> [!Note]
> As of July 2023, Azure AI services encompass all of what were previously known as Cognitive Services and Azure Applied AI Services. There are no changes to pricing. The names Cognitive Services and Azure Applied AI continue to be used in Azure billing, cost analysis, price list, and price APIs. There are no breaking changes to application programming interfaces (APIs) or SDKs.

## Set up Microsoft Azure AI Speech

- Navigate to the [Microsoft Azure portal](https://portal.azure.com) and create a _Speech Service_. Follow the prompt to set up the resources.
- Once done, you have access to your keys, locations/regions, and endpoints. You need these details before you can consume the service in Power Apps.

> [!NOTE]
> You need an active Microsoft Azure subscription to carry out this exercise. If you're a student you can benefit from a [free Azure for Students subscription](https://azure.microsoft.com/free/students) with $100 in credit to spend on Azure services for 12 months. If you're not a student, you can still sign up for a [free Azure trial](https://azure.microsoft.com/free) with $200 in credit to spend on Azure services for 30 days.

## About Microsoft Azure Blob Storage

Azure Blob Storage is a service that enables you to store massive amounts of unstructured data as binary large objects, or blobs, in the cloud. Blobs are an efficient way to store data files in a format that's optimized for cloud-based storage, and applications can read them and write to them by using the Azure Blob Storage API.

## Set up Microsoft Azure Blob Storage

Navigate to the Azure portal and create a storage account by following the steps to set up the resource. Once done, you have access to your keys, location/region, Blob Storage name, and endpoints. You need these details before you can consume the service in Power Apps.

## About Microsoft Azure AI Translator

Azure AI Translator is an Azure AI service that converts text from one language to another. Translator uses AI to automatically detect the source language of documents or given texts and translate the text into the languages of your choice while maintaining the text's layout and formatting - in near-real time.

## Set up Microsoft Azure AI Translator

Navigate to the Azure portal and create a Translator service by following the steps to set up the resource. Once done, you have access to your keys, location/region, Translator service name, and the endpoints. You need these details before you can consume the service in Power Automate.

## Check your work

1. To validate that your setup works, navigate to Power Apps, add `AzureBatchSpeech-to-text` to your data source, and connect by using the key and region details from the Azure portal.
1. Navigate to Power Apps, add Azure Blob Storage as your data source, and connect by using the service name and key details from the Azure portal.
1. Navigate to Power Apps, add Microsoft Translator V3 as your data source, and connect by using the service name and the key details from the Azure portal.

If added successfully, congratulations! You're making incredible progress.

## Helpful resources

If you need help with Azure AI Speech, kindly explore the resources here:
- [Microsoft Azure AI services - Speech Recognition](/azure/ai-services/speech-service/overview)
- [Quickstart: Create a multi-service resource for Azure AI services](/azure/ai-services/multi-service-resource)
