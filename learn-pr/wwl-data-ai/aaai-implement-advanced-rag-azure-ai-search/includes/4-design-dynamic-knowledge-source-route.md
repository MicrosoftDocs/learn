Not every clinical query needs to search every knowledge base. Azure AI Search supports separate indexes for different content types, and querying only the relevant ones reduces both computational cost and result noise. Intent-based routing automates this decision by classifying what the query is seeking before any search runs.

Northwind Health maintains three specialized knowledge bases: a drug formulary with medication details and pricing, clinical practice guidelines from medical societies, and laboratory reference ranges with test interpretation guidance. When a clinician asks "What is the normal range for hemoglobin A1c in diabetic patients?" searching all three indexes wastes computational resources and risks surfacing less relevant content from the formulary or clinical guidelines. Intent-based routing directs each query to only the knowledge sources likely to contain the answer.

| Query Example | Detected Intent | Routed To | Why Other Sources Skipped |
|---------------|-----------------|-----------|---------------------------|
| "What are side effects of metformin?" | Medication query | Drug formulary | Guidelines discuss diseases, not specific drugs; labs don't cover medications |
| "What is the first-line treatment for type 2 diabetes?" | Clinical protocol query | Clinical guidelines | Formulary has drug facts but not treatment algorithms; labs irrelevant |
| "What TSH level indicates hypothyroidism?" | Lab interpretation query | Lab reference ranges | Formulary and guidelines mention TSH but labs have definitive ranges |
| "How do I manage a patient with diabetes starting insulin?" | Complex clinical query | All three sources | Requires medication info, treatment protocols, and monitoring labs |

## Classify queries to determine knowledge source relevance

Query classification identifies the clinical intent—what type of information the query is seeking—before executing retrieval. A lightweight classifier processes the query and outputs one or more categories that map to your knowledge sources. This classification step adds minimal latency (typically 50-200ms) while preventing wasted searches across irrelevant indexes.

You implement classification using either a small supervised model trained on labeled query examples or a fast LLM call with a structured prompt. The supervised approach offers lower cost and more consistent latency but requires training data and periodic retraining as query patterns evolve. The LLM approach adapts to new query types without retraining but costs more per query and has variable latency.

For a three-index configuration (formulary, guidelines, labs), your classifier outputs three binary decisions indicating whether each source is relevant. A medication-focused query gets `[True, False, False]` for [formulary, guidelines, labs]. A complex query about managing diabetic ketoacidosis gets `[True, True, True]` because it requires medication dosing, treatment protocols, and lab monitoring.

The classifier prompt must be specific about what makes a query relevant to each source. Rather than general categories like "medical question," define decision criteria like "mentions a specific medication by brand or generic name" (formulary), "asks about diagnosis, treatment approach, or clinical decision-making" (guidelines), or "asks about lab test values, reference ranges, or test interpretation" (labs).

```python
from azure.ai.inference import ChatCompletionsClient
from azure.identity import DefaultAzureCredential
import os

chat_client = ChatCompletionsClient(
    endpoint=os.environ["AZURE_AI_SERVICES_ENDPOINT"],
    credential=DefaultAzureCredential(),
)

classification_prompt = """Analyze this clinical query and determine which knowledge sources are needed to answer it.

Query: {query}

Available knowledge sources:
- drug_formulary: Medication information including brand/generic names, dosing, side effects, contraindications, interactions, costs
- clinical_guidelines: Diagnosis criteria, treatment algorithms, clinical protocols, disease management strategies
- lab_references: Laboratory test reference ranges, interpretation guidelines, test indications

Output your classification as a JSON object with boolean values:
{{"drug_formulary": true/false, "clinical_guidelines": true/false, "lab_references": true/false}}

Examples:
Query: "What is the starting dose of lisinopril for heart failure?"
Output: {{"drug_formulary": true, "clinical_guidelines": false, "lab_references": false}}

Query: "What criteria define sepsis?"
Output: {{"drug_formulary": false, "clinical_guidelines": true, "lab_references": false}}

Query: "What HbA1c level indicates poor diabetes control?"
Output: {{"drug_formulary": false, "clinical_guidelines": false, "lab_references": true}}

Query: "How do I manage hypertension in a patient with chronic kidney disease?"
Output: {{"drug_formulary": true, "clinical_guidelines": true, "lab_references": true}}

Provide only the JSON output, no explanation."""

def route_query(query: str) -> dict:
    response = chat_client.complete(
        model="gpt-4o-mini",  # Fast, cost-effective for classification
        messages=[
            {"role": "user", "content": classification_prompt.format(query=query)}
        ],
        temperature=0,
        response_format={"type": "json_object"}
    )
    
    import json
    routing = json.loads(response.choices[0].message.content)
    
    print(f"Query: {query}")
    print(f"Routing: {routing}")
    
    return routing
```

## Implement conditional search execution based on intent

After classification determines which knowledge sources are relevant, you execute searches only against those selected indexes. This conditional execution reduces both cost (fewer search operations) and noise (fewer irrelevant results mixing with relevant ones). The query processing pipeline becomes a directed search rather than broadcasting to all sources.

For each knowledge source classified as relevant, you execute your full hybrid search and re-ranking pipeline. These searches run in parallel to minimize latency—a query needing both formulary and guidelines takes roughly the same time as a query needing only one source because the searches execute concurrently. You aggregate results from all searched sources, preserving their individual relevance scores for downstream re-ranking.

When only one source is needed, the routing decision maps directly to a single search execution. When multiple sources are needed, you must merge their results into a unified ranking. Results from different indexes have scores on different scales—a formulary document score of 0.85 might not be comparable to a guidelines document score of 0.78. You normalize scores within each source before merging, using min-max normalization or z-score standardization to make scores comparable across knowledge bases.

The merged result list requires final re-ranking because documents from different sources now compete for inclusion in the context provided to your agent. You apply the same LLM-as-reranker approach described in the previous unit, but now the comparison spans multiple knowledge sources rather than just ranking within one source.

```python
from azure.search.documents import SearchClient
from azure.search.documents.models import VectorizedQuery
from azure.identity import DefaultAzureCredential
import asyncio
import os

async def search_source(search_client: SearchClient, query: str, embedding: list[float]) -> list[dict]:
    """Execute hybrid search on a single knowledge source."""
    results = search_client.search(
        search_text=query,
        vector_queries=[
            VectorizedQuery(
                vector=embedding,
                k_nearest_neighbors=50,
                fields="content_vector"
            )
        ],
        query_type="semantic",
        semantic_configuration_name="clinical-semantic-config",
        select=["document_id", "title", "content", "source"],
        top=10
    )
    return [dict(result) for result in results]

async def execute_routed_search(query: str, routing: dict) -> list[dict]:
    """Execute searches in parallel based on routing classification."""
    
    # Initialize search clients for each source
    search_clients = {
        "drug_formulary": SearchClient(
            endpoint=os.environ["AZURE_SEARCH_ENDPOINT"],
            index_name="drug-formulary-index",
            credential=DefaultAzureCredential()
        ),
        "clinical_guidelines": SearchClient(
            endpoint=os.environ["AZURE_SEARCH_ENDPOINT"],
            index_name="clinical-guidelines-index",
            credential=DefaultAzureCredential()
        ),
        "lab_references": SearchClient(
            endpoint=os.environ["AZURE_SEARCH_ENDPOINT"],
            index_name="lab-references-index",
            credential=DefaultAzureCredential()
        )
    }
    
    # Get query embedding once for all searches
    query_embedding = get_query_embedding(query)
    
    # Execute searches in parallel for sources classified as relevant
    search_tasks = []
    for source, should_search in routing.items():
        if should_search and source in search_clients:
            search_tasks.append(
                search_source(search_clients[source], query, query_embedding)
            )
    
    # Gather results from all parallel searches
    results_by_source = await asyncio.gather(*search_tasks)
    
    # Flatten and tag with source information
    all_results = []
    for source, results in zip([k for k, v in routing.items() if v], results_by_source):
        for result in results:
            result["knowledge_source"] = source
            all_results.append(result)
    
    return all_results

# Usage
query = "What are the monitoring requirements for a patient starting warfarin?"
routing = route_query(query)
results = asyncio.run(execute_routed_search(query, routing))

print(f"Retrieved {len(results)} documents from routed sources")
```

## Design confidence-based fallback strategies

Classification models make mistakes, especially when queries are ambiguous or use terminology that spans multiple domains. A query like "What is the role of insulin in managing hyperkalemia?" could be classified as needing guidelines (treatment protocol) or formulary (insulin dosing) or labs (potassium reference ranges), and all three might be relevant. When classifier confidence is low, a fallback strategy ensures you don't miss relevant information due to misclassification.

You implement confidence thresholds by having your classifier output not just binary decisions but probability scores for each knowledge source. A score above 0.7 indicates high confidence that the source is relevant. A score between 0.4 and 0.7 indicates uncertainty. A score below 0.4 indicates likely irrelevance. Your routing logic uses these thresholds to make conservative decisions when uncertainty is high.

With a threshold-based approach, you route to all sources with confidence above 0.7 (definitely relevant) plus any sources with confidence above 0.4 if the highest-confidence source is below 0.7 (uncertain classification triggers broader search). This fallback prevents misclassification from excluding a relevant knowledge source while still avoiding searches of clearly irrelevant sources.

For queries where the classifier assigns all sources low confidence (<0.4 for all), you default to searching all sources. This complete fallback ensures that novel query types or terminology shifts don't cause retrieval failures. You log these low-confidence queries for later analysis—they indicate gaps in your classifier's training data or query patterns that need explicit handling.

## Measure routing accuracy and quality impact

Routing quality has two dimensions: classification accuracy (does it select the right sources?) and retrieval quality (do routed searches return better results than broadcasting to all sources?). You measure both to understand whether routing improves your system.

Classification accuracy requires labeled evaluation data where you know which sources contain relevant documents for each query. You measure recall (what percentage of relevant sources are selected?) and precision (what percentage of selected sources are actually relevant?). Recall gaps mean missing relevant knowledge; precision gaps mean wasting compute on irrelevant searches.

You collect routing telemetry for every query: the classifier's confidence scores for each source, which sources were searched, how many results each source returned, and what the final agent response quality was. Over time, this data reveals patterns like "guideline queries misclassified as formulary queries when they mention drug names"—insights that drive classifier improvements.

Routing quality appears in cost savings and latency improvements. If 60% of queries need only one knowledge source but you search all three, you perform 3x more searches than necessary. After implementing routing, you measure the average number of sources searched per query. A reduction from 3.0 to 1.4 represents 53% cost savings on search operations. Latency improvements come from parallel execution—searching one or two sources in parallel is faster than sequentially searching three.

## Handle dynamic source availability

Production systems must handle scenarios where knowledge sources become temporarily unavailable—index rebuilding, service maintenance, or transient failures. Your routing logic needs fallback paths when a selected source can't be queried. A reliable fallback routes to all remaining available sources when the primary selected source fails, ensuring queries get answers even when ideal sources are down.

You implement health checks that probe each knowledge source before executing searches. If a source fails the health check, you log the unavailability and skip it in routing decisions. The classifier output still indicates relevance, but execution skips unavailable sources. This separation of intent (classifier) and capability (source availability) keeps your classification logic stable while handling operational issues.

For planned maintenance windows, you configure routing to temporarily redirect queries to alternative sources. If the drug formulary index is being rebuilt, you route medication queries to clinical guidelines that contain some drug information, albeit less comprehensive than the dedicated formulary. You include a flag in responses indicating suboptimal routing so users understand limitations.

Source availability logging feeds into operational monitoring. A pattern of frequent unavailability for one source indicates infrastructure issues that need addressing. Temporary spikes in routing to all sources due to unavailability indicate your fallback logic is activating correctly. These metrics ensure routing remains robust in production environments.

Routing controls where searches run. What you can retrieve still depends on what's in those indexes—which depends on the chunking and embedding decisions covered in the next unit.

## Key takeaways

- **Query classification** identifies clinical intent before retrieval, routing queries to only relevant knowledge sources—reducing cost by up to 53% when most queries need only one of three indexes
- **Confidence-based fallback** uses probability thresholds to make conservative routing decisions—high confidence (>0.7) routes precisely, low confidence (<0.4 across all sources) triggers a full search as a safety net
- **Parallel conditional execution** searches multiple selected sources concurrently with score normalization and cross-source re-ranking to produce a unified result ranking
- **Dynamic source availability** separates classification intent from execution capability—the classifier indicates relevance while health checks determine which sources can actually be queried
- **Routing telemetry** captures confidence scores, sources searched, and result counts per query, enabling continuous classifier improvement and cost-savings measurement
