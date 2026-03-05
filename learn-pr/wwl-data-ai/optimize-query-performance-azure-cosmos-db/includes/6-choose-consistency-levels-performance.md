Azure Cosmos DB's consistency levels control the trade-off between data freshness, latency, throughput, and availability. AI applications have diverse consistency requirements. Some need immediate visibility of uploaded content while others can tolerate brief delays in exchange for higher throughput and lower costs. Understanding consistency levels helps you select the appropriate level for different parts of your AI application.

## Understand the five consistency levels

Azure Cosmos DB offers five consistency levels that form a spectrum from strongest to weakest guarantees. Each level provides specific guarantees about when reads reflect committed writes.

### Strong consistency

Strong consistency offers linearizability, meaning reads always return the most recent committed write. When a client writes data to one region, a subsequent read from any region returns that value. This guarantee requires global majority consensus before confirming writes, which increases write latency for multi-region accounts.

**When to use:**
- Financial or transactional systems requiring absolute accuracy
- Scenarios where stale data causes incorrect decisions
- Applications with strict regulatory compliance requirements

**Trade-offs:**
- Higher write latency, especially for accounts spanning multiple regions
- Not supported with multiple write regions
- Reads consume twice the RUs of weaker consistency levels because they read from two replicas

### Bounded staleness consistency

Bounded staleness guarantees that reads lag behind writes by at most K versions (updates) or T seconds, whichever is reached first. This level provides near-strong consistency with more predictable latency than strong consistency.

**When to use:**
- Single-region write accounts that need cross-region consistency guarantees
- Scenarios where brief staleness is acceptable but data should converge quickly

**Trade-offs:**
- Still requires reading from two replicas, consuming more RUs than weaker levels
- Not recommended for multi-region write accounts because staleness depends on replication lag between regions

### Session consistency

Session consistency guarantees that within a single client session, reads always reflect that session's writes. This "read-your-writes" guarantee uses session tokens to track the client's position in the write stream. Session consistency is the most popular choice for applications because it balances performance with practical consistency needs.

**When to use:**
- Most application scenarios, especially user-facing applications
- AI applications where users expect to see their uploaded content immediately
- Applications where a single user or service account performs related operations

**Trade-offs:**
- Requires maintaining and passing session tokens across requests
- Other sessions might see stale data until replication completes
- Reads consume single-replica RU costs

### Consistent prefix consistency

Consistent prefix guarantees that reads never see out-of-order writes. If writes occur in order A, B, C, reads see either nothing, A, A-B, or A-B-C—never B without A or C without B. Transactional batches are visible together or not at all.

**When to use:**
- Scenarios where write order matters but absolute freshness doesn't
- Applications reading sequences of updates (audit logs, event streams)

**Trade-offs:**
- Reads might return stale data
- Provides ordering guarantees without freshness guarantees

### Eventual consistency

Eventual consistency provides the weakest guarantee—reads might return stale data with no ordering promises. However, this level offers the highest availability, throughput, and lowest latency because reads use a single replica without coordination.

**When to use:**
- Analytics and reporting workloads
- Background processing that doesn't require fresh data
- High-throughput scenarios where absolute freshness isn't critical

**Trade-offs:**
- Reads might return older values
- No guarantee about read order relative to writes

## Apply session consistency to AI applications

Session consistency suits most AI applications because it provides the read-your-writes guarantee that users expect. When a user uploads a document and immediately searches for it, session consistency ensures the document appears in search results—as long as the search request includes the session token from the upload operation.

Session tokens are partition-bound, meaning each token tracks position within a specific partition. The SDK manages session tokens automatically within a client instance. For distributed applications where multiple services handle different parts of a user request, you must pass session tokens explicitly.

The following example shows configuring session consistency at the client level:

```python
from azure.cosmos import CosmosClient, ConsistencyLevel

client = CosmosClient(
    url=endpoint,
    credential=credential,
    consistency_level=ConsistencyLevel.Session
)

database = client.get_database_client("documents-db")
container = database.get_container_client("documents")

# Write a document and capture the session token using response_hook
session_info = {}

def capture_session_token(headers, result):
    session_info["token"] = headers.get("x-ms-session-token", "")

container.create_item(
    body={
        "id": "doc-123",
        "title": "Project Proposal",
        "content": "Document content...",
        "category": "proposals"
    },
    response_hook=capture_session_token
)

# Use the session token for subsequent reads to guarantee read-your-writes
results = container.query_items(
    query="SELECT * FROM c WHERE c.category = @category",
    parameters=[{"name": "@category", "value": "proposals"}],
    session_token=session_info.get("token")
)
```

When the application uses the session token from the write operation, the subsequent query is guaranteed to see the newly created document.

## Understand consistency and RU consumption

Consistency level directly affects RU consumption for read operations. Strong and bounded staleness consistency requires reading from two replicas (minority quorum) to ensure consistency guarantees. Session, consistent prefix, and eventual consistency read from a single replica.

| Consistency level | Replicas read | Relative RU cost |
|-------------------|---------------|------------------|
| Strong | Two (minority quorum) | 2× |
| Bounded staleness | Two (minority quorum) | 2× |
| Session | One | 1× |
| Consistent prefix | One | 1× |
| Eventual | One | 1× |

For read-heavy AI applications, using session consistency instead of strong consistency reduces read costs by half while still providing practical consistency guarantees for user-facing operations.

Write RU costs don't vary by consistency level at the operation level, but strong consistency requires waiting for global replication, which increases latency. All consistency levels write to a local majority (three replicas in a four-replica set) before confirming the operation.

## Override consistency per request

The Python SDK sets the consistency level at the client level when constructing the `CosmosClient`. You can create separate client instances with different consistency levels for different parts of your application, enabling stronger consistency for critical operations and weaker consistency for background tasks.

You can use stronger consistency for critical operations:

```python
from azure.cosmos import CosmosClient, ConsistencyLevel

# Client with strong consistency for critical reads
strong_client = CosmosClient(
    url=endpoint,
    credential=credential,
    consistency_level=ConsistencyLevel.Strong
)
strong_container = strong_client.get_database_client("documents-db").get_container_client("documents")

# Critical read that must return the latest data
results = strong_container.query_items(
    query="SELECT * FROM c WHERE c.id = @id",
    parameters=[{"name": "@id", "value": "critical-doc-123"}]
)
```

You can use weaker consistency for background operations:

```python
# Client with eventual consistency for analytics
eventual_client = CosmosClient(
    url=endpoint,
    credential=credential,
    consistency_level=ConsistencyLevel.Eventual
)
eventual_container = eventual_client.get_database_client("documents-db").get_container_client("documents")

# Analytics query where staleness is acceptable
results = eventual_container.query_items(
    query="SELECT c.category, COUNT(1) as count FROM c GROUP BY c.category"
)
```

This flexibility lets you optimize costs for different scenarios while maintaining required consistency for user-facing operations.

## Select consistency for vector search

Vector search queries typically tolerate eventual consistency because semantic similarity results don't require absolute freshness. A query asking "find documents similar to X" produces useful results even if the newest documents aren't yet searchable.

However, if users expect to find recently uploaded content through vector search, session consistency ensures newly indexed embeddings are immediately searchable within the same session. The user who uploaded a document and generated its embedding sees that document in similarity search results.

For hybrid queries that combine vector similarity with metadata filters, apply the same consistency considerations as for standard queries. If users filter by date and expect recent documents to appear, session consistency provides the expected behavior.

## Consider consistency in multi-region deployments

For accounts distributed across multiple regions, consistency level affects write latency and read freshness:

- **Strong consistency:** Requires waiting for replication to all regions before confirming writes. Write latency increases with the distance to the farthest region. Strong consistency with multiple write regions isn't supported.

- **Bounded staleness:** Works best for single-region write accounts that need predictable cross-region consistency. Reads from non-primary regions return data within the configured staleness bounds.

- **Session and weaker levels:** Writes confirm after local majority commit. Cross-region replication happens asynchronously. Session tokens ensure read-your-writes within a session, but other regions might briefly see stale data.

For most globally distributed AI applications, session consistency provides the best balance. Users interacting with a specific region see their writes immediately. Users in other regions see eventually consistent data, which is typically acceptable for document search scenarios.

## Monitor consistency with PBS metrics

Probabilistically Bounded Staleness (PBS) metrics show how often reads with eventual consistency actually return the latest data. This metric helps validate whether weaker consistency levels meet your application requirements.

You can access PBS metrics through the Azure portal:

1. Navigate to your Azure Cosmos DB account
1. Select **Metrics** in the left pane
1. Select the **Consistency** category
1. View the PBS metric for your regions

If PBS metrics show that eventual consistency returns current data more than 99% of the time, you might safely use eventual consistency for more operations. If PBS shows significant staleness, consider using session consistency for user-facing operations.

## Additional resources

- [Consistency levels in Azure Cosmos DB](/azure/cosmos-db/consistency-levels)
- [Configure default consistency level](/azure/cosmos-db/how-to-manage-consistency)
- [Manage consistency in Azure Cosmos DB](/azure/cosmos-db/how-to-manage-consistency)
