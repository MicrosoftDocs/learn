By incorporating Azure OpenAI into your PostgreSQL database, you can create highly scalable AI-powered apps. This integration allows you to use the familiar SQL language and the flexibility of PostgreSQL to build intelligent solutions within your database layer. Whether natural language processing, recommendation systems, or content generation, Azure OpenAI empowers your applications.

The `azure_openai` schema installed by the `azure_ai` extension allows you to connect to and interact with an Azure OpenAI Service instance. This schema enables seamless integration with the Azure OpenAI service, allowing you to create powerful generative AI applications directly from your PostgreSQL database.

## Create embeddings

With the `azure_openai` schema, you can call the `create_embeddings()` function, which generates vector embeddings from within the database layer. These embeddings allow efficient storage, indexing, and querying of high-dimensional vectors. The function can take text input or an array of text values, depending on how many items you want to embed at once.

The function requires you to:

- specify the embedding deployment name,
- supply the input text or array of text,
- let the function return the embedding vector as `vector` or `vector[]`.

Example:

    ```sql
    SELECT azure_openai.create_embeddings(
    '{your-deployment-name}',
    'Sample text to embed'
    );
    ```

When passing multiple input values, the function returns an array of vectors:

    ```sql
    SELECT azure_openai.create_embeddings(
    '{your-deployment-name}',
    ARRAY['First text', 'Second text']
    );
    ```

The function handles batching internally based on the number of items supplied.



## Configure a connection to Azure OpenAI

Before using the `azure_openai` functions, configure the extension with your Azure OpenAI service endpoint and key. The following command represents the queries you would use to set the endpoint and key required to connect to your Azure OpenAI instance:

```sql
SELECT azure_ai.set_setting('azure_openai.endpoint', '{endpoint}');
SELECT azure_ai.set_setting('azure_openai.subscription_key', '{api-key}');
```

You can then use the `get_setting()` function to verify the settings written in the `azure_ai.settings` configuration table:

```sql
SELECT azure_ai.get_setting('azure_openai.endpoint');
SELECT azure_ai.get_setting('azure_openai.subscription_key');
```

## Enable vector support with the vector extension

The `azure_openai.create_embeddings()` function in the `azure_ai` extension allows you to generate embeddings for input text. To enable the generated vectors to be stored alongside the rest of your data in the database, you must also install the `vector` extension by following the guidance in the [enable vector support in your database](/azure/postgresql/flexible-server/how-to-use-pgvector#enable-extension) documentation.

You can install the `vector` extension using the [CREATE EXTENSION](https://www.postgresql.org/docs/current/sql-createextension.html) command.

```sql
CREATE EXTENSION IF NOT EXISTS vector;
```

### Generate and store vectors

In the AI-powered rental property recommendation application you're developing for Margie's Travel, you must add a new column to the target table using the `vector` data type to store embeddings within that table after adding vector support to the database. Vectors are enabled on the `listings` table to allow semantic search capabilities when executing queries to search for available properties. The `text-embedding-ada-002` model produces vectors with 1,536 dimensions, so you must specify `1536` as the vector size.

```sql
ALTER TABLE listings
ADD COLUMN description_vector vector(1536);
```

The `listings` table is now ready to store embeddings. Using the `azure_openai.create_embeddings()` function, you create vectors for the `description` field and insert them into the newly created `description_vector` column in the `listings` table.

```sql
UPDATE listings
SET description_vector = azure_openai.create_embeddings('{your-deployment-name}', description);
```

Each embedding is a vector of floating-point numbers, so the distance between two embeddings in the vector space is correlated with the semantic similarity between two inputs in the original format.
