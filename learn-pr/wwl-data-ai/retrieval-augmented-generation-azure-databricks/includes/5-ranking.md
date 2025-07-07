When you perform vector search, you get document chunks ranked by similarity scores. But similarity doesn't always equal relevance - sometimes the most mathematically similar chunks aren't the most useful for answering a user's question. Ranking and reranking help you understand and improve these results.

:::image type="content" source="../media/reranker.png" alt-text="Diagram showing the reranking process: user query leads to multiple similar documents from vector search, then reranking selects the most relevant subset for the language model.":::

This diagram illustrates the complete process: A user query searches your vector database and returns multiple semantically similar document chunks. However, only some of these chunks are truly relevant to answering the user's question. A reranker evaluates all the retrieved chunks and selects the most relevant ones to send to the language model for generating the final response.

## Understanding similarity scores

Vector search ranks results using **similarity scores** that measure how mathematically similar document chunk vectors are to your query vector. These scores help determine which chunks are most likely to be relevant, but higher similarity doesn't guarantee the content will best answer the user's question.

For example, a query about "dog training methods" might return highly similar chunks about "pet care supplies" or "animal behavior theory" - these are topically related but may not contain the specific training techniques the user needs.

## When and why to rerank

**Reranking** goes beyond basic similarity to evaluate actual relevance to the user's question. Instead of just looking at vector similarity, reranking considers factors like:

- How well the content directly answers the query
- The context and intent behind the user's question  
- The practical usefulness of the information

This additional step can improve answer quality and reduce hallucinations, but it also adds processing time to your RAG pipeline.

## Implementing reranking

If the basic similarity search provided by Mosaic AI Vector Search isn't providing relevant enough results for your use case, you can implement reranking using:

- **APIs** like [Cohere](https://cohere.com/rerank) or [Jina](https://jina.ai/reranker/?azure-portal=true)
- **Open-source models** like [cross-encoders](https://www.sbert.net/docs/cross_encoder/pretrained_models.html?azure-portal=true), [FlagEmbedding](https://github.com/FlagOpen/FlagEmbedding?azure-portal=true), or [FlashRank](https://github.com/PrithivirajDamodaran/FlashRank?azure-portal=true)

Keep in mind that reranking adds complexity and processing time to your RAG pipeline. Start with Mosaic AI Vector Search's built-in similarity search and consider reranking only if you need to improve result relevance for your specific use case.