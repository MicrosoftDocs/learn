This unit explains the creation of a Text Analytics resource, and the creation and deployment of an associated Language Detection module.

Before you start deploying the Language Detection module, you firstly need to create a cognitive service in the cloud; then, you'll configure the Azure Cognitive Services API to the Language Detection containerized module and deploy it to the edge device. To configure Text Analytics API to the containerized module, you'll need an API key and endpoint.

The components you'll use:

**Text Analytics API:** The Text Analytics API is a part of Azure Cognitive Services that provides advanced natural language processing over raw text. It includes four main functions: sentiment analysis, key phrase extraction, language detection, and named entity recognition.

**Language Detection module:** Analyze text on the edge, on-premises, and in the cloud using container support. It detects and reports in which language the input text is written. It's available in Azure Marketplace.

Parameters for configuring Cognitive Services containers:

**The end-user license agreement (EULA):** indicates that you've accepted the license for the container. It must be set to a value of accept.

**Endpoint URI value:** is available on the Azure portal's **Overview** page of the corresponding Cognitive Services resource.

**Keys {API_KEY}:** tracks billing information and is available on the Azure portal's **Keys** page of the corresponding Cognitive Services resource.

The steps you'll follow:

1. Create a Cognitive Services Text Analytics resource

2. Configure the Cognitive Services API to the Language Detection module

3. Deploy the Language Detection module to the edge device

At the end of the unit, your module will be configured with Cognitive Services Text Analytics, and the Language Detection module will be deployed. The module uses Text Analytics and analyses the language of the text on the edge using container support.
