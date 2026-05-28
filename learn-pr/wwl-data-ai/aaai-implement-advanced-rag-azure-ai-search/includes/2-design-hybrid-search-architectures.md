Clinical terminology is inconsistent—one clinician writes "MI" while another writes "myocardial infarction," and patients use different terms still. Azure AI Search addresses this with a hybrid search mode that runs BM25 keyword retrieval and vector similarity search together in a single query, then uses Reciprocal Rank Fusion to merge the ranked results into a unified list that handles both exact matches and semantic relationships.

Basic vector search works well for finding semantically similar content, but clinical applications reveal important gaps. When a clinician asks about "atorvastatin 40mg contraindications," pure semantic search might return documents about "cholesterol management" or "cardiovascular medication risks"—conceptually related but not the specific drug requested. When exact terminology matters for patient safety, you need more than semantic similarity.

| Search Approach | Strength | Clinical Limitation |
|----------------|----------|---------------------|
| Vector search only | Finds semantically related concepts | Misses exact drug names, NDC codes, specific dosages |
| Keyword search only | Matches exact terms precisely | Fails on synonyms ("MI" vs "myocardial infarction") |
| Hybrid search | Combines both strengths | Requires tuning for optimal balance |

## Understand BM25 keyword search for exact clinical terminology

Azure AI Search uses the BM25 algorithm for traditional keyword search, also called lexical search. BM25 scores documents based on term frequency (how often search terms appear) and inverse document frequency (how rare those terms are across all documents). This approach excels at finding exact matches for clinical identifiers that don't vary semantically.

For drug formulary searches, BM25 reliably matches brand names like "Lipitor," generic names like "atorvastatin," and National Drug Codes (NDC) like "00071-0156-23." These terms have precise spellings that clinicians expect to find exactly as written. A patient allergic to "penicillin" needs records that match that specific term, not documents that discuss "antibiotics" generally.

The limitation appears when clinicians use different terms for the same concept. BM25 treats "heart attack," "myocardial infarction," and "MI" as unrelated terms. A search for "cardiac arrest" won't find guidelines that only mention "sudden cardiac death." This vocabulary mismatch problem becomes critical when different specialists use different terminology for the same condition.

## Understand vector search for semantic clinical concepts

Vector search converts both documents and queries into high-dimensional embeddings—numerical representations that capture meaning rather than exact words. Documents with similar meanings cluster together in vector space, even when they use completely different words. This approach finds documents about "heart attack" when you search for "myocardial infarction" because the concepts are semantically similar.

For clinical guidelines that describe symptoms, treatments, and outcomes in varied language, vector search performs better than keyword matching. A search for "shortness of breath" retrieves documents mentioning "dyspnea," "respiratory distress," or "difficulty breathing" without requiring you to list every synonym. The embedding model learns that these phrases describe related clinical presentations.

Vector search struggles with terms that lack semantic relationships in the training data. Rare drug names, manufacturer-specific codes, and numerical identifiers don't cluster meaningfully because they're arbitrary labels rather than descriptive concepts. A query for "CYP2D6" (a metabolic enzyme) might not retrieve relevant drug interaction warnings if the embedding model wasn't trained on pharmacogenomics literature.

## Combine BM25 and vector search with hybrid architecture

Azure AI Search's hybrid search runs both BM25 keyword queries and vector queries simultaneously, then merges their results using Reciprocal Rank Fusion (RRF). RRF combines ranked lists by scoring each document based on its position in each ranking—a document ranked #1 in both lists scores higher than a document ranked #1 in one list and #50 in another.

The RRF algorithm handles cases where keyword search and vector search disagree about relevance. When you search for "atorvastatin side effects," keyword search ranks documents containing those exact terms highest, while vector search considers documents about "statin adverse reactions" or "lipid-lowering medication risks." RRF merges these perspectives, surfacing documents that either match exactly or are semantically similar.

You configure hybrid search in Azure AI Search by enabling semantic ranking and including both a text query and a vector query in your search request:

```python
from azure.search.documents import SearchClient
from azure.search.documents.models import VectorizedQuery
from azure.ai.inference import EmbeddingsClient
from azure.identity import DefaultAzureCredential
import os

# Create search client directly using the endpoint from environment
search_client = SearchClient(
    endpoint=os.environ["AZURE_SEARCH_ENDPOINT"],
    index_name="clinical-guidelines-index",
    credential=DefaultAzureCredential()
)

# Create embeddings client
embed_client = EmbeddingsClient(
    endpoint=os.environ["AZURE_AI_SERVICES_ENDPOINT"],
    credential=DefaultAzureCredential(),
)

# Get embeddings for vector query
query_embedding = embed_client.embed(
    input=["atorvastatin contraindications"],
    model=os.environ["EMBEDDING_MODEL_DEPLOYMENT_NAME"]
).data[0].embedding

# Execute hybrid search with both keyword and vector queries
results = search_client.search(
    search_text="atorvastatin contraindications",  # BM25 keyword query
    vector_queries=[
        VectorizedQuery(
            vector=query_embedding,
            k_nearest_neighbors=50,
            fields="content_vector"
        )
    ],
    query_type="semantic",  # Enable semantic ranking
    semantic_configuration_name="clinical-semantic-config",
    select=["document_id", "title", "content", "source"],
    top=10
)

for result in results:
    print(f"Score: {result['@search.score']}, Title: {result['title']}")
```

## Tune hybrid search weights for knowledge source characteristics

Different knowledge sources benefit from different keyword-to-vector weight ratios. Drug formularies contain precise terminology where exact matches indicate high relevance—a 0.7 keyword / 0.3 vector split prioritizes exact drug name matches while still considering semantically similar medications. Clinical guidelines use more varied language to describe the same conditions—a 0.3 keyword / 0.7 vector split emphasizes semantic understanding over exact phrase matching.

You tune these weights by running evaluation queries against labeled test sets. For each knowledge source, create 50-100 queries with known relevant documents, then test different weight configurations. Measure precision at position 5 (P@5)—what percentage of the top 5 results are truly relevant. The weight configuration that maximizes P@5 for your specific content becomes your production setting.

Azure AI Search exposes a `weight` parameter directly on `VectorizedQuery` objects to control the relative influence of vector search in the RRF merge. The default weight is `1.0`. Setting `weight=0.7` on the vector query reduces its contribution to RRF scoring relative to BM25, effectively shifting influence toward exact keyword matching. Setting `weight=1.5` or higher increases vector search influence. For a drug formulary index, configure the vector query with `weight=0.3` to prioritize BM25 exact-match results; for a clinical guidelines index, use `weight=0.7` to favor semantic similarity. The `k_nearest_neighbors` parameter controls how many vector candidates enter the RRF pool—it determines recall breadth, not the relative ranking weight between keyword and vector results.

## Design index schemas for optimal hybrid recall

For hybrid search to work effectively, your Azure AI Search index must support both keyword matching and vector similarity. Each document field you want to search needs appropriate configuration: `searchable: true` for keyword search and a corresponding vector field for semantic search.

Consider a drug formulary document with fields for drug name, active ingredients, indications, contraindications, and dosing. You make the text fields searchable for keyword matching and create vector embeddings of the concatenated content for semantic search. This dual representation ensures both search approaches have the data they need.

Fields containing structured identifiers like NDC codes or ICD-10 diagnosis codes should be marked as `searchable` for keyword matching but might not need vector embeddings—these codes don't have meaningful semantic relationships. Fields with clinical narratives like "patient counseling information" or "mechanism of action" benefit from both searchable text and vector embeddings because they contain rich conceptual content.

Composite field strategies improve retrieval quality by creating specialized embeddings for different content types. Rather than embedding an entire formulary document as one vector, create separate embeddings for the "indications" section, the "contraindications" section, and the "dosing" section. This granularity lets vector search find the specific section relevant to a query rather than matching on the overall document similarity.

Hybrid search gives you a strong candidate list, but the initial ranking is still approximate. The next unit covers re-ranking—progressively more accurate scoring that identifies which of those candidates actually answer the clinical question.

## Key takeaways

- **BM25 keyword search** excels at matching exact clinical identifiers (drug names, NDC codes, ICD-10 codes) but fails on vocabulary mismatches where different terms describe the same clinical concept
- **Vector search** captures semantic similarity across different terminology (dyspnea ↔ shortness of breath) but struggles with rare terms and arbitrary identifiers that lack meaningful embeddings
- **Hybrid search with RRF** runs both keyword and vector queries simultaneously, merging results via Reciprocal Rank Fusion to surface documents that match either exactly or semantically
- **Weight tuning** per knowledge source optimizes the keyword-to-vector balance—drug formularies favor keyword matching (0.7/0.3) while clinical guidelines favor semantic understanding (0.3/0.7)
- **Index schema design** requires dual representation—`searchable` text fields for keyword matching plus vector fields for semantic search, with composite field strategies creating separate embeddings per document section
