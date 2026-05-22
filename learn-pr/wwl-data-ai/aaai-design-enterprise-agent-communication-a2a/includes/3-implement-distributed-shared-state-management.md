Multiple agents in Contoso Capital's platform must collaborate on the same research task. The market analysis agent writes sector trends for healthcare companies. The risk assessment agent adds stress-test results for those same companies. The regulatory compliance agent annotates which findings must appear in client disclosures. The final report agent reads all three contributions and synthesizes them. This collaborative pattern requires shared mutable state that persists across agent invocations and remains consistent when multiple agents update it concurrently.

| State Pattern | Use Case | Trade-offs |
|---------------|----------|-----------|
| Local agent memory | Single-agent in-process state | Fast but lost on restart, no sharing |
| Azure Cosmos DB | Durable cross-agent state | Survives restarts, globally replicated, higher latency |
| Azure Managed Redis | Hot shared cache | Low latency, pub/sub notifications, volatile |

The shift from local agent memory to distributed shared state introduces new challenges around concurrent access, consistency guarantees, and conflict resolution. Understanding when to use durable storage versus in-memory caches shapes your state architecture.

## Choose state storage for agent collaboration

Azure Cosmos DB provides the foundation for durable agent state that must survive process restarts and remain accessible across regions. Each research task maps to one Cosmos DB document identified by `taskId`, containing contributions from all participating agents. When the market analysis agent completes its work, it writes its findings to the task document. When the risk agent runs later, it reads the existing content, adds its risk metrics, and writes back the updated document.

Cosmos DB's document model naturally represents hierarchical agent state. A research task document contains nested objects for each analysis dimension—market trends, risk metrics, compliance findings, executive summary. Each agent owns one section of the document and updates only its own section, reducing the likelihood of write conflicts. The document schema grows organically as new agent types join the workflow without requiring schema migrations.

The consistency model you choose for Cosmos DB profoundly affects concurrent agent behavior. **Strong consistency** guarantees that agents always read the most recent write, but this increases latency and reduces availability during network partitions. **Session consistency** provides read-your-writes guarantees for each agent's session while allowing other agents to momentarily see stale data. **Eventual consistency** maximizes availability and performance but requires explicit conflict handling when agents read stale state.

For Contoso Capital's financial research workflows, session consistency provides the right balance. Each agent sees its own writes immediately—critical when an agent updates state and then reads it back to validate success. Agents tolerate brief delays before seeing other agents' contributions because the orchestrator coordinates turn-taking through the task queue.

Azure Managed Redis complements Cosmos DB for hot state that agents access frequently within a single workflow execution. While Cosmos DB stores the authoritative version of each task document, Redis caches active task state for agents currently working on that task. This hybrid pattern reduces Cosmos DB read costs and latency while preserving durability through write-through updates.

```python
from azure.cosmos import CosmosClient, PartitionKey
from azure.identity import DefaultAzureCredential
import redis
import json
import os

class DistributedStateManager:
    """Manage shared state for collaborative agent tasks with Cosmos DB and Redis."""
    
    def __init__(self):
        credential = DefaultAzureCredential()
        
        # Durable state in Cosmos DB
        self.cosmos_client = CosmosClient(
            url=os.environ["COSMOS_ENDPOINT"],
            credential=credential
        )
        self.database = self.cosmos_client.get_database_client("agent-state")
        self.container = self.database.get_container_client("research-tasks")
        
        # Hot state cache in Redis
        self.redis_client = redis.Redis(
            host=os.environ["REDIS_HOST"],
            port=6380,
            password=os.environ["REDIS_KEY"],
            ssl=True,
            decode_responses=True
        )
```

The `read_task_state` method implements a cache-aside pattern. It checks Redis first for frequently accessed hot state, falling back to Cosmos DB on cache miss and populating the cache with a five-minute TTL for subsequent reads.

```python
    def read_task_state(self, task_id: str) -> dict:
        """Read task state with Redis cache-aside pattern."""
        
        # Check cache first
        cached = self.redis_client.get(f"task:{task_id}")
        if cached:
            return json.loads(cached)
        
        # Cache miss - read from Cosmos DB
        try:
            response = self.container.read_item(
                item=task_id,
                partition_key=task_id
            )
            
            # Populate cache with 5-minute TTL
            self.redis_client.setex(
                f"task:{task_id}",
                300,
                json.dumps(response)
            )
            
            return response
            
        except Exception as e:
            print(f"Failed to read task state: {e}")
            return None
```

The `update_task_state_optimistic` method uses Cosmos DB ETags for optimistic concurrency control. Each agent reads the current document with its version identifier, applies changes locally, and writes back conditionally. If another agent modified the document in the meantime, Cosmos DB rejects the write and the method retries up to three times.

```python
    def update_task_state_optimistic(
        self,
        task_id: str,
        agent_id: str,
        contribution: dict
    ) -> bool:
        """Update task state with optimistic concurrency control."""
        
        max_retries = 3
        for attempt in range(max_retries):
            # Read current state with ETag
            current_state = self.container.read_item(
                item=task_id,
                partition_key=task_id
            )
            
            current_etag = current_state.get("_etag")
            
            # Merge agent's contribution into current state
            if "contributions" not in current_state:
                current_state["contributions"] = {}
            
            current_state["contributions"][agent_id] = {
                "data": contribution,
                "timestamp": datetime.utcnow().isoformat()
            }
            
            # Attempt conditional write with ETag
            try:
                self.container.replace_item(
                    item=current_state,
                    body=current_state,
                    etag=current_etag,
                    match_condition=MatchConditions.IfNotModified
                )
                
                # Write succeeded - invalidate cache
                self.redis_client.delete(f"task:{task_id}")
                
                # Publish cache invalidation notification
                self.redis_client.publish(
                    "cache-invalidations",
                    json.dumps({"taskId": task_id, "reason": "state-update"})
                )
                
                return True
                
            except exceptions.CosmosHttpResponseError as e:
                if e.status_code == 412:  # Precondition failed - ETag mismatch
                    print(f"Optimistic concurrency conflict on attempt {attempt + 1}")
                    continue
                else:
                    raise
        
        # All retries exhausted
        print(f"Failed to update task state after {max_retries} attempts")
        return False
```

This implementation demonstrates the optimistic concurrency pattern that prevents lost updates when multiple agents modify shared state simultaneously. Each agent reads the current document and its ETag version identifier, applies its changes locally, and writes back with the ETag condition. If another agent modified the document since this agent's read, Cosmos DB rejects the write with a 412 status code. The agent retries—reading the updated document, re-applying its changes, and attempting the write again.

## Apply optimistic versus pessimistic locking

Two concurrency control strategies address conflicting agent updates—optimistic and pessimistic locking. Each strategy fits different conflict patterns in multi-agent systems.

**Optimistic concurrency** assumes conflicts are rare and detects them at write time. Agents read state without acquiring locks, apply their logic, and write results with a version check. If the version changed since the read, the write fails and the agent retries. This approach maximizes parallelism because agents never wait for locks. Cosmos DB's ETag mechanism provides built-in optimistic concurrency—every document has an ETag that changes with each update.

Optimistic concurrency works well for Contoso Capital's research tasks because different agents typically update different sections of the task document. The market agent writes to `contributions.market`, the risk agent writes to `contributions.risk`, and conflicts rarely occur. When conflicts do happen—perhaps two versions of the market agent running simultaneously—the retry logic resolves them automatically by merging both contributions.

**Pessimistic locking** assumes conflicts are common and prevents them by acquiring exclusive locks before reads. An agent requests a distributed lock on the task document, performs its read-modify-write cycle while holding the lock, then releases the lock. Other agents wait until the lock becomes available. This approach guarantees no conflicts but serializes all access to the locked resource.

Pessimistic locking fits critical decisions where concurrent modification would produce inconsistent state that's hard to reconcile. When Contoso Capital's trading execution agent decides whether to place a buy order, it must read current portfolio holdings, calculate the new position size, and reserve capital atomically. If two execution agents ran this logic concurrently without locking, both might reserve the same capital, leading to over-commitment.

Redis provides a distributed lock implementation using the SETNX (set-if-not-exists) command pattern. An agent attempts to set a lock key with a unique identifier and a 30-second expiration. If the key doesn't exist, SETNX succeeds and the agent owns the lock. If another agent already holds the lock, SETNX fails and this agent waits. The expiration prevents deadlocks if an agent crashes while holding a lock.

```python
import uuid
import time

def acquire_distributed_lock(redis_client, resource_id: str, timeout: int = 30) -> str | None:
    """Acquire a distributed lock for a resource using Redis SETNX."""
    
    lock_key = f"lock:{resource_id}"
    lock_value = str(uuid.uuid4())  # Unique identifier for this lock holder
    
    # Try to acquire lock with expiration
    acquired = redis_client.set(
        lock_key,
        lock_value,
        nx=True,  # Only set if key doesn't exist
        ex=timeout  # Expire after timeout seconds
    )
    
    if acquired:
        return lock_value
    return None

def release_distributed_lock(redis_client, resource_id: str, lock_value: str) -> bool:
    """Release a distributed lock if we still own it."""
    
    lock_key = f"lock:{resource_id}"
    
    # Lua script ensures atomic compare-and-delete
    # Only delete the lock if it matches our lock_value
    release_script = """
        if redis.call("get", KEYS[1]) == ARGV[1] then
            return redis.call("del", KEYS[1])
        else
            return 0
        end
    """
    
    result = redis_client.eval(release_script, 1, lock_key, lock_value)
    return result == 1
```

The lock release uses a Lua script to atomically compare the stored lock value against the value held by this agent before deleting the lock. This prevents an agent from accidentally releasing another agent's lock if its own lock expired and another agent acquired it.

## Implement state versioning and conflict detection

Even with optimistic concurrency preventing lost updates, agents can produce logically conflicting contributions. The market analysis agent writes that MSFT shows strong growth indicators and recommends increasing position size. The risk assessment agent writes that MSFT faces elevated sector-specific risk and recommends reducing exposure. Both writes succeed without technical conflicts because they update different document sections, but their conclusions contradict each other.

Detecting these semantic conflicts requires state versioning and explicit conflict detection logic. Each contribution in the task document includes a version number and timestamp. When the synthesis agent reads the complete task state, it checks whether any contributions produced contradictory outputs. The synthesis agent compares recommendations, identifies divergence, and escalates to the conflict resolution system covered in Unit 5.

Version numbers also enable causality tracking when one agent's output depends on another agent's contribution. The risk agent's assessment should reflect the market agent's latest sector classification. If the risk agent reads an outdated version of the market contribution, its risk metrics might be invalid. Embedding version numbers in agent inputs makes these dependencies explicit and detectable.

## Publish cache invalidation notifications

When agents cache shared state locally or in Redis, updates by other agents can leave those caches stale. Each agent maintains fast local access to frequently-read state but risks making decisions based on outdated data if another agent modified the authoritative state in Cosmos DB.

Redis pub/sub provides lightweight cache invalidation notifications across the agent ecosystem. When any agent successfully writes state to Cosmos DB, it publishes a cache invalidation message on a shared channel. All other agents subscribe to this channel and flush their cached copies of that task state when they receive invalidation notifications.

```python
def subscribe_to_cache_invalidations(redis_client, state_manager):
    """Listen for cache invalidation notifications and update local state."""
    
    pubsub = redis_client.pubsub()
    pubsub.subscribe("cache-invalidations")
    
    print("Subscribed to cache invalidation notifications")
    
    for message in pubsub.listen():
        if message["type"] == "message":
            notification = json.loads(message["data"])
            task_id = notification.get("taskId")
            reason = notification.get("reason")
            
            print(f"Cache invalidation: task {task_id}, reason: {reason}")
            
            # Remove from local cache
            redis_client.delete(f"task:{task_id}")
```

This pattern trades increased message traffic for reduced cache staleness. For Contoso Capital's workflows where research tasks progress through multiple agent stages sequentially, invalidation notifications ensure each agent reads the latest contributions from previous agents without polling Cosmos DB repeatedly.

The distributed state management patterns—durable storage in Cosmos DB, hot caching in Redis, optimistic concurrency with ETag checks, and pub/sub cache invalidation—enable safe collaboration across dozens of concurrent agents. However, Contoso Capital serves hundreds of clients with strict data isolation requirements. Shared state infrastructure must prevent one client's portfolio data from leaking into another client's context. You need context isolation strategies.

> [!TIP]
> **Pause and reflect:** Consider a scenario where two agents simultaneously update the same shared research state — the market analyst adds a "growth opportunity" finding while the risk assessor adds a "downgrade risk" finding. With optimistic locking (WATCH/MULTI/EXEC in Redis), one write will fail. How would you design the retry logic? Should the failed agent re-read the state (which now includes the other agent's finding) and adjust its own finding, or simply retry the original write?

## Unit summary

- **Durable state in Cosmos DB** persists shared data across agent restarts, with partition keys scoped to research tasks or client portfolios.
- **Hot caching in Redis** provides sub-millisecond reads for frequently accessed state, with TTL-based expiration to prevent stale data.
- **Optimistic concurrency** with Redis WATCH/MULTI/EXEC or Cosmos DB ETags detects concurrent modifications and rejects conflicting writes rather than silently overwriting.
- **Pub/sub cache invalidation** notifies agents when shared state changes, reducing polling overhead and ensuring sequential pipeline stages read current data.

## Check your understanding

**1. Two agents simultaneously update the same shared research state in Redis. With optimistic concurrency (WATCH/MULTI/EXEC), what happens?**

- A. Both writes succeed because Redis handles concurrent writes automatically
- B. The first write succeeds and the second write fails, requiring the second agent to re-read the state and retry
- C. Redis locks the key until both agents complete their updates sequentially

***Correct answer: B.*** With WATCH/MULTI/EXEC, Redis monitors the key for changes. If another client modifies the key between WATCH and EXEC, the transaction fails. The second agent must re-read the current state (which now includes the first agent's changes) and retry its update.
