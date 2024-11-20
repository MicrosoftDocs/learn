In the previous unit, you created a simple canvas app. However, not all the features are working. For example, nothing happens when you press the **Translate** button, because there's no service yet for speech recognition and translation. 

In this exercise, you set up Microsoft Azure AI Speech, Azure Blob Storage, and Microsoft Translator.

## About Microsoft Azure AI Speech

Azure AI Speech provides speech-to-text and text-to-speech capabilities with a speech resource. You can transcribe speech to text with high accuracy, produce natural-sounding text-to-speech voices, translate spoken audio, and use speaker recognition during conversations.

:::image type="content" source="../media/speech-to-text-service.png" alt-text="Screenshot showing available speech to text services." lightbox="../media/speech-to-text-service.png":::

Azure AI Speech is the back-end engine that completes the solution you're building.

> [!NOTE]
> As of July 2023, Azure AI services encompass all of what were previously known as Cognitive Services and Azure Applied AI Services. There are no changes to pricing. The names Cognitive Services and Azure Applied AI continue to be used in Azure billing, cost analysis, price list, and price APIs. There are no breaking changes to application programming interfaces (APIs) or SDKs.

## Set up Microsoft Azure AI Speech

Go to the [Microsoft Azure portal](https://portal.azure.com) and follow the steps to create a Speech resource. This process gives you access to your keys, locations/regions, and endpoints. You need these details before you can consume the service in Power Apps.

> [!NOTE]
> You need an active Microsoft Azure subscription to carry out this exercise. If you're a student you can benefit from a [free Azure for Students subscription](https://azure.microsoft.com/free/students/?WT.mc_id=academic-114984-somelezediko). If you're not a student, you can still sign up for a [free Azure trial](https://azure.microsoft.com/free/?WT.mc_id=academic-114984-somelezediko).

## About Microsoft Azure Blob Storage

Azure Blob Storage lets you store massive amounts of unstructured data as binary large objects, or blobs, in the cloud. Blobs are an efficient way to store data files in a format that's optimized for cloud-based storage. Applications can read the files and write to them by using the Azure Blob Storage API.

## Set up Microsoft Azure Blob Storage

Go to the Azure portal and create a storage account by following the steps to set up the resource. This process gives you access to your keys, location/region, Blob Storage name, and endpoints. You need these details before you can consume the service in Power Apps.

## About Microsoft Azure AI Translator

Azure AI Translator converts text from one language to another. Translator uses AI to automatically detect the source language of documents or given texts and translate the text into the languages of your choice while maintaining the text's layout and formatting.

## Set up Microsoft Azure AI Translator

Go to the Azure portal and follow the steps to create a Translator resource. This process gives you access to your keys, location/region, Translator resource name, and the endpoints. You need these details before you can consume the service in Power Automate.

## Check your work

To validate that your setup works, go to Power Apps and do the following tasks:

1. Add `AzureBatchSpeech-to-text` to your data source and connect by using the key and region details from the Azure portal.
1. Add Azure Blob Storage as your data source and connect by using the service name and key details from the Azure portal.
1. Add `Microsoft Translator V3` as your data source and connect by using the service name and the key details from the Azure portal.

Congratulations on your progress so far!

## Helpful resources

If you need help with Azure AI Speech, you can find out more in the following resources:

- [What is the Speech service?](/azure/ai-services/speech-service/overview/?WT.mc_id=academic-114984-somelezediko)
- [Quickstart: Create a multi-service resource for Azure AI services](/azure/ai-services/multi-service-resource/?WT.mc_id=academic-114984-somelezediko)
