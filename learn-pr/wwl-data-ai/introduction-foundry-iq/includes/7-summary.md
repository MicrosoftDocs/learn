
You've learned how Foundry IQ transforms AI agents from simple chatbots into knowledge-enhanced enterprise tools capable of accessing your organization's information.

## RAG solves the knowledge problem

Retrieval Augmented Generation addresses the fundamental limitations of AI agents by connecting them to real-time knowledge sources. Instead of relying only on training data, RAG-enabled agents retrieve relevant information, augment queries with factual context, and generate responses grounded in your organizational content. This provides real-time updates, source transparency, and factual grounding.

## Foundry IQ provides a shared knowledge platform

Foundry IQ eliminates the need to build custom RAG infrastructure for every agent. You create knowledge bases organized by business domain, connect data sources from SharePoint, Azure Blob Storage, OneLake, or existing Azure AI Search indexes, and any agent can access them. When you improve a knowledge base, every connected agent benefits immediately. This shared approach scales knowledge access across your organization.

## Data quality determines retrieval effectiveness

You improve retrieval through three key techniques:

- **Scoring profiles** boost specific fields or attributes to surface more relevant results
- **Semantic ranking** uses AI models to understand meaning and context beyond keywords
- **Custom analyzers** handle specialized content like HTML, product codes, or technical terminology

These techniques work together to transform basic search into intelligent retrieval tailored to your content.

## Instructions control agent behavior

Effective agent instructions specify when to retrieve (always use the knowledge base), how to cite (exact format for source attribution), and what to do when unsure (graceful fallback). Test different query types to verify consistent behavior. Monitor production usage to identify patterns and refine your configuration.

## Next steps

Start with a high-value knowledge domain where accurate, cited information provides immediate business impact. Build your first knowledge base, configure data quality settings, create an agent with clear retrieval instructions, and test systematically before deploying to users.
