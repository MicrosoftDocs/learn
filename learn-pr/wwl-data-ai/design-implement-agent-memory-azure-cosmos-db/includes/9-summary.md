Memory is what separates an assistant that answers questions from one that knows who's asking. You build that memory as two stores with opposite characteristics, wire a distillation step between them, and set the policies that keep the durable half accurate as it grows.

## What you learned

- Short-term conversation state and long-term memory differ in volume, scope, lifetime, and retrieval pattern, which is why they belong in separate containers with separate partition keys and separate retention.
- One item per turn, partitioned on the thread, keeps write cost flat as a conversation grows and makes recent history a single-partition query, while time to live removes the log without a cleanup job.
- Distillation turns raw turns into small, categorized, individually correctable facts, and embedding the fact's own text is what lets a later session recall it by meaning rather than by wording.
- A context window is a budget that history, retrieved knowledge, and memory share, and memory earns its small share by ranking on confidence, recency, and category rather than on vector distance alone.
- Retention runs per memory type. Contradictions are retired with a supersession pointer rather than deleted, and erasure has to cascade across every derived layer, which the partition key makes cheap or expensive.

## Learn more

- [Agent memories in Azure Cosmos DB for NoSQL](/azure/cosmos-db/gen-ai/agentic-memories)
- [Agent Memory Toolkit for Azure Cosmos DB](/azure/cosmos-db/gen-ai/agent-memory-toolkit)
- [Azure Cosmos DB context providers for the Microsoft Agent Framework](/agent-framework/integrations/by-component/context-providers/azure-cosmos)
- [Time to live in Azure Cosmos DB](/azure/cosmos-db/time-to-live)
- [Hierarchical partition keys](/azure/cosmos-db/hierarchical-partition-keys)
- [Delete items by partition key value](/azure/cosmos-db/how-to-delete-by-partition-key)
- [Prompt Shields](/azure/foundry/openai/concepts/content-filter-prompt-shields)
