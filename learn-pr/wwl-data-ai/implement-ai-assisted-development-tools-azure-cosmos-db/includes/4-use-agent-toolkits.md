Connecting an assistant to the catalog helps the Contoso developer inspect data. The application still needs to remember shopper preferences and answer questions that span several products. In this unit, you use the public-preview Agent Memory Toolkit and the Agentic Retrieval reference implementation to address those needs and identify what each integration requires.

Both implementations are Python-based. Agent Memory Toolkit is an installable public-preview SDK. Agentic Retrieval is a product-owned reference implementation that you clone and adapt rather than install as a versioned SDK. The code that follows runs against an Azure Cosmos DB for NoSQL account and a Microsoft Foundry deployment providing a chat model and an embedding model.

## Install the toolkit and provision resources

The memory toolkit ships as a package:

```bash
pip install azure-cosmos-agent-memory==0.3.0b2
```

It needs an Azure Cosmos DB account and a Foundry resource with chat and embedding deployments. The examples use `gpt-5.4-mini` with `text-embedding-3-small`. Provision the resources and assign the roles required for keyless access before connecting.

Use a Foundry region where your subscription has quota for both models. Confirm the container policies and model deployment names before connecting. The toolkit's repository template can use different defaults from these examples.

## Use the memory toolkit in an application

The client takes the model endpoint, the deployment names, and a credential. Setting `use_default_credential=True` authenticates with Microsoft Entra ID rather than keys, which matches how the rest of your application should reach the account. This example assumes the database and the five toolkit containers already exist with their required policies. Provision this topology through the management plane before connecting.

```python
import os
from azure.cosmos.agent_memory import CosmosMemoryClient

memory = CosmosMemoryClient(
    cosmos_database="ai_memory",
    cosmos_container="memories",
    ai_foundry_endpoint=os.environ["AI_FOUNDRY_ENDPOINT"],
    embedding_deployment_name="text-embedding-3-small",
    embedding_dimensions=1536,
    chat_deployment_name="gpt-5.4-mini",
    use_default_credential=True,
)

memory.connect_cosmos(endpoint=os.environ["COSMOS_DB_ENDPOINT"])
```

Set `AI_FOUNDRY_ENDPOINT` to the Azure OpenAI endpoint for your Foundry resource, without appending `/openai/v1/`. The toolkit constructs its own client. The deployment names in the code must match your model deployments.

`create_memory_store` attempts to create the database and containers with vector and full-text policies. The constructor calls it automatically when you pass `cosmos_endpoint`. Microsoft Entra ID can't authorize these data-plane creation requests for databases or containers. A control-plane role doesn't change that restriction. Create the resources through Azure Resource Manager, the Azure CLI, or the Azure portal first. Then connect without creating resources by constructing the client without `cosmos_endpoint` and calling `connect_cosmos` as shown.

Writing a turn is one call per message. The toolkit stores the raw text, and embeds the turn itself only if you opt in with `enable_turn_embeddings`, because what retrieval searches is the memory derived from turns rather than the turns themselves:

```python
thread_id = "thread-001"

memory.upsert_memory(
    user_id="shopper-4471",
    thread_id=thread_id,
    role="user",
    content="I ride a road bike and I only want components that fit a carbon frame.",
)
```

Raw turns alone recall poorly, because a conversation buries its useful content in filler. The processing pipeline extracts that content, summarizes the thread, and updates a profile that spans every thread for the user:

```python
memory.process_now(user_id="shopper-4471", thread_id=thread_id)
```

Retrieval searches the extracted facts, filtered to the user, and returns the type alongside the content. Episodic records join the results only when you pass `include_episodes=True`:

```python
hits = memory.search_cosmos(
    search_terms="frame material preference",
    user_id="shopper-4471",
    top_k=5,
    min_confidence=0.7,
)

for hit in hits:
    print(hit.get("type"), "-", hit["content"])

print(memory.get_user_summary(user_id="shopper-4471"))
```

That search is hybrid by default. It combines vector similarity with full-text scoring and fuses the two rankings, which is the unified-store property from the previous unit doing the work: one query over one container, no second system to synchronize.

The example shows the integration boundary: your application supplies messages and user identifiers, and the toolkit handles processing and search. The `min_confidence` argument filters weaker results, but you still evaluate whether recalled content is appropriate for the response. Choosing the memory types, container layout, processing schedule, and retention policies is a separate memory-design task.

For those design decisions, see [Design multi-agent memory architectures with Azure Cosmos DB](xref:learn.wwl.design-multi-agent-memory-azure-cosmos-db).

## Attach memory to an agent framework

Microsoft Agent Framework provides a prerelease integration package that wraps Agent Memory Toolkit in a `CosmosMemoryContextProvider`. Install it by explicitly allowing prerelease packages:

```bash
pip install agent-framework-azure-cosmos-memory --pre
```

Add the provider to an agent’s `context_providers` list. Its `before_run` hook retrieves relevant memory and injects it into the agent context. Its `after_run` hook stores the new conversation turns so the Agent Memory Toolkit processing pipeline can derive more memories.

The provider reuses the toolkit’s storage, processing, and search behavior rather than introducing a separate memory store. Use it when the application already uses Microsoft Agent Framework. Call Agent Memory Toolkit directly when the application manages its own conversation flow.

Both the provider and Agent Memory Toolkit are prerelease dependencies. Validate their APIs and behavior against the versions selected by the application before adopting them for production.

## Add multi-step retrieval

Agentic Retrieval is a reference implementation rather than a package. You clone the repository, install its requirements, and adapt it, which is the point: it's an architecture to learn from and modify, not a dependency to pin.

Configuration lives in a `config.yaml` copied from the supplied example. It names the model endpoints and, under `cosmos.sources`, one entry per corpus. Each source maps to a container and carries its own partition key path, embedding field, the text fields to embed, retrieval depths for vector and full-text search, and the indexing and full-text policies to apply.

Two scripts do the work. Ingestion reads the configured sources, generates embeddings, and upserts documents into containers with vector and full-text indexing enabled:

```bash
python cosmos_db_upload.py --config config.yaml
```

Retrieval answers questions from a JSON file and writes its output under `out/`. In decomposed mode, that output includes per-question traces alongside a grouped answer file:

```bash
python dynamic_retriever.py \
    --mode decomposed \
    --config config.yaml \
    --questions-path data/questions-answers.json
```

The `--mode` flag selects the retrieval paradigm. The preceding command explicitly selects `decomposed`, which performs initial retrieval, drafts a preliminary answer, identifies missing or weakly supported information, generates focused subquestions, retrieves more evidence, and synthesizes a final answer. If `--mode` isn’t supplied, the current default is `tool-use`, in which the model drives an agentic function-calling loop.

Two retrieval controls are worth understanding, because they're the ones you tune. Diversity selection uses a greedy log-determinant method to pick a varied subset of retrieved chunks rather than the highest-scoring near-duplicates, controlled by `--k-diverse`. It applies to decomposed mode only, and it ships disabled, so it's something you opt into. A semantic reranker reorders results by relevance before synthesis, works in either mode, and is enabled through the `ranker` settings when a reranker resource is available.

Both toolkits reach Azure Cosmos DB with Microsoft Entra ID. The memory toolkit defaults to it. The retrieval toolkit documents it as the default but ships an example configuration with `use_rbac_auth: false`, so set that value yourself. Because the retrieval toolkit writes during ingestion, its identity needs **Cosmos DB Built-in Data Contributor** rather than the reader role a Model Context Protocol server uses. If you also let its ingestion script create the database and containers, or enable the account's vector and full-text search capabilities, that work goes through Azure Resource Manager, so the identity needs an Azure RBAC role such as Cosmos DB Operator as well.
