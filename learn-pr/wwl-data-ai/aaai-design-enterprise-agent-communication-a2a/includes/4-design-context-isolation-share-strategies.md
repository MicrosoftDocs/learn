Azure Cosmos DB partition keys and Azure Managed Redis namespace prefixes provide storage-layer isolation for multi-tenant agent deployments. Azure AI Foundry Agent Service runs shared agent pools efficiently across hundreds of clients while these patterns ensure each client's data stays physically and logically separate.

| Architecture | Isolation Strength | Resource Efficiency | Use Case |
|--------------|-------------------|---------------------|----------|
| Dedicated instances | Complete physical isolation | Low (idle waste) | Regulated clients with strict requirements |
| Shared agents with context isolation | Logical isolation via access controls | High (resource pooling) | Standard clients, general-purpose agents |
| Hybrid (shared + dedicated) | Flexible per-client | Balanced | Mix of standard and high-security clients |

The architecture you choose determines which data individual agents can access, how context propagates through agent invocations, and what safeguards prevent cross-tenant leakage. Understanding the isolation-sharing trade-offs guides your tenant segmentation strategy.

## Navigate the isolation-sharing spectrum

At one extreme, perfect isolation deploys separate agent instances for each client. Each client gets their own market analysis agent, risk assessment agent, and compliance agent running in isolated containers with dedicated state storage. No agent ever processes data from multiple clients, eliminating any possibility of data leakage. This architecture mirrors traditional single-tenant SaaS where each customer gets dedicated infrastructure.

Perfect isolation maximizes security and provides clear regulatory compliance evidence—auditors can verify physical separation between client data. However, the cost scales linearly with client count. Deploying 500 market analysis agents for 500 clients means most agents sit idle most of the time, wasting compute capacity. Operational complexity multiplies—every agent update requires 500 deployments, monitoring tracks 500 separate instances, and troubleshooting must identify which of 500 agents caused an issue.

At the other extreme, complete sharing runs all clients through the same agent pool with no isolation. The same three market analysis agent instances serve all 500 clients, maximizing resource utilization. This architecture delivers the cost efficiency of true multi-tenancy but creates high data leakage risk. If an agent caches research results and accidentally serves that cache to a different client, proprietary analysis leaks. If an agent includes client A's portfolio holdings in its context when processing client B's request, sensitive financial positions leak.

Production systems typically adopt a hybrid approach that shares general-purpose processing while isolating sensitive data. Contoso Capital runs shared pools for stateless reasoning tasks—market analysis agents that analyze public financial statements operate identically for all clients and can safely serve anyone. Client-specific state like portfolio holdings, trade history, and internal risk models gets strictly isolated through context propagation and scoped data access.

## Implement context propagation architecture

Context propagation ensures every agent invocation carries tenant identity throughout its execution. The orchestrator initiates a workflow on behalf of client "Acme Retirement Fund" by generating a context object containing `clientId: "acme-retirement"`, `portfolioId: "arf-conservative"`, and `regulatoryJurisdiction: "SEC-US"`. This context object flows through every subsequent agent call in the workflow.

When the orchestrator invokes the market analysis agent via A2A, it includes the context in the request metadata. The market agent receives the context, validates it, and stores it in thread-local storage accessible throughout its execution. Every database query the market agent makes gets automatically scoped to `clientId: "acme-retirement"`. Every state document it writes includes the tenant identifier. Every response it generates gets tagged with the client ID for audit logging.

Context objects follow a hierarchical structure reflecting organizational relationships. Contoso Capital's clients have multiple portfolios—Acme Retirement Fund manages a conservative portfolio, a growth portfolio, and a high-risk allocation portfolio. The context hierarchy represents this:

```
clientId: "acme-retirement"
├── portfolioId: "arf-conservative"
├── portfolioId: "arf-growth"  
└── portfolioId: "arf-high-risk"
```

Some analyses operate at client level—regulatory compliance checking applies across all portfolios. Other analyses operate at portfolio level—risk assessment evaluates each portfolio independently. Context propagation carries both identifiers so each agent can scope its operations appropriately.

```python
from contextvars import ContextVar
from functools import wraps
from typing import Any
import json

# Thread-safe context storage
tenant_context: ContextVar[dict | None] = ContextVar("tenant_context", default=None)

class TenantContext:
    """Tenant context object with validation and access control."""
    
    def __init__(self, client_id: str, portfolio_id: str | None = None, jurisdiction: str = "SEC-US"):
        self.client_id = client_id
        self.portfolio_id = portfolio_id
        self.jurisdiction = jurisdiction
        self.access_token = None  # Set by auth system
    
    def to_dict(self) -> dict:
        return {
            "clientId": self.client_id,
            "portfolioId": self.portfolio_id,
            "jurisdiction": self.jurisdiction
        }
    
    def get_partition_key(self) -> str:
        """Generate partition key for data scoping."""
        if self.portfolio_id:
            return f"{self.client_id}#{self.portfolio_id}"
        return self.client_id

def require_tenant_context(func):
    """Decorator that validates tenant context before agent operations."""
    
    @wraps(func)
    def wrapper(*args, **kwargs):
        context = tenant_context.get()
        
        if context is None:
            raise ValueError("Tenant context required but not set")
        
        # Validate context has required fields
        if not context.get("clientId"):
            raise ValueError("Tenant context missing clientId")
        
        # Log the operation with tenant context for audit
        operation = func.__name__
        print(f"[AUDIT] Operation: {operation}, Client: {context['clientId']}, Portfolio: {context.get('portfolioId')}")
        
        return func(*args, **kwargs)
    
    return wrapper

@require_tenant_context
def read_portfolio_holdings(symbol: str) -> dict:
    """Read holdings for current tenant context."""
    
    context_obj = TenantContext(**tenant_context.get())
    partition_key = context_obj.get_partition_key()
    
    # Query scoped to tenant partition
    query = """
        SELECT c.symbol, c.quantity, c.costBasis
        FROM c
        WHERE c.portfolioId = @portfolioId
        AND c.symbol = @symbol
    """
    
    # Database client automatically applies partition key scope
    # This prevents reading data from other tenants
    return execute_scoped_query(query, partition_key, {"symbol": symbol})

# Agent initialization sets context for entire request lifecycle
def init_agent_request(client_id: str, portfolio_id: str):
    """Initialize tenant context at start of agent request."""
    
    context = {
        "clientId": client_id,
        "portfolioId": portfolio_id,
        "jurisdiction": "SEC-US"
    }
    
    tenant_context.set(context)
    print(f"Initialized context for client {client_id}, portfolio {portfolio_id}")
```

The `require_tenant_context` decorator ensures no agent operation executes without validated tenant context. If an agent function attempts to read portfolio data without context initialization, the decorator raises an exception immediately rather than allowing a query that could return data from multiple tenants.

## Prevent cross-tenant context leakage

The most serious security failure in multi-tenant agent systems occurs when data from one tenant appears in another tenant's results. Cross-tenant leakage happens through four primary vectors—each requiring specific mitigation.

**Agent response caching** stores completed agent outputs for reuse when identical requests arrive. If the market analysis agent analyzes Microsoft's Q2 earnings, caching that analysis avoids redundant work when another client requests Microsoft analysis. However, naive caching can serve client A's cached analysis to client B, leaking proprietary insights. Mitigation requires including tenant identifier in cache keys—`cache:market-analysis:MSFT:acme-retirement` differs from `cache:market-analysis:MSFT:other-client`, preventing cross-tenant cache hits.

**Prompt context injection** builds LLM prompts by retrieving relevant background information from agent memory or state stores. If the market agent's prompt builder retrieves "recent portfolio trades" without tenant scoping, it might inject client A's trades into client B's prompt context. Mitigation requires validating that every document retrieved for prompt building matches the current tenant context before injection.

**Shared state documents** enable agent collaboration but create leakage risk if not properly partitioned. If two market analysis agents from different tenants both write to state document `task:latest-tech-sector-analysis`, their findings mix. Mitigation requires embedding tenant identifier in all state document keys—`task:acme-retirement:tech-analysis` and `task:other-client:tech-analysis` remain isolated.

**Error messages and logs** can inadvertently reveal information across tenant boundaries. An error message "Failed to analyze MSFT because client acme-retirement already has maximum concentration in technology sector" reveals client A's portfolio composition to any user who triggers that error. Mitigation requires sanitizing error messages to remove tenant-specific details before display and logging full context only to secure audit systems.

The principle behind all leakage prevention measures: every data access must validate tenant scope before execution. No query should retrieve documents from multiple tenants. No cache read should return content generated for a different tenant. No state update should write to another tenant's partition.

## Implement tenant isolation in shared storage

Azure Cosmos DB's partition key feature provides physical data isolation boundaries that support multi-tenant architectures. When you create a container with partition key set to `tenantId`, Cosmos DB physically separates documents by that field—client A's data lives in different storage partitions than client B's data. Queries that specify the partition key can only access documents within that partition, preventing cross-tenant reads even if query logic is incorrect.

For Contoso Capital's research task state, using `clientId` as the partition key ensures each client's tasks remain isolated. When the market analysis agent queries for client "acme-retirement"'s pending tasks, Cosmos DB only searches that client's partition. A malicious or buggy query can't accidentally return tasks from other clients.

```python
# Tenant-isolated state access pattern
def write_tenant_state(cosmos_container, client_id: str, task_id: str, data: dict):
    """Write state document with tenant isolation."""
    
    document = {
        "id": f"{client_id}:{task_id}",  # Include tenant in document ID
        "tenantId": client_id,  # Partition key for physical isolation
        "taskId": task_id,
        "data": data,
        "timestamp": datetime.utcnow().isoformat()
    }
    
    cosmos_container.upsert_item(document)

def read_tenant_state(cosmos_container, client_id: str, task_id: str) -> dict:
    """Read state document with automatic tenant scoping."""
    
    try:
        return cosmos_container.read_item(
            item=f"{client_id}:{task_id}",
            partition_key=client_id  # Must match or read fails
        )
    except exceptions.CosmosResourceNotFoundError:
        return None

def query_tenant_tasks(cosmos_container, client_id: str, status: str) -> list[dict]:
    """Query tasks scoped to one tenant partition."""
    
    query = """
        SELECT c.taskId, c.data, c.timestamp
        FROM c
        WHERE c.status = @status
    """
    
    # Partition key limits query scope to one tenant
    results = cosmos_container.query_items(
        query=query,
        parameters=[{"name": "@status", "value": status}],
        partition_key=client_id,  # Critical: always specify partition key
        enable_cross_partition_query=False  # Explicitly disable cross-partition
    )
    
    return list(results)
```

Setting `enable_cross_partition_query=False` provides defense-in-depth—if code mistakenly omits the partition key parameter, the query fails immediately rather than scanning all tenants' data. This fail-safe prevents the worst-case scenario where a missing tenant scope turns into a mass data leak.

Azure Managed Redis requires manual tenant scoping because it has no built-in partition key concept. All Redis keys must include tenant identifier as a prefix—`acme-retirement:portfolio:holdings`, `other-client:portfolio:holdings`. Agents must construct these prefixed keys programmatically using the current tenant context.

## Audit context access patterns

Even with robust isolation controls, monitoring actual access patterns provides essential security validation. Audit logging captures every tenant context access with metadata identifying which agent performed what operation on which tenant's data at what time. This audit trail serves two purposes—regulatory compliance evidence and anomaly detection.

Contoso Capital's audit log schema captures:

| Field | Purpose | Example |
|-------|---------|---------|
| `timestamp` | When access occurred | `2026-04-07T15:42:33Z` |
| `agentId` | Which agent performed operation | `market-analysis-v2-eastus` |
| `operation` | What action was taken | `read_portfolio_holdings` |
| `clientId` | Primary tenant identifier | `acme-retirement` |
| `portfolioId` | Scoped context identifier | `arf-conservative` |
| `resourceId` | What data was accessed | `holdings:MSFT` |
| `outcome` | Success or failure | `success` / `denied` |

Anomaly detection analyzes audit logs to identify suspicious patterns. An agent that reads holdings from multiple different clients within a single 60-second window triggers an alert—legitimate operations should stay within one client context per request. An agent whose queries suddenly start failing partition key validation suggests degraded tenant context propagation.

These audit logs provide evidence for regulatory compliance reviews. When financial auditors ask "prove that client A's portfolio data never leaked to client B," Contoso Capital can query the audit log to show no operation ever accessed both clients' data within the same context or agent session.

With context isolation preventing data leakage, the final challenge emerges: agents sometimes produce contradictory conclusions about the same entity. When the market agent says "growth opportunity" and the risk agent says "avoid exposure," the system needs automated conflict detection and resolution rather than surfacing inconsistent recommendations to clients.

## Key takeaways

- **The isolation-sharing spectrum** ranges from full isolation (maximum security, highest cost) to full sharing (maximum efficiency, highest leakage risk)—most production systems use selective sharing with explicit access controls.
- **Context propagation architecture** ensures tenant identity flows through every agent-to-agent call, preventing context-free operations that could cross tenant boundaries.
- **Partition-key-based isolation** in Cosmos DB and namespace-scoped keys in Redis physically prevent cross-tenant data access at the storage layer.
- **Audit trails** for context access provide regulatory evidence that client data boundaries were never breached.
