Azure Cosmos DB's vector storage capabilities make it the right foundation for encoding clinical observations as semantic memories that agents retrieve by meaning rather than exact match. Not every agent interaction is worth storing—effective encoding policy filters routine exchanges and captures observations that contain new, useful information about the patient's condition, preferences, and care context.

> [!TIP]
> Store observations that reveal patient preferences ("prefers morning appointments"), clinical patterns ("experiences fatigue from this medication"), persistent concerns ("worried about side effects"), or care context ("caregiver is daughter"). Skip generic acknowledgments and routine process statements.

## Extract memorable observations from agent responses

After the agent generates a response, you analyze it to determine if it contains information worth encoding as a memory. A response recommending a medication contains memorable content: the medication name, the indication, the dosing discussed. A response confirming receipt of a document doesn't contain memorable content. You use a lightweight classifier or LLM prompt to make this determination.

The extraction prompt explicitly defines what constitutes a memorable observation. Rather than asking "What should be remembered?" you ask "What new information about the patient was revealed or discussed in this interaction?" This specificity produces focused memories that provide value in future sessions.

> [!NOTE]
> The `azure-ai-inference` package used in the code examples below is currently in public preview. Pin your package version in production deployments and check the [release notes](https://learn.microsoft.com/python/api/overview/azure/ai-inference-readme?view=azure-python-preview) before upgrading.

```python
from azure.ai.inference import ChatCompletionsClient, EmbeddingsClient
from azure.identity import DefaultAzureCredential
import os

chat_client = ChatCompletionsClient(
    endpoint=os.environ["AZURE_AI_SERVICES_ENDPOINT"],
    credential=DefaultAzureCredential(),
)

embed_client = EmbeddingsClient(
    endpoint=os.environ["AZURE_AI_SERVICES_ENDPOINT"],
    credential=DefaultAzureCredential(),
)

memory_extraction_prompt = """Analyze this conversation interaction and extract observations worth remembering for future sessions with this patient.

Conversation Context:
{conversation_history}

Recent Agent Response:
{agent_response}

Extract 0-3 memorable observations that meet these criteria:
- Reveals patient preferences, concerns, or care needs
- Documents clinical patterns or responses to treatment
- Records decisions made or plans established
- Contains information relevant for future interactions

For each observation, provide:
1. A concise statement (1-2 sentences)
2. An importance score (1-10, where 10 is critical clinical information)
3. The observation type (preference, clinical_pattern, concern, decision, or context)

Output as JSON:
{{
  "observations": [
    {{"statement": "...", "importance": 8, "type": "clinical_pattern"}},
    {{"statement": "...", "importance": 6, "type": "preference"}}
  ]
}}

If nothing memorable was discussed, return: {{"observations": []}}"""

def extract_memories(conversation_history: str, agent_response: str) -> list[dict]:
    """Extract memorable observations from an agent interaction."""
    
    response = chat_client.complete(
        model="gpt-4o-mini",
        messages=[
            {"role": "user", "content": memory_extraction_prompt.format(
                conversation_history=conversation_history,
                agent_response=agent_response
            )}
        ],
        temperature=0,
        response_format={"type": "json_object"}
    )
    
    import json
    result = json.loads(response.choices[0].message.content)
    return result["observations"]
```

## Store memories in Azure Cosmos DB with vector embeddings

Each extracted observation becomes a memory document in Azure Cosmos DB. You store the memory text, metadata (patient ID, timestamp, importance score, memory type), and a vector embedding of the content. The embedding enables semantic similarity retrieval in future sessions.

> [!IMPORTANT]
> Before creating a container with vector search, you must first enable the Vector Search feature on your Azure Cosmos DB for NoSQL account. In the Azure portal, go to your Cosmos DB account → **Settings** → **Features** → **Vector Search for NoSQL API** → **Enable**. Alternatively, use the Azure CLI: `az cosmosdb update --resource-group <rg> --name <account> --capabilities EnableNoSQLVectorSearch`. Allow up to 15 minutes for the registration to take effect. Vector embedding policies and vector indexes can only be configured at container *creation* time—they cannot be added to existing containers.

Azure Cosmos DB for NoSQL supports vector search through the vector indexing and query capabilities. You create a container configured with vector indexing on the embedding field, then insert memory documents with both text content and embeddings. The patient ID serves as the partition key, ensuring queries remain isolated to authorized patients.

```python
from azure.cosmos import CosmosClient, PartitionKey
from azure.identity import DefaultAzureCredential
from datetime import datetime

# Initialize Cosmos DB client
cosmos_client = CosmosClient(
    url="https://<your-cosmosdb-account>.documents.azure.com:443/",
    credential=DefaultAzureCredential()
)

database = cosmos_client.get_database_client("clinical-memory-db")
container = database.get_container_client("patient-memories")

def store_memory(patient_id: str, observation: dict) -> None:
    """Store a memory observation in Cosmos DB with vector embedding."""
    
    # Generate embedding for the observation
    embedding_response = embed_client.embed(
        input=[observation["statement"]],
        model=os.environ["EMBEDDING_MODEL_DEPLOYMENT_NAME"]
    )
    embedding_vector = embedding_response.data[0].embedding
    
    # Create memory document
    memory_doc = {
        "id": f"{patient_id}_{datetime.utcnow().timestamp()}",
        "patient_id": patient_id,  # Partition key for isolation
        "content": observation["statement"],
        "importance": observation["importance"],
        "memory_type": observation["type"],
        "timestamp": datetime.utcnow().isoformat(),
        "embedding": embedding_vector,
        "access_count": 0,  # Track how often this memory is retrieved
        "last_accessed": None
    }
    
    container.upsert_item(memory_doc)
    print(f"Stored memory: {observation['statement'][:50]}...")

# Example: Store memories after extracting them
observations = extract_memories(conversation_history, agent_response)
for obs in observations:
    store_memory(patient_id="patient-12345", observation=obs)
```

## Retrieve semantically relevant memories at session start

When starting a new consultation session, you query Cosmos DB for memories semantically similar to the current context. You embed the initial query or session description, then use vector search to find memories with similar embeddings. This retrieval surfaces relevant past observations even when they use different terminology than the current session.

Azure Cosmos DB's vector search uses the `VectorDistance` function in queries to calculate cosine similarity between the query embedding and stored memory embeddings. You specify a similarity threshold (typically 0.7 or higher) to filter for genuinely relevant memories, avoiding low-quality matches.

```python
def retrieve_relevant_memories(patient_id: str, session_context: str, top_k: int = 10) -> list[dict]:
    """Retrieve semantically similar memories for the current session."""
    
    # Generate embedding for session context
    context_embedding = embed_client.embed(
        input=[session_context],
        model=os.environ["EMBEDDING_MODEL_DEPLOYMENT_NAME"]
    ).data[0].embedding
    
    # Query Cosmos DB using vector search
    query = """
        SELECT TOP @top_k 
            c.id,
            c.content, 
            c.importance, 
            c.memory_type, 
            c.timestamp,
            c.access_count,
            VectorDistance(c.embedding, @query_embedding) AS similarity_score
        FROM c
        WHERE c.patient_id = @patient_id
            AND VectorDistance(c.embedding, @query_embedding) > 0.7
        ORDER BY VectorDistance(c.embedding, @query_embedding) DESC
    """
    
    parameters = [
        {"name": "@patient_id", "value": patient_id},
        {"name": "@query_embedding", "value": context_embedding},
        {"name": "@top_k", "value": top_k}
    ]
    
    items = list(container.query_items(
        query=query,
        parameters=parameters,
        partition_key=patient_id
    ))
    
    # Update access tracking for retrieved memories
    for item in items:
        item["access_count"] += 1
        item["last_accessed"] = datetime.utcnow().isoformat()
        container.upsert_item(item)
    
    return items

# Example: Retrieve memories at session start
session_context = "Patient returning for diabetes follow-up after starting metformin"
relevant_memories = retrieve_relevant_memories(
    patient_id="patient-12345",
    session_context=session_context,
    top_k=5
)

for mem in relevant_memories:
    print(f"[{mem['memory_type']}] {mem['content']} (importance: {mem['importance']}, similarity: {mem['similarity_score']:.3f})")
```

## Key takeaways

- **Memory extraction** identifies memorable observations from agent responses—track patient preferences, clinical concerns, and behavioral patterns rather than storing every interaction verbatim.
- **Vector storage in Cosmos DB** uses the `vector_embedding` container policy with HNSW indexing and cosine similarity to enable semantic retrieval of memories.
- **Semantic retrieval** at session start finds relevant memories based on meaning, not keywords—a query about "blood sugar concerns" retrieves a memory about "glucose monitoring anxiety" even without shared terms.
- **Patient-scoped partitioning** uses `patient_id` as the partition key, ensuring all memory queries are physically isolated to a single patient's data.
