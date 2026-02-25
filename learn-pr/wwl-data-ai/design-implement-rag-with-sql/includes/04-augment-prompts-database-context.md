Retrieval gets you the data. But a JSON blob on its own doesn't answer anyone's question. If a customer asks about bike pedal compatibility, you've got the product info from your database, but now you need to tell the language model what to do with it. That step represents the "A" in RAG: augmentation.

## Understand the chat message structure

Different models have different APIs, but most chat-based models follow a similar pattern. We use Azure OpenAI as our example, but the concepts apply broadly.

Azure OpenAI chat models expect messages with roles. The **system** role defines how the assistant should behave. The **user** role contains the original question and the database context into which the model should ground its answer. Optionally, an **assistant** role can hold previous responses in a multi-turn conversation. Here's a simplified example of a prompt structure:

```json
{
  "messages": [
    {
      "role": "system",
      "content": "You are a helpful assistant that answers questions about products. Use only the provided context to answer. If the context doesn't contain enough information, say so."
    },
    {
      "role": "user", 
      "content": "Context: {retrieved_data}\n\nQuestion: {user_question}"
    }
  ]
}
```

In this example, `{retrieved_data}` would be the JSON you built from your product query, and `{user_question}` would be something like "Which pedals are compatible with the Mountain-500?"

The **system** message sets ground rules. The **user** message combines your database context with the actual question.

## Build prompts in T-SQL

You could build this JSON in your application code, but it's often convenient to keep it all in the database. Your retrieval query, your context formatting, and your prompt construction live together, and T-SQL's `JSON_OBJECT` and `JSON_ARRAY` functions handle the JSON formatting.

```sql
DECLARE @userQuestion NVARCHAR(1000) = 'Which pedals are compatible with the Mountain-500?';

-- @context contains retrieved product data as JSON from the retrieval step

DECLARE @systemMessage NVARCHAR(MAX) = 'You are a customer service assistant for Adventure Works. Answer questions using only the provided product information. Be concise and helpful.';

DECLARE @userMessage NVARCHAR(MAX) = 'Product information: ' + @context + CHAR(10) + CHAR(10) + 'Customer question: ' + @userQuestion;

DECLARE @payload NVARCHAR(MAX) = JSON_OBJECT(
    'messages': JSON_ARRAY(
        JSON_OBJECT('role': 'system', 'content': @systemMessage),
        JSON_OBJECT('role': 'user', 'content': @userMessage)
    ),
    'max_tokens': 500,
    'temperature': 0.7
);
```

The `@payload` variable now contains a complete request body ready for the Azure OpenAI API.

## Ground the model in your data

Grounding tells the model to use your data as the source of truth. Without it, the model might rely on its training data, which could be outdated or wrong for your domain. A customer asking about Adventure Works bike warranties shouldn't get generic warranty information from the internet.

Good grounding instructions set scope ("use only the provided product data"), encourage honesty ("if you don't have enough information, say so"), and can specify format ("keep responses under 100 words"). Here's an example for the *system* role:

```sql
DECLARE @systemMessage NVARCHAR(MAX) = 
'You are an Adventure Works product expert. Follow these rules:
1. Answer only using the product information provided
2. Do not invent features or specifications
3. If information is missing, tell the customer you''ll need to check
4. Keep responses under 100 words
5. Suggest related products when relevant';
```

These instructions help the model stay focused and provide useful, accurate answers.

## Control model behavior

The request payload includes a couple of parameters that affect how the model generates responses:

- `max_tokens` limits response length. For detailed product answers, 500 to 1,000 works well.
- `temperature` controls creativity on a scale from 0 to 2. Lower values (0.3 to 0.5) produce more consistent, factual responses. Higher values let the model get more creative, which you usually don't want for RAG.

Controlling the tokens and temperature helps ensure the model behaves predictably when grounded in your data.

## Construct the complete payload

Here's how you might build a RAG prompt for a product question using Adventure Works tables:

```sql
DECLARE @userQuestion NVARCHAR(1000) = 'Which pedals are compatible with the Mountain-500?';
DECLARE @questionVector VECTOR(1536);
DECLARE @context NVARCHAR(MAX);
DECLARE @payload NVARCHAR(MAX);

-- Generate embedding for the question
SELECT @questionVector = AI_GENERATE_EMBEDDINGS(@userQuestion USE MODEL my_embedding_model);

-- Get product context using vector search
SET @context = (
    SELECT TOP 3
        p.Name AS ProductName,
        p.Color,
        p.Size,
        pc.Name AS Category,
        pm.Name AS Model
    FROM Production.Product p
    INNER JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    INNER JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
    INNER JOIN Production.ProductModel pm ON p.ProductModelID = pm.ProductModelID
    ORDER BY VECTOR_DISTANCE('cosine', p.DescriptionVector, @questionVector)
    FOR JSON PATH
);

-- Build the prompt
SET @payload = JSON_OBJECT(
    'messages': JSON_ARRAY(
        JSON_OBJECT(
            'role': 'system', 
            'content': 'You are an Adventure Works product assistant. Use only the provided product data to answer questions.'
        ),
        JSON_OBJECT(
            'role': 'user', 
            'content': 'Product data: ' + @context + CHAR(10) + 'Question: ' + @userQuestion
        )
    ),
    'max_tokens': 500,
    'temperature': 0.5
);
```

The `@payload` variable now contains everything the model needs: your grounding instructions, the retrieved product data, and the customer's question. All you need to do is send it to the model endpoint and handle the response.

## Key takeaways

The prompt is where retrieval becomes useful. Your JSON context means nothing unless you tell the model how to use it. Set clear grounding rules in the system message so the model sticks to your data. Keep temperature low for factual answers. Use `JSON_OBJECT` and `JSON_ARRAY` to build valid JSON payloads directly in T-SQL.
