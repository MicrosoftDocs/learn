AI-enabled database solutions often expose model endpoints that applications call to generate predictions, embeddings, or other AI-powered responses. Securing these endpoints protects both your AI models and the data they process. Managed Identity provides a secure, credential-free way to authenticate applications to model endpoints.

When applications call Azure OpenAI, Azure Machine Learning, or other AI services from within your database environment, you need to control who can invoke these calls and protect the communication channel. This unit covers strategies for securing model endpoints in SQL Server, Azure SQL, and SQL databases in Microsoft Fabric.

## Understand model endpoint security concerns

Model endpoints present unique security challenges compared to traditional database operations. These endpoints often process sensitive data, can incur significant costs per call, and may expose intellectual property embedded in fine-tuned models.

Unauthorized access to model endpoints can lead to data exfiltration through carefully crafted prompts, unexpected costs from excessive API calls, and exposure of proprietary model behaviors. Protecting these endpoints requires authentication, authorization, and monitoring.

In Azure SQL and SQL databases in Microsoft Fabric, you can call external AI services using stored procedures or functions that make HTTP requests. These calls must authenticate to the AI service, typically using API keys or Managed Identity.

## Configure Managed Identity for AI services

Managed Identity eliminates the need to store API keys in your database or application code. Instead, Azure manages the identity credentials automatically, and you grant that identity access to AI services.

For an Azure SQL Database that needs to call Azure OpenAI, first enable system-assigned managed identity:

```sql
-- The managed identity is enabled in Azure portal or via Azure CLI
-- Verify the identity exists
SELECT * FROM sys.dm_external_provider_certificate_store;
```

Grant the managed identity access to Azure OpenAI in Azure role-based access control (RBAC):

```powershell
# Get the managed identity principal ID from Azure SQL
$sqlIdentity = (Get-AzSqlServer -ServerName myserver -ResourceGroupName myrg).Identity.PrincipalId

# Assign Cognitive Services User role on the Azure OpenAI resource
New-AzRoleAssignment -ObjectId $sqlIdentity `
    -RoleDefinitionName "Cognitive Services User" `
    -Scope "/subscriptions/{sub-id}/resourceGroups/{rg}/providers/Microsoft.CognitiveServices/accounts/{aoai-name}"
```

Create a database-scoped credential that uses Managed Identity:

```sql
CREATE DATABASE SCOPED CREDENTIAL AzureOpenAICredential
WITH IDENTITY = 'Managed Identity',
SECRET = '{"resourceId": "https://cognitiveservices.azure.com/"}';
```

This credential tells SQL to obtain a token for the Cognitive Services resource scope using its managed identity.

## Implement secure endpoint calls

Use external REST endpoint invocation to call AI services securely. Create an external data source that references the AI endpoint:

```sql
CREATE EXTERNAL DATA SOURCE AzureOpenAI
WITH (
    TYPE = REST,
    LOCATION = 'https://myopenai.openai.azure.com',
    CREDENTIAL = AzureOpenAICredential
);
```

Create a stored procedure that calls the AI endpoint:

```sql
CREATE PROCEDURE dbo.GetEmbedding
    @InputText nvarchar(max),
    @Embedding nvarchar(max) OUTPUT
AS
BEGIN
    DECLARE @payload nvarchar(max) = JSON_OBJECT('input': @InputText);
    DECLARE @response nvarchar(max);
    
    EXEC sp_invoke_external_rest_endpoint
        @url = 'https://myopenai.openai.azure.com/openai/deployments/text-embedding/embeddings?api-version=2024-02-01',
        @method = 'POST',
        @payload = @payload,
        @credential = AzureOpenAICredential,
        @response = @response OUTPUT;
    
    SET @Embedding = JSON_VALUE(@response, '$.data[0].embedding');
END;
```

Grant execute permission only to users who should access AI capabilities:

```sql
-- Create a role for AI feature access
CREATE ROLE AIFeatureUsers;
GRANT EXECUTE ON dbo.GetEmbedding TO AIFeatureUsers;

-- Add specific users to the role
ALTER ROLE AIFeatureUsers ADD MEMBER [app-service-identity];
```

> [!IMPORTANT]
> Limit which database users can invoke AI endpoints. AI calls often incur costs and may process sensitive data. Use role-based access to control which applications and users can use these features.

## Secure Azure Machine Learning endpoints

Azure Machine Learning model endpoints follow similar patterns. Configure Managed Identity access and create credentials for authentication.

For real-time inference endpoints:

```sql
CREATE DATABASE SCOPED CREDENTIAL AMLCredential
WITH IDENTITY = 'Managed Identity',
SECRET = '{"resourceId": "https://ml.azure.com/"}';

CREATE EXTERNAL DATA SOURCE AMLEndpoint
WITH (
    TYPE = REST,
    LOCATION = 'https://myworkspace.region.inference.ml.azure.com',
    CREDENTIAL = AMLCredential
);
```

When calling batch inference endpoints, you typically submit data to storage and trigger a pipeline. Secure the storage access using Managed Identity as well.

## Implement endpoint monitoring

Monitor AI endpoint usage to detect anomalies and control costs:

```sql
-- Create a logging table for AI calls
CREATE TABLE dbo.AIEndpointLog (
    LogID int IDENTITY PRIMARY KEY,
    CallTimestamp datetime2 DEFAULT SYSUTCDATETIME(),
    CallerPrincipal nvarchar(128) DEFAULT ORIGINAL_LOGIN(),
    EndpointName nvarchar(256),
    InputLength int,
    ResponseStatus int,
    DurationMs int
);

-- Modify procedures to log calls
CREATE PROCEDURE dbo.GetEmbeddingWithLogging
    @InputText nvarchar(max),
    @Embedding nvarchar(max) OUTPUT
AS
BEGIN
    DECLARE @StartTime datetime2 = SYSUTCDATETIME();
    DECLARE @response nvarchar(max);
    DECLARE @status int;
    
    -- Make the AI call
    EXEC sp_invoke_external_rest_endpoint
        @url = 'https://myopenai.openai.azure.com/openai/deployments/text-embedding/embeddings?api-version=2024-02-01',
        @method = 'POST',
        @payload = JSON_OBJECT('input': @InputText),
        @credential = AzureOpenAICredential,
        @response = @response OUTPUT;
    
    -- Log the call
    INSERT INTO dbo.AIEndpointLog (EndpointName, InputLength, ResponseStatus, DurationMs)
    VALUES ('text-embedding', LEN(@InputText), 200, DATEDIFF(millisecond, @StartTime, SYSUTCDATETIME()));
    
    SET @Embedding = JSON_VALUE(@response, '$.data[0].embedding');
END;
```

Query the log to identify unusual patterns:

```sql
-- Find users making excessive AI calls
SELECT CallerPrincipal, COUNT(*) AS CallCount, AVG(DurationMs) AS AvgDuration
FROM dbo.AIEndpointLog
WHERE CallTimestamp > DATEADD(hour, -1, SYSUTCDATETIME())
GROUP BY CallerPrincipal
HAVING COUNT(*) > 100
ORDER BY CallCount DESC;
```

> [!TIP]
> Set up alerts for unusual AI endpoint usage patterns. Sudden spikes in calls or calls from unexpected principals may indicate compromised credentials or application bugs.

For SQL databases in Microsoft Fabric, AI endpoint access is managed through workspace permissions and Fabric capacity. Users with appropriate workspace roles can invoke AI features, and usage is tracked through Fabric's monitoring capabilities.
