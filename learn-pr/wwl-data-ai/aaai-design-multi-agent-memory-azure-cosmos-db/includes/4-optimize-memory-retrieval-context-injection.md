Azure Cosmos DB stores an importance score alongside each memory embedding, giving your retrieval layer the signal it needs to decay outdated records, boost frequently accessed ones, and inject only the most relevant context into the agent. Managing importance dynamically keeps the context window focused on what matters most for each clinical interaction.

## Update memory importance with relevance decay

Memories become less relevant over time. A concern about medication side effects from 6 months ago might no longer apply if the patient successfully adapted or changed medications. You implement importance decay that reduces memory relevance scores based on age, access frequency, and whether newer information contradicts it.

Time-based decay follows an exponential or linear function: memories lose a percentage of their importance score for each month elapsed since creation. A memory with importance 9 might decay to 7.2 after 6 months using a 20% decay rate. Access-based boosting counteracts decay: memories frequently retrieved remain relevant because they continue to apply across sessions.

Contradiction detection identifies when new memories supersede old ones. If a new memory states "Patient now prefers afternoon appointments" and an old memory says "Patient prefers morning appointments," the old memory's importance drops to near-zero because it's been contradicted. You implement this through semantic similarity between memories plus temporal ordering — newer memories with high similarity to older memories indicate updates.

For Northwind Health, contradiction detection prevents clinically dangerous stale context. A January memory stating "Patient tolerates metformin 500mg well" gets contradicted by a March memory recording "Patient reports persistent GI distress on metformin — switched to extended-release formulation." The system automatically reduces the outdated tolerance memory's importance so the next clinician isn't told the patient tolerates standard metformin when they've already been switched.

```python
from datetime import datetime, timedelta

def calculate_decayed_importance(memory: dict, decay_rate: float = 0.02) -> float:
    """Calculate current importance score with time-based decay and access-based boost."""
    
    # Base importance from memory
    base_importance = memory["importance"]
    
    # Calculate age in days
    memory_date = datetime.fromisoformat(memory["timestamp"])
    age_days = (datetime.utcnow() - memory_date).days
    
    # Time decay: reduce importance by decay_rate per month
    months_old = age_days / 30.0
    time_decay_factor = (1 - decay_rate) ** months_old
    decayed_importance = base_importance * time_decay_factor
    
    # Access boost: frequently accessed memories stay relevant
    access_boost = min(memory["access_count"] * 0.5, 3.0)  # Cap boost at +3
    
    # Final importance with floor and ceiling
    final_importance = max(1.0, min(10.0, decayed_importance + access_boost))
    
    return final_importance

def identify_contradicted_memories(patient_id: str, new_memory: dict) -> list[str]:
    """Find old memories that are contradicted by a new memory."""
    
    # Find semantically similar memories (potential contradictions)
    embedding = new_memory["embedding"]
    
    query = """
        SELECT c.id, c.content, c.timestamp,
               VectorDistance(c.embedding, @new_embedding) AS similarity
        FROM c
        WHERE c.patient_id = @patient_id
            AND c.memory_type = @memory_type
            AND c.timestamp < @new_timestamp
            AND VectorDistance(c.embedding, @new_embedding) > 0.85
    """
    
    parameters = [
        {"name": "@patient_id", "value": patient_id},
        {"name": "@new_embedding", "value": embedding},
        {"name": "@memory_type", "value": new_memory["memory_type"]},
        {"name": "@new_timestamp", "value": new_memory["timestamp"]}
    ]
    
    similar_old_memories = list(container.query_items(
        query=query,
        parameters=parameters,
        partition_key=patient_id
    ))
    
    # These highly similar, older memories of the same type are likely contradicted
    contradicted_ids = [mem["id"] for mem in similar_old_memories]
    
    # Mark contradicted memories with importance near-zero
    for mem_id in contradicted_ids:
        memory_doc = container.read_item(item=mem_id, partition_key=patient_id)
        memory_doc["importance"] = 1.0  # Minimum importance
        memory_doc["contradicted_by"] = new_memory["id"]
        container.upsert_item(memory_doc)
    
    return contradicted_ids
```

## Inject retrieved memories into agent context

Retrieved memories must be formatted and injected into the agent's context in a way that clearly distinguishes them from the current conversation and from document retrieval results. You create a distinct section in the system prompt labeled "Patient Context from Previous Interactions" that precedes the current conversation.

The injection format summarizes memories concisely to conserve context window space. Rather than including full memory documents with metadata, you extract just the content statement and importance indicator. Memories are ordered by relevance (combination of similarity score and current importance) so the most pertinent information appears first.

For Northwind Health's diabetes management agent, the injected context might look like: "1. ⚠️ Patient has documented penicillin allergy — confirmed anaphylactic reaction. 2. Patient experiences GI side effects from metformin ER. 3. Patient prefers morning appointments and communicates better with written instructions." The hierarchy flows from critical clinical safety (allergy) to active treatment context (side effects) to care preferences — ensuring the most important information survives if the context window forces truncation.

```python
def format_memories_for_context(memories: list[dict]) -> str:
    """Format retrieved memories for injection into agent system prompt."""
    
    if not memories:
        return ""
    
    # Calculate current importance with decay applied
    for mem in memories:
        mem["current_importance"] = calculate_decayed_importance(mem)
    
    # Sort by combination of similarity and current importance
    memories.sort(
        key=lambda m: m["similarity_score"] * (m["current_importance"] / 10.0),
        reverse=True
    )
    
    formatted = "**Patient Context from Previous Interactions:**\n\n"
    
    for i, mem in enumerate(memories[:5], 1):  # Limit to top 5
        importance_marker = "⚠️" if mem["current_importance"] >= 8 else ""
        formatted += f"{i}. {importance_marker} {mem['content']}\n"
    
    formatted += "\nUse this context to personalize your responses and maintain continuity of care.\n"
    return formatted

# Example: Create system message with memory context
memories = retrieve_relevant_memories(patient_id, session_context)
memory_context = format_memories_for_context(memories)

system_prompt = f"""You are a clinical assistant for Northwind Health helping with patient consultations.

{memory_context}

**Current Session:**
{session_context}

Provide evidence-based clinical guidance, reference relevant memories when appropriate, and maintain continuity with previous interactions."""

# Use system_prompt in your agent's messages
```

Now that you've implemented memory importance management and context injection, you're ready to optimize context window usage by selecting which memories to inject based on relevance, importance, and the specific needs of each query.

## Key takeaways

- **Importance decay** reduces memory relevance over time using exponential or linear functions, preventing stale observations from dominating context. Access-based boosting counteracts decay for frequently retrieved memories.
- **Contradiction detection** uses semantic similarity between memories plus temporal ordering to identify when newer memories supersede older ones, automatically reducing the contradicted memory's importance.
- **Context injection** formats memories as a distinct "Patient Context from Previous Interactions" section in the agent's system prompt, ordered by combined similarity and importance scores.
- **Concise formatting** conserves context window space — inject content statements and importance indicators only, not full memory documents with metadata.
