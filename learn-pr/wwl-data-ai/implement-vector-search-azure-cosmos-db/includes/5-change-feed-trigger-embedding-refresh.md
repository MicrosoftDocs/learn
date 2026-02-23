AI applications need to keep embeddings synchronized with current content—stale embeddings return irrelevant search results when the underlying documents change. The Azure Cosmos DB change feed provides a reliable mechanism to detect document changes and trigger embedding regeneration without polling or manual synchronization, enabling reactive architectures that keep your vector search results accurate as content evolves.

## Understand the change feed

The change feed is a persistent, ordered log of all inserts and updates to a container. When a document is created or modified, the change appears in the feed in the order the modification occurred. Applications subscribe to the feed and process changes as they happen, enabling event-driven architectures where embedding updates occur automatically when source documents change.

Key characteristics of the change feed make it well-suited for embedding synchronization:

- **Persistent record:** Changes are retained and can be processed even if your application was offline when the change occurred
- **Ordered delivery:** Changes within a partition key arrive in modification order
- **Exactly-once opportunity:** Each change appears exactly once in the feed, though consumers must handle their own checkpointing
- **Automatic enablement:** The change feed is enabled by default on all containers with no other configuration

For the support knowledge base, when a support engineer updates a troubleshooting guide, the change feed captures that modification. Your embedding refresh process detects the change, regenerates the embedding using the updated content, and writes the new embedding back to the document. This process keeps search results accurate without manual intervention.

## Choose between push and pull models

Azure Cosmos DB offers two approaches for consuming the change feed. The push model automatically delivers changes to your processing code, while the pull model requires your code to poll for changes.

**Push model benefits:**
- Automatic delivery of changes without polling
- Built-in partition management and load balancing across multiple instances
- Automatic checkpointing to track processing progress
- Simpler implementation with less boilerplate code
- Better suited for continuous processing scenarios

**Pull model benefits:**
- More control over when and how changes are processed
- Lower resource consumption for batch or infrequent processing
- No external dependencies on other containers or services
- Useful for one-time migrations or batch refreshes

For embedding refresh in production AI applications, the push model provides better reliability and simpler operations. Use Azure Functions or the change feed processor library to implement push-based change consumption.

## Use Azure Functions for change feed processing

Azure Functions provides the simplest integration with the change feed. The Cosmos DB trigger automatically invokes your function when documents change, handles partition management, and maintains checkpoints to track processing progress.

The following Python function regenerates embeddings when documents change in the knowledge base container:

```python
import azure.functions as func
from openai import AzureOpenAI
from azure.cosmos import CosmosClient
import os

app = func.FunctionApp()

@app.cosmos_db_trigger(
    arg_name="documents",
    container_name="knowledge-base",
    database_name="support-db",
    connection="CosmosDBConnection",
    lease_container_name="leases",
    create_lease_container_if_not_exists=True
)
def refresh_embeddings(documents: func.DocumentList):
    if not documents:
        return

    # Initialize clients
    openai_client = AzureOpenAI(
        api_key=os.environ["OPENAI_API_KEY"],
        api_version="2024-02-01",
        azure_endpoint=os.environ["OPENAI_ENDPOINT"]
    )

    cosmos_client = CosmosClient.from_connection_string(
        os.environ["CosmosDBConnection"]
    )
    container = cosmos_client.get_database_client("support-db").get_container_client("knowledge-base")

    for doc in documents:
        # Check if content that affects embeddings changed
        if should_refresh_embedding(doc):
            # Generate new embedding from updated content
            text_content = f"{doc.get('title', '')} {doc.get('content', '')}"

            response = openai_client.embeddings.create(
                input=text_content,
                model="text-embedding-ada-002"
            )

            # Update document with new embedding
            doc["embedding"] = response.data[0].embedding
            container.upsert_item(doc)

def should_refresh_embedding(doc):
    """Determine if the document needs a new embedding."""
    # Always refresh if no embedding exists
    if "embedding" not in doc or doc["embedding"] is None:
        return True

    # Check for content-related fields that affect embeddings
    # In a full implementation, compare against the previous version
    return True
```

The trigger configuration specifies the container to monitor (`knowledge-base`), the database (`support-db`), and a lease container (`leases`) for tracking processing progress. The `create_lease_container_if_not_exists` option automatically creates the lease container if needed.

## Understand the lease container

The change feed processor (used by Azure Functions triggers) requires a separate container to store leases. Leases track which partitions each processor instance owns and the processing checkpoint for each partition. This mechanism enables several important capabilities:

- **Checkpointing:** If processing fails or restarts, it resumes from the last checkpoint rather than reprocessing all changes
- **Coordination:** Multiple processor instances divide partitions among themselves, enabling horizontal scaling
- **Failover:** If an instance fails, other instances acquire its leases and continue processing

The lease container has minimal storage and throughput requirements. A small container with 400 RU/s is typically sufficient unless you're processing high change volumes.

When deploying Azure Functions, ensure the lease container has a different name than your data containers. Multiple functions monitoring the same data container can share a lease container if they use different `leaseContainerPrefix` values, or they can use separate lease containers.

## Implement selective embedding refresh

Regenerating embeddings for every document change is expensive because embedding API calls cost money and have rate limits. You can implement selective refresh logic to update embeddings only when the content that affects semantic search has changed.

The following approach compares document versions to determine whether embedding refresh is needed:

```python
def should_refresh_embedding(current_doc, previous_doc=None):
    """
    Determine if document changes require new embeddings.
    Returns True if content affecting embeddings has changed.
    """
    # New document always needs embedding
    if previous_doc is None:
        return "embedding" not in current_doc

    # Check fields that contribute to the embedding
    content_fields = ["title", "content", "description", "summary"]

    for field in content_fields:
        current_value = current_doc.get(field, "")
        previous_value = previous_doc.get(field, "")

        if current_value != previous_value:
            return True

    # Metadata-only changes don't need new embeddings
    # Examples: category changes, status updates, access permission changes
    return False
```

In production, you might store a hash of the content used to generate the embedding, enabling efficient comparison without retrieving previous versions:

```python
import hashlib

def compute_content_hash(doc):
    """Compute hash of content used for embedding generation."""
    text_content = f"{doc.get('title', '')} {doc.get('content', '')}"
    return hashlib.sha256(text_content.encode()).hexdigest()

def should_refresh_embedding(doc):
    """Check if content hash changed since last embedding."""
    current_hash = compute_content_hash(doc)
    stored_hash = doc.get("contentHash", "")

    return current_hash != stored_hash
```

When regenerating the embedding, update the content hash in the same operation so future comparisons work correctly.

## Handle high-volume changes

Applications with frequent document updates need strategies to manage embedding API throughput and costs. Consider these approaches for high-volume scenarios:

**Batch API calls:** Group multiple texts into a single embedding API call where the API supports batching. Azure OpenAI accepts arrays of input texts, generating embeddings for all in one request with lower per-item overhead.

```python
# Batch multiple texts in a single API call
texts_to_embed = [doc.get("content", "") for doc in batch_documents]

response = openai_client.embeddings.create(
    input=texts_to_embed,
    model="text-embedding-ada-002"
)

for i, doc in enumerate(batch_documents):
    doc["embedding"] = response.data[i].embedding
```

**Rate limiting and backoff:** Implement retry logic with exponential backoff when hitting API rate limits. Azure Functions handles some retry scenarios automatically, but explicit backoff for embedding API calls ensures graceful handling of quota exhaustion.

**Queue-based processing:** For high volumes, write change events to Azure Queue Storage and process them with a separate function. This decouples change detection from embedding generation, allowing independent scaling and providing buffer capacity during traffic spikes.

**Prioritized refresh:** Process high-priority documents (like active troubleshooting guides) before lower-priority content (like archived documentation). Implement priority queues or separate processing paths for different content types.

## Use the pull model with Python SDK

When Azure Functions isn't suitable (for example, in batch processing scenarios or when you need more control), you can use the pull model to read changes directly using the SDK. The Python SDK supports reading the change feed through the `query_items_change_feed` method.

```python
from azure.cosmos import CosmosClient

cosmos_client = CosmosClient(endpoint, credential)
container = cosmos_client.get_database_client("support-db").get_container_client("knowledge-base")

def process_change_feed_batch():
    """Process a batch of changes using the pull model."""

    # Read changes from the beginning or from a continuation token
    change_feed_iterator = container.query_items_change_feed(
        start_time="Beginning"  # Or use a stored continuation token
    )

    continuation_token = None

    for page in change_feed_iterator.by_page():
        for change in page:
            if should_refresh_embedding(change):
                new_embedding = generate_embedding(change.get("content", ""))
                change["embedding"] = new_embedding
                change["contentHash"] = compute_content_hash(change)
                container.upsert_item(change)

        # Store continuation token for next batch
        continuation_token = change_feed_iterator.continuation_token

    # Save continuation_token for next run
    return continuation_token
```

The continuation token preserves your position in the change feed between runs. You can store it persistently (in a database or configuration store) to ensure you don't reprocess changes or miss updates.

## Handle errors and ensure idempotency

Change feed processing might deliver the same change multiple times in certain failure scenarios. Your processing logic must be idempotent—applying the same change twice should produce the same result as applying it once.

For embedding refresh, idempotency is straightforward: regenerating an embedding from the same content produces the same (or functionally equivalent) result. However, ensure your logic handles edge cases:

- **Document deleted before processing:** The change feed captures the change, but the document might be deleted before your function processes it. Handle `NOT_FOUND` errors gracefully.
- **Concurrent updates:** While processing a change, the same document might be updated again. Use optimistic concurrency with ETags if strict consistency is required.
- **API failures:** If embedding generation fails, the change might be retried. Implement appropriate retry logic and consider dead-letter queues for repeatedly failing documents.

```python
from azure.cosmos.exceptions import CosmosResourceNotFoundError

def process_document_change(doc, container, openai_client):
    """Process a single document change with error handling."""
    try:
        if should_refresh_embedding(doc):
            text_content = f"{doc.get('title', '')} {doc.get('content', '')}"

            response = openai_client.embeddings.create(
                input=text_content,
                model="text-embedding-ada-002"
            )

            doc["embedding"] = response.data[0].embedding
            doc["contentHash"] = compute_content_hash(doc)
            container.upsert_item(doc)

    except CosmosResourceNotFoundError:
        # Document was deleted, skip processing
        pass
    except Exception as e:
        # Log error and potentially write to dead-letter queue
        logging.error(f"Failed to process document {doc.get('id')}: {e}")
        raise  # Re-raise to trigger retry
```

## Scale change feed processing

When change volumes exceed what a single processor instance can handle, deploy multiple instances to parallelize processing. The change feed processor automatically distributes partitions across available instances.

For Azure Functions, scale is managed automatically—the Functions runtime spawns additional instances based on the change backlog. You can monitor the `ChangeFeedProcessorHostLag` metric to ensure processing keeps pace with changes.

For applications using the change feed processor library directly, deploy multiple instances of your application. Each instance registers with the same lease container, and the processor distributes partitions automatically. You can add instances when lag increases and remove instances when processing catches up.

## Additional resources

- [Change feed in Azure Cosmos DB](/azure/cosmos-db/change-feed)
- [Change feed processor in Azure Cosmos DB](/azure/cosmos-db/change-feed-processor)
- [Azure Functions Cosmos DB trigger](/azure/azure-functions/functions-bindings-cosmosdb-v2-trigger)
