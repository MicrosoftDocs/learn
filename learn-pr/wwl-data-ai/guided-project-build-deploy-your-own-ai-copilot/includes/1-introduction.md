In this guided project, you build an AI copilot for Contoso Bike Shop using Azure OpenAI and Azure Cosmos DB for MongoDB to power advanced data exploration. Imagine you're developing an AI copilot for the Contoso Bike Shop, a virtual assistant chatbot that allows users to ask questions about the bike inventory. This AI copilot helps customers find bikes that best fit their preferences.

In this module, you work through the steps required to create Contoso Bike Shop's virtual assistant. You load product data into a Cosmos DB database while generating embeddings to enrich search accuracy. You also set up a vector index to facilitate smart searches. You integrate GPT-3.5 to refine search results and allow the chatbot to deliver user-friendly results. Finally, you set up REST endpoints, test the application locally, and deploy it on Azure Kubernetes Service (AKS) to make your virtual assistant ready for use. You call functions that call external APIs, work with data in the cloud, and handle user requests, creating an interactive, AI-powered solution that brings Contoso Bike Shop’s inventory to life!

## Learning objectives

- Load data from Azure Blob Storage into a local directory and import it into vCore-based Azure Cosmos DB for MongoDB, generating embeddings for product fields
- Create a vector index on the generated embeddings and perform vector searches
- Enhance search results using GPT-3.5
- Deploy the application on Azure Kubernetes Service

## Prerequisites

- Access to Azure OpenAI studio
- Familiarity with Azure and the Azure portal
- Experience programming with Node.js