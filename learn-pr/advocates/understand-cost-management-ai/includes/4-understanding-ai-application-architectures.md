When you consider how much AI costs, you need to include all of the resources and infrastructure in your AI application's architecture. An AI service is just one component in this architecture. 

Let's look at some examples of AI application architectures.

## Example 1: E-commerce Pet Store on Azure Kubernetes Service

[![A diagram showing the architecture of a pet store application.](../media/ecommerce-pet-store.png)](../media/ecommerce-pet-store-big.png#lightbox)

This sample demo application consists of a group of containerized microservices that can be deployed into an Azure Kubernetes Service (AKS) cluster. It uses a polyglot architecture, event-driven design, and common open source back-end services (like RabbitMQ and MongoDB). The application also leverages OpenAI models to generate product descriptions. <br>Deploy this application: [https://learn.microsoft.com/azure/aks/open-ai-quickstart](/azure/aks/open-ai-quickstart)

## Example 2: E-commerce Adventure Store on .NET

[![A diagram showing the architecture of an ecommerce adventure store](../media/ecommerce-adventure-store.png)](../media/ecommerce-adventure-store-big.png#lightbox)

This sample uses a services-based architecture to provide a retail (e-commerce) website that is responsive to desktop and mobile devices. OpenAI integrates with the web application, providing an intelligent chatbot that can offer advice and recommendations on products in the catalogue.  <br>Deploy this application: <https://github.com/Azure-Samples/eShopOnAzure>

### Example 3: AI processing of audio files

[![A diagram showing the architecture of an audio processing application](../media/ai-audio-processing.png)](../media/ai-audio-processing-big.png#lightbox)

This application uses Azure Functions for an AI workflow, triggered when an audio podcast file is uploaded. The file is stored and analyzed by Azure's Speech to text AI service to produce a text transcript. Then Azure OpenAI generates a synopsis, tag line and SEO keywords.

Microsoft provides guidance on AI workload design and cost considerations in the Cloud Adoption Framework for Azure and the Well Architected Framework.
