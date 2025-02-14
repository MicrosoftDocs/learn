Vector search matches user queries with semantically similar content instead of exact word matches. However, you can get multiple results from a vector search that you want to filter and rerank to refine and reorder your search results.

Imagine the following scenario:

:::image type="content" source="../media/reranker.png" alt-text="Diagram of a ranking scenario after retrieving relevant documents.":::

1. A user query comes in and is used to search your vector store for any relevant documents.
1. Multiple documents are identified as being semantically similar to the user query.
1. Only a subset of the documents are relevant. You can use a **reranker** to select the top three documents based on certain criteria.
1. The three documents are provided as context for a language model to generate a response to the user.

Reranking adjusts the initial ranking of retrieved documents to enhance the precision and relevance of search results. You can reorder documents based on the relevance scores with the goal to place the most relevant documents at the top of the list.

When you use vector search to retrieve relevant documents, the similarity between two vectors is calculated with the **cosine similarity**. The higher the metric, the more similar two vectors are.

:::image type="content" source="../media/cosine-similarity.png" alt-text="Diagram of the cosine similarity between a query and document vector.":::

Reranking goes beyond just evaluating the cosine similarity between the query and document vectors. It supports a deeper semantic understanding by considering the actual relevance of the documents to the query. A reranker can select more relevant documents and reduce hallucinations.

:::image type="content" source="../media/reranker-vectors.png" alt-text="Diagram of the reranking of multiple document vectors.":::

To use a reranker, you can use:

- **Private** APIs, like [Cohere](https://cohere.com/rerank) or [Jina](https://jina.ai/reranker/?azure-portal=true).
- **Open-source** rerankers, like [cross-encoders](https://www.sbert.net/docs/cross_encoder/pretrained_models.html?azure-portal=true), [FlagEmbedding](https://github.com/FlagOpen/FlagEmbedding?azure-portal=true), or [FlashRank](https://github.com/PrithivirajDamodaran/FlashRank?azure-portal=true).

Though rerankers can improve the accuracy of the final response of your Generative AI application, implementing rerankers adds complexity to the RAG pipeline and must be done with care.
