Azure Cosmos DB supports all three memory tiers that clinical agents use—working, episodic, and semantic—each with different storage, query, and retention characteristics. Selecting the right tier for each type of clinical information determines retrieval performance, storage cost, and compliance posture.

| Memory Type | Retention Period | Query Pattern | Storage Approach | Clinical Example |
|-------------|------------------|---------------|------------------|------------------|
| Working (short-term) | Current session only | Sequential access | In-memory or cache | Recent messages in active conversation |
| Episodic (medium-term) | Weeks to months | Exact match, time-based | Document database | "What was discussed on March 15?" |
| Semantic (long-term) | Months to years | Similarity search | Vector database | "Previous concerns about side effects" |

## Understand working memory for active conversations

Working memory holds the current conversation context—the system prompt, recent messages, retrieved documents, and tool results. This content must be immediately available with submillisecond access times because the agent references it for every response. The context window size limits working memory capacity: GPT-4o supports 128K tokens, but filling the entire window becomes expensive and slows response generation.

When you use the Foundry Responses API in **stateless mode** (`client.agents.responses.create()`), your application owns working memory entirely. Every call must include the full conversation history you want the agent to see—the runtime doesn't accumulate history between calls. Stateless mode is the most common pattern for clinical agents, because the application retains explicit control over every piece of context the agent sees. You build working memory from three sources: recent conversation turns (kept in application memory or Redis), retrieved episodic memories injected as context, and retrieved semantic memories summarized at session start.

When you use **server-managed Conversations** (`client.agents.conversations.*`), the runtime automatically accumulates conversation items during the session. Working memory management shifts from "what do I inject each call?" to "when do I start a new conversation to avoid context overflow?" You still implement the episodic and semantic memory tiers externally, but session-scope history is handled for you.

The primary architectural decision for working memory is size management. Once conversation history grows beyond your target context window utilization (perhaps 60% of maximum), you implement truncation strategies: keeping only the most recent N messages, summarizing older messages into a compressed representation, or moving older messages to episodic memory while removing them from working memory.

Working memory doesn't require complex persistence infrastructure because it only exists during active sessions. Your focus is on what content enters working memory and when to remove content to prevent context window overflow.

## Understand episodic memory for specific interaction records

Episodic memory stores records of specific past interactions: what was discussed, what decisions were made, what information was provided. Unlike working memory's focus on the active conversation, episodic memory preserves historical interactions for later exact retrieval. When a patient returns and asks "What medication did we decide to try last month?" the agent queries episodic memory for the specific consultation record.

You store episodic memory in structured document databases like Azure Cosmos DB using the NoSQL API. Each consultation becomes a document with fields for patient ID, timestamp, conversation summary, key decisions, medications discussed, and follow-up plans. Queries use exact matching: retrieve all consultations for this patient, retrieve the consultation from a specific date, or retrieve consultations mentioning a specific medication.

Episodic memory provides audit trails and enables agents to reference specific past events. Healthcare regulations require maintaining records of clinical interactions, making episodic memory a compliance requirement as well as a functional one. The structured format supports compliance reporting: "Show all consultations where warfarin was prescribed" or "Show follow-up rate for diabetes management consultations."

The architectural consideration is retention duration. Episodic memories consume storage indefinitely unless you implement retention policies. For active patients, retain all consultation records. For inactive patients (no visits in 12+ months), you might summarize episodic memories into semantic memories and archive the detailed records to cheaper storage tiers.

## Understand semantic memory for pattern recognition and personalization

Semantic memory stores generalized knowledge extracted from many interactions: patient preferences, recurring concerns, effectiveness of previous interventions, and behavioral patterns. Unlike episodic memory's "what happened on date X" focus, semantic memory answers "what patterns exist across all interactions with this patient?" A semantic memory might state "Patient prefers written summaries over verbal explanations" or "Patient experiences anxiety about new medications"—knowledge that applies across multiple sessions.

You implement semantic memory using vector databases that enable similarity-based retrieval. Each memory has a text description and a corresponding embedding vector. When starting a new session, you retrieve semantically similar memories by comparing the current query or session context against stored memory vectors. Memories about "medication side effects" surface when the current conversation involves "drug adverse reactions," even if exact terms differ.

Semantic memory provides the agent with continuity and personalization. Rather than treating each session as independent, the agent recalls relevant context: "I remember you mentioned difficulty swallowing pills—let me suggest liquid or dissolvable alternatives." This continuity improves patient satisfaction and care quality by making interactions feel coherent and personalized.

The architectural decision is scope: global semantic memory shared across all patients would enable population-level learning ("most patients on this medication report fatigue in week 2"), but creates privacy risks and requires careful de-identification. Patient-specific semantic memory keeps data isolated and complies with privacy requirements but doesn't benefit from aggregate patterns. Most clinical applications use patient-specific semantic memory with aggregation only for de-identified quality improvement.

## Select memory architecture for different agent types

A clinical documentation agent that simply records what clinicians dictate needs only working memory—conversations are linear, single-session recordings with no need for historical context. A medication review agent needs episodic memory to recall previous medications tried and semantic memory to recognize patterns in side effects or adherence. A diagnostic support agent needs semantic memory containing clinical patterns observed across many cases plus episodic memory of this specific patient's presentation timeline.

| Agent Type | Working Memory | Episodic Memory | Semantic Memory | Rationale |
|------------|----------------|-----------------|-----------------|-----------|
| Documentation assistant | Required | Optional | Not needed | Records single session, minimal context needed |
| Medication review | Required | Required | Required | Needs past prescriptions and adherence patterns |
| Appointment scheduling | Required | Required | Optional | Needs past appointments but pattern recognition less critical |
| Diagnostic support | Required | Required | Required | Needs symptom timeline and pattern recognition |

You evaluate memory needs by analyzing your agent's typical conversations. Does the agent need to reference specific past events? Episodic memory. Does the agent benefit from recognizing patterns across sessions? Semantic memory. Does the agent work in isolated single-shot interactions? Working memory only. Answer these questions during design to avoid over-engineering memory systems for agents that don't need them.

## Design memory with privacy and compliance requirements

Patient memory data is Protected Health Information (PHI) under HIPAA and similar healthcare privacy regulations. Every design decision must consider privacy implications. Storing memories requires encryption at rest using Azure Cosmos DB's customer-managed keys. Accessing memories requires authentication and authorization ensuring only authorized clinical staff access patient data. Retaining memories requires compliance with regulatory minimum retention periods (often 6+ years) but also maximum retention policies that limit risk.

You implement per-patient partitioning in Azure Cosmos DB using patient ID as the partition key. This ensures queries never accidentally span patients without explicit authorization. Every memory retrieval operation includes the patient ID from the authenticated session context, preventing unauthorized cross-patient access.

Audit logging tracks every memory access: which agent, which session, what memories were retrieved, and what they were used for. These logs provide the audit trail needed to demonstrate compliance and investigate potential privacy breaches. You retain audit logs longer than the memories themselves—typically 7+ years for healthcare compliance.

Right-to-deletion compliance requires the ability to expunge all patient data on request. Your memory architecture must support complete patient data deletion: all working memory records, all episodic memories, all semantic memories, and all derived embeddings. You implement deletion as a cascading operation that removes all data associated with a patient ID, then verifies completeness through compliance validation queries.

Now that you understand the taxonomy of memory types and architectural patterns for different agent requirements, you're ready to implement semantic memory using Azure Cosmos DB's vector search capabilities to enable concept-based memory retrieval.

## Key takeaways

- **Working memory** holds active conversation context and disappears when the session ends—it's sufficient for single-turn interactions but insufficient for continuity.
- **Episodic memory** stores specific interaction records that persist across sessions, enabling agents to recall what happened in prior encounters.
- **Semantic memory** extracts patterns and generalizations from multiple episodes, supporting personalization without storing every detail.
- **Memory architecture selection** depends on agent function: routing agents need minimal memory, specialist agents need episodic recall, and personalization agents need all three tiers.
- **Privacy and compliance** must be designed into the architecture upfront—partition keys, access controls, and right-to-deletion support can't be retrofitted.
