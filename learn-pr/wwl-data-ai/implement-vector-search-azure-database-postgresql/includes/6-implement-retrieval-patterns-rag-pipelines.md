Retrieval-augmented generation (RAG) enhances language model responses by providing relevant context from your data. The retriever component searches your knowledge base and returns documents that the LLM uses to generate accurate, grounded answers. Azure Database for PostgreSQL with pgvector serves as an effective retriever, storing your document embeddings and executing similarity queries that feed the generation step.

This unit covers designing schemas for RAG workloads, implementing chunk retrieval queries, building document ingestion pipelines, returning citation metadata, and evaluating retrieval quality.

## Understand RAG architecture and the retriever role

RAG systems follow a three-step pattern:

1. **Query embedding:** Convert the user's question into a vector using an embedding model
1. **Retrieval:** Search the vector store for documents similar to the query embedding
1. **Generation:** Pass the retrieved documents as context to an LLM, which generates a response

PostgreSQL acts as the retriever in this architecture. The quality of retrieval directly impacts generation quality. If the retriever returns irrelevant documents, the LLM lacks the context needed to answer correctly and might generate incorrect information. If the retriever misses relevant documents, the answer might be incomplete.

For a legal research assistant, effective retrieval means finding the case precedents, statutes, and contract clauses that address the attorney's question. The LLM then synthesizes these sources into a coherent answer with citations.

## Design schemas for RAG workloads

RAG applications typically work with document chunks rather than whole documents. Long documents exceed LLM context limits and might contain sections irrelevant to a specific query. Chunking splits documents into smaller, focused segments that can be retrieved independently.

### Separate documents and chunks

Use two tables: one for source documents and one for chunks with embeddings:

```sql
CREATE TABLE source_documents (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    source_url TEXT,
    document_type TEXT,
    ingested_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE document_chunks (
    id SERIAL PRIMARY KEY,
    document_id INTEGER REFERENCES source_documents(id) ON DELETE CASCADE,
    chunk_index INTEGER NOT NULL,
    content TEXT NOT NULL,
    embedding vector(1536),
    token_count INTEGER,
    start_char INTEGER,
    end_char INTEGER,
    UNIQUE (document_id, chunk_index)
);
```

This design provides several benefits:

- **Flexible retrieval:** You can retrieve individual chunks or reconstruct document sections
- **Source tracking:** Every chunk links back to its source for citations
- **Efficient storage:** Document metadata is stored once, not duplicated per chunk
- **Easy updates:** Replacing a document means deleting its chunks and reingesting

### Add metadata for filtering and context

Include metadata that helps with filtering and context reconstruction:

```sql
CREATE TABLE document_chunks (
    id SERIAL PRIMARY KEY,
    document_id INTEGER REFERENCES source_documents(id) ON DELETE CASCADE,
    chunk_index INTEGER NOT NULL,
    content TEXT NOT NULL,
    embedding vector(1536),
    token_count INTEGER,
    section_title TEXT,
    page_number INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW()
);
```

Section titles and page numbers help users verify retrieved information and help the LLM understand the context of each chunk.

### Create indexes for RAG query patterns

Vector similarity indexes (HNSW or IVFFlat) enable fast embedding lookups, as covered earlier in this module. RAG workloads also benefit from B-tree indexes that accelerate the joins and filters unique to chunk retrieval. When you retrieve chunks, you frequently join back to source documents for citation metadata and filter or order by chunk position within a document. Without these indexes, PostgreSQL scans the entire chunks table for every retrieval query.

```sql
-- B-tree index for document lookups (speeds up JOINs to source_documents)
CREATE INDEX document_chunks_document_id_idx
ON document_chunks (document_id);

-- Composite index for chunk ordering (supports context window queries)
CREATE INDEX document_chunks_doc_chunk_idx
ON document_chunks (document_id, chunk_index);
```

The composite index on `(document_id, chunk_index)` is particularly important for context-window retrieval, where you fetch adjacent chunks to provide surrounding context. Without it, PostgreSQL must scan all chunks for a document to find neighbors.

## Implement chunk retrieval for context building

RAG queries retrieve chunks that become the LLM's context. The retrieval pattern you choose affects both answer quality and token efficiency. You need to balance three competing concerns: retrieving enough relevant content, staying within token limits, and providing sufficient context for the LLM to understand each chunk.

The simplest approach retrieves the top-k most similar chunks directly. This works well when your chunks are self-contained and your questions match single chunks cleanly. However, legal documents, technical specifications, and narrative content often spread concepts across multiple paragraphs. A chunk might reference "the foregoing conditions" or "as described above" without containing the referenced text.

For these cases, context-window retrieval fetches adjacent chunks along with each match. If chunk 47 is most similar to the query, you also retrieve chunks 46 and 48. This increases token usage but reduces the risk of incomplete answers. The trade-off depends on your content structure: highly structured documents with clear section boundaries need less surrounding context than flowing narrative text.

Token limits add another constraint. LLMs have fixed context windows, and you need room for the system prompt, user question, and generated response. If you retrieve 10 chunks averaging 500 tokens each, you've consumed 5,000 tokens before the LLM writes a single word. Track cumulative token counts during retrieval to stay within budget.

The following query combines these patterns. It retrieves the most similar chunks with their neighbors, tracks cumulative tokens, and includes citation metadata:

```sql
WITH matched_chunks AS (
    -- Find the most similar chunks
    SELECT id, document_id, chunk_index, embedding <=> $1 AS distance
    FROM document_chunks
    ORDER BY embedding <=> $1
    LIMIT 3
),
context_window AS (
    -- Expand to include adjacent chunks for context
    SELECT DISTINCT dc.id, dc.document_id, dc.chunk_index, dc.content,
           dc.token_count, mc.distance
    FROM matched_chunks mc
    JOIN document_chunks dc ON dc.document_id = mc.document_id
        AND dc.chunk_index BETWEEN mc.chunk_index - 1 AND mc.chunk_index + 1
),
token_limited AS (
    -- Track cumulative tokens to respect LLM context limits
    SELECT cw.*, sd.title AS source_title, sd.source_url,
           SUM(cw.token_count) OVER (ORDER BY cw.distance, cw.chunk_index) AS cumulative_tokens
    FROM context_window cw
    JOIN source_documents sd ON cw.document_id = sd.id
)
SELECT id, content, source_title, source_url, distance
FROM token_limited
WHERE cumulative_tokens <= 3000
ORDER BY distance, chunk_index;
```

Adjust the parameters based on your use case. For a legal research assistant answering specific clause questions, you might retrieve five matches with no context window. For a customer support bot answering open-ended questions about product documentation, you might retrieve three matches with two chunks of surrounding context each.

## Handle document ingestion pipelines

New documents must be processed before they're searchable. The ingestion pipeline splits documents into chunks, generates embeddings, and stores everything in PostgreSQL.

How you split documents directly affects retrieval quality. The right chunking strategy depends on your content structure and query patterns:

- **Fixed-size chunks:** Split every N characters or tokens. This approach is simple to implement and produces predictable token counts, but it might cut sentences or paragraphs mid-thought. Use fixed-size chunking when your content lacks clear structural boundaries or when you need consistent chunk sizes for token budget planning.

- **Semantic chunks:** Split at natural boundaries like paragraphs, sections, or sentences. This preserves meaning within each chunk but produces variable sizes. Use semantic chunking for structured documents where sections represent complete thoughts, such as legal clauses, API documentation, or FAQ entries.

- **Overlapping chunks:** Include text from adjacent chunks to preserve context at boundaries. For example, a 200-character overlap between 1,000-character chunks ensures that concepts spanning chunk boundaries appear in at least one complete chunk. Use overlapping when your queries might match content near chunk boundaries.

For the legal research assistant scenario, semantic chunking at paragraph or section boundaries works well because legal text is organized into discrete clauses and arguments. Each chunk represents a complete legal concept that can stand alone in the LLM's context.

Once you've chunked your documents and generated embeddings, insert them efficiently using batch operations. The two-table design requires inserting the source document first to obtain its ID, then inserting all chunks in a single multi-row `INSERT`. This approach minimizes round trips to the database and keeps the document-to-chunk relationship intact. Most embedding APIs also accept multiple texts per request, so you can generate embeddings for an entire document's chunks in one API call before inserting.

Document updates require a decision: do you version documents or replace them? For most RAG applications, replacement is simpler. Delete the existing chunks (the `ON DELETE CASCADE` constraint handles this automatically when you delete the source document), then reingest the updated content. This approach ensures your retrieval results always reflect the current document state. If you need version history, add a `version` column to `source_documents` and keep old chunks alongside new ones, filtering by version at query time.

HNSW indexes handle deletions gracefully without rebuilding. IVFFlat indexes might accumulate fragmentation after significant changes, requiring periodic rebuilding to maintain query performance.

## Implement retrieval with citations

Citations transform RAG from a black box into a transparent research tool. When the legal research assistant quotes a contract clause, the attorney needs to verify that quote against the original document. Without citation metadata, users must trust the LLM's output blindly—a significant liability in legal, medical, or financial contexts where accuracy is critical.

Effective citations require more than just the chunk content. Your retrieval queries should return the source document title, URL or document ID, section heading, and page number when available. This metadata lets your application format citations that users can actually follow back to the source. The distance score also helps: you might display high-confidence citations prominently while flagging lower-confidence matches for user verification.

A common challenge arises when multiple chunks from the same document match a query. If chunks 12, 15, and 18 from "Employment Agreement Template" all appear in your top results, listing them as three separate citations clutters the response. Instead, group chunks by source document and present them as a single citation with multiple relevant excerpts. This approach produces cleaner output and helps users see the full context from each source.

The following query demonstrates document-grouped retrieval. It ranks chunks within each document, limits to three chunks per document to avoid overwhelming the context, and aggregates the content for cleaner citation formatting:

```sql
WITH ranked_chunks AS (
    SELECT
        dc.*,
        sd.title AS document_title,
        sd.source_url,
        dc.embedding <=> $1 AS distance,
        ROW_NUMBER() OVER (PARTITION BY dc.document_id ORDER BY dc.embedding <=> $1) AS rank_in_doc
    FROM document_chunks dc
    JOIN source_documents sd ON dc.document_id = sd.id
    WHERE dc.embedding <=> $1 < 0.5
)
SELECT
    document_id,
    document_title,
    source_url,
    array_agg(content ORDER BY chunk_index) AS chunks,
    MIN(distance) AS best_distance
FROM ranked_chunks
WHERE rank_in_doc <= 3
GROUP BY document_id, document_title, source_url
ORDER BY best_distance
LIMIT 5;
```

Your application can then format this into user-friendly citations:

> "The employer might terminate this agreement with 30 days notice."
> — *Employment Agreement Template*, Section 4.2, Page 3

## Evaluate and improve retrieval quality

Retrieval quality determines RAG effectiveness. Poor retrieval leads to poor generation, regardless of how capable your LLM is. If the retriever returns irrelevant chunks, the LLM wastes context window capacity on useless text. If the retriever misses relevant chunks, the LLM lacks the information needed to answer correctly. Measuring retrieval quality separately from generation quality helps you diagnose where your RAG pipeline needs improvement.

Three metrics capture different aspects of retrieval performance:

- **Precision:** The fraction of retrieved chunks that are actually relevant. Low precision means the LLM receives irrelevant context that might confuse it or cause it to generate incorrect information. Improve precision by tightening distance thresholds or reducing the number of retrieved chunks.

- **Recall:** The fraction of relevant chunks that are retrieved. Low recall means the LLM misses important information, leading to incomplete or incorrect answers. Improve recall by loosening distance thresholds, increasing retrieved chunk count, or adjusting index parameters like `ef_search`.

- **Mean Reciprocal Rank (MRR):** How high the first relevant result appears in the ranked list. MRR matters because LLMs weight earlier context more heavily, and users scanning citations notice top results first. Improve MRR by refining your embedding model or query preprocessing.

To measure these metrics, you need an evaluation dataset: a set of representative queries paired with human judgments about which chunks are relevant. Building this dataset requires effort upfront—someone must run sample queries and label the results—but it pays off by letting you make data-driven improvements rather than guessing. Start with 20-50 queries that represent the types of questions your users actually ask. For each query, retrieve the top 10-20 chunks and have a domain expert rate their relevance on a simple scale (irrelevant, somewhat relevant, highly relevant).

With this evaluation set in place, you can measure precision and recall at different cutoffs (precision@5, recall@10) and track how changes to your pipeline affect these metrics. Run your retrieval queries against the evaluation set, compare the results to the human judgments, and calculate the metrics. Most teams automate this into a scoring script that runs whenever they change chunking strategies, embedding models, or index parameters.

When metrics fall below target, systematically experiment with parameters that affect the precision-recall trade-off:

- **Chunk size:** Smaller chunks improve precision by returning more focused content, but might hurt recall by fragmenting relevant information across multiple chunks. Larger chunks improve recall but dilute relevance.

- **Chunk overlap:** More overlap preserves context across boundaries, helping queries that match content near chunk edges. However, overlap increases storage requirements and might return redundant content.

- **Embedding model:** Different models capture different semantic relationships. A model trained on legal text might outperform a general-purpose model for legal research. Consider domain-specific or fine-tuned models if general models underperform.

- **Index parameters:** Higher `ef_search` (HNSW) or `probes` (IVFFlat) improves recall by searching more candidates, at the cost of query latency. Start with default parameters and increase only if recall is insufficient.

- **Distance thresholds:** Tighter thresholds improve precision by excluding marginal matches. Looser thresholds improve recall by including more candidates. Use your evaluation dataset to find the threshold that balances both metrics for your use case.
