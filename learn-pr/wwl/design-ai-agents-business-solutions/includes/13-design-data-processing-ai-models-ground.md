## Learning objectives

By the end of this unit, learners will be able to:

- Explain how grounding improves accuracy and trust in generative AI, and when to use RAG versus other approaches
- Design a data processing workflow (ingestion → preparation → indexing → retrieval) that balances performance, cost, and governance for production AI
- Choose chunking, embeddings, schema, and indexing strategies that maximize retrieval relevance while controlling latency and spend
- Apply Microsoft platform options for grounding (Azure AI Search, Foundry/Foundry IQ, Copilot Studio/AI Builder with Dataverse) and know when to use each

## Why data processing and grounding matter

Grounding supplies trusted, task-relevant data to the model at inference time so responses are accurate, current, and auditable. Microsoft guidance emphasizes grounding (often via Retrieval-Augmented Generation, or RAG) as a core element of building effective enterprise solutions.

The Azure Well-Architected guidance adds that data design is iterative: you refine prompts and context, test with real queries, and adjust preprocessing, embeddings, and chunking as you learn.

## The data processing pipeline for grounded AI

### Ingestion and preparation

**Scope the corpus.** Start with sources that users trust and that change at the cadence your scenarios require. Remove irrelevant or duplicative content and standardize formats.

**Normalize and enrich.** Clean text, apply consistent metadata, and (where helpful) enrich with tags or Q&A pairs to improve match quality at retrieval time.

**Respect sensitivity and residency.** Preserve data classification labels and avoid indexing personal data you don't need.

### Chunking and embeddings

**Chunking.** Choose chunk sizes that fit your model's context window and your documents' semantic boundaries. Poor chunking increases cost and reduces answer quality.

**Embeddings.** Store vector representations to enable semantic and hybrid search; prefer hybrid (vector + keyword + semantic ranker) to boost recall and relevance.

### Indexing strategy

**Externalize to a search index.** Don't query live systems for every turn. Build an index optimized for your questions and topped up on an SLO-driven freshness schedule.

**Schema & capabilities.** Mark fields as _searchable_, _filterable_, _sortable_, and _retrievable_ only when you'll use them; extra capabilities increase size and cost.

**Topology.** Use a single index for simplicity; split across indexes when audiences, compliance boundaries, or query patterns differ. Plan for side-by-side rebuilds.

### Retrieval and orchestration

**Retrieval modes.** Combine vector queries, keyword search, and semantic reranking; hybrid search generally yields the most reliable results.

**RAG orchestration.** Fetch top K passages by filter (e.g., product, region, role), then construct a grounded prompt that cites sources for traceability.

## Platform choices for grounding

### Azure Well-Architected + Azure AI Search

Use Azure AI Search as the retrieval backbone; manage ingestion, chunking, embedding, schema, and freshness with index maintenance patterns (for example, side-by-side rebuilds).

### Microsoft Foundry (RAG with your data)

The **Copilot Foundations / Foundry** modules cover how to make data searchable and build agents grounded on your own data using the Foundry portal and SDK.

### Copilot Studio & AI Builder (Dataverse grounded prompts)

For low-code scenarios, **AI Builder grounded prompts** let you generate responses based on Dataverse data and reuse prompts in Power Apps, Power Automate, and Copilot Studio. Licensing and environment prerequisites apply.

## Chart: Design decisions and tradeoffs

| **Design area** | **Preferred options (typical)** | **Why it matters** |
|---|---|---|
| **Retrieval mode** | **Hybrid** (vector + keyword + semantic rerank) | Best relevance across phrasing, synonyms, and exact terms |
| **Chunking** | **Semantic chunks** sized to model context | Improves answer quality and reduces token waste |
| **Index topology** | **Single index** unless distinct audiences/compliance | Simplifies schema and tuning; split when necessary |
| **Freshness** | **SLO-based** updates; side-by-side rebuilds | Avoid stale answers; test indexes before cutover |
| **Provenance** | **Citations** to sources | Builds trust; supports audit and review |

## Operational considerations

**Cost and performance:** Index capability flags increase storage; prefer minimum viable schema and cap top K + token budgets.

**Security and compliance:** Preserve labels and access controls from source to index; design for "right to be forgotten."

**Evaluation:** Iterate with real queries; measure answer quality, citation correctness, latency, and coverage.

## References

**Ground AI using trusted data** — _Build effective generative AI solutions in your organization_ (module). [Microsoft Learn](/training/modules/build-effective-generative-ai-solutions-organization/)

**Ground language models / RAG with your data** — _Develop a RAG-based solution with your own data using Microsoft Foundry_ (module). [Microsoft Learn](/training/modules/build-copilot-ai-studio/)

**Grounding Data Design for AI Workloads on Azure** — Azure Well-Architected Framework. [Microsoft Learn](/azure/well-architected/ai/grounding-data-design)

**Create AI Builder grounded prompts with Dataverse data** — (module). [Microsoft Learn](/training/modules/ai-builder-grounded-prompts/)

**(Community perspective, optional)** _Microsoft Foundry IQ and Agent 365: Enterprise Grounding, Governance, and Model Routing_. [Windows Forum](https://windowsforum.com/threads/microsoft-foundry-iq-and-agent-365-enterprise-grounding-governance-and-model-routing.390257/)