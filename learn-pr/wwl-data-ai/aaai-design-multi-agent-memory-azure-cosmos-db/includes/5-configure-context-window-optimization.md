The context window is your most constrained resource in memory-augmented agents. GPT-4o's 128K token limit must accommodate the system prompt, retrieved memories, current document content, conversation history, tool results, and space for the agent's response. When you retrieve 20 relevant memories totaling 8,000 tokens, those tokens displace other content — fewer documents can be included, or less conversation history fits. Optimal context allocation balances completeness with relevance across all content types.

| Content Type | Typical Size | Priority | Allocation Strategy |
|--------------|--------------|----------|---------------------|
| System prompt | 500-1,500 tokens | Required | Fixed allocation, optimize for conciseness |
| Retrieved memories | 2,000-6,000 tokens | High for follow-ups | Variable based on query complexity |
| Document content | 10,000-30,000 tokens | High for knowledge queries | Variable based on retrieval quality |
| Conversation history | 5,000-20,000 tokens | Medium | Sliding window, keep recent + important |
| Tool results | 1,000-5,000 tokens | Required | Dynamic based on tool usage |
| Response buffer | 4,000-16,000 tokens | Required | Reserve for generation |

## Allocate context budget based on interaction type

Different clinical interactions have different context needs. A medication review benefits from extensive patient memory (past medications, side effects, adherence patterns) but needs minimal document retrieval. A diagnostic consultation needs comprehensive document retrieval from clinical guidelines but fewer patient memories. You classify the interaction type and adjust context allocation accordingly.

Simple queries like "What is the normal range for blood glucose?" need minimal memory — perhaps 2-3 relevant memories consuming 500 tokens. Complex queries like "Review this patient's diabetes management plan considering their history" need more memory — 8-10 memories consuming 3,000+ tokens. You implement dynamic allocation that assigns more context budget to memories when the query indicates historical context is critical.

Query complexity classification uses similar techniques to the routing classifier from Module A. A fast LLM call or lightweight model categorizes queries as "simple factual," "patient-history dependent," or "complex multi-factor." Each category maps to a memory allocation target: simple queries get 5-10% of context for memories, patient-history queries get 20-30%, complex queries get 15-25%.

Document retrieval receives the largest allocation for knowledge-intensive queries. When the query requires clinical guidelines, drug information, or lab interpretation, you reserve 30-50% of the context window for retrieved documents. When the query primarily requires patient history, document allocation drops to 10-20% while memory allocation increases proportionally.

```python
def allocate_context_budget(query: str, max_context_tokens: int = 100000) -> dict:
    """Determine context token allocation based on query complexity and type."""
    
    # Classify query type (simplified - use actual classifier in production)
    classification = classify_query_type(query)  # Returns: simple, history_dependent, complex
    
    # Base allocations by query type
    allocations = {
        "simple": {
            "system_prompt": 1000,
            "memories": 500,
            "documents": 30000,
            "conversation": 10000,
            "tools": 2000,
            "response_buffer": 8000
        },
        "history_dependent": {
            "system_prompt": 1200,
            "memories": 6000,
            "documents": 10000,
            "conversation": 15000,
            "tools": 3000,
            "response_buffer": 10000
        },
        "complex": {
            "system_prompt": 1500,
            "memories": 5000,
            "documents": 20000,
            "conversation": 15000,
            "tools": 5000,
            "response_buffer": 12000
        }
    }
    
    budget = allocations.get(classification, allocations["complex"])
    
    # Validate total doesn't exceed limit
    total_allocated = sum(budget.values())
    if total_allocated > max_context_tokens:
        # Scale all allocations proportionally
        scale_factor = max_context_tokens / total_allocated
        budget = {k: int(v * scale_factor) for k, v in budget.items()}
    
    return budget
```

## Compress memories through summarization and distillation

Before injecting memories into context, you compress them to maximize information density. Raw memories often contain repetitive phrasing or verbose descriptions. Compression extracts the core information while reducing token count by 40-60%.

Summarization combines multiple related memories into a single concise statement. If five memories discuss the patient's difficulty with medication adherence, you combine them: "Patient has documented adherence challenges with complex medication schedules, particularly evening doses. Prefers once-daily medications and uses pill organizers successfully." This summary conveys the same information in fewer tokens than listing all five memories separately.

Distillation removes linguistic hedging and extracts only factual content. A memory stating "During the March consultation, the patient expressed concerns about potential side effects and mentioned they had read online about possible fatigue" distills to "Patient concerned about fatigue side effect." This distillation preserves the key information while cutting token count by 60%.

```python
from azure.ai.inference import ChatCompletionsClient
from azure.identity import DefaultAzureCredential
import os

chat_client = ChatCompletionsClient(
    endpoint=os.environ["AZURE_AI_SERVICES_ENDPOINT"],
    credential=DefaultAzureCredential(),
)

def compress_memories(memories: list[dict]) -> str:
    """Compress multiple memories through summarization and distillation."""
    
    if not memories:
        return ""
    
    # Group memories by type for better compression
    grouped = {}
    for mem in memories:
        mem_type = mem["memory_type"]
        if mem_type not in grouped:
            grouped[mem_type] = []
        grouped[mem_type].append(mem["content"])
    
    compression_prompt = """Compress these patient memories into concise factual statements.

Memories to compress:
{memories}

Requirements:
- Combine related memories into single statements
- Remove hedging language ("expressed," "mentioned," "indicated")
- Keep only clinically relevant facts
- Preserve important details (medication names, dates, specific concerns)
- Output as bullet points, one per key fact

Example:
Input: "Patient mentioned during March visit they prefer morning appointments. In April, patient again requested morning rather than afternoon."
Output: "• Prefers morning appointments"

Compress these memories:"""

    compressed_sections = []
    
    for mem_type, mem_list in grouped.items():
        response = chat_client.complete(
            model="gpt-4o-mini",
            messages=[
                {"role": "user", "content": compression_prompt.format(
                    memories="\n".join(f"- {mem}" for mem in mem_list)
                )}
            ],
            temperature=0
        )
        
        compressed = response.choices[0].message.content.strip()
        compressed_sections.append(f"**{mem_type.replace('_', ' ').title()}:**\n{compressed}")
    
    return "\n\n".join(compressed_sections)

# Example usage
memories = retrieve_relevant_memories(patient_id, session_context, top_k=10)
compressed_memory_context = compress_memories(memories)

print(f"Original: {sum(len(m['content'].split()) for m in memories) * 1.3:.0f} tokens")
print(f"Compressed: {len(compressed_memory_context.split()) * 1.3:.0f} tokens")
```

## Select memories using importance-based ranking

When you retrieve 20 semantically relevant memories but can only inject 5 due to context constraints, which 5 do you choose? Importance-based selection ranks memories by a combined score that considers semantic similarity to the query, current importance (with decay applied), and recency. This ensures the most valuable memories enter the context while less critical information is excluded.

The ranking formula balances multiple factors: `score = (similarity * 0.5) + (importance/10 * 0.3) + (recency * 0.2)`. Similarity ensures retrieved memories relate to the current query. Importance gives weight to clinically significant observations over minor preferences. Recency provides a slight boost to recent information that's more likely to remain accurate.

You tune these coefficients based on your specific application needs. Clinical decision support might weight importance higher (0.4) and similarity lower (0.3) because critical clinical facts matter more than semantic relevance. Patient preference tracking might weight recency higher (0.3) because preferences change over time.

```python
from datetime import datetime, timedelta

def rank_memories_by_importance(memories: list[dict], top_k: int = 5) -> list[dict]:
    """Rank memories by combined similarity, importance, and recency."""
    
    current_time = datetime.utcnow()
    
    for mem in memories:
        # Calculate recency score (0-1, decays over 180 days)
        memory_age_days = (current_time - datetime.fromisoformat(mem["timestamp"])).days
        recency_score = max(0, 1 - (memory_age_days / 180))
        
        # Get decayed importance
        importance_score = calculate_decayed_importance(mem) / 10.0
        
        # Combined ranking score
        mem["rank_score"] = (
            mem["similarity_score"] * 0.5 +
            importance_score * 0.3 +
            recency_score * 0.2
        )
    
    # Sort by rank score and return top-k
    memories.sort(key=lambda m: m["rank_score"], reverse=True)
    return memories[:top_k]

# Example: Select top 5 memories within token budget
memory_budget_tokens = 3000
average_memory_tokens = 250

max_memories = memory_budget_tokens // average_memory_tokens  # ~12 memories
retrieved_memories = retrieve_relevant_memories(patient_id, session_context, top_k=20)
selected_memories = rank_memories_by_importance(retrieved_memories, top_k=max_memories)

print(f"Retrieved {len(retrieved_memories)} memories, selected top {len(selected_memories)} within budget")
```

## Implement hybrid selection with recency and importance

Selecting only the highest-importance memories risks excluding all recent information when older memories have high importance scores. A hybrid approach ensures context includes both high-importance memories AND recent memories, even if some recent memories have lower overall scores.

You allocate your memory budget into two pools: 70% for top-ranked memories by importance, 30% reserved for recent memories regardless of importance. This guarantees that the agent sees what happened in the most recent visit (helpful for continuity) while also getting critical historical context (necessary for clinical decisions).

The hybrid approach prevents scenarios where a patient's medication change from last week doesn't appear in context because older, higher-importance memories about chronic conditions dominate the ranking. Recent information provides temporal continuity; important information provides clinical context. Both matter.

```python
def select_memories_hybrid(memories: list[dict], token_budget: int, avg_tokens_per_memory: int = 250) -> list[dict]:
    """Select memories using hybrid strategy: importance-ranked + recent."""
    
    max_memories = token_budget // avg_tokens_per_memory
    
    # Allocate 70% budget to importance-ranked memories
    importance_slots = int(max_memories * 0.7)
    recency_slots = max_memories - importance_slots
    
    # Get top memories by importance ranking
    importance_ranked = rank_memories_by_importance(memories, top_k=len(memories))
    selected_memories = importance_ranked[:importance_slots]
    
    # Get most recent memories not already selected
    memories_by_recency = sorted(memories, key=lambda m: m["timestamp"], reverse=True)
    recent_memories = [m for m in memories_by_recency if m not in selected_memories][:recency_slots]
    
    # Combine and return
    final_selection = selected_memories + recent_memories
    final_selection.sort(key=lambda m: m["timestamp"])  # Present in chronological order
    
    return final_selection
```

## Measure memory impact on agent quality and cost

Context optimization requires measuring tradeoffs between token cost and response quality. You run controlled experiments: answer the same set of test queries with 0 memories, 3 memories, 5 memories, and 10 memories. Measure agent response accuracy against ground truth answers and track total tokens consumed per query.

The quality curve typically shows diminishing returns: going from 0 to 3 memories improves accuracy significantly, 3 to 5 shows moderate improvement, 5 to 10 shows minimal improvement. The token cost increases linearly with memory count. You identify the inflection point where additional memories stop improving quality enough to justify their token cost.

For Northwind Health's clinical agents, evaluation might show that 5 memories achieve 92% answer accuracy while 10 memories achieve 93% accuracy but cost 40% more tokens. The optimal configuration is 5 memories — the quality improvement from adding 5 more isn't worth the cost increase.

You also measure latency impact. More context tokens increase generation time because the model processes more input. A session with 5 memories might respond in 2.3 seconds while 10 memories takes 3.1 seconds. User experience research guides the quality-speed tradeoff: is 1% better accuracy worth 35% longer wait times?

```python
import time

def evaluate_memory_impact(test_queries: list[dict], memory_counts: list[int]) -> dict:
    """Measure how memory count affects quality, cost, and latency."""
    
    results = {count: {"accuracy": [], "tokens": [], "latency": []} for count in memory_counts}
    
    for query_data in test_queries:
        query = query_data["query"]
        ground_truth = query_data["expected_answer"]
        patient_id = query_data["patient_id"]
        
        for count in memory_counts:
            start_time = time.time()
            
            # Retrieve and select memories
            memories = retrieve_relevant_memories(patient_id, query, top_k=20)
            selected = rank_memories_by_importance(memories, top_k=count)
            memory_context = format_memories_for_context(selected)
            
            # Generate response with this memory configuration
            response = generate_agent_response(query, memory_context)
            
            latency = time.time() - start_time
            
            # Evaluate accuracy (would use more sophisticated metric in production)
            accuracy = calculate_answer_similarity(response, ground_truth)
            
            results[count]["accuracy"].append(accuracy)
            results[count]["tokens"].append(response["usage"]["total_tokens"])
            results[count]["latency"].append(latency)
    
    # Calculate averages
    summary = {}
    for count in memory_counts:
        summary[count] = {
            "avg_accuracy": sum(results[count]["accuracy"]) / len(results[count]["accuracy"]),
            "avg_tokens": sum(results[count]["tokens"]) / len(results[count]["tokens"]),
            "avg_latency": sum(results[count]["latency"]) / len(results[count]["latency"])
        }
    
    return summary

# Example evaluation
test_queries = load_test_queries()  # Load labeled test set
memory_counts = [0, 3, 5, 10, 15]
evaluation_results = evaluate_memory_impact(test_queries, memory_counts)

for count, metrics in evaluation_results.items():
    print(f"{count} memories: {metrics['avg_accuracy']:.1%} accuracy, {metrics['avg_tokens']:.0f} tokens, {metrics['avg_latency']:.2f}s latency")
```

Now that you've optimized context window usage through budget allocation, compression, and importance-based selection, you're ready to design memory lifecycle policies that manage retention, pruning, and compliance for production agent systems.

## Context-window failure mode vocabulary

The JTA and production troubleshooting guides use specific vocabulary for context-window failures. The table below maps each named failure mode to the curriculum mechanism that addresses it and where it is taught.

| JTA failure mode | What it means in production | Curriculum mechanism | Where taught |
|---|---|---|---|
| **Sliding-window amnesia** | The agent forgets events from early in a long conversation because a fixed sliding window drops them when the window slides forward | Sliding-window retention with importance pruning \u2014 critical memories (drug allergies, confirmed diagnoses) are exempt from the sliding window | This unit (importance-based ranking + budget allocation) |
| **Summary drift** | Iterative summarization introduces factual errors \u2014 each summary of a summary diverges further from the original event | Contradiction detection in retention consolidation + importance decay that favors raw episodic memories over summaries when the episode was recent | LP3 M5 Unit 6 + LP1 M1 Unit 4 (reflection cycle quality checks) |
| **Vector-only recall** | Vector similarity alone retrieves thematically related memories but misses exact-match facts (patient IDs, drug names, dosages) that embed similarly to other values | Hybrid search (vector + keyword) in retrieval + cross-encoder re-ranking to surface exact-match facts | LP2 M3 Units 2-3 (hybrid search and re-ranking) |
| **Entity continuity** | The agent loses track of which entity (patient, drug, case) a memory belongs to across session boundaries | Episodic memory with entity resolution \u2014 memories tagged with entity IDs that survive session resets | LP3 M5 Unit 4 (semantic memory + entity-linked storage) |

When troubleshooting context-window quality issues in production, use these diagnostic terms to identify the failure mode before choosing a mitigation. The mitigations are different: sliding-window amnesia requires importance-aware retention policy; summary drift requires better consolidation validation; vector-only recall requires hybrid retrieval; entity continuity requires entity-linked episodic storage.

> [!TIP]
> **Pause and reflect:** Consider a scenario where Northwind Health's clinical agent assists with a complex patient who has 50+ memories spanning 3 years. The context window can hold 10 memories. How would you design the selection strategy to balance recency (recent lab results) with clinical importance (documented drug allergies from 2 years ago)? What happens if the patient's critical allergy memory gets bumped by less important but more recent memories?

## Unit summary

- **Context budget allocation** assigns fixed token budgets to different memory categories (patient history, preferences, clinical alerts) to prevent any single category from consuming the entire window.
- **Memory compression** uses LLM summarization and distillation to reduce verbose episodic memories into concise summaries that preserve clinical meaning.
- **Importance-based ranking** selects which memories to inject based on a combination of importance score, recency, and relevance to the current query.
- **Hybrid selection** combines recency and importance signals to prevent both stale-context and important-context-dropped failure modes.
- **Quality measurement** tracks how memory injection affects accuracy, token consumption, and latency to guide optimization decisions.
