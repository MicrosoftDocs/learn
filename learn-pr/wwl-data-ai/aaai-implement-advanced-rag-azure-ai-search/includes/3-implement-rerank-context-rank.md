Getting the right documents into the initial result set is only part of the challenge—the harder part is putting the most useful ones first. Azure AI Search's semantic ranker rescores those initial candidates using a language model, without requiring any changes to your index. Combined with cross-encoder models and Large Language Model (LLM) based scoring, it forms the foundation of a multi-stage pipeline that progressively narrows results to the documents that genuinely answer the query.

Hybrid search returns a ranked list of potentially relevant documents, but the initial ranking reflects a general-purpose scoring algorithm that doesn't understand your specific query context. When a clinician asks "What are the monitoring requirements for a patient starting warfarin therapy?" hybrid search might rank documents about warfarin pharmacology, general anticoagulation guidelines, and laboratory testing procedures—all potentially relevant, but not all equally useful. Reranking applies more sophisticated relevance scoring to select the documents that best answer the specific question.

| Reranking Stage | Speed | Accuracy | Best For |
|------------------|-------|----------|----------|
| Hybrid search (first pass) | Fast | Good | Candidate retrieval (top-50 to top-100) |
| Semantic reranking | Medium | Better | Refining top-50 to top-10 |
| Cross-encoder reranking | Slow | High | Domain-specific refinement (top-20 to top-5) |
| LLM-as-reranker | Very slow | Highest | Final selection (top-10 to top-3) |

## Implement semantic reranking with Azure AI Search

Azure AI Search's built-in semantic ranking uses a language model trained on large corpora to score query-document relevance based on semantic understanding rather than term frequency. Unlike the initial BM25 and vector scores, semantic ranking evaluates how well a document's content answers the query as a complete question.

You enable semantic ranking by setting `query_type="semantic"` and specifying a semantic configuration that defines which fields to consider for ranking. The semantic ranker analyzes document titles, content, and keywords to create a comprehensive relevance score. For clinical queries, this means semantic ranking recognizes that a document titled "Warfarin Monitoring Protocol" with content discussing "INR target ranges" and "bleeding risk assessment" is more relevant to a monitoring question than a general warfarin overview.

Semantic ranking operates on the top-50 results from hybrid search by default. The ranker doesn't see documents ranked beyond position 50, so the quality of your initial hybrid search matters—semantic reranking refines good candidates but can't rescue relevant documents that hybrid search missed entirely. This two-stage architecture balances computational cost (semantic ranking is more expensive than hybrid search) with result quality.

The semantic ranking process also generates captions and answers. Captions are short excerpts from documents that highlight the most relevant passage for your query. Answers are direct responses extracted from a single document when the ranker determines it contains a definitive answer. For clinical decision support, answers provide quick access to specific guidance like dosage recommendations or contraindication warnings.

Semantic ranker also supports **query rewrite** (preview), which expands the original query into multiple semantically similar alternatives before retrieval runs. A fine-tuned small language model hosted by Azure AI Search generates these synthetic queries; the service then merges them with the original query for both BM25 and vector retrieval. Query rewrite improves recall by finding relevant documents that use different terminology than the original query—useful when clinical guidelines use formal language ("anticoagulation therapy") while queries use informal phrasing ("blood thinners"). You enable it by adding `queryRewrites: "generative|count-5"` to the search request. Use it selectively for conceptual clinical queries; avoid it for searches on exact identifiers such as National Drug Code (NDC) codes or ICD-10 codes, because rewritten queries might not preserve those exact terms.

```python
from azure.search.documents import SearchClient
from azure.search.documents.models import VectorizedQuery
from azure.identity import DefaultAzureCredential
import os

search_client = SearchClient(
    endpoint=os.environ["AZURE_SEARCH_ENDPOINT"],
    index_name="clinical-guidelines-index",
    credential=DefaultAzureCredential()
)

# First stage: hybrid search returns top-50 candidates
query_embedding = get_query_embedding("warfarin monitoring requirements")

results = search_client.search(
    search_text="warfarin monitoring requirements",
    vector_queries=[
        VectorizedQuery(
            vector=query_embedding,
            k_nearest_neighbors=50,
            fields="content_vector"
        )
    ],
    query_type="semantic",
    semantic_configuration_name="clinical-semantic-config",
    select=["document_id", "title", "content"],
    top=50  # Retrieve more candidates for reranking
)

# Azure AI Search semantic ranker automatically refines top-50 to top-10
semantic_results = list(results)[:10]

# Second stage: LLM reranks top-10 for final selection
reranking_prompt = """Rate how well this document answers the query on a scale of 1-10.

Query: {query}

Document Title: {title}
Document Content: {content}

Provide only a number between 1-10, where 10 means the document directly and completely answers the query."""

from azure.ai.inference import ChatCompletionsClient
import os

chat_client = ChatCompletionsClient(
    endpoint=os.environ["AZURE_AI_SERVICES_ENDPOINT"],
    credential=DefaultAzureCredential(),
)

reranked_results = []
for doc in semantic_results:
    response = chat_client.complete(
        model="gpt-4o-mini",
        messages=[
            {"role": "user", "content": reranking_prompt.format(
                query="warfarin monitoring requirements",
                title=doc["title"],
                content=doc["content"][:2000]  # Truncate long documents
            )}
        ],
        temperature=0
    )
    
    score = float(response.choices[0].message.content.strip())
    reranked_results.append({
        "document": doc,
        "rerank_score": score
    })

# Sort by LLM rerank score and select top-3
final_results = sorted(reranked_results, key=lambda x: x["rerank_score"], reverse=True)[:3]

for i, result in enumerate(final_results, 1):
    print(f"{i}. {result['document']['title']} (score: {result['rerank_score']})")
```

## Implement cross-encoder reranking for domain-specific refinement

Cross-encoder models score each query-document pair by processing them together through a neural network, unlike bi-encoder models (used for embeddings) that process queries and documents separately. This joint processing captures subtle relevance signals that bi-encoders miss, particularly for domain-specific terminology and complex clinical relationships.

A clinical cross-encoder trained on medical literature understands that a query about "anticoagulation reversal" and a document discussing "prothrombin complex concentrate administration" have high relevance even though they share few common terms. The model learns from medical training data that these concepts have a clinical relationship—Prothrombin Complex Concentrate (PCC) reverses anticoagulation caused by warfarin.

You deploy a cross-encoder model through Azure Machine Learning or use a pretrained medical cross-encoder from the Hugging Face model hub. The model takes concatenated query-document pairs as input and outputs a relevance score. Unlike embedding models that generate vectors once during indexing, cross-encoders must process every query-document combination at query time, making them too expensive for large candidate sets but practical for refining a top-20 list to a top-5.

Cross-encoder reranking provides the most benefit when your content has specialized vocabulary that general-purpose semantic rankers don't understand well. Drug interaction warnings, surgical procedure descriptions, and diagnostic criteria all contain domain-specific relationships that benefit from medical training data. For general patient education content written in plain language, the improvement over semantic ranking might not justify the extra computational cost.

## Use LLM-as-reranker for highest accuracy final selection

Large language models like GPT-4o can evaluate relevance by reading the query and each document, then providing a numerical rating or explanation of how well the document answers the question. This approach achieves the highest accuracy because the LLM applies reasoning about what the query is asking and what information would satisfy that need.

For clinical applications, LLM reranking excels at handling complex queries that require integrating multiple pieces of information. A query like "What monitoring is needed for a patient who has diabetes and is starting ACE inhibitors?" requires understanding that people who have diabetes need renal function monitoring, ACE inhibitors can affect potassium levels, and blood pressure monitoring is standard—an LLM can evaluate whether a candidate document addresses all these aspects.

The primary constraint is cost and latency. Each reranking request consumes input tokens for the prompt (including the full query and document content) and output tokens for the score. For a top-10 list being refined to top-3, you make 10 separate LLM calls. This makes LLM reranking practical only for the final selection stage after earlier stages have narrowed candidates to a small set.

You design the reranking prompt to be specific about your relevance criteria. Rather than asking "Is this relevant?" specify "Does this document provide actionable clinical guidance for the specific patient scenario in the query?" The more precise your prompt, the more consistent and useful the relevance scores become.

## Balance context diversity with precision

Retrieving the three highest-scoring documents might return three excerpts from the same clinical guideline, each scored highly because they all address the query. But this redundancy wastes context window space that could provide broader perspective. After reranking by relevance, apply a diversity filter that prefers documents covering different aspects of the query.

Maximum Marginal Relevance (MMR) is one diversity algorithm that balances relevance and novelty. For each candidate document, MMR calculates a score that combines its relevance to the query with its dissimilarity to already-selected documents. The first document selected is simply the highest relevance score. The second document selected must be both relevant and sufficiently different from the first. This process continues until you reach your target number of documents.

For clinical decision support, diversity ensures agents consider multiple treatment approaches or recognize when guidelines from different specialty societies offer different recommendations. A query about "atrial fibrillation management" benefits from retrieving documents about rate control, rhythm control, and anticoagulation decisions rather than three documents that all focus on anticoagulation alone.

You implement diversity filtering by calculating embedding similarity between already-selected documents and remaining candidates. Documents with high similarity to already-selected content receive a penalty in their final score. The penalty weight controls the diversity-precision trade-off—higher penalties enforce more diversity but might exclude highly relevant secondary documents.

## Measure reranking impact on retrieval quality

Offline evaluation uses a labeled dataset where domain experts have marked which documents are relevant for specific queries. You measure ranking quality using normalized Discounted Cumulative Gain (nDCG), which scores ranking quality by position—relevant documents at position 1 contribute more to the score than relevant documents at position 10. Mean Reciprocal Rank (MRR) measures where the first relevant document appears in your ranking.

You establish a baseline by measuring nDCG and MRR for your hybrid search results without reranking, then compare against the same metrics after each reranking stage. A meaningful improvement is at least 5 percentage points of nDCG, though clinical applications might require larger gains to justify the added complexity and cost.

Online evaluation complements offline metrics by measuring how reranking affects downstream agent accuracy. When agents use better-ranked retrieval results, do they generate more accurate clinical recommendations? You track this by comparing agent responses against gold-standard answers or by having clinicians rate agent response quality. If reranking improves retrieval metrics but doesn't improve agent answer quality, the initially retrieved documents might lack the needed information entirely—a signal to improve your indexing or expand your knowledge sources.

Northwind Health's clinical team measured that after adding cross-encoder reranking to the formulary index, the agent's drug interaction recommendations improved from 78% to 91% accuracy on a 50-query clinical test set. The improvement came specifically because the reranker correctly prioritized contraindications sections over general pharmacology overview documents—the information was always in the index, but the initial ranking buried it below less relevant results.

User satisfaction provides another signal for reranking quality. When clinicians interact with agent responses, implicit feedback like which citations they select, how long they spend reading responses, and whether they rephrase and retry queries all indicate whether the agent found useful information. Tracking these metrics before and after implementing reranking reveals whether the added complexity benefits users.

Reranking improves how results are ordered within a search. When your RAG pipeline spans multiple specialized indexes, the bigger efficiency question is which sources to search at all—that's where dynamic routing comes in.

## Key takeaways

- **Multi-stage reranking pipeline** progressively refines results—hybrid search retrieves top-50 candidates, semantic ranking refines to top-10, cross-encoder or LLM reranking selects the final top-3
- **Semantic ranking** in Azure AI Search evaluates query-document relevance using language models, generates extractive captions and answers, and optionally rewrites queries into semantically similar alternatives to improve recall—all operating on or before the top-50 from hybrid search
- **Cross-encoder models** score query-document pairs jointly for domain-specific refinement—effective for specialized clinical terminology but too expensive for large candidate sets
- **LLM-as-reranker** achieves the highest accuracy by reasoning about whether documents answer the specific question, but cost and latency limit it to final selection on small candidate sets
- **Maximum Marginal Relevance (MMR)** balances precision with diversity by penalizing candidates similar to already-selected documents, ensuring agents receive multi-perspective context rather than redundant excerpts
