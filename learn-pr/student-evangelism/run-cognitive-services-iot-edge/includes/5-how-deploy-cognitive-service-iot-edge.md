This unit explains how to create a Text Analytics resource and deploy a related language detection module.

## Before you start

To deploy the Language Detection module:

- Create a cognitive service in the cloud
- Configure the Azure AI services API to the Language Detection containerized module
- Retrieve the API key and endpoint
- Deploy the module to the edge device.

## Components used

- **Text Analytics API:** The Text Analytics API is part of Azure AI services and provides advanced natural language processing over raw text. It includes four main functions: sentiment analysis, key phrase extraction, language detection, and named entity recognition.
- **Language Detection module:** Analyze text on the edge, on-premises, or in the cloud using container support. It detects and reports which language the input text is written in.

<a name='parameters-for-configuring-ai-services-containers'></a>

## Parameters for configuring Azure AI services containers

- **End-user license agreement (EULA):** indicates that you've accepted the license for the container. It must be set to a value of accept.
- **Endpoint URI value:** is available on the Azure portal's **Overview** page of the corresponding Azure AI services resource.
- **Keys {API_KEY}:** tracks billing information and is available on the Azure portal's **Keys** page of the corresponding Azure AI services resource.

## Detailed steps

In this exercise, you complete these steps:

1. Create an Azure AI Text Analytics resource
1. Configure the Azure AI services API to the Language Detection module
1. Deploy the Language Detection module to the edge device

At the end of the unit, your module will be configured with Azure AI Text Analytics, and the Language Detection module will be deployed. The module uses Text Analytics and analyses the language of the text on the edge using container support.
