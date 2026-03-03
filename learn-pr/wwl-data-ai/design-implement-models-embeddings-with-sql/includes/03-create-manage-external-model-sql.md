External models provide a way to reference AI models from within SQL Server and Azure SQL using Transact-SQL. An external model represents a connection to a model endpoint and defines how SQL built-in AI functions invoke that model.

By creating external models, you make AI capabilities available directly inside the database engine without embedding model-specific logic in application code.

## What is an external model

An external model is a database object that stores metadata about an AI model endpoint. This metadata includes information such as the endpoint URL, authentication details, and model-specific configuration.

External models aren't models that run inside SQL Server. Instead, they act as a managed reference that allows SQL Server to call an external AI service when executing AI functions.

Once created, external models can be reused across queries and workloads, providing a consistent and centrally managed way to access AI capabilities from SQL.

## Create an external model

You create an external model by using the `CREATE EXTERNAL MODEL` statement. This statement defines the model name and associates it with an external endpoint.

Creating the external model doesn't invoke the model or generate output. It establishes a reusable definition that AI functions such as embedding generation or other AI-assisted operations can later reference.

Because external models are database objects, they can be managed using standard SQL practices, including naming conventions, permissions, and deployment through scripts.

## Modify an external model

External models can change over time as endpoints, credentials, or configuration settings are updated. To reflect these changes, you can use the `ALTER EXTERNAL MODEL` statement.

Altering an external model updates its metadata without requiring dependent queries or functions to be rewritten. This update allows you to adjust model configuration centrally while keeping existing SQL logic intact.

Managing changes at the external model level helps reduce coupling between application logic and AI service configuration.

## Use external models with AI functions

SQL Server provides built-in AI functions that reference an external model to perform AI-related operations. These functions handle tasks such as generating embeddings by calling the external model endpoint defined in the database.

AI functions use the external model definition to determine which endpoint to call and how to authenticate the request. This separation allows Transact-SQL code to focus on data processing rather than connection or credential details.

Before creating an external model, you need a database scoped credential that stores the authentication details for the AI endpoint. Azure OpenAI endpoints support two authentication options:

- **Managed Identity** (recommended for Azure SQL Database): Your database's managed identity authenticates directly with Azure OpenAI. Grant it the Cognitive Services OpenAI User role on the Azure OpenAI resource.

    ```sql
    CREATE DATABASE SCOPED CREDENTIAL [https://<resource-name>.cognitiveservices.azure.com/]
        WITH IDENTITY = 'Managed Identity',
        SECRET = '{"resourceid":"https://cognitiveservices.azure.com"}';
    ```

- **API key**: Store the key in HTTP headers. This approach works for both Azure SQL Database and SQL Server 2025.

    ```sql
    CREATE DATABASE SCOPED CREDENTIAL [https://<resource-name>.cognitiveservices.azure.com/]
        WITH IDENTITY = 'HTTPEndpointHeaders',
        SECRET = '{"api-key":"<your-api-key>"}';
    ```

Avoid hardcoding API keys in your T-SQL code. Use managed identities when possible for better security and easier key rotation.

> [!IMPORTANT]
> Grant the `EXECUTE ANY EXTERNAL ENDPOINT` permission to users or roles that need to call external endpoints: `GRANT EXECUTE ANY EXTERNAL ENDPOINT TO [user_or_role];`

With the credential in place, you can create the external model. The following example shows a minimal workflow.

```sql
CREATE EXTERNAL MODEL my_external_model
WITH (
    LOCATION   = 'https://<resource-name>.cognitiveservices.azure.com/openai/deployments/<deployment-name>/embeddings?api-version=<api-version>',
    API_FORMAT = 'Azure OpenAI',
    MODEL_TYPE = EMBEDDINGS,
    MODEL      = 'text-embedding-3-small',
    CREDENTIAL = [https://<resource-name>.cognitiveservices.azure.com/],
    PARAMETERS = '{"dimensions":<n>}'
);
```

Once the external model is created, AI functions can reference it in queries.

```sql
SELECT
    id,
    AI_GENERATE_EMBEDDINGS(
        description USE MODEL my_external_model
    ) AS embedding
FROM dbo.documents;
```

In this example, the external model defines how SQL Server connects to the AI service. The `AI_GENERATE_EMBEDDINGS` function uses that definition to generate embeddings for the `description` column without embedding endpoint or authentication details in the query.

When you combine external models with AI functions, SQL Server enables AI workflows that are defined, executed, and maintained entirely through Transact-SQL.

## Managing external models as database objects

Because external models are database-scoped objects, they fit naturally into existing database management practices. You can control access through permissions, include them in deployment pipelines, and manage their lifecycle alongside other schema objects.

Treating external models as first-class database objects helps ensure consistency, maintainability, and predictable behavior when integrating AI capabilities into SQL-based solutions.

## Key takeaways

External models are database objects that store metadata about AI model endpoints, allowing SQL Server to call external AI services without embedding connection details in application code. You create them with `CREATE EXTERNAL MODEL`, update them with `ALTER EXTERNAL MODEL`, and reference them in built-in AI functions like `AI_GENERATE_EMBEDDINGS`. Because they're database-scoped, you can manage permissions, lifecycle, and deployment alongside your other schema objects.
