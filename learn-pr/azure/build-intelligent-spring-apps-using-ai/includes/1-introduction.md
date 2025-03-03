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

A Retrieval Augmented Generation (RAG) application has these capabilities:

1. Converts user questions into vector embeddings
2. Finds similar previous Q&As using vector similarity search
3. Uses found Q&As as context for generating responses
4. Stores interactions for future reference

## Why Azure OpenAI and Container Apps?

- **Azure OpenAI**: Secure, scalable AI model deployment with enterprise features
- **Azure Container Apps**: Serverless container hosting with autoscaling
- **Azure PostgreSQL**: Managed database service with vector search capabilities

## Learning Objectives

After completing this module, you'll be able to:

- Understand Spring AI's core abstractions and Azure OpenAI integration
- Create and configure Azure PostgreSQL for vector storage
- Implement an end-to-end AI application with Spring AI
- Deploy and scale your application on Azure Container Apps

## Prerequisites

Before starting this module, you should have:

- Basic familiarities with Java and Spring Boot
- Experience with Git and Maven/Gradle
- An active Azure subscription
- Java 17 or later installed
- `psql` client

Let's get started by setting up our development environment!
