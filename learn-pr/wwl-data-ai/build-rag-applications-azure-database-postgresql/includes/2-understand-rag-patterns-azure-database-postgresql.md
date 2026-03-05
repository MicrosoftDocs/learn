Imagine you’re building an internal assistant that answers employee questions about company policies. A large language model (LLM) can generate fluent responses. However, if it doesn’t have access to your latest company data, the LLM gives outdated or incorrect answers. **Retrieval Augmented Generation (RAG)** solves this issue by combining the reasoning power of an LLM with the accuracy of your own data.

## Why RAG matters

LLMs are trained on vast quantities of text but don’t know your organization’s data or proprietary content. To address this problem, RAG retrieves relevant information from trusted sources you provide, grounding the LLM model’s response. This approach improves accuracy, reduces AI-generated responses that might be incorrect, and ensures answers are based on facts you control.

## How the RAG pipeline works

A RAG pipeline consists of several key components that work together to provide accurate and relevant responses. Think of RAG as a sequence of steps working together:

- **Prepare and store content**: Break your documents into smaller chunks and store them for efficient search.
- **Create embeddings**: Convert your text into numeric vectors that capture meaning, making it possible to find related content even if the wording is different.
- **Retrieve relevant chunks**: When a user asks a question, the system finds the most similar chunks in your database using vector similarity search.
- **Generate an answer**: The retrieved chunks are passed usually to an application that calls the language model, which in turn crafts a natural language response from your actual data.

So, if, for example, you store your company policies in the database, the RAG pipeline can help retrieve the most relevant policy for your own company instead of generic data that an LLM by itself might provide.

## Where Azure Database for PostgreSQL fits in the RAG pipeline

*Azure Database for PostgreSQL* can handle the retrieval layer of this pipeline. *Azure Database for PostgreSQL* includes built-in support for vector embeddings and similarity search. What this means is that you can use the database's capabilities to efficiently manage and query your embeddings. *Azure Database for PostgreSQL* provides two key extensions that make this process possible:

- **`azure_ai` extension**: Calls Azure AI services, such as *Azure OpenAI*, directly from SQL to generate embeddings. It also provides **semantic operators** that can generate responses (`azure_ai.generate`), evaluate statements (`azure_ai.is_true`), extract structured values (`azure_ai.extract`), and rerank documents (`azure_ai.rank`) inside the database. These capabilities enable advanced generation and reasoning workflows without leaving the SQL environment.
- **`vector` (pgvector) extension**: Stores embeddings in the database and runs similarity searches efficiently.


So, there's no need for a separate vector database. You can keep everything together, your structured data, metadata, and embeddings—inside your PostgreSQL instance, which also simplifies governance and security.


## A simple RAG example

*Azure Database for PostgreSQL* can, for example, be used to implement a RAG pipeline for your company's internal knowledge base. An application uses *Azure Database for PostgreSQL* to query the database for relevant documents and use them as context for generating answers. You then feed that context into the language model to produce a natural language response.

For example, let’s say you have a table of the company policies called `company_policies`. You can use the `azure_ai` extension to generate embeddings for each policy and store them alongside the text on the same table. That way, when employees ask a question, that question is turned into an embedding, and you can pull up the matching policies right away. The following SQL commands illustrate how to set this up:

> [!NOTE]
> Before you can run the ***CREATE EXTENSION*** commands to enable these extensions, you must add `azure_ai` and `vector` to the *azure.extensions* *Server parameter* on the *Azure Database for PostgreSQL* server either through the Azure portal or through CLI commands.

```sql
-- Enable required extensions (to enable, only need to be run once per database)
CREATE EXTENSION IF NOT EXISTS azure_ai;
CREATE EXTENSION IF NOT EXISTS vector;

-- Configure Azure OpenAI endpoint and key (requires azure_ai_settings_manager role)
SELECT azure_ai.set_setting('azure_openai.endpoint', '<your-endpoint>');
SELECT azure_ai.set_setting('azure_openai.subscription_key', '<your-key>');

-- Create a table to store documents and embeddings
CREATE TABLE IF NOT EXISTS company_policies (
    id bigserial PRIMARY KEY,
    title text,
    policy_text text NOT NULL,
    embedding vector(1536) -- set to your model's dimension
);

-- Insert a sample row and generate its embedding in one step.
-- Obviously your table will have hundreds, thousands or millions of rows.
INSERT INTO company_policies (title, policy_text, embedding)
VALUES (
    'vacation policy',
    'Employees receive 15 vacation days per year. Unused days can roll over to the next year.',
    azure_openai.create_embeddings('<embedding-deployment-name>',
                                   'Employees receive 15 vacation days per year. Unused days can roll over to the next year.')
);

-- Run a quick test to retrieve the most similar chunk to a sample question.
-- Notice how you are converting the question into an embedding for the search,
-- then using that embedding to find the closest match in the database.
SELECT id, title, policy_text
FROM company_policies
ORDER BY embedding <-> azure_openai.create_embeddings('<embedding-deployment-name>',
                                                      'How many vacation days do employees get?')::vector
LIMIT 1;

-- This query returns the most relevant row that matches the query. 
-- The final step on a RAG is to pass 'both' the returned row(s) and the question back 
-- to your application. Your application then passes that context to the LLM
-- to generate a natural language answer.
```

In this example, the table is now ready to store policies and their embeddings. You can insert policies into the table using SQL commands, and the embeddings are generated using the Azure AI services. You cover indexing and querying these embeddings in later sections.

Regardless of the complexity of your own solutions, you use a similar approach to set up your own environment. First, you enable the required extensions, then create your tables with their respective vector columns, and then start inserting and embedding your content together. You then ask your questions whose embeddings are then compared to the table's embeddings. Finally, the rows returned from the database are used to provide context to the LLM to generate a natural language answer. These steps allow you to easily build a RAG application on top of your PostgreSQL database.

## Key takeaways

*Azure Database for PostgreSQL* can effectively implement RAG patterns by applying its builtin AI and vector search capabilities. The `azure_ai` extension enables seamless integration with Azure OpenAI and Azure AI Services for generating embeddings, creating chat completions, and using semantic operators for tasks such as text generation, information extraction, truth evaluation, and ranking—directly within SQL queries. The `vector` (pgvector) extension facilitates efficient storage and retrieval of embeddings, making it possible to perform similarity searches without the need for a separate vector database. Start small when applying these methods to new scenarios, gradually expanding the scope as you refine your approach in your own environment.
