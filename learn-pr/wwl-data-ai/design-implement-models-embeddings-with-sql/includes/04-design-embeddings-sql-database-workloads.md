Embeddings represent data as vectors so that similarity between pieces of text can be compared. How you design embeddings affects relevance, performance, and cost when vectors are later generated and queried.

SQL Server provides built-in AI functions that support embedding workflows. Common vector search patterns help guide how text should be prepared before embeddings are generated.

## Understand how vectors are created

But what does the term ***vector*** mean in the context of AI integration with a SQL database? 

An AI model creates a vector, not SQL itself. The model was trained to read text and return a list of numbers that represents the meaning of that text.

When SQL sends text to an embedding model, the model returns a vector, which SQL stores for later comparison with other vectors.

For example, when the text *"lightweight hiking backpack"* is sent to an embedding model, the model might return:

`[0.12, -0.87, 0.45, 0.31, …]`

A related sentence such as *"compact backpack for day hikes"* would produce a different list of numbers that looks similar:

`[0.10, -0.85, 0.47, 0.29, …]`

Because the vectors look similar, SQL can treat the two pieces of text as related, even though the wording is different.

## Identify data to include in embeddings

Embeddings work best when they represent text that carries semantic meaning, such as descriptions, titles, or other free-form text fields.

Columns that store identifiers, numeric values, or operational metadata usually don't add semantic value and should be excluded. Limiting embeddings to meaningful text reduces token usage and improves similarity results.

Design choices at this stage determine what information embeddings capture and how well they represent the underlying data.

## Control input size and structure

Embedding models operate on tokenized input and impose limits on how much text can be processed in a single request. A token is a small piece of text, such as a word or part of a word, that the model processes as a unit. Long text values often require division into smaller units.

SQL Server supports this pattern through built-in AI functions that help prepare text for embedding workflows. By controlling input size, you can keep text within model limits and ensure each embedding represents a clear, focused piece of content.

Well structured input also helps avoid embedding unrelated ideas together, which can reduce the quality of similarity results.

## Design chunking strategies

Chunking defines how larger text values are divided into smaller segments. A chunking strategy balances context and precision.

Chunks that are too large may exceed token limits or dilute semantic focus. Chunks that are too small may lose important context. The goal is to preserve meaning while keeping chunks efficient to process.

In practice, chunking is defined by the rules you apply when splitting text in SQL. These rules typically control how much text goes into each chunk, such as a maximum number of characters, and where splits are allowed to occur.

```sql
AI_GENERATE_CHUNKS(SOURCE = description, CHUNK_TYPE = FIXED, CHUNK_SIZE = 500)
```

By defining chunking rules directly in SQL, near the source tables, you can change chunk size or splitting behavior by adjusting the query instead of modifying application code.


## Apply embedding design with SQL

The following example shows a conceptual pattern that prepares text for embedding generation by splitting it into smaller units.

```sql
SELECT
    id,
    c.chunk
FROM dbo.documents
CROSS APPLY
    AI_GENERATE_CHUNKS(SOURCE = description, CHUNK_TYPE = FIXED, CHUNK_SIZE = 500) AS c;
```

In this example, the text in the `description` column is divided into chunks of up to 500 characters. Each chunk can later be passed to an embedding function, ensuring embeddings represent focused portions of the original content.

For example, if a row contains the following text in the `description` column:

`"Lightweight backpack designed for long day hikes in warm weather."`

The chunking function might produce multiple chunks such as:

- `"Lightweight backpack designed for long day hikes"`
- `"in warm weather."`

Each chunk is returned as a separate row by the query. These smaller pieces can then be passed individually to an embedding function so that each embedding represents a focused portion of the original text.

> [!TIP]
> One design pattern is to store vectors in a separate table from the source text data. A dedicated embeddings table makes it easier to track how much space vectors consume and to rebuild embeddings without affecting the original data.

## Key takeaways

Embedding quality depends on the decisions you make before any model runs. Choosing the right columns and chunking long text into focused segments with `AI_GENERATE_CHUNKS` determine how useful your vector search results are. Getting these design choices right early prevents costly rework when you move to embedding generation and storage.
