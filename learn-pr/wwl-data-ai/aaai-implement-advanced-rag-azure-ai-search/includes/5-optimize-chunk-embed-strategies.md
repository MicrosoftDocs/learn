The drug formulary documents you indexed started as 50-page PDFs covering hundreds of medications. You split them into chunks for embedding and retrieval, but the quality of those chunks determines whether your RAG pipeline can find the right information. A chunk that's too large includes irrelevant context about unrelated medications, reducing semantic match quality. A chunk that's too small loses the surrounding context needed to understand dosing instructions or contraindications. Optimal chunking depends on your content structure and the questions being asked.

| Chunking Strategy | Best For | Example Clinical Content | Trade-off |
|-------------------|----------|--------------------------|-----------|
| Fixed-size (1000 tokens) | Uniform content structure | Patient education articles | Simple but breaks semantic boundaries |
| Structural (section boundaries) | Formatted documents with headers | Clinical guidelines with numbered sections | Preserves meaning but creates variable sizes |
| Semantic (topic shift detection) | Unstructured narrative text | Clinical case discussions | High quality but computationally expensive |
| Hierarchical (parent-child) | Long documents needing context | Multi-page treatment protocols | Provides context but increases index complexity |

## Implement structural chunking for formatted clinical documents

Clinical guidelines, formulary entries, and lab documentation follow consistent formatting with section headers, numbered lists, and hierarchical structure. These structural markers indicate semantic boundaries where topics change — the "Indications" section of a drug monograph discusses different content than the "Contraindications" section. Chunking at these boundaries preserves complete semantic units.

You parse documents to identify structural markers: markdown headers (`##`), XML tags (`<section>`), or visual formatting cues in PDFs (font size changes, bold headers). Each section becomes a chunk with metadata indicating its position in the document hierarchy. A formulary entry for "Atorvastatin" might split into chunks for "Drug Names," "Mechanism of Action," "Indications," "Dosing," "Contraindications," "Adverse Effects," and "Monitoring."

This approach creates chunks of variable size — an "Adverse Effects" section might be 2000 tokens while "Mechanism of Action" is only 300 tokens. Variable sizing is acceptable because each chunk represents a complete thought rather than an arbitrary cutoff. When a query asks about atorvastatin contraindications, you retrieve the complete contraindications section rather than a fragment that cuts off mid-sentence.

Structural chunking requires preprocessing to extract document structure reliably. For PDFs, you use libraries that detect formatting changes to infer hierarchy. For markdown or HTML, you parse the markup directly. For narrative text without clear structure, structural chunking doesn't apply — you need semantic approaches instead.

```python
from azure.ai.documentintelligence import DocumentIntelligenceClient
from azure.identity import DefaultAzureCredential

# Extract structure from PDF using Document Intelligence
doc_intel_client = DocumentIntelligenceClient(
    endpoint="https://<your-doc-intel>.cognitiveservices.azure.com",
    credential=DefaultAzureCredential()
)

def extract_structural_chunks(pdf_path: str) -> list[dict]:
    """Extract chunks based on document structure using Azure Document Intelligence."""
    
    with open(pdf_path, "rb") as f:
        poller = doc_intel_client.begin_analyze_document(
            "prebuilt-layout",
            analyze_request=f,
            content_type="application/pdf"
        )
    result = poller.result()
    
    chunks = []
    current_section = None
    current_content = []
    
    # Process each paragraph, grouping by detected sections
    for paragraph in result.paragraphs:
        # Document Intelligence identifies section headers by role
        if paragraph.role == "sectionHeading":
            # Save previous section if it exists
            if current_section and current_content:
                chunks.append({
                    "section": current_section,
                    "content": "\n".join(current_content),
                    "page_numbers": list(set(p.bounding_regions[0].page_number 
                                            for p in current_content if p.bounding_regions))
                })
            
            # Start new section
            current_section = paragraph.content
            current_content = []
        else:
            # Add content to current section
            current_content.append(paragraph.content)
    
    # Don't forget last section
    if current_section and current_content:
        chunks.append({
            "section": current_section,
            "content": "\n".join(current_content),
            "page_numbers": list(set(p.bounding_regions[0].page_number 
                                    for p in current_content if p.bounding_regions))
        })
    
    return chunks
```

## Design semantic chunking for unstructured clinical narratives

Clinical case discussions, physician notes, and narrative literature reviews don't have explicit structural markers. The text flows continuously, with topic shifts indicated by semantic changes rather than formatting. Semantic chunking identifies these topic boundaries by analyzing where the content meaning shifts substantially.

You implement semantic chunking by embedding sentences individually, then identifying points where embedding similarity between adjacent sentences drops significantly. When sentences N and N+1 have low cosine similarity, a topic boundary likely exists between them. After identifying all boundaries, you group sentences between boundaries into chunks.

This approach requires more computation than structural chunking — you must generate embeddings for every sentence during preprocessing rather than only for final chunks. For large document collections, this preprocessing cost is significant but paid once during ingestion. The benefit appears at retrieval time when chunks better match query intent because they contain semantically coherent content.

Threshold tuning determines how sensitive boundary detection is to similarity drops. A threshold of 0.5 creates many small chunks (topic shifts at small similarity drops). A threshold of 0.3 creates fewer, larger chunks (topic shifts only at major similarity drops). You tune the threshold by evaluating retrieval quality with your actual query workload — the threshold that maximizes retrieval precision indicates appropriate semantic boundaries for your content.

Northwind Health's physician case notes illustrate why threshold tuning matters. A diabetes management note shifts from documenting A1C history to discussing medication tolerability to recording patient concerns about cost — three distinct clinical topics in one narrative. A similarity threshold of 0.4 correctly identifies these topic shifts, creating chunks that let the RAG pipeline retrieve the medication tolerability section specifically when the agent needs to check for past side effect patterns, rather than returning the entire multi-topic note.

## Implement hierarchical parent-child chunking

Medical treatment protocols often span multiple pages, with detailed subsections about specific scenarios. A protocol for "Management of Diabetic Ketoacidosis" might have a high-level overview followed by detailed sections on fluid resuscitation, insulin therapy, electrolyte replacement, and complication management. A query about "DKA potassium management" needs the specific potassium section but benefits from the protocol overview for context.

Hierarchical chunking creates two levels: small child chunks for precise retrieval and large parent chunks for complete context. You index both levels separately in Azure AI Search, with child documents storing a reference to their parent. When a child chunk is retrieved, you also retrieve its parent to provide the agent with both specific and contextual information.

The child chunks might be individual subsections (500-1000 tokens each) while the parent chunk is the complete protocol (5000+ tokens). You embed child chunks for semantic search but also store the parent document ID. When a child chunk matches a query, your retrieval logic fetches both the matching child and its parent, then includes both in the context provided to the agent.

This approach increases index size and complexity — you store up to 2x the content in your index (children plus parents). The benefit is retrieval quality for complex clinical queries that need both specific details and surrounding context. You measure whether this benefit justifies the cost by comparing agent answer quality with and without parent context.

```python
from azure.search.documents import SearchClient
from azure.identity import DefaultAzureCredential
from typing import List, Dict

def create_hierarchical_chunks(document: dict) -> tuple[dict, list[dict]]:
    """Create parent document and child chunks from a clinical protocol."""
    
    parent_id = document["document_id"]
    parent_doc = {
        "document_id": parent_id,
        "title": document["title"],
        "content": document["full_text"],
        "doc_type": "parent"
    }
    
    # Split into sections (structural chunking)
    sections = split_by_sections(document["full_text"])
    
    child_docs = []
    for i, section in enumerate(sections):
        child_docs.append({
            "document_id": f"{parent_id}_child_{i}",
            "parent_id": parent_id,
            "title": f"{document['title']} - {section['heading']}",
            "content": section["content"],
            "doc_type": "child"
        })
    
    return parent_doc, child_docs

def index_hierarchical_documents(documents: list[dict], search_client: SearchClient):
    """Index both parent and child documents with embeddings."""
    
    embeddings_client = get_embeddings_client()
    all_docs_to_index = []
    
    for doc in documents:
        parent, children = create_hierarchical_chunks(doc)
        
        # Embed parent (for potential direct retrieval of overview content)
        parent_embedding = embeddings_client.embed(
            input=parent["content"][:8000],  # Truncate if too long
            model="text-embedding-3-large"
        ).data[0].embedding
        parent["content_vector"] = parent_embedding
        all_docs_to_index.append(parent)
        
        # Embed each child for precise retrieval
        for child in children:
            child_embedding = embeddings_client.embed(
                input=child["content"],
                model="text-embedding-3-large"
            ).data[0].embedding
            child["content_vector"] = child_embedding
            all_docs_to_index.append(child)
    
    # Batch upload to Azure AI Search
    search_client.upload_documents(documents=all_docs_to_index)
    print(f"Indexed {len(all_docs_to_index)} documents (parents + children)")

def retrieve_with_parent_context(query: str, search_client: SearchClient) -> list[dict]:
    """Retrieve matching child chunks and their parent documents for context."""
    
    query_embedding = get_query_embedding(query)
    
    # Search for child documents only (more precise matching)
    results = search_client.search(
        search_text=query,
        vector_queries=[{
            "vector": query_embedding,
            "k_nearest_neighbors": 50,
            "fields": "content_vector"
        }],
        filter="doc_type eq 'child'",  # Only retrieve children
        query_type="semantic",
        semantic_configuration_name="clinical-semantic-config",
        select=["document_id", "parent_id", "title", "content"],
        top=5
    )
    
    enriched_results = []
    for result in results:
        # Fetch the parent document for context
        parent = search_client.get_document(key=result["parent_id"])
        
        enriched_results.append({
            "child_chunk": {
                "title": result["title"],
                "content": result["content"]
            },
            "parent_context": {
                "title": parent["title"],
                "content": parent["content"]
            }
        })
    
    return enriched_results
```

## Select embedding models for clinical content

General-purpose embedding models like `text-embedding-3-large` perform well for most content, but clinical text contains specialized terminology, abbreviations, and concept relationships that benefit from domain-specific training. BioBERT, PubMedBERT, and other biomedical language models were trained on medical literature and understand clinical relationships better than general models.

The trade-off is infrastructure complexity. Microsoft Foundry's managed embeddings use OpenAI's models, which are general-purpose. To use a specialized clinical embedding model, you deploy it through Azure Machine Learning or Azure AI Model Inference, then manage versioning, scaling, and monitoring yourself. For many applications, the general-purpose model performs well enough that the added complexity isn't justified.

You evaluate embedding model quality by measuring retrieval precision and recall against a labeled dataset of clinical queries. For each query, you know which documents are relevant. You measure what percentage of top-10 results are relevant (precision) and what percentage of all relevant documents appear in top-10 (recall). Compare these metrics between general-purpose and clinical embeddings. An improvement of 10+ percentage points in precision or recall indicates clinical embeddings provide meaningful benefit.

Clinical embeddings particularly help with abbreviations and specialized terminology. A query for "CAD" (coronary artery disease) needs to match documents discussing "coronary atherosclerosis" or "cardiac ischemia" — clinical embeddings trained on cardiology literature capture these relationships better than general models that might confuse CAD with "computer-aided design."

## Design embedding versioning and index migration strategies

When you improve your embedding model — whether upgrading from `text-embedding-3-small` to `text-embedding-3-large` or switching to a clinical model — all document embeddings become invalid. New query embeddings and old document embeddings exist in different vector spaces and don't compare meaningfully. You must re-embed and re-index all documents, a process that can take hours or days for large document collections.

Blue-green index deployment handles this migration without downtime. You create a new index with a different name, re-embed all documents using the new model, and index them in the new index. While this happens, your application continues using the old index. After verifying the new index works correctly, you update your application configuration to switch from the old index to the new one. Finally, you delete the old index.

During the transition period, you maintain both indexes and run parallel queries against both, comparing results to validate the new embedding model actually improves retrieval quality before committing to it. This A/B testing approach ensures you don't degrade retrieval quality by switching to a model that performs worse for your specific content and queries.

Embedding version metadata becomes critical for debugging. Each document in your index should store which embedding model version created its vector. When you mix documents embedded with different models, retrieval quality degrades unpredictably. Version tracking ensures you can detect and fix such inconsistencies.

You test re-embedding impact before committing to production by sampling 1000 representative documents, re-embedding them with the new model, and measuring retrieval quality changes. If the sample shows improvement, proceed with full re-indexing. If quality degrades or doesn't change significantly, the re-embedding cost isn't justified.

> [!TIP]
> **Pause and reflect:** Your clinical RAG system indexes both structured drug formulary entries and unstructured physician case notes. If you had to choose a single chunking strategy for both content types, which would you pick and what retrieval quality trade-offs would you accept? How might hierarchical parent-child chunking help you avoid that compromise?

Now that you've optimized your chunking and embedding strategies to match clinical content structure and improve retrieval precision, you're ready to integrate all these techniques in a hands-on exercise where you build an end-to-end advanced RAG pipeline for Northwind Health's clinical agents.

## Unit summary

- **Structural chunking** splits at document boundaries (headers, sections) to preserve complete semantic units — ideal for formatted clinical documents like formularies and guidelines, but creates variable-sized chunks
- **Semantic chunking** detects topic shifts via embedding similarity between adjacent sentences — best for unstructured narratives but computationally expensive during preprocessing
- **Hierarchical parent-child chunking** indexes small child chunks for precise retrieval alongside large parent chunks for context, improving answer quality for complex queries at the cost of increased index size
- **Embedding model selection** trades infrastructure complexity for domain accuracy — general-purpose models like `text-embedding-3-large` work well for most content, while clinical models (BioBERT, PubMedBERT) add 10+ points of precision for specialized terminology
- **Blue-green index deployment** handles embedding model upgrades without downtime — re-embed all documents into a new index, validate retrieval quality with parallel queries, then switch traffic
