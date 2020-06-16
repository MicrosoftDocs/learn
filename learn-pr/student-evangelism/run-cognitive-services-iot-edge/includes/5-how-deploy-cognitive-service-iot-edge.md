This unit explains the creation of a Text Analytics resource, the creation, and deployment of an associated Language Detection module.

Before you start deploying the Language Detection module, you firstly need to create a Cognitive Service in the cloud; then, you will configure the Cognitive Service API to the Language Detection containerised module and deploy it to the edge device. To configure Text Analytics API to the containerised module, you will need an API key, Endpoint.

The component you will use:

**Text Analytics API:** The Text Analytics API is a part of Azure Cognitive Services that provides advanced natural language processing over raw text, and includes four main functions: sentiment analysis, key phrase extraction, language detection, and named entity recognition.

**Language Detection module:** Analyze text on the edge, on-premises, and in the cloud using container support. It detects and reports in which language the input text is written. It is available in Azure Marketplace.

Parameters for configuring Cognitive Service container:

**The end-user license agreement (EULA):** indicate that you've accepted the license for the container. It must be set to a value of accept.
**Endpoint URI value:** is available on the Azure portal Overview page of the corresponding Cognitive Service resource.

**Keys {API_KEY}:** track billing information and is available on the Azure portal's Keys page of the corresponding Cognitive Service resource.

The steps you will follow:

1. Create a Cognitive Service Text Analytics

2. Configure Cognitive Service API to the Language Detection module

3. Deploy Language Detection module to the edge device

At the end of the unit, your module will be configured with Cognitive Service Text Analytics, and the Language Detection module will be deployed. The module uses Text Analytics and analyses the language of the text on the edge using container support.
