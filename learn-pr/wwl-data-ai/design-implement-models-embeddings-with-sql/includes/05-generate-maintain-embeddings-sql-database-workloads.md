After you design how embeddings represent your data, you need to generate them and keep them in sync as data changes.

SQL Server provides built-in AI functions to generate embeddings from text stored in database columns. Generating embeddings is typically not a one-time operation. When source data changes, embeddings may need to be regenerated so they continue to reflect the current state of the data.

## Generate embeddings with SQL

SQL Server provides the `AI_GENERATE_EMBEDDINGS` function to generate embeddings directly from text stored in database columns. This function uses an external model to convert text into a vector that can be stored and later compared.

A common pattern is to generate embeddings during an initial load or as part of a batch process. The resulting vectors are stored alongside the source data or in a related table so they can be queried efficiently.

The following example shows a simple end-to-end pattern, from table definition to embedding generation.

First, create a table that stores both the source text and it's embedding.

```sql
CREATE TABLE dbo.documents
(
    id INT PRIMARY KEY,
    description NVARCHAR(MAX),
    embedding VECTOR(1536)
);
```

Next, generate embeddings from the text and store them in the table.

```sql
UPDATE dbo.documents
SET embedding = AI_GENERATE_EMBEDDINGS(description USE MODEL my_embedding_model);
```

In this example, each row’s `description` value is sent to the embedding model. The function returns a vector, which is stored in the `embedding` column. These stored vectors can later be queried or compared without regenerating them. You might want to include extra logic to handle chunking or filtering based on your embedding design.

Embedding generation determines how vectors are created. Maintenance strategies determine when those vectors need to be refreshed.

## Understand embedding maintenance

Embedding maintenance keeps stored embeddings aligned with changes to the underlying data. When text values are inserted, updated, or deleted, the corresponding embeddings may no longer reflect the current content.

Different maintenance approaches can be used depending on how often data changes, how quickly embeddings must be updated, and where embedding generation runs.

### Choose an embedding maintenance method

Embeddings need to stay aligned with the source text as data changes. Several options can be used to detect changes and decide when embeddings should be regenerated. These options differ in where the work happens and how quickly changes are reflected.

- **Table triggers**  
  Triggers run automatically when rows are inserted or updated. For embedding maintenance, a trigger can mark rows that need new embeddings or initiate regeneration immediately. This approach reflects changes quickly but adds work to write operations.

- **Change Tracking**  
  Change Tracking records that a row changed since a given point in time. A background process can use this information to identify which rows need their embeddings refreshed and process them in batches. This approach balances latency and performance.

- **Change Data Capture (CDC)**  
  CDC records detailed information about data changes, including before and after values. Embedding maintenance can use CDC tables to identify which text values changed and regenerate embeddings asynchronously. This approach is suitable for high-volume workloads.

- **Azure Functions with SQL trigger binding**  
  Azure Functions can react to database changes using SQL trigger bindings. This feature allows embedding generation to run outside the database engine while still responding to data changes. This approach offloads work from the database and can scale independently.

- **Azure Logic Apps**  
  Logic Apps can orchestrate embedding updates as part of a workflow. For example, a Logic App might periodically check for changed rows and call an embedding service, coordinating updates with other systems. This approach is low-code and integrates well with other Azure services.

- **Change Event Streaming**  
  Change event streaming (CES) streams DML changes directly into Azure Event Hubs in near real-time. Downstream systems can consume these events and regenerate embeddings as changes occur without adding work to database transactions. This approach decouples embedding generation from the database and supports multiple consumers processing the same change stream.

- **Microsoft Foundry**  
  Microsoft Foundry can be used to manage and evaluate the models that generate embeddings. In a maintenance workflow, Foundry typically supports model selection or hosting while another process handles change detection and database updates. This approach centralizes model management while embedding generation occurs in response to data changes.

## Choose an appropriate maintenance approach

There's no single correct way to maintain embeddings. The right approach depends on factors such as data volume, update frequency, latency requirements, and where embedding generation fits within the overall solution.

Some solutions favor immediate updates, while others prioritize batching or external processing. Understanding these trade-offs helps you choose a maintenance strategy that fits your SQL application.

## Key takeaways

Generating embeddings with `AI_GENERATE_EMBEDDINGS` is only the first step. As source data changes, stored vectors can fall out of sync, so you need a maintenance strategy. Options range from triggers and Change Tracking for tightly coupled updates to Change Data Capture, Change Event Streaming, and Azure Functions for asynchronous or decoupled approaches. The right choice depends on your data volume, latency requirements, and where embedding generation fits in your overall architecture.
