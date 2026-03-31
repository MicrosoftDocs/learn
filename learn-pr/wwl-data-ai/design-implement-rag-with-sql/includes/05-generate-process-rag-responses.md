A customer wants to know which pedals fit their Mountain-500 bike. You use vector search to find the relevant products, formatted them as JSON, and built a prompt with grounding instructions. The retrieval and augmentation steps are done. Now comes the "G" in RAG: generation. This step is where you send everything to a language model and get back an answer.

Think about it like this: you gathered all the ingredients (retrieved data), prepared the recipe (augmented prompt), and now you're putting it in the oven (calling the model) to bake the final dish (the response). The model uses the context you provided to generate a grounded answer.

## Call the model from SQL

You might think this step requires leaving T-SQL and writing application code. But SQL Server and Azure SQL Database can call REST endpoints directly using `sp_invoke_external_rest_endpoint`. This stored procedure sends HTTPS requests to external services and returns the response. The stored procedure is enabled by default in Azure SQL Database and can be enabled in SQL Server 2025 using `sp_configure`.

Here's the basic pattern:

```sql
DECLARE @response NVARCHAR(MAX);
DECLARE @returnValue INT;

EXECUTE @returnValue = sp_invoke_external_rest_endpoint
    @url = N'https://<endpoint>.openai.azure.com/openai/deployments/<model>/chat/completions?api-version=<api-version>',
    @method = 'POST',
    @payload = @payload,
    @credential = [https://<endpoint>.openai.azure.com],
    @response = @response OUTPUT;
```

The `@url` parameter points to your Azure OpenAI deployment endpoint. The `@method` is usually 'POST' for generation requests. The `@payload` contains the JSON prompt you previously built. The `@credential` references a database scoped credential that holds your authentication details. The `@response` output parameter captures the model's response.

When you call the deployment endpoint of your model with your augmented prompt, the model processes it and returns the result. The stored procedure returns 0 when the HTTP call succeeds with a 2xx status code, or the actual HTTP status code when it fails.

## Authenticate with the endpoint

The `@credential` parameter references a database scoped credential that holds your authentication details. You set up these credentials when you create an external model, using either managed identity or an API key. The same credential works for both external model calls and direct REST endpoint calls with `sp_invoke_external_rest_endpoint`.

## Extract the answer from the response

When the model finishes processing your prompt, `sp_invoke_external_rest_endpoint` returns the result wrapped in a standard envelope. The stored procedure adds metadata about the HTTP transaction, then nests the actual API response inside a `result` property:

```json
{
  "response": {
    "status": {
      "http": {
        "code": 200,
        "description": "OK"
      }
    }
  },
  "result": {
    "choices": [
      {
        "message": {
          "role": "assistant",
          "content": "The Mountain-500 is compatible with several pedal options..."
        }
      }
    ]
  }
}
```

The answer you want lives at `$.result.choices[0].message.content`. To get there, use `JSON_VALUE`, which extracts scalar values from JSON:

```sql
IF @returnValue = 0
BEGIN
    DECLARE @answer NVARCHAR(MAX);
    SET @answer = JSON_VALUE(@response, '$.result.choices[0].message.content');
    SELECT @answer AS AssistantResponse;
END
ELSE
BEGIN
    SELECT 
        @returnValue AS HttpStatus,
        JSON_VALUE(@response, '$.response.status.http.description') AS ErrorDescription;
END
```

If you ever need to extract a JSON object or array rather than a single value, use `JSON_QUERY` instead. For most RAG scenarios, `JSON_VALUE` on the message content is all you need.

## Manage errors and retries

Calling an external service from a database can introduces failure modes you don't encounter with local queries. The endpoint might be temporarily unavailable, your request might get rate-limited, or authentication could fail. Your SQL queries need to handle these conditions gracefully.

The return value from `sp_invoke_external_rest_endpoint` tells you what happened. A 0 means the HTTP call succeeded with a 2xx status. For failures, the return value is the HTTP status code itself. For example, a 429 status means the service is throttling your requests. A 401 or 403 points to credential problems:

```sql
IF @returnValue = 0
    SET @answer = JSON_VALUE(@response, '$.result.choices[0].message.content');
ELSE IF @returnValue = 429
    RAISERROR('Service is busy. Try again later.', 16, 1);
ELSE IF @returnValue = 401 OR @returnValue = 403
    RAISERROR('Authentication failed. Check your credential configuration.', 16, 1);
ELSE
BEGIN
    DECLARE @errorMsg NVARCHAR(500) = 'API call failed with status ' + CAST(@returnValue AS NVARCHAR(10));
    RAISERROR(@errorMsg, 16, 1);
END
```

For transient failures like timeouts or temporary service unavailability, the stored procedure can retry automatically. Add the `@retry_count` parameter and in this example, it attempts the call up to three times before giving up:

```sql
EXECUTE @returnValue = sp_invoke_external_rest_endpoint
    @url = @url,
    @payload = @payload,
    @credential = @credentialName,
    @retry_count = 3,
    @response = @response OUTPUT;
```

This parameter handles the common case where a request fails once but succeeds on the next attempt.

## Build a complete RAG stored procedure

You now know each piece of the RAG puzzle. Let's put them together into a single stored procedure that a customer support application could call. The procedure accepts a natural language question and returns an answer grounded in your product data.

Here's what the procedure does:

1. Converts the question into an embedding so you can compare it against your product descriptions.
1. Finds the most relevant products using vector distance to compare the question embedding against each product's precomputed description embedding.
1. Builds the prompt with a system message that tells the model to stick to the provided data, and a user message that combines the retrieved products with the original question.
1. Sends everything to Azure OpenAI.
1. Extracts the answer from the response and return it to the caller.

```sql
CREATE PROCEDURE dbo.AskProductQuestion
    @Question NVARCHAR(1000),
    @Answer NVARCHAR(MAX) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @questionVector VECTOR(1536);
    DECLARE @context NVARCHAR(MAX);
    DECLARE @payload NVARCHAR(MAX);
    DECLARE @response NVARCHAR(MAX);
    DECLARE @returnValue INT;
    
    -- Step 1:Convert question to embedding
    SELECT @questionVector = AI_GENERATE_EMBEDDINGS(@Question USE MODEL my_embedding_model);
    
    -- Step 2: Retrieve relevant products using vector search
    SET @context = (
        SELECT TOP 3 
            p.Name AS ProductName, 
            p.Color, 
            p.Size, 
            pm.Name AS Model
        FROM Production.Product p
        INNER JOIN Production.ProductModel pm ON p.ProductModelID = pm.ProductModelID
        ORDER BY VECTOR_DISTANCE('cosine', p.DescriptionVector, @questionVector)
        FOR JSON PATH
    );
    
    -- Step 3: Build augmented prompt
    SET @payload = JSON_OBJECT(
        'messages': JSON_ARRAY(
            JSON_OBJECT('role': 'system', 'content': 'You are an Adventure Works product assistant. Answer questions using only the provided product data.'),
            JSON_OBJECT('role': 'user', 'content': 'Products: ' + @context + ' Question: ' + @Question)
        ),
        'max_tokens': 500,
        'temperature': 0.5
    );
    
    -- Step 4: Call the model
    EXECUTE @returnValue = sp_invoke_external_rest_endpoint
        @url = N'https://adventureworks-openai.openai.azure.com/openai/deployments/gpt-5.2/chat/completions?api-version=2024-10-21',
        @method = 'POST',
        @payload = @payload,
        @credential = [https://adventureworks-openai.openai.azure.com],
        @response = @response OUTPUT;
    
    -- Extract and return the answer
    IF @returnValue = 0
        SET @Answer = JSON_VALUE(@response, '$.result.choices[0].message.content');
    ELSE
        SET @Answer = 'Unable to process your question. Please try again.';
END;
```

You completed the RAG pipeline in T-SQL. A customer asks "Which pedals work with the Mountain-500?" Your procedure converts that question to a vector, finds the most relevant products, sends them to the model with grounding instructions, and returns an answer based on your actual inventory. No middleware, no external application code, just SQL calling AI and returning results.

## Key takeaways

The *generation* step is where your RAG pipeline delivers value. You send the augmented prompt to Azure OpenAI using `sp_invoke_external_rest_endpoint`, which handles the HTTP communication without leaving T-SQL. Authentication uses the same database scoped credentials you set up when creating external models. When the response comes back, `JSON_VALUE` pulls out the assistant's answer. Build in error handling because network calls fail in ways that local queries don't. With all three RAG steps running in T-SQL, your database becomes more than storage. It becomes an intelligent service that answers questions using your data.
