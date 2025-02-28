Spring AI + ACA Learn Module Agenda

# Part 1 Module

**Title:** Building an AI-Powered Java App with Spring AI, Azure OpenAI, and Azure Database for PostgreSQL on Azure Container Apps

**Duration:** ~40 minutes

### Learning Objectives

### Understand Spring AI’s core abstractions (ChatClient, function calling, embeddings) and how to integrate Azure OpenAI with Java applications using Microsoft Entra ID or Managed Identity

### Create and configure Azure Database for PostgreSQL Flexible Server as a vector database and for storing data

### Implement an end-to-end AI-driven use case with minimal deployment steps to Azure Container Apps

### Gain confidence in building, configuring, and running a simple AI + Data application without deep containerization overhead

### Prerequisites

- Basic familiarity with Java and Spring Boot
- Experience with Git, Maven/Gradle, or other build tools
- An active Azure subscription with permissions to create Container Apps and Azure Database for PostgreSQL

### 1\. Introduction to Spring AI in Java

- **Overview**: What is Spring AI? Brief discussion of its design, parallels to frameworks like LangChain.
- **Key Features**: ChatClient API, multi-provider support, vector DB integrations, prompt engineering.
- **Simple Use Cases:** Q&A, chatbots, function calling for real-time data, embeddings.

### 2\. Environment Setup

- **Local Tools: Java 17+, Maven/Gradle, Git, Azure CLI with the Container Apps extension.**
- **Azure Setup: Creating or selecting a resource group (no advanced networking details; keep it simple), basic authentication options.**

### 3\. Azure Database for PostgreSQL Flexible Server

- **Provisioning**: Create a PostgreSQL Flexible Server (portal or CLI). Keep networking simple (public access).
- **Schema**: Demonstrate a small table for AI data (e.g., storing conversation logs or vector embeddings).

### 4\. Building a Spring AI Application

- **Project Bootstrapping**: Use Spring Initializr or add dependencies manually.
- **Spring AI Dependencies**: BOM, AI Model Starters, OpenAI or Azure OpenAI libraries, plus a Postgres driver.
- **Basic AI Workflow**:
    1. Configure Spring AI + Azure OpenAI keys.
    2. Write a ChatClient snippet or embeddings example.
    3. (Optional) Show a single retrieval call or function-calling scenario.

### 5\. Integrating with Azure PostgreSQL

- **Database Connectivity**: Configure spring.datasource and test a local connection.
- **Application Logic**:
  - Store AI responses or user prompts in Postgres.
  - Retrieve domain data from Postgres and feed it back into the AI model.

### 6\. Deploying to Azure Container Apps

_Simple steps, no deep containerization instruction._

- **Essential Steps**:
    1. Create a Container Apps environment.
    2. Use az containerapp up to deploy from source or artifact.
    3. Set environment variables for DB connection and OpenAI key.
    4. Confirm the application is running by hitting the assigned endpoint.

**7\. Summary & Hands-On**

- **Recap**: You now have a local Java + Spring AI project, connected to Azure PostgreSQL, minimally deployed to ACA.
- **Hands-On Cleanup**: Provide a command to remove the resource group:  
    \` az group delete --name &lt;RESOURCE_GROUP&gt; --yes --no-wait \`

**8\. Assessment (4 Questions)**

1. **Spring AI Basics**: Which core abstraction allows you to interact with an LLM for text completion and function calling?
    - (Correct answer: ChatClient API)
2. **Azure PostgreSQL**: How do you store AI context or user data in an Azure PostgreSQL database for retrieval?
    - (Correct answer: Via JDBC + spring.datasource.\* config)
3. **Azure OpenAI Integration**: Which property/credential must be set in Spring AI to point to an Azure OpenAI deployment?
    - (Correct answer: deploymentName or endpoint for the Azure resource)
4. **Deployment to ACA**: Which Azure CLI command can quickly push your code/artifact to Azure Container Apps?
    - (Correct answer: az containerapp up)

# Part-2 module

**Title:** Testing, Observability, and Scaling for AI-driven Java Apps

**Duration:** ~30-40 minutes

## Focus Areas

1. **Testing and Evaluation**: Use Spring AI’s built-in strategies to evaluate prompt accuracy, reduce hallucinations, and maintain structured output.
2. **Observability**: Review logs in Azure Container Apps, set up minimal Application Insights or Log Analytics.
3. **Scaling**: Configure horizontal autoscaling rules (HTTP or CPU-based) in ACA for heavier loads.
4. **Advanced/Optional**: Explore function evaluation, security (Key Vault), or retrieval-augmented generation with larger data sets.

## Outline

### Testing AI Responses

- - Structured output checks, built-in Evaluator API.
    - Example: verifying that a generated JSON matches your schema.

### Observability Tools

- - Checking logs and live metrics in Container Apps.
    - Basic guidance for hooking up Application Insights or Log Analytics.

### Autoscaling

- - Setting min/max instances, scale to zero, CPU/memory thresholds.
    - Quick demonstration in the portal or CLI.

### Hands-On Example

- - Show retrieving logs, diagnosing a potential error, then adjusting scaling to handle bursty traffic.