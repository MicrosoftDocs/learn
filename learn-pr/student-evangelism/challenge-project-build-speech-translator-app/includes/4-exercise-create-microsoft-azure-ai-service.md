# Exercise 2 - Create Microsoft Azure AI Service

Now that you have built your Canvas App, you observe that not all the features are working e.g. clicking on the Translate button didn't change anything as there is no service yet to do the recognition and translation. In this exercise, you will be setting up Microsoft Azure AI Speech Service which will take care of this need.

# About Microsoft AI Service - Speech Service

The Speech service provides speech to text and text to speech capabilities with a Speech resource. You can transcribe speech to text with high accuracy, produce natural-sounding text to speech voices, translate spoken audio, and use speaker recognition during conversations.

![Available Speech to text services](./images/speech-to-text-service.png)

The Microsoft Azure AI Service - Speech Service is the back-end engine that will make complete the solution we are building.

>[!Note]
>As of July 2023, Azure AI services encompass all of what were previously known as Cognitive Services and Azure Applied AI Services. There are no changes to pricing. The names Cognitive Services and Azure Applied AI continue to be used in Azure billing, cost analysis, price list, and price APIs. There are no breaking changes to application programming interfaces (APIs) or SDKs.

# Setup Microsoft Azure Speech Service
- Navigate to [Microsoft Azure Portal](https://portal.azure.com) and create a `Speech Service`. Follow the prompt to setup the resources.
- Once done, you will gain access to your Keys, Locations/Regions, and Endpoints. You will need these information before you can consume the service in Power Apps.


> [!NOTE]
> You need an Active Microsoft Azure subscription to carry out this exercise. If you are a student you can benefit from a [free Azure for students subscription](https://azure.microsoft.com/en-us/free/students/) with $100 in credit to spend on Azure services for 12 months. If you are not a student, you can still sign up for a [free Azure trial](https://azure.microsoft.com/en-us/free/) with $200 in credit to spend on Azure services for 30 days.


## Check your work

1. To validate if this works and if everything is working fine, In Power Apps, add `AzureBatchSpeech-to-text` to your data source and connect using the key and region from details from the Microsoft Azure Portal.

If added successfuly, Congratulations! You are making incredible progress.

## Additional Resources
If you need help with Azure AI Speech Service, kindly explore the resources below:
- [Microsoft AI Service - Speech Recognition ](https://learn.microsoft.com/en-us/azure/ai-services/speech-service/overview)
- [Quickstart: Create a multi-service resource for Azure AI services](https://learn.microsoft.com/en-us/azure/ai-services/multi-service-resource)
