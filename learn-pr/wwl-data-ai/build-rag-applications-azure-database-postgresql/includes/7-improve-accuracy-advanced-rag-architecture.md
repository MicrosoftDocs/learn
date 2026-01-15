So far, the pipeline retrieves relevant chunks and answers based on them. But accuracy can still suffer when queries are ambiguous, chunks are too large, or ranking is weak. This unit explores strategies to improve precision and recall without sacrificing speed. These techniques build on the foundation from earlier units and prepare you for more advanced RAG patterns.

## **Why Accuracy Matters**

Even when a vector search is used, wrong, or incomplete context leads to fluent but incorrect answers. Users lose trust if the assistant sounds confident but is wrong. Improving accuracy means:

- **Better chunking**: Right size and overlap for embeddings.
- **Smarter retrieval**: Combine multiple signals, not just vector similarity.
- **Context optimization**: Ensure the model sees the most relevant, diverse evidence.

## Core Strategies

There are many strategies to improve accuracy in retrieval-augmented generation (RAG) systems. Let's explore some of the core techniques.

- **Chunking and embeddings** - Start with moderate chunk sizes for embeddings, about 512 tokens, and use small overlaps of roughly 10 to 15 percent. Tune these values for your data. If you change how you chunk, recompute the embeddings so the index matches the new boundaries. Azure guidance recommends around 512 tokens per chunk with 10 to 15 percent overlap as a starting point.

- **Query rewriting** - Normalize and expand queries before embedding by fixing spelling, resolving acronyms, and adding missing context. When a question is ambiguous, apply lightweight rules or use a Large Language Model (LLM) to rewrite it into a clearer form. For example, turn "vacation policy" into "How many vacation days do employees get?"

- **Hybrid search** - Combine vector similarity with keyword or metadata filters, such as `WHERE department = 'HR'`. When you need both keyword and vector signals, merge results with a reranker like Reciprocal Rank Fusion to improve recall and ordering.

- **Metadata filtering** - Tag chunks with attributes such as department, date, or document type. Filter on these fields at query time to cut noise and speed up the search.

- **Semantic ranking** - After the initial retrieval, rerank with a cross-encoder or an LLM scoring step to tighten the ordering when similarity alone isn't enough.

Querying for relevant chunks isn't enough. Context matters as well, and these strategies help ensure the model has the right context for each query.

## Advanced Architectures

While those strategies improve accuracy, they can still struggle with complex queries or large document sets. Advanced architectures build on these foundations to unlock new capabilities. Let's explore a few key approaches.

[**GraphRAG**](https://techcommunity.microsoft.com/blog/adforpostgresql/introducing-the-graphrag-solution-for-azure-database-for-postgresql/4299871)

Build a knowledge graph from your content and retrieve along relationships, for example policy → benefits → vacation. Azure provides a *GraphRAG* framework that runs on *Azure Database for PostgreSQL*.

[**Hierarchical indexing / summarization**](/azure/developer/ai/advanced-retrieval-augmented-generation)

Use summary or higher-level indexes to narrow candidates first, then drill down to exact chunks. This method is useful for long documents at scale.

[**Agentic systems**](/azure/postgresql/flexible-server/generative-ai-agents)

Use specialized agents for query rewriting, retrieval, and answer validation. Agents plan steps, call tools such as database queries and search, and validate answers before responding.


## Practical example: Hybrid retrieval with filters

Filters help narrow down the search space before applying vector similarity. In this example, you combine vector similarity with a metadata filter. The embedding produced in SQL is cast to `vector` and you use *cosine distance (`<=>`)* to match the index operator class. Note how you filter by department before applying the vector search.

```sql
-- Retrieve HR policies similar to the query, using cosine distance
SELECT id, title, policy_text
FROM company_policies
WHERE department = 'HR'
ORDER BY embedding <=> azure_openai.create_embeddings('<embedding-deployment>', 'vacation policy')::vector
LIMIT 5;
```

> [!TIP]
> You can run separate keyword and vector queries and rerank the merged set (for example, with Reciprocal Rank Fusion) when you need both signals.

## **Key Takeaways**

Accuracy isn’t just about better models, it’s about better retrieval. Start simple, *good chunking + hybrid search* often delivers big wins. *Advanced patterns* (GraphRAG, hierarchical indexing, agentic workflows) unlock new capabilities for complex environments. It's not just about quick searches, it's about finding the right information efficiently and the methods that can help achieve that.
