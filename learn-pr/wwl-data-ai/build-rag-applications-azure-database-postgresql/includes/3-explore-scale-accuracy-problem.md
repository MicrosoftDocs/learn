
Retrieval augmented generation (RAG) depends on pulling the right passages from your data before the model answers. Two issues show up as your content grows: **scale** and **accuracy**. *Scale* is about how your data size and access patterns grow, and how fast results come back. *Accuracy* is about whether those results actually answer the question. If retrieval is slow or off target, the experience suffers regardless of the model's strength.

## Scale

In a RAG, every user question triggers a nearest neighbor search over vectors. As more rows are added and more users query the data at once, data access patterns slow down and concurrency pressure increases the delay.

Keep retrieval inside *Azure Database for PostgreSQL* and decide how results are searched and ranked in the database. Start with `pgvector` for vector similarity search. When data sets grow, use an approximate index so queries avoid comparing against every row. To improve performance, `pgvector` provides index options like `IVFFlat` or `HNSW`. For very large data sets, consider `DiskANN` through the `pg_diskann` extension, which is designed for high recall, high QPS (queries per second), and low latency at large *scale*.

## Accuracy

Fast queries don't help if they return the wrong passages. Missing relevant rows or ranking them poorly forces the model to guess.

Treat *accuracy* as a two-step concern in the database. First, generate *good candidates* with `pgvector` using a distance function that matches your embeddings and an index that balances recall and latency for your size. Second, improve ordering when needed. You can rerank results directly in SQL by using the semantic operators in the `azure_ai` extension—such as `azure_ai.rank` for LLM-based relevance ranking. 

There's also a Semantic Ranker solution accelerator for Azure Database for PostgreSQL if you want a full pipeline example built around this pattern. Both approaches are designed to run with PostgreSQL as the single data tier.


### When relationships help

Some domains benefit from modeling how things connect. A graph step can improve retrieval by using relationships and prominence signals. Graph queries are available in *Azure Database for PostgreSQL* through the *Apache AGE* extension. *GraphRAG* is a Microsoft Research approach that combines vector search with graph queries to improve retrieval *accuracy*. It extracts a knowledge graph from your data and uses that structure to supply better context to the Large Language Model.

## Measure and monitor

You need to establish a monitoring strategy that captures key metrics and provides insights into query performance.

**Create a baseline of your RAG query performance using:**

- **Query Store** - Captures query text, runtime, and wait statistics so you can see top queries and trends over time.
- **Query Performance Insight** - Visualizes Query Store data for Flexible Server to highlight long running and resource-heavy queries.
- **Azure Monitor metrics and workbooks** - Server level charts and dashboards for latency, connections, CPU, IO, and more.

These tools help you identify bottlenecks and areas for improvement in your RAG pipeline. They help you make determinations about performance (*scale*), but you need other strategies to ensure retrieval *accuracy*.

**Measuring accuracy:**

While measuring *accuracy* isn't as straightforward as measuring for *scale*, you can use some of the lessons from the [Architecture Center](/azure/architecture/ai-ml/guide/rag/rag-llm-evaluation-phase) article on the evaluation phase.

- **Log requests and metrics** - For every question, save the question text, the rows retrieved from PostgreSQL with their rank and distance, the exact context sent to the model, and the model's final answer.
- **Compute signals** - In your application code, compute three simple signals:
  - *Relevance and utilization* - Measure how much of the answer's key phrases also appear in the retrieved passages and how often those passages are quoted or echoed.
  - *Groundedness* - Check that each specific claim in the answer supports at least one retrieved row.
  - *Completeness* - Check that the main parts of the question are covered in the answer with supporting text from the retrieved rows.
- **Guide changes with scores** - Use the scores to guide changes, then rerun the same small test set:
  - If answers miss parts of the question, raise *k* or adjust *chunking*.
  - If the right rows aren't showing up, increase `IVFFlat` probes in `pgvector` or raise the `DiskANN` `l_value_is` setting so the search considers more neighbors.
  - If ordering is the issue, add a reranking pass in SQL using the *Semantic Ranking* solution for *Azure Database for PostgreSQL*.
  - When relationships matter, add a short graph step with *Apache AGE* before the final vector step.
- **Track trends over time** - Monitor to confirm that *accuracy* improved, not just speed.

As your application grows, reevaluate your application's performance and adjust your RAG pipeline as needed. It's important to monitor both retrieval speed and accuracy over time.

## Key Takeaways

For a Postgres RAG path, you keep the retrieval in the database, start with `pgvector`, and move to the appropriate index as the data set and traffic grows. Add a *Semantic Ranking* pass in SQL if ordering needs to be tighter. Bring in *GraphRAG* to add a short graph step when relationships carry meaning. Evaluate regularly and monitor in production so the system stays both fast and correct as data and usage change.