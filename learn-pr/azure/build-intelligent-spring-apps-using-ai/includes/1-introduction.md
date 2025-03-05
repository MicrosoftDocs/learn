Spring AI is a powerful framework that simplifies the integration of AI capabilities into Java applications. In this module, you learn how to build an AI-powered application using Spring AI with Azure OpenAI and deploy it to Azure Container Apps.

## What is Spring AI?

Spring AI provides a set of abstractions and tools that make it easy to work with various AI models and services:

- **ChatClient API**: Core abstraction for interacting with Large Language Models (LLMs).
- **Multiple AI Model providers**: Support for all major AI Model providers, including Azure OpenAI.
- **Embeddings**: Generate vector embeddings for semantic search.
- **Vector storage integration**: Built-in support for vector databases, such as PGVector.
- **Advisors API**: Encapsulates Generative AI patterns, for example, to implement Retrieval Augmentation (RAG).

## Sample Use Cases

### RAG Implementation

A Retrieval Augmented Generation (RAG) application typically has these capabilities:

1. Converts user questions into vector embeddings
2. Finds similar previous prompts and responses using vector similarity search
3. Uses found responses as context for generating responses
4. Stores interactions for future reference

## Why Azure OpenAI and Container Apps?

- **Azure OpenAI**: Azure OpenAI provides a secure and scalable platform for deploying AI models with enterprise-grade features. It ensures data privacy and compliance, making it suitable for sensitive applications. Additionally, it integrates seamlessly with other Azure services for a comprehensive AI solution.
- **Azure Container Apps**: Azure Container Apps offers a serverless environment for running containerized applications with automatic scaling based on demand. It simplifies the deployment and management of microservices, enabling developers to focus on building applications without worrying about infrastructure.
- **Azure PostgreSQL**: Azure PostgreSQL is a fully managed database service that supports advanced features like vector search for AI applications. It provides high availability, security, and performance, making it an ideal choice for storing and querying large datasets used in AI models.

## Learning Objectives

After completing this module, you'll be able to:

- Understand Spring AI's core abstractions and Azure OpenAI integration
- Create and configure Azure PostgreSQL for vector storage
- Implement an end-to-end AI application with Spring AI
- Deploy and scale your application on Azure Container Apps
