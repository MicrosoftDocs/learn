As your data grows, many documents or rows start to sound alike. This unit shows how to keep the full retrieval flow inside *Azure Database for PostgreSQL* while also taking relationships into account. Documents stay in tables. Relationships live in a property graph with **Apache AGE** (A Graph Extension) and are queried with **openCypher**. When the question is evaluated, you combine meaning-based matches from `pgvector` (with optional reranking) and a relationship score from the graph. Because the whole flow runs in SQL, the system is easier to operate and easier to understand.

## Graphs in Azure Database for PostgreSQL

*Apache AGE* adds graph features to *Azure Database for PostgreSQL*. You model *entities* as *nodes* and *relationships* as *edges*, with properties on both. This method lets you run graph queries alongside your regular SQL, so you can mix structured tables and graph structure in one place. It fits use cases like social networks, recommendation systems, and knowledge graphs. You get the strengths of both relational and graph models without running a second database.

## Where similarity isn't enough

Text similarity is good at "this looks like that" answers, but large sets of similar or near duplicate text can hide the best answers. Reranking improves ordering, yet it still scores passages one by one. Many questions depend on connections like citations, comembership, repeated references, and neighborhood patterns. In the company policy database example, you might have two sections about taxi reimbursement. One lives in the 2025 Travel Policy and several current rules point to it. The other is a 2023 section kept for historic purposes with no current links to it. A plain similarity search treats them the same. But when you also look at how rules connect to policies using the graph, the 2025 section rises to the top. That result is the one you return.

## GraphRAG

When similarity alone isn't enough, **GraphRAG** is a method from *Microsoft Research* that improves RAG by extracting a knowledge graph from your source data and using that structure to supply better context to the Large Language Model (LLM). It has three main steps:

1. **Graph extraction**
   In the company policy database example, use the `company_policies` table as the source. Each row becomes a `Policy` node with `policy_id`, `title`, `policy_text`, `department`, and `category` as properties. Create `Entity` nodes from values you already have (one per department and one per category). Optionally add `Entity` nodes for important terms found in `policy_text` (such as "taxi reimbursement" or "airport"). Connect them with edges:

   - `(:Policy)-[:BELONGS_TO]->(:Entity {type: 'Department', name: department})`
   - `(:Policy)-[:HAS_CATEGORY]->(:Entity {type: 'Category', name: category})`
   - `(:Policy)-[:MENTIONS]->(:Entity {type: 'Topic', name: <term>})` (optional, from text extraction)

   Store this graph in the same Postgres instance with *Apache AGE* so you can join graph results back to `company_policies` without the need for a separate graph database.

1. **Entity summarization**  
   Create short summaries for each policy and, if helpful, for small groups (for example, by category or department). The *GraphRAG* library can build multi-level summaries. Keep these summaries as node properties so they're easy to fetch during ranking and when preparing model context.

1. **Graph query generation at query time**  
   At question time, run *vector search* over `company_policies.embedding` to get an initial set of candidates by semantic similarity. In parallel, run an *openCypher* query that scores how well each candidate is connected to what the question is about. For the "taxi reimbursement from the airport" example, the graph score can reward policies that belong to the **Travel** category, sit under the **Finance** department (or another relevant one), and mention entities like **taxi reimbursement** and **airport**.

Similarity alone often ties near duplicate sections. The graph step promotes sections that both match the question and sit in the right part of the network. The final context you send to the model is smaller, clearer, and easier to justify. The full pipeline, vector search, optional semantic reranking, openCypher graph query, and RRF (Reciprocal Rank Fusion), runs inside Postgres.

## From similarity only to GraphRAG ranking

With similarity only, look-alike text can crowd out the right passage. In the taxi reimbursement example, relationship signals push items that match the question and live in the most relevant category, department, or topic to the top. The context you pass to the model is tighter and easier to defend, and you can point to exact paths and scores to explain each rank.

Use *GraphRAG* in *Azure Database for PostgreSQL* to keep data and relationships in one place, rank results by both meaning and connections, and cite the exact source for each answer. The *GraphRAG* solution accelerator shows the full pipeline. It includes vector search, semantic reranking, *openCypher* graph scoring, and rank fusion. It runs inside Postgres and is written in SQL, and it delivers clear gains over vector-only retrieval.

You can keep reranking inside the database with SQL semantic operators. The `rank()` operator from the `azure_ai` semantic operators lets you rerank top candidates with state of the art models directly in a query, so you can combine semantic ranking with graph scoring without leaving Postgres. As your data grows, pair the graph step with the right vector index. `DiskANN` in *Azure Database for PostgreSQL* supports high dimensional embeddings (up to 16,000 dimensions), faster index builds, and a Product Quantization that can reduce memory and cost while maintaining high accuracy. Reported gains include up to 10× faster performance and about 4× cost savings versus an *HNSW* (Hierarchical Navigable Small Worlds) index.

## Key Takeaways

A similarity-only search often falls short on real questions. *GraphRAG* with *Apache AGE* adds a knowledge graph so the model gets structure and meaning. You extract relationships into an *AGE* graph, keep short summaries on the nodes, and at question time run vector search and an *openCypher* query to see how the candidates connect. In *Azure Database for PostgreSQL*, this process all stays in one place. Tables hold the content, *Apache AGE* manages the graph, `pgvector` pulls likely passages, and a light rerank with simple fusion tightens the order. The result is a smaller, clearer context that points to the right sources and produces answers you can verify.
