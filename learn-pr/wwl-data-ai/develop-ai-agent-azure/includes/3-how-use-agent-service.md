Azure AI Agent Service is a fully managed service designed to empower developers to securely build, deploy, and scale high-quality, extensible AI agents without needing to manage the underlying compute and storage resources. This learning unit will cover the purpose, key features, setup process, and integration capabilities of Azure AI Agent Service.

## Describe the purpose of Azure AI Agent Service

Azure AI Agent Service allows developers to create AI agents tailored to their needs through custom instructions and advanced tools like code interpreters and custom functions. These agents can answer questions, perform actions, or automate workflows by combining generative AI models with tools that interact with real-world data sources. The service simplifies the development process by reducing the amount of code required and managing the underlying infrastructure.

## Key features of Azure AI Agent Service

Azure AI Agent Service offers several key features:

- **Automatic tool calling**: The service handles the entire tool-calling lifecycle, including running the model, invoking tools, and returning results.
- **Securely managed data**: Conversation states are securely managed using threads, eliminating the need for developers to handle this manually.
- **Out-of-the-box tools**: The service includes tools for file retrieval, code interpretation, and interaction with data sources like Bing, Azure AI Search, and Azure Functions.
- **Flexible model selection**: Developers can choose from various models, including Azure OpenAI models and others like Llama 3, Mistral, and Cohere.
- **Enterprise-grade security**: The service ensures data privacy and compliance with secure data handling and keyless authentication.
- **Customizable storage solutions**: Developers can use either platform-managed storage or bring their own Azure Blob storage for full visibility and control.

Azure AI Agent Service provides a more streamlined and secure way to build and deploy AI agents compared to developing with the Inference API directly.

## Outline the steps to set up Azure AI Agent Service

To set up Azure AI Agent Service, follow these steps:

1. **Create an Azure AI Foundry hub and project**: Start by creating an AI hub and project in your Azure subscription.
2. **Deploy a compatible model**: Deploy a model such as GPT-4o to your project.
3. **Make API calls using SDKs**: Once the model is deployed, you can start making API calls to the service using the provided SDKs.

For detailed instructions, refer to the [quickstart guide](/azure/ai-services/agents/quickstart?azure-portal=true).

## Describe how Azure AI Agent Service integrates with other Azure AI services

Azure AI Agent Service integrates seamlessly with other Azure AI services to enhance functionality. For example, it can work with Azure Functions to create intelligent, event-driven applications. Azure Functions provide support for triggers and bindings, allowing AI agents to interact dynamically with external systems and services based on incoming events. This integration enables the creation of scalable and flexible AI-driven workflows.

> [!NOTE]
> For more information on integrating Azure AI Agent Service with Azure Functions, refer to the [integration guide](/azure/ai-services/agents/how-to/tools/azure-functions?azure-portal=true).
