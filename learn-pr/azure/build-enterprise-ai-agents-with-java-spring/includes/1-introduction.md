Spring AI is a powerful framework that simplifies the integration of AI capabilities into Java applications. In this module, you learn how to build an AI-powered application and AI Agents, using Spring AI with Azure OpenAI, and deploy it to Azure Container Apps.

## What is Spring AI?

Spring AI provides the following abstractions and tools that make it easy to work with various AI models and services:

- ChatClient API: Core abstraction for interacting with Large Language Models (LLMs).
- Multiple AI Model providers: Support for all major AI Model providers, including Azure OpenAI.
- Embeddings: Generate vector embeddings for semantic search.
- Vector storage integration: Built-in support for vector databases, such as `pgvector`.
- Advisors API: Encapsulates Generative AI patterns, for example, to implement Retrieval Augmented Generation (RAG).

## Sample use cases

### RAG implementation

A retrieval-augmented generation (RAG) application typically has the following capabilities:

- Converts user questions into vector embeddings.
- Finds similar previous prompts and responses using vector similarity search.
- Uses found responses as context for generating responses.
- Stores interactions for future reference.

### Agents and Workflows

Spring AI also empowers you to build dynamic AI Agents and orchestrated workflows. While various patterns exist - like chain, parallelization, and routing - this module focuses exclusively on the *Evaluator-Optimizer Workflow*.

This pattern iteratively refines outputs through a generator-evaluator loop, ensuring high-quality and adaptive AI responses.

## Why Azure OpenAI and Container Apps?

Azure OpenAI provides a secure and scalable platform for deploying AI models with enterprise-grade features. It ensures data privacy and compliance, making it suitable for sensitive applications, and integrates seamlessly with other Azure services.

Azure Container Apps offers a serverless environment for running containerized applications with automatic scaling based on demand, simplifying microservice deployment and management.

Azure PostgreSQL is a fully managed database service that supports advanced features like vector search, providing high availability, security, and performance for large datasets used in AI models.

## Learning objectives

After completing this module, you'll be able to:

- Understand Spring AI's core abstractions and Azure OpenAI integration.
- Create and configure Azure PostgreSQL for vector storage.
- Implement an end-to-end AI application and AI Agents with Spring AI.
- Deploy and scale your application on Azure Container Apps.
