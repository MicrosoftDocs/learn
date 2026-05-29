Azure Cosmos DB's partition key design enforces patient data isolation at the storage level, preventing cross-patient memory access even when application code passes incorrect identifiers. This unit covers how to configure patient-scoped memory operations, implement session-bound access controls, and maintain the audit trail that HIPAA compliance requires.

## Enforce patient data isolation and access controls

Every memory query must be scoped to a single authorized patient. Azure Cosmos DB's partition key strategy enforces this isolation at the database level. By using patient_id as the partition key, queries physically cannot span patients without explicitly changing the partition key parameter.

You implement application-level access controls that validate the patient_id in every memory operation matches the patient_id in the authenticated session context. An agent session for patient-12345 cannot retrieve or modify memories for patient-67890, even if a bug passes the wrong patient_id to a query.

Session management includes patient scope validation: when a clinical session starts, you authenticate which patient's records the clinician is authorized to access, then bind that patient_id to the session. Every memory operation during that session includes the session-bound patient_id, preventing cross-patient data leakage.

This guard prevents real clinical harm. If a Northwind Health nurse practitioner reviewing patient-12345's diabetes management accidentally copies patient-67890's ID into a tool call, the `PatientMemoryService` rejects the operation immediately. Without this guard, the agent would inject patient-67890's medication history (potentially including sensitive behavioral health notes) into the wrong patient's consultation — creating both a HIPAA violation and a clinical safety risk.

```python
class PatientMemoryService:
    """Service layer enforcing patient isolation for all memory operations."""
    
    def __init__(self, cosmos_client: CosmosClient, session_patient_id: str):
        self.container = cosmos_client.get_database_client("clinical-memory-db").get_container_client("patient-memories")
        self.session_patient_id = session_patient_id
    
    def _validate_patient_access(self, patient_id: str) -> None:
        """Ensure requested patient matches session authorization."""
        if patient_id != self.session_patient_id:
            raise PermissionError(f"Session not authorized for patient {patient_id}")
    
    def retrieve_memories(self, patient_id: str, query_context: str) -> list[dict]:
        """Retrieve memories with patient isolation enforced."""
        self._validate_patient_access(patient_id)
        
        query_embedding = generate_embedding(query_context)
        
        query = """
            SELECT * FROM c
            WHERE c.patient_id = @patient_id
                AND VectorDistance(c.embedding, @embedding) > 0.7
            ORDER BY VectorDistance(c.embedding, @embedding) DESC
        """
        
        return list(self.container.query_items(
            query=query,
            parameters=[
                {"name": "@patient_id", "value": patient_id},
                {"name": "@embedding", "value": query_embedding}
            ],
            partition_key=patient_id  # Enforces isolation at database level
        ))
    
    def store_memory(self, patient_id: str, memory_data: dict) -> None:
        """Store memory with patient isolation enforced."""
        self._validate_patient_access(patient_id)
        
        memory_data["patient_id"] = patient_id
        self.container.create_item(memory_data)
    
    def delete_patient_memories(self, patient_id: str) -> None:
        """Delete all memories for a patient (compliance/right-to-deletion)."""
        self._validate_patient_access(patient_id)
        
        # Query all memories for patient
        query = "SELECT c.id FROM c WHERE c.patient_id = @patient_id"
        memories = list(self.container.query_items(
            query=query,
            parameters=[{"name": "@patient_id", "value": patient_id}],
            partition_key=patient_id
        ))
        
        # Delete all memories
        for mem in memories:
            self.container.delete_item(item=mem["id"], partition_key=patient_id)
        
        # Log deletion for compliance audit
        log_patient_data_deletion(patient_id, f"Deleted {len(memories)} memories")
```

## Audit memory access for regulatory compliance

HIPAA and similar healthcare regulations require comprehensive audit trails of who accessed patient data, when, and for what purpose. Every memory retrieval, creation, update, or deletion must be logged with sufficient detail to reconstruct the event during compliance audits or privacy investigations.

Audit logs capture: timestamp, user/agent identifier, patient_id, operation type (read/write/delete), which memories were accessed (by ID), and the session context explaining why access occurred. These logs persist separately from the memories themselves with longer retention periods (typically 7-10 years vs. 6 years for clinical records).

During Northwind Health's annual HIPAA audit, the compliance team queries the audit container: "Show all memory retrievals for patient-12345 during Q1 2026." The audit trail reveals 47 memory retrievals across 12 clinical sessions, each logged with the clinician's identity, the session context, and which specific memories were accessed — demonstrating to auditors exactly who saw what patient data and why.

You implement audit logging as middleware that intercepts all memory operations before executing them. The middleware writes audit entries to a dedicated Cosmos DB container configured with higher retention settings.

```python
def audit_memory_access(
    operation: str,
    patient_id: str,
    user_id: str,
    memory_ids: list[str],
    session_context: str
) -> None:
    """Log memory access for compliance auditing."""
    
    audit_entry = {
        "id": f"audit_{datetime.utcnow().timestamp()}",
        "timestamp": datetime.utcnow().isoformat(),
        "operation": operation,  # retrieve, store, update, delete
        "patient_id": patient_id,
        "user_id": user_id,
        "memory_ids": memory_ids,
        "session_context": session_context,
        "ip_address": get_client_ip(),
        "agent_version": get_agent_version()
    }
    
    audit_container = get_audit_container()
    audit_container.create_item(audit_entry)

# Example: Audit a memory retrieval operation
def retrieve_memories_with_audit(patient_id: str, user_id: str, context: str) -> list[dict]:
    """Retrieve memories and log the access."""
    
    memories = retrieve_relevant_memories(patient_id, context)
    memory_ids = [mem["id"] for mem in memories]
    
    audit_memory_access(
        operation="retrieve",
        patient_id=patient_id,
        user_id=user_id,
        memory_ids=memory_ids,
        session_context=context
    )
    
    return memories
```

Now that you've designed comprehensive memory privacy controls and audit compliance, you're ready to integrate all these techniques in a hands-on exercise where you build a complete patient memory system for Northwind Health's clinical agents.

## Key takeaways

- **Patient data isolation** uses Cosmos DB's partition key strategy (`patient_id`) to physically prevent cross-patient queries, combined with application-level session-bound access validation.
- **Right-to-deletion** support enables complete removal of a patient's memories with audit logging, satisfying HIPAA compliance requirements.
- **Comprehensive audit trails** log every memory operation (retrieve, store, update, delete) with sufficient detail to reconstruct events during compliance investigations, persisting with 7-10 year retention.
- **Audit middleware** intercepts all memory operations before execution, ensuring no access goes unlogged regardless of which code path triggered the operation.
