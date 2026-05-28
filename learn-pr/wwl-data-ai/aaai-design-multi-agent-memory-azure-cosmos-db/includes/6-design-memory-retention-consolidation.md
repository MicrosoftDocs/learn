Patient memories accumulate continuously as agents conduct consultations. Without lifecycle management, storage grows indefinitely, costs increase linearly, and retrieval performance degrades as vector searches scan larger indexes. Healthcare regulations require specific retention minimums (often 6+ years for medical records) but also impose constraints on unnecessary data retention — keeping patient data longer than required increases privacy risk and storage costs. Memory lifecycle policies balance regulatory compliance, operational efficiency, and patient privacy.

| Lifecycle Stage | Trigger | Action | Compliance Rationale |
|-----------------|---------|--------|----------------------|
| Active retention | Patient has visits within 12 months | Retain all memories | Supports ongoing care continuity |
| Consolidation | No visits for 12-24 months | Compress episodic to semantic | Reduce storage while preserving patterns |
| Archive | No visits for 24+ months | Move to cold storage | Meet retention minimums at lower cost |
| Expunge | Patient request or end of retention period | Permanent deletion with audit log | HIPAA right-to-deletion compliance |

## Design tiered retention policies by patient activity

Active patients who visit regularly generate and benefit from detailed memories. The agent references recent consultations frequently, making high-granularity memory valuable. Inactive patients who haven't visited in months or years have memories that consume storage but rarely get retrieved. You implement tiered retention that adjusts memory detail based on patient activity patterns.

Tier 1 (Active - visits within 6 months): Retain all episodic and semantic memories at full detail. No compression or pruning. These patients benefit most from continuity, and the agent frequently retrieves their memories.

Tier 2 (Semi-active - visits between 6-24 months ago): Consolidate low-importance episodic memories into semantic summaries. Keep high-importance memories (clinical decisions, adverse reactions, critical preferences) at full detail. This reduces storage by 40-60% while preserving clinically significant information.

Tier 3 (Inactive - no visits for 24+ months): Archive to cold storage tiers with longer retrieval latency. If patient returns, restore memories to hot storage for that session. Most healthcare systems retain records for 6-7 years, so deletion isn't appropriate yet, but cold storage reduces cost by 80%.

Tier 4 (Retention expired): After the minimum retention period (typically 6-10 years depending on jurisdiction), memories become candidates for deletion unless the patient remains active or specific legal holds apply (ongoing litigation, research cohort, etc.).

```python
from datetime import datetime, timedelta
from azure.cosmos import CosmosClient
from azure.identity import DefaultAzureCredential

def calculate_retention_tier(last_visit_date: datetime) -> str:
    """Determine retention tier based on patient activity."""
    
    now = datetime.utcnow()
    months_inactive = (now - last_visit_date).days / 30.0
    
    if months_inactive < 6:
        return "active"
    elif months_inactive < 24:
        return "semi_active"
    elif months_inactive < 84:  # 7 years
        return "inactive"
    else:
        return "retention_expired"

def apply_retention_policy(patient_id: str, last_visit_date: datetime) -> None:
    """Apply appropriate retention actions based on patient tier."""
    
    tier = calculate_retention_tier(last_visit_date)
    
    if tier == "active":
        # No action needed - retain all memories
        print(f"Patient {patient_id}: Active tier, no retention actions")
        
    elif tier == "semi_active":
        # Consolidate low-importance episodic memories
        consolidate_low_importance_memories(patient_id)
        print(f"Patient {patient_id}: Semi-active tier, consolidated low-importance memories")
        
    elif tier == "inactive":
        # Archive to cold storage
        archive_patient_memories(patient_id)
        print(f"Patient {patient_id}: Inactive tier, archived to cold storage")
        
    elif tier == "retention_expired":
        # Flag for deletion review (requires manual approval for compliance)
        flag_for_deletion_review(patient_id)
        print(f"Patient {patient_id}: Retention expired, flagged for deletion review")
```

## Implement automated pruning by importance and age

Low-importance, old memories provide minimal value while consuming storage and slowing vector search. Automated pruning removes memories that fall below a combined threshold of importance and age. A memory with importance 3 (low) that's 18 months old provides less value than the storage it consumes and should be pruned.

The pruning algorithm calculates current importance (applying decay) and checks whether it falls below the threshold. You run pruning as a scheduled batch job (weekly or monthly) that queries for expired memories and deletes them in batches. The pruning job logs all deletions for compliance auditing.

Critical memories are exempt from pruning regardless of age: adverse drug reactions, allergies, major diagnoses, and documented refusals of treatment. These memories get tagged as `critical: true` during creation, and the pruning query explicitly filters them out.

At Northwind Health, a 2-year-old memory with importance 2 about a patient asking about vitamin D supplements gets pruned during the monthly batch job. But their documented penicillin allergy (tagged `critical: true`, importance 10) survives indefinitely — even though it's 4 years old and the patient hasn't visited in 18 months. The pruning system never discards safety-critical clinical information.

```python
def prune_expired_memories(patient_id: str, importance_threshold: float = 3.0) -> int:
    """Remove low-importance, old memories that no longer provide value."""
    
    # Query for memories below threshold (excluding critical memories)
    query = """
        SELECT c.id, c.importance, c.timestamp, c.memory_type, c.content
        FROM c
        WHERE c.patient_id = @patient_id
            AND (c.critical IS NOT defined OR c.critical = false)
    """
    
    container = get_memory_container()
    memories = list(container.query_items(
        query=query,
        parameters=[{"name": "@patient_id", "value": patient_id}],
        partition_key=patient_id
    ))
    
    pruned_count = 0
    pruning_log = []
    
    for mem in memories:
        current_importance = calculate_decayed_importance(mem)
        
        if current_importance < importance_threshold:
            # Delete memory
            container.delete_item(item=mem["id"], partition_key=patient_id)
            
            # Log pruning action for audit trail
            pruning_log.append({
                "patient_id": patient_id,
                "memory_id": mem["id"],
                "content_summary": mem["content"][:100],
                "importance_at_pruning": current_importance,
                "timestamp_pruned": datetime.utcnow().isoformat(),
                "reason": "below_importance_threshold"
            })
            
            pruned_count += 1
    
    # Write pruning log to audit container
    if pruning_log:
        audit_container = get_audit_container()
        for log_entry in pruning_log:
            audit_container.create_item(log_entry)
    
    return pruned_count

# Run as scheduled job
def scheduled_pruning_job():
    """Batch prune memories across all patients."""
    
    # Get all patient IDs with memories (would use continuation token for large datasets)
    query = "SELECT DISTINCT c.patient_id FROM c"
    patient_ids = [item["patient_id"] for item in container.query_items(query)]
    
    total_pruned = 0
    for patient_id in patient_ids:
        pruned = prune_expired_memories(patient_id, importance_threshold=3.0)
        total_pruned += pruned
    
    print(f"Pruning job complete: removed {total_pruned} memories across {len(patient_ids)} patients")
```

## Consolidate episodic memories into semantic patterns

Individual episodic memories ("Patient reported mild nausea on 2025-03-15," "Patient mentioned stomach discomfort on 2025-04-02") contain similar information across multiple visits. Rather than storing each instance separately, you consolidate them into a single semantic memory: "Patient experiences mild gastric side effects periodically." This consolidation preserves the pattern while reducing memory count by 70-80%.

Northwind Health's chronic care agent illustrates consolidation at scale. A diabetes patient has 7 episodic memories: three about morning blood sugar spikes, two about skipping evening insulin doses, and two about carb-counting confusion. Consolidation produces two semantic memories: "Patient has recurring morning hyperglycemia, potentially linked to inconsistent evening insulin adherence" and "Patient struggles with carbohydrate counting for meal-time dosing." Seven memories become two — clearer clinical patterns, lower storage cost, and faster context retrieval.

Consolidation identifies clusters of semantically similar memories within a patient's history, then uses an LLM to extract the common pattern or theme. The consolidated semantic memory replaces the original episodic memories, which are either deleted or archived depending on their individual importance.

You run consolidation as part of the semi-active tier retention policy. When a patient becomes semi-active (6-24 months since last visit), consolidation compresses their detailed episodic history into semantic patterns.

```python
def consolidate_similar_memories(patient_id: str, similarity_threshold: float = 0.85) -> int:
    """Find clusters of similar memories and consolidate them into semantic patterns."""
    
    # Retrieve all memories for patient
    query = "SELECT * FROM c WHERE c.patient_id = @patient_id AND c.doc_type = 'episodic'"
    memories = list(container.query_items(
        query=query,
        parameters=[{"name": "@patient_id", "value": patient_id}],
        partition_key=patient_id
    ))
    
    # Find clusters using embedding similarity
    clusters = find_memory_clusters(memories, similarity_threshold)
    
    consolidated_count = 0
    
    for cluster in clusters:
        if len(cluster) >= 3:  # Only consolidate if 3+ similar memories
            # Use LLM to extract pattern from cluster
            pattern = extract_pattern_from_memories(cluster)
            
            # Create consolidated semantic memory
            consolidated_memory = {
                "id": f"{patient_id}_consolidated_{datetime.utcnow().timestamp()}",
                "patient_id": patient_id,
                "content": pattern["statement"],
                "importance": max(mem["importance"] for mem in cluster),
                "memory_type": "semantic_consolidated",
                "doc_type": "semantic",
                "timestamp": datetime.utcnow().isoformat(),
                "consolidated_from": [mem["id"] for mem in cluster],
                "embedding": generate_embedding(pattern["statement"])
            }
            
            container.create_item(consolidated_memory)
            
            # Delete or archive original episodic memories
            for mem in cluster:
                container.delete_item(item=mem["id"], partition_key=patient_id)
            
            consolidated_count += len(cluster)
    
    return consolidated_count

def extract_pattern_from_memories(memories: list[dict]) -> dict:
    """Use LLM to extract common pattern from similar memories."""
    
    memory_texts = "\n".join(f"- {mem['content']}" for mem in memories)
    
    prompt = f"""Extract the common pattern or theme from these related patient observations:

{memory_texts}

Provide a single concise statement that captures the pattern across all observations.
Focus on what remains consistent, not specific dates or one-time details."""
    
    response = chat_client.complete(
        model="gpt-4o-mini",
        messages=[{"role": "user", "content": prompt}],
        temperature=0
    )
    
    return {"statement": response.choices[0].message.content.strip()}
```

## Unit summary

- **Tiered retention policies** apply different expiration rules based on patient activity — active patients retain memories longer than inactive ones, preventing useful context from being pruned prematurely.
- **Automated pruning** removes low-importance, old memories using scheduled batch jobs that evaluate both importance scores and age against configurable thresholds.
- **Memory consolidation** transforms multiple episodic memories into higher-level semantic patterns using LLM summarization — reducing storage and context window costs while preserving behavioral insights.
