By incorporating Azure OpenAI into your PostgreSQL database, you can create highly scalable AI-powered apps. This integration allows you to use the familiar SQL language and the flexibility of PostgreSQL to build intelligent solutions within your database layer. Whether natural language processing, recommendation systems, or content generation, Azure OpenAI empowers your applications.

The `azure_openai` schema installed by the `azure_ai` extension allows you to connect to and interact with an Azure OpenAI Service instance. This schema enables seamless integration with the Azure OpenAI service, allowing you to create powerful generative AI applications directly from your PostgreSQL database.

## Create embeddings

With the `azure_openai` schema, you can call the `create_embeddings()` function, which generates vector embeddings from within the database layer. These embeddings allow efficient storage, indexing, and querying of high-dimensional vectors. The function can take on two forms:

- `azure_openai.create_embeddings(text,text,integer,boolean,integer,integer)`
- `azure_openai.create_embeddings(text,text[],integer,integer,boolean,integer,integer)`

The following table describes the arguments expected by the function:

| Argument | Type | Default | Description |
| -------- | ---- | ------- | ----------- |
| deployment_name | `text` || Name of the embedding model deployment in Azure OpenAI studio. This name typically refers to a deployment of the `text-embeddings-ada-002` model. |
| input | `text` or `text[]` || Input text (or array of input text) for which vector embeddings are created. |
| batch_size | `integer` | `100` | Only applies when the `input` argument is an array of `text` values. `batch_size` specifies the number of records from the array to process simultaneously. |
| timeout_ms | `integer` | `NULL::integer` | Timeout in milliseconds after which the operation is stopped. |
| throw_on_error | `boolean` | `true` | Flag indicating whether the function should, on error, throw an exception, resulting in a rollback of the wrapping transactions. |
| max_attempts | `integer` | `1` | Number of times to retry the call to Azure OpenAI service in the event of a failure. |
| retry_delay_ms | `integer` | `1000` | Amount of time, in milliseconds, to wait before attempting to retry calling the Azure OpenAI service endpoint. |

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
