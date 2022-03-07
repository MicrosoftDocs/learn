**Azure Cognitive Services** are cloud-based services that encapsulate AI capabilities. Rather than a single product, you should think of Azure Cognitive Services as a set of individual services that you can use as building blocks to compose sophisticated, intelligent applications.

Cognitive services includes a wide range of individual AI services across multiple categories, as shown in the following table.

| Language | Speech | Vision | Decision |
| -------- | ------ | ------ | -------- |
| Language | Speech | Computer Vision |  Anomaly Detector |
| Translator | | Custom Vision | Content Moderator |
| | | Face | Personalizer |
| | | | |

You can use Cognitive Services to build your own AI solutions, and they also underpin *Azure Applied AI Services* that provide out-of-the-box solutions for common AI scenarios. Applied AI Services include:

- **Azure Form Recognizer** - an optical character recognition (OCR) solution that can extract semantic meaning from forms, such as invoices, receipts, and others.
- **Azure Metrics Advisor** - A service built on the Anomaly Detector cognitive service that simplifies real-time monitoring and response to critical metrics.
- **Azure Video Analyzer for Media** - A comprehensive video analysts solution build on the Video Indexer cognitive service.
- **Azure Immersive Reader** - A reading solution that supports people of all ages and abilities.
- **Azure Bot Service** - A cloud service for delivering conversational AI solutions, or *bots*.
- **Azure Cognitive Search** - A cloud-scale search solution that uses cognitive services to extract insights from data and documents.

While the details of each cognitive service can vary, the approach to provisioning and consuming them is generally the same.

In this module, you will learn how to:

- Provision cognitive service resources in an Azure subscription.
- Identify endpoints, keys, and locations required to consume a cognitive service resource.
- Use a REST API to consume a cognitive service.
- Use an SDK to consume a cognitive service.
