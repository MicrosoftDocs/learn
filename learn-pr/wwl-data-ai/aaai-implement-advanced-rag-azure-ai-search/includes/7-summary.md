Production-grade RAG pipelines require more sophistication than basic vector search to deliver reliable clinical decision support. In this module, you implemented the architectural patterns that make RAG work at scale for specialized domains like healthcare.

Hybrid search combined BM25 keyword matching with vector similarity to handle both exact clinical terminology and semantic concept matching. This dual approach ensured that queries for specific drug names, diagnostic codes, or test values retrieved documents containing those exact terms, while queries about symptoms or treatment approaches found semantically similar content even when different vocabulary was used.

Multi-stage reranking refined initial search results through progressively more powerful but slower models. Semantic ranking in Azure AI Search improved upon hybrid search scores using language understanding. Cross-encoder models specialized for medical content captured domain-specific relevance signals. LLM-as-reranker provided the highest accuracy for final document selection when cost and latency constraints allowed this expensive approach.

Dynamic knowledge source routing directed queries to relevant indexes based on clinical intent, avoiding wasted searches across irrelevant knowledge bases. Classification models determined whether queries needed medication information, clinical protocols, laboratory references, or multiple sources. Confidence-based fallbacks prevented misclassification from excluding relevant knowledge while still optimizing resource usage.

Chunking and embedding optimization matched content preparation to clinical document structure and query patterns. Structural chunking preserved semantic boundaries in formatted documents like guidelines and formularies. Hierarchical parent-child relationships provided both precise information and complete context. Domain-specific embedding models captured clinical terminology relationships better than general-purpose models when evaluation justified the implementation complexity.

Together, these techniques transformed basic retrieval into a production system capable of finding the right clinical knowledge reliably. The hybrid architectures, multi-stage refinement, intelligent routing, and optimized content representation work together to support accurate clinical decision-making.

## Key design decisions you face

When you implement production RAG pipelines, these are the trade-offs that shape your architecture:

- **Hybrid vs. pure vector search.** Use hybrid when your domain has exact-match terminology (drug names, diagnostic codes, lab values) that vector search alone misses. Use pure vector only when all queries are conceptual and exact terms don't matter—rare in specialized domains.
- **How many reranking stages.** Semantic ranking in Azure AI Search adds minimal latency and should be enabled by default. Cross-encoder reranking adds 50-200ms but significantly improves relevance for domain-specific content—justify with offline evaluation showing ≥5 percentage points of nDCG improvement. LLM-as-reranker is reserved for the final 3-5 candidates when accuracy justifies the cost.
- **Single-index vs. multi-index with routing.** Start with a single index if your knowledge comes from one source type. Move to multi-index routing when different query types need different search configurations (for example, formulary queries need exact BM25 weight while guideline queries need stronger semantic weight). The routing classifier adds complexity but prevents one index's configuration from compromising another's recall.
- **General-purpose vs. domain-specific embeddings.** Start with `text-embedding-3-large`—it works well for most content. Invest in domain-specific embeddings (PubMedBERT, BioBERT) only when evaluation shows measurable precision improvement on your actual query workload.
- **Structural vs. semantic chunking.** Use structural chunking for formatted documents with clear section boundaries (formularies, guidelines, protocols). Use semantic chunking for unstructured narratives (physician notes, case summaries) where topic boundaries aren't marked by formatting. Hierarchical parent-child chunking works well when you need both precise retrieval and complete context.

## Learn more

- [Azure AI Search](https://learn.microsoft.com/azure/search/)
