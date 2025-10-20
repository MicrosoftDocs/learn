Retrieval Augmented Generation (RAG) is a pattern for AI applications that interact with data. Instead of relying solely on the knowledge embedded in large language models during training, RAG applications dynamically retrieve relevant information from your database and provide it as context to the AI model. This approach ensures responses are grounded in your current, accurate data while using the reasoning capabilities of language models.

[SQL Server 2025](/sql/sql-server/what-s-new-in-sql-server-2025?azure-portal=true) provides a complete platform for building RAG applications, combining vector search capabilities, native AI integration, and enterprise-grade data management. This integrated approach means you can build AI applications without managing multiple databases, synchronizing data across systems, or compromising on security and compliance.

RAG addresses the limitations of static AI models—knowledge cutoff dates, incorrect information, and lack of domain-specific information—by augmenting model responses with real-time data retrieval. For developers, this means building applications that deliver accurate, contextual, and up-to-date answers while maintaining full control over the data sources used.

## Understand the RAG pattern

The RAG pattern follows a systematic workflow that combines traditional database operations with AI capabilities.

### Explore the RAG workflow

The RAG pattern orchestrates interaction between your database, AI models, and application users. Understanding this workflow is important for building AI-powered applications that deliver accurate, contextually relevant responses. The following diagram from Microsoft's Azure OpenAI documentation illustrates how the different components of a RAG system work together:

:::image type="content" source="../media/rag.png" alt-text="Diagram illustrating the Retrieval Augmented Generation workflow showing data ingestion, development, and inference phases." lightbox="../media/rag.png" border="false":::

The diagram shows the three-phase RAG workflow: **Ingest** (uploading and embedding data into searchable indexes), **Develop** (creating applications with prompts and search intents), and **Inference** (processing user prompts through intent generation, retrieval, filtration/reranking, and response generation). 

This pattern applies to SQL Server 2025 RAG implementations, where data is stored and searched in SQL Server before being sent to language models for response generation.

A typical RAG implementation involves several key steps:

- **Data ingestion:** Store your source documents or data in SQL Server
- **Embedding generation:** Convert text into vector embeddings using AI models
- **Vector storage:** Store embeddings alongside your relational data
- **Query processing:** When a user asks a question, generate an embedding for their query
- **Similarity search:** Find the most relevant documents using vector search
- **Context assembly:** Retrieve the full content of relevant documents
- **Prompt construction:** Build a prompt that includes the user's question and relevant context
- **AI inference:** Send the prompt to a language model (like GPT-4) for response generation
- **Response delivery:** Return the AI-generated answer to the user

## Implement basic RAG with T-SQL

SQL Server 2025 enables you to build RAG applications entirely within the database using [T-SQL](/sql/t-sql/language-reference?azure-portal=true).

### Prepare your knowledge base

Start by creating a table to store documents and their embeddings:

```sql
CREATE TABLE knowledge_base (
    doc_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(200),
    content NVARCHAR(MAX),
    category NVARCHAR(100),
    created_date DATETIME2 DEFAULT GETDATE(),
    embedding VECTOR(1536)
);

-- Create a vector index for efficient similarity search
CREATE VECTOR INDEX idx_knowledge_embedding ON knowledge_base(embedding);
```

This table stores both the original content and its [vector](/sql/t-sql/data-types/vector-data-type?azure-portal=true) embedding. The vector index enables fast similarity searches when users query the knowledge base.

### Generate and store embeddings

Insert documents and generate embeddings in a single operation:

```sql
-- Insert a document with embedding generation
DECLARE @content NVARCHAR(MAX) = N'SQL Server 2025 introduces native vector support for AI applications. Developers can store high-dimensional embeddings alongside relational data and perform semantic similarity searches using the VECTOR_DISTANCE function.';

INSERT INTO knowledge_base (title, content, category, embedding)
VALUES (
    N'SQL Server 2025 Vector Support',
    @content,
    N'Product Features',
    AI_GENERATE_EMBEDDINGS(@content USE MODEL Ada2Embeddings)
);
```

This code inserts a document and automatically generates its [embedding](/azure/ai-services/openai/concepts/understand-embeddings?azure-portal=true) using the external model defined earlier. The embedding is stored in the same row as the source text, ensuring data consistency.

### Execute semantic search

Retrieve relevant documents based on a user's query:

```sql
-- User's question
DECLARE @user_query NVARCHAR(MAX) = N'How do I use vectors in SQL Server?';

-- Generate embedding for the query
DECLARE @query_embedding VECTOR(1536) = AI_GENERATE_EMBEDDINGS(@user_query USE MODEL Ada2Embeddings);

-- Find top 5 most relevant documents
SELECT TOP 5
    doc_id,
    title,
    content,
    category,
    VECTOR_DISTANCE('cosine', @query_embedding, embedding) AS relevance_score
FROM knowledge_base
ORDER BY relevance_score;
```

This query finds documents semantically similar to the user's question by comparing vector embeddings. The [`VECTOR_DISTANCE`](/sql/t-sql/functions/vector-distance-transact-sql?azure-portal=true) function calculates similarity, with lower scores indicating higher relevance.

### Construct prompts with context

Build a prompt that includes retrieved context:

```sql
DECLARE @user_query NVARCHAR(MAX) = N'How do I use vectors in SQL Server?';
DECLARE @query_embedding VECTOR(1536) = AI_GENERATE_EMBEDDINGS(@user_query USE MODEL Ada2Embeddings);

-- Retrieve relevant context
DECLARE @context NVARCHAR(MAX);

SELECT @context = STRING_AGG(
    CONCAT('Document: ', title, CHAR(10), 'Content: ', content, CHAR(10), CHAR(10)),
    ''
)
FROM (
    SELECT TOP 3
        title,
        content,
        VECTOR_DISTANCE('cosine', @query_embedding, embedding) AS score
    FROM knowledge_base
    ORDER BY score
) AS relevant_docs;

-- Construct the prompt
DECLARE @prompt NVARCHAR(MAX) = CONCAT(
    'You are a helpful assistant. Use the following context to answer the user''s question.',
    CHAR(10), CHAR(10),
    'Context:', CHAR(10),
    @context,
    CHAR(10),
    'Question: ', @user_query,
    CHAR(10),
    'Answer:'
);

SELECT @prompt AS constructed_prompt;
```

This code retrieves the top three most relevant documents, concatenates them into a context string, and builds a complete prompt that instructs the AI model to use the provided context when answering the question.

### Generate AI responses

Send the constructed prompt to a language model:

```sql
-- Build the chat completion request
DECLARE @chat_request NVARCHAR(MAX) = JSON_OBJECT(
    'messages': JSON_ARRAY(
        JSON_OBJECT('role': 'system', 'content': 'You are a helpful assistant that answers questions based on provided context.'),
        JSON_OBJECT('role': 'user', 'content': @prompt)
    ),
    'max_tokens': 500,
    'temperature': 0.7
);

DECLARE @response NVARCHAR(MAX);

-- Call GPT-4
EXEC sp_invoke_external_rest_endpoint
    @url = N'https://myopenai.openai.azure.com/openai/deployments/gpt-4/chat/completions?api-version=2024-02-15-preview',
    @method = 'POST',
    @credential = [MyAzureOpenAICredential],
    @payload = @chat_request,
    @response = @response OUTPUT;

-- Extract and display the answer
SELECT JSON_VALUE(@response, '$.result.choices[0].message.content') AS ai_answer;
```

This completes the RAG pattern by sending the prompt with context to GPT-4 and returning the generated answer. The AI model uses the retrieved context to provide accurate, data-grounded responses.

## Integrate with LangChain

[LangChain](https://python.langchain.com/) is a popular framework for building applications with large language models. SQL Server 2025 provides support for LangChain integration, enabling you to use SQL Server as a vector store in your LangChain applications.

> [!NOTE]
> LangChain integration with SQL Server vector features is in preview. Package names, APIs, and implementation details might change. Check the [LangChain documentation](https://python.langchain.com/docs/integrations/vectorstores/) for the latest information on SQL Server vector store support.

### Set up LangChain with SQL Server

Install the required packages:

```python
# Install LangChain SQL Server connector (preview)
# Package names may vary - check documentation for latest
pip install langchain-sqlserver
pip install langchain-openai
```

Configure the connection to SQL Server:

```python
from langchain_sqlserver import SQLServerVectorStore
from langchain_openai import OpenAIEmbeddings, AzureChatOpenAI
from langchain.chains import RetrievalQA

# Configure Azure OpenAI
embeddings = OpenAIEmbeddings(
    deployment="text-embedding-ada-002",
    model="text-embedding-ada-002",
    azure_endpoint="https://myopenai.openai.azure.com",
    api_key="your-api-key"
)

# Connect to SQL Server vector store
vector_store = SQLServerVectorStore(
    connection_string="Driver={ODBC Driver 18 for SQL Server};Server=myserver;Database=mydb;Trusted_Connection=yes;",
    embedding_function=embeddings,
    table_name="knowledge_base",
    vector_column_name="embedding"
)
```

This Python code establishes a connection between LangChain and your SQL Server database, enabling you to use SQL Server as the vector store for your RAG application.

### Build a RAG chain with LangChain

Create a complete question-answering system:

```python
# Initialize the language model
llm = AzureChatOpenAI(
    deployment_name="gpt-4",
    azure_endpoint="https://myopenai.openai.azure.com",
    api_key="your-api-key"
)

# Create a retrieval QA chain
qa_chain = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=vector_store.as_retriever(search_kwargs={"k": 3})
)

# Ask a question
question = "How do I use vectors in SQL Server?"
answer = qa_chain.run(question)
print(answer)
```

This creates a RAG pipeline where LangChain automatically retrieves relevant documents from SQL Server, constructs prompts, calls the language model, and returns answers—all with just a few lines of code.

## Integrate with Semantic Kernel

[Semantic Kernel](/semantic-kernel/overview/?azure-portal=true) is Microsoft's open-source SDK for integrating AI capabilities into applications. SQL Server 2025 provides support for Semantic Kernel integration, enabling you to use SQL Server as a vector store in your AI applications.

> [!NOTE]
> Semantic Kernel integration with SQL Server vector features is in preview. Package names, APIs, and implementation details might change. Check the [Semantic Kernel documentation](/semantic-kernel/concepts/vector-store-connectors/?azure-portal=true) for the latest information on SQL Server vector store support.

### Configure Semantic Kernel with SQL Server

Set up the connection in C#:

```csharp
using Microsoft.SemanticKernel;
using Microsoft.SemanticKernel.Connectors.SqlServer;
using Microsoft.SemanticKernel.Connectors.OpenAI;

// Build the kernel
var builder = Kernel.CreateBuilder();

// Add Azure OpenAI chat completion
builder.AddAzureOpenAIChatCompletion(
    deploymentName: "gpt-4",
    endpoint: "https://myopenai.openai.azure.com",
    apiKey: "your-api-key"
);

// Add SQL Server vector store (preview - API may change)
builder.AddSqlServerVectorStore(
    connectionString: "Server=myserver;Database=mydb;Trusted_Connection=True;",
    tableName: "knowledge_base",
    vectorColumnName: "embedding"
);

var kernel = builder.Build();
```

This configures Semantic Kernel to use SQL Server as the vector store and Azure OpenAI for language model inference.

### Implement RAG with Semantic Kernel

Create a RAG-powered plugin:

```csharp
using Microsoft.SemanticKernel;
using Microsoft.SemanticKernel.Memory;

public class KnowledgeBasePlugin
{
    private readonly ISemanticTextMemory _memory;
    
    public KnowledgeBasePlugin(ISemanticTextMemory memory)
    {
        _memory = memory;
    }
    
    [KernelFunction]
    [Description("Answers questions based on the knowledge base")]
    public async Task<string> AskQuestion(
        [Description("The user's question")] string question)
    {
        // Search for relevant documents
        var results = _memory.SearchAsync("knowledge_base", question, limit: 3);
        
        // Build context from retrieved documents
        var context = new StringBuilder();
        await foreach (var result in results)
        {
            context.AppendLine($"Document: {result.Metadata.Text}");
            context.AppendLine();
        }
        
        // The kernel will automatically use this context with the LLM
        return context.ToString();
    }
}
```

This plugin searches the SQL Server vector store and provides relevant context to the language model for generating responses.

## Integrate with Azure AI Search

[Azure AI Search](/azure/search/search-what-is-azure-search?azure-portal=true) provides advanced search capabilities that complement SQL Server's vector search features.

### Configure hybrid search with Azure AI Search

Hybrid search combines the strengths of both vector-based semantic search and traditional keyword-based [full-text search](/sql/relational-databases/search/full-text-search?azure-portal=true). Vector search excels at finding conceptually similar content even when exact words don't match, while full-text search captures precise terminology and domain-specific phrases. This combination is critical for RAG applications because it ensures you retrieve documents that are both semantically relevant and contain the specific terms users ask about, leading to more accurate and comprehensive AI responses.

Set up an indexer to synchronize data from SQL Server to Azure AI Search:

```sql
-- Enable Change Tracking on your table
ALTER DATABASE mydb SET CHANGE_TRACKING = ON;
ALTER TABLE knowledge_base ENABLE CHANGE_TRACKING;
```

Configure the [Azure AI Search indexer](/azure/search/search-indexer-overview?azure-portal=true) through the Azure portal or REST API to pull data from SQL Server, enabling you to use both SQL Server's transactional capabilities and Azure AI Search's advanced text analysis.

### Combine vector and full-text search

Implement a hybrid search strategy:

```sql
DECLARE @user_query NVARCHAR(MAX) = N'machine learning with SQL Server';
DECLARE @query_embedding VECTOR(1536) = AI_GENERATE_EMBEDDINGS(@user_query USE MODEL Ada2Embeddings);

-- Hybrid search combining vector similarity and full-text search
SELECT 
    kb.doc_id,
    kb.title,
    kb.content,
    VECTOR_DISTANCE('cosine', @query_embedding, kb.embedding) AS vector_score,
    fts.RANK AS text_score,
    -- Combined score (weighted average)
    (VECTOR_DISTANCE('cosine', @query_embedding, kb.embedding) * 0.5) + 
    ((1.0 - fts.RANK/1000.0) * 0.5) AS combined_score
FROM knowledge_base kb
INNER JOIN CONTAINSTABLE(knowledge_base, content, @user_query) fts
    ON kb.doc_id = fts.[KEY]
ORDER BY combined_score;
```

This query combines semantic similarity (vector search) with keyword matching ([full-text search](/sql/relational-databases/search/query-with-full-text-search?azure-portal=true)) to deliver relevant results that capture both conceptual and exact matches.

## Build production-ready RAG applications

Moving from prototype to production requires extra considerations for performance, reliability, and maintainability.

### Optimize embedding generation

Generate embeddings for multiple documents efficiently:

```sql
-- Update embeddings for documents that don't have them yet
-- Note: AI_GENERATE_EMBEDDINGS executes once per row, not as a batch operation
UPDATE knowledge_base
SET embedding = AI_GENERATE_EMBEDDINGS(content USE MODEL Ada2Embeddings)
WHERE embedding IS NULL;

-- For large-scale operations, process in smaller batches to avoid long transactions
DECLARE @batch_size INT = 100;

WHILE EXISTS (SELECT 1 FROM knowledge_base WHERE embedding IS NULL)
BEGIN
    -- Update a limited number of rows at a time
    UPDATE TOP (@batch_size) knowledge_base
    SET embedding = AI_GENERATE_EMBEDDINGS(content USE MODEL Ada2Embeddings)
    WHERE embedding IS NULL;
    
    -- Optional: Add a small delay to avoid overloading the API endpoint
    WAITFOR DELAY '00:00:01';
END;
```

This approach processes embeddings in manageable batches, reducing transaction lock times and allowing you to monitor progress for large document collections.

### Implement caching strategies

Cache frequently asked questions and their responses:

```sql
CREATE TABLE query_cache (
    cache_id INT IDENTITY(1,1) PRIMARY KEY,
    query_text NVARCHAR(500),
    query_embedding VECTOR(1536),
    response_text NVARCHAR(MAX),
    created_date DATETIME2 DEFAULT GETDATE(),
    hit_count INT DEFAULT 0,
    INDEX idx_query_embedding (query_embedding)
);

-- Check cache before executing full RAG pipeline
DECLARE @user_query NVARCHAR(MAX) = N'What are vectors?';
DECLARE @query_embedding VECTOR(1536) = AI_GENERATE_EMBEDDINGS(@user_query USE MODEL Ada2Embeddings);
DECLARE @cached_response NVARCHAR(MAX);

-- Look for similar cached queries
SELECT TOP 1 @cached_response = response_text
FROM query_cache
WHERE VECTOR_DISTANCE('cosine', @query_embedding, query_embedding) < 0.05
ORDER BY VECTOR_DISTANCE('cosine', @query_embedding, query_embedding);

IF @cached_response IS NOT NULL
BEGIN
    -- Return cached response
    SELECT @cached_response AS answer;
    
    -- Increment hit count
    UPDATE query_cache
    SET hit_count = hit_count + 1
    WHERE response_text = @cached_response;
END
ELSE
BEGIN
    -- Execute full RAG pipeline
    -- ... (RAG code here)
    
    -- Cache the new response
    INSERT INTO query_cache (query_text, query_embedding, response_text)
    VALUES (@user_query, @query_embedding, @generated_response);
END;
```

Query caching reduces costs and improves response times by reusing answers to similar questions.

### Handle chunking for large documents

Break large documents into manageable chunks:

```sql
-- Use AI_GENERATE_CHUNKS for text splitting
DECLARE @large_document NVARCHAR(MAX) = N'... very long document content ...';

-- Generate chunks with AI_GENERATE_CHUNKS
-- The function splits text into fixed-size character chunks
INSERT INTO knowledge_base (title, content, embedding)
SELECT 
    CONCAT('Document Chunk ', c.chunk_order),
    c.chunk,
    AI_GENERATE_EMBEDDINGS(c.chunk USE MODEL Ada2Embeddings)
FROM AI_GENERATE_CHUNKS(
    source = @large_document,
    chunk_type = FIXED,
    chunk_size = 512  -- Size in characters (not tokens)
) AS c;
```

Chunking ensures that retrieved context fits within token limits and improves the relevance of retrieved passages.

## Apply RAG best practices

Follow these guidelines for effective RAG implementations:

| Category | Practice | Description |
|----------|----------|-------------|
| **Design effective prompts** | Be specific | Clearly instruct the model to use only the provided context |
| | Add constraints | Specify that the model should admit when information isn't in the context |
| | Include examples | Provide few-shot examples of desired response format |
| | Set tone | Define the assistant's persona and communication style |
| **Tune retrieval parameters** | Adjust k value | Experiment with retrieving different numbers of documents (typically 3-5) |
| | Set similarity thresholds | Filter out documents below a relevance score threshold |
| | Balance precision and recall | Find the right trade-off for your use case |
| | Test with diverse queries | Ensure retrieval works across different question types |
| **Ensure data quality** | Clean source documents | Remove noise, formatting issues, and irrelevant content |
| | Update regularly | Refresh embeddings when source documents change |
| | Validate embeddings | Check that embeddings accurately represent content |
| | Monitor for drift | Track if retrieval quality degrades over time |
| **Secure RAG applications** | Control data access | Use [row-level security](/sql/relational-databases/security/row-level-security?azure-portal=true) to restrict which documents users can retrieve |
| | Audit AI operations | Log all queries and responses for compliance |
| | Sanitize inputs | Validate and clean user queries to prevent injection attacks |
| | Protect API keys | Use [managed identities](/entra/identity/managed-identities-azure-resources/overview?azure-portal=true) and secure credential storage |

By following these practices and applying SQL Server 2025's integrated AI capabilities, you can build production-ready RAG applications that deliver accurate, contextual, and secure AI-powered experiences.
