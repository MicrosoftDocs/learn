You set out to turn a ranked list of catalog records into an answer a shopper can act on and a support agent can check. The Contoso assistant now answers from the same container the catalog writes to, names the product behind every claim, and says so when the catalog has nothing to say.

## What you learn

- A retrieval-augmented generation (RAG) request runs retrieval, assembly, and generation, and retrieval sets the ceiling on the whole request, so an answer that comes back wrong is usually evidence that never reached the prompt.
- The retrieval unit is the design decision that shapes every answer, and what you embed and what you ground on don't have to be the same text, because similarity search wants discriminating words and an answer wants the fields it has to quote.
- Retrieve wider than you ground, narrow by authorization first and relevance second, and keep retrieved text in the user turn so evidence never carries the authority of an instruction.
- The pipeline is five replaceable stages, and the one most demonstrations omit is resolving a follow-up question into a standalone one before it reaches the embedding model.

## Learn more

- [Retrieval-augmented generation in Azure Cosmos DB](/azure/cosmos-db/gen-ai/rag)
- [Build a RAG chatbot with Azure Cosmos DB for NoSQL](/azure/cosmos-db/gen-ai/rag-chatbot)
- [Semantic Reranker in Azure Cosmos DB for NoSQL](/azure/cosmos-db/gen-ai/semantic-reranker)
- [Agentic Retrieval Toolkit for Azure Cosmos DB](/azure/cosmos-db/gen-ai/agentic-retrieval)
- [Azure Cosmos DB integrations for AI applications](/azure/cosmos-db/gen-ai/integrations)
- [RAG chunking phase](/azure/architecture/ai-ml/guide/rag/rag-chunking-phase)
- [Prompt Shields in Microsoft Foundry](/azure/foundry/openai/concepts/content-filter-prompt-shields)

## Clean up resources

If you completed the exercise and no longer need the resources, delete the resource group it created to stop all charges.
