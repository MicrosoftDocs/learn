
[SQL Server 2025](/sql/sql-server/what-s-new-in-sql-server-2025?azure-portal=true) provides native support for connecting to external AI models and services directly from [T-SQL](/sql/t-sql/language-reference?azure-portal=true). This integration eliminates the complexity of managing separate infrastructure while maintaining enterprise-grade security and compliance standards.

The ability to connect SQL Server to external AI services means you can use models from [Azure OpenAI](/azure/ai-services/openai/overview?azure-portal=true), custom [ONNX](/sql/machine-learning/sql-server-machine-learning-services?azure-portal=true) models, or any REST-based AI endpoint without moving your data out of the database. This approach keeps your data secure, reduces latency, and simplifies your application architecture by centralizing AI operations within your data platform.

## Connect to external AI models using REST APIs

SQL Server 2025 builds on the [`sp_invoke_external_rest_endpoint`](/sql/relational-databases/system-stored-procedures/sp-invoke-external-rest-endpoint-transact-sql?azure-portal=true) system stored procedure (introduced in SQL Server 2022) to enable integration with AI services. This capability allows you to call REST APIs directly from T-SQL for integrating with AI services like [Azure OpenAI](/azure/ai-services/openai/overview?azure-portal=true), [Microsoft Foundry](/azure/ai-studio/what-is-ai-studio?azure-portal=true), and custom AI endpoints without leaving the database context.

### Invoke REST endpoints for AI inference

The basic pattern for calling an external AI service involves constructing a JSON payload and sending it to a REST endpoint:

```sql
DECLARE @url NVARCHAR(4000) = N'https://myopenai.openai.azure.com/openai/deployments/text-embedding-ada-002/embeddings?api-version=2023-05-15';
DECLARE @payload NVARCHAR(MAX) = JSON_OBJECT('input': N'SQL Server 2025 AI capabilities');
DECLARE @response NVARCHAR(MAX);
DECLARE @ret INT;

EXEC @ret = sp_invoke_external_rest_endpoint
    @url = @url,
    @method = 'POST',
    @credential = [MyAzureOpenAICredential],
    @payload = @payload,
    @response = @response OUTPUT;

-- Extract the embedding from the response
DECLARE @embedding VECTOR(1536) = JSON_QUERY(@response, '$.result.data[0].embedding');
SELECT @embedding AS generated_embedding;
```

This code sends a text string to Azure OpenAI's embedding endpoint and retrieves a [vector](/sql/t-sql/data-types/vector-data-type?azure-portal=true) embedding. The `sp_invoke_external_rest_endpoint` procedure handles authentication using a [database-scoped credential](/sql/t-sql/statements/create-database-scoped-credential-transact-sql?azure-portal=true), executes the HTTP request, and returns the response as JSON. The embedding is then extracted using `JSON_QUERY` and cast to the vector data type for storage or further processing.

### Use database credentials securely

To call external services securely, you can create [database-scoped credentials](/sql/t-sql/statements/create-database-scoped-credential-transact-sql?azure-portal=true) that store authentication information:

```sql
-- Create a credential for Azure OpenAI
CREATE DATABASE SCOPED CREDENTIAL [MyAzureOpenAICredential]
WITH IDENTITY = 'HTTPEndpointHeaders',
SECRET = '{"api-key":"your-api-key-here"}';
```

This credential stores the API key securely within SQL Server and can be referenced in REST endpoint calls. The credential is encrypted and only accessible to authorized users, ensuring that sensitive authentication information isn't exposed in application code.

## Manage external AI models with `CREATE EXTERNAL MODEL`

SQL Server 2025 introduces new syntax for managing AI model definitions directly in the database. The [`CREATE EXTERNAL MODEL`](/sql/t-sql/statements/create-external-model-transact-sql?azure-portal=true) statement allows you to define model endpoints, authentication methods, and purposes in a centralized, reusable way.

### Define external model objects

Create an external model object to encapsulate the connection details for an AI service:

```sql
CREATE EXTERNAL MODEL Ada2Embeddings
WITH (
    LOCATION = 'https://myopenai.openai.azure.com/openai/deployments/text-embedding-ada-002/embeddings?api-version=2023-05-15',
    API_FORMAT = 'Azure OpenAI',
    MODEL_TYPE = EMBEDDINGS,
    MODEL = 'text-embedding-ada-002',
    CREDENTIAL = [MyAzureOpenAICredential]
);
```

This creates a reusable model definition named `Ada2Embeddings` that points to an Azure OpenAI embedding model. By defining the model once, you can use it throughout your database without repeating connection details, making maintenance easier and reducing the risk of configuration errors.

### Generate embeddings using external models

Once an external model is defined, you can use it with the [`AI_GENERATE_EMBEDDINGS`](/sql/t-sql/functions/ai-generate-embeddings-transact-sql?azure-portal=true) function:

```sql
DECLARE @text NVARCHAR(MAX) = N'SQL Server 2025 enables AI-powered applications';
DECLARE @embedding VECTOR(1536) = AI_GENERATE_EMBEDDINGS(@text USE MODEL Ada2Embeddings);

INSERT INTO documents (title, content, embedding)
VALUES (N'Getting Started', @text, @embedding);
```

This code generates an [embedding](/azure/ai-services/openai/concepts/understand-embeddings?azure-portal=true) for the provided text using the Ada2Embeddings model and stores it in the documents table. The `AI_GENERATE_EMBEDDINGS` function abstracts the complexity of making REST calls and parsing responses, providing a simple, SQL-native way to generate embeddings.

### Modify and remove external models

You can update or remove external model definitions as your requirements change:

```sql
-- Alter an existing external model
ALTER EXTERNAL MODEL Ada2Embeddings
SET LOCATION = 'https://newendpoint.openai.azure.com/openai/deployments/text-embedding-ada-002/embeddings?api-version=2023-05-15';

-- Drop an external model when no longer needed
DROP EXTERNAL MODEL Ada2Embeddings;
```

The `ALTER EXTERNAL MODEL` statement allows you to update model configurations without recreating dependent objects. When a model is no longer needed, `DROP EXTERNAL MODEL` removes the definition cleanly from the database.

## Implement secure authentication patterns

When integrating with external services, SQL Server 2025 provides multiple authentication mechanisms to ensure secure, compliant access to AI services.

### Use managed identities with Microsoft Entra

[Managed identities](/entra/identity/managed-identities-azure-resources/overview?azure-portal=true) eliminate the need to store credentials by using Azure's identity infrastructure. With [SQL Server enabled by Azure Arc](/sql/sql-server/azure-arc/overview?azure-portal=true), you can use managed identities for both inbound and outbound connections:

```sql
-- Create a credential using managed identity
CREATE DATABASE SCOPED CREDENTIAL [AzureOpenAIManagedIdentity]
WITH IDENTITY = 'Managed Identity';

-- Use the managed identity credential with external models
CREATE EXTERNAL MODEL SecureEmbeddingModel
WITH (
    LOCATION = 'https://myopenai.openai.azure.com/openai/deployments/text-embedding-ada-002/embeddings?api-version=2023-05-15',
    API_FORMAT = 'Azure OpenAI',
    MODEL_TYPE = EMBEDDINGS,
    MODEL = 'text-embedding-ada-002',
    CREDENTIAL = [AzureOpenAIManagedIdentity]
);
```

This approach uses the managed identity assigned to your SQL Server instance for authentication, eliminating the need to manage API keys or passwords. The Azure platform handles credential rotation and access management, reducing security risks and administrative overhead.

## Integrate with Azure AI services

SQL Server 2025 integrates with the full suite of [Azure AI services](/azure/ai-services/what-are-ai-services?azure-portal=true), enabling AI scenarios directly from your database.

### Connect to Azure OpenAI Service

[Azure OpenAI](/azure/ai-services/openai/overview?azure-portal=true) provides access to language models like GPT-4, GPT-3.5, and embedding models:

```sql
-- Create a model for GPT-4
CREATE EXTERNAL MODEL GPT4Model
WITH (
    LOCATION = 'https://myopenai.openai.azure.com/openai/deployments/gpt-4/chat/completions?api-version=2024-02-15-preview',
    API_FORMAT = 'Azure OpenAI',
    MODEL_TYPE = EMBEDDINGS,
    MODEL = 'gpt-4',
    CREDENTIAL = [MyAzureOpenAICredential]
);

-- Use GPT-4 for text generation via REST endpoint
DECLARE @prompt NVARCHAR(MAX) = JSON_OBJECT(
    'messages': JSON_ARRAY(
        JSON_OBJECT('role': 'system', 'content': 'You are a helpful assistant'),
        JSON_OBJECT('role': 'user', 'content': 'Explain vector search in simple terms')
    )
);
DECLARE @response NVARCHAR(MAX);

EXEC sp_invoke_external_rest_endpoint
    @url = N'https://myopenai.openai.azure.com/openai/deployments/gpt-4/chat/completions?api-version=2024-02-15-preview',
    @method = 'POST',
    @credential = [MyAzureOpenAICredential],
    @payload = @prompt,
    @response = @response OUTPUT;

SELECT JSON_VALUE(@response, '$.result.choices[0].message.content') AS ai_response;
```

This example creates an external model definition for GPT-4 and demonstrates calling the chat completion API. The response is parsed using JSON functions to extract the AI-generated text, which can then be used in your application logic or stored for later use.

### Use Microsoft Foundry

[Microsoft Foundry](/azure/ai-studio/what-is-ai-studio?azure-portal=true) provides a comprehensive platform for building, training, and deploying custom AI models that address specific business requirements beyond what general-purpose models can offer. While Azure OpenAI provides access to pretrained models like GPT-4 and text-embedding-ada-002, Microsoft Foundry enables you to create specialized models trained on your proprietary data, industry-specific terminology, and unique use cases.

The integration between SQL Server 2025 and Microsoft Foundry allows you to bring domain-specific intelligence directly to your data without data movement or synchronization. For example, you might train a custom classification model to categorize customer support tickets based on your company's specific products and services, or create a sentiment analysis model tuned to your industry's language patterns. Once deployed in Microsoft Foundry, these models become accessible through the same `CREATE EXTERNAL MODEL` syntax you use for Azure OpenAI.

```sql
-- Connect to a custom classification model in Microsoft Foundry
CREATE EXTERNAL MODEL CustomClassifier
WITH (
    LOCATION = 'https://myaifoundry.cognitiveservices.azure.com/models/classifier/predict?api-version=1.0',
    API_FORMAT = 'Azure OpenAI',
    MODEL_TYPE = EMBEDDINGS,
    MODEL = 'classifier',
    CREDENTIAL = [AzureAIFoundryCredential]
);

-- Use the custom model for domain-specific predictions
DECLARE @input_text NVARCHAR(MAX) = N'Customer reports slow query performance in production database';
DECLARE @request NVARCHAR(MAX) = JSON_OBJECT('input': @input_text);
DECLARE @response NVARCHAR(MAX);

EXEC sp_invoke_external_rest_endpoint
    @url = N'https://myaifoundry.cognitiveservices.azure.com/models/classifier/predict?api-version=1.0',
    @method = 'POST',
    @credential = [AzureAIFoundryCredential],
    @payload = @request,
    @response = @response OUTPUT;

-- Extract classification result
SELECT JSON_VALUE(@response, '$.result.category') AS ticket_category,
       JSON_VALUE(@response, '$.result.priority') AS priority_level;
```

This approach enables you to maintain a single source of truth for your data in SQL Server while using AI capabilities that understand your specific business context. The benefit extends beyond technical convenience: by keeping your data in SQL Server and calling AI models through secure API endpoints, you maintain full control over data governance, compliance, and access policies. Your sensitive business data never needs to leave your database infrastructure, yet you can still apply AI models that were trained to understand your unique requirements.

## Deploy ONNX models

[Open Neural Network Exchange (ONNX)](https://onnx.ai?azure-portal=true) is an open standard for representing machine learning models. SQL Server 2025 supports ONNX runtime, enabling you to deploy custom models locally.

### Use ONNX runtime for local inference

ONNX models can run directly within SQL Server without external dependencies:

```sql
-- Reference a local ONNX model file
CREATE EXTERNAL MODEL LocalSentimentModel
WITH (
    LOCATION = 'C:\Models\sentiment_analysis',
    API_FORMAT = 'ONNX Runtime',
    MODEL_TYPE = EMBEDDINGS,
    MODEL = 'sentiment-model',
    LOCAL_RUNTIME_PATH = 'C:\onnx_runtime\'
);
```

This approach suits scenarios where you need low-latency inference, want to avoid external network calls, or have compliance requirements that prevent data from leaving your infrastructure. The `LOCATION` should point to the directory containing the model.onnx and tokenizer.json files, while `LOCAL_RUNTIME_PATH` points to the directory containing the ONNX runtime DLL files.

## Apply security best practices

When integrating AI services with SQL Server, follow these security guidelines:

### Control access with permissions

Grant permissions to external model objects carefully:

```sql
-- Grant permission to use an external model
GRANT EXECUTE ON EXTERNAL MODEL::Ada2Embeddings TO AIApplicationUser;

-- Revoke permissions when no longer needed
REVOKE EXECUTE ON EXTERNAL MODEL::Ada2Embeddings FROM AIApplicationUser;
```

These statements control which users and roles can use specific external models, enabling fine-grained access control over AI capabilities.

### Enable auditing and monitoring

Track AI operations for compliance and troubleshooting:

```sql
-- Create an audit specification for external REST endpoint calls
CREATE SERVER AUDIT SPECIFICATION TrackAIOperations
FOR SERVER AUDIT [MyServerAudit]
ADD (DATABASE_OBJECT_ACCESS_GROUP);
```

Auditing captures all interactions with external models and REST endpoints, providing visibility into AI usage patterns and supporting compliance requirements.

By implementing these secure integration patterns, you can deploy AI-powered solutions with SQL Server 2025 that meet enterprise security, compliance, and governance requirements.

