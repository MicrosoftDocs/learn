Azure AI Foundry Agent Service hosts A2A agents as independently deployable services, each advertising its capabilities through an authenticated agent card at the `agentCard/v0.3` endpoint. Azure Cosmos DB provides the central discovery registry where agents register on startup and clients query at runtime—eliminating hardcoded endpoint dependencies and supporting ecosystems that scale to hundreds of agents across regions.

| Challenge | Impact | Solution Pattern |
|-----------|--------|------------------|
| Hardcoded agent endpoints | Every client update when adding/removing agents | Central discovery registry |
| Unknown agent capabilities | Clients send requests to wrong agents | Capability-based routing |
| Single-point agent failures | No automatic failover to equivalent instances | Multi-instance load distribution |

Agent ecosystems at production scale require discovery infrastructure that makes agent location, capability matching, and health monitoring automatic rather than manual. The core architectural shift moves from static configuration to dynamic service discovery.

## Build a central agent discovery registry

Instead of embedding agent endpoints in client configuration files, agents register themselves in a central registry when they start. The registry stores each agent's endpoint URL, capability declarations from its Agent Card, current health status, and version identifier. Clients query the registry with task requirements and receive matching agent endpoints dynamically.

Azure Cosmos DB provides an ideal registry store for agent ecosystems. Its global distribution ensures agents in any region can register and clients worldwide can discover them with low latency. Its document model naturally represents agent metadata—each agent is one JSON document. Its indexing capabilities make capability-based queries efficient even with hundreds of registered agents.

The registry document structure captures everything a routing client needs to select the right agent:

| Field | Purpose | Example |
|-------|---------|---------|
| `agentId` | Unique identifier (partition key) | `market-analysis-v2-eastus` |
| `endpointUrl` | A2A agent server address | `https://market-agent.contoso.com` |
| `capabilities` | Task types this agent handles | `["sector-analysis", "trend-forecasting"]` |
| `healthStatus` | Current operational state | `healthy` / `degraded` / `offline` |
| `lastHeartbeat` | Timestamp of most recent health check | `2026-04-07T14:32:18Z` |
| `version` | Agent implementation version | `2.3.1` |

Agents register by POSTing their Agent Card data to the registry on startup. The registration operation includes time-to-live (TTL) so orphaned entries automatically expire if an agent crashes without de-registering.

```python
from azure.cosmos import CosmosClient
from azure.identity import DefaultAzureCredential
from datetime import datetime, timedelta
import os

# Agent registration with automatic TTL expiration
def register_agent_in_cosmos_registry(agent_card: dict):
    """Register an A2A agent in the Cosmos DB discovery registry."""
    
    credential = DefaultAzureCredential()
    cosmos_client = CosmosClient(
        url=os.environ["COSMOS_ENDPOINT"],
        credential=credential
    )
    
    database = cosmos_client.get_database_client("agent-registry")
    container = database.get_container_client("agents")
    
    # Build registry document from agent card
    registry_entry = {
        "id": agent_card["id"],
        "agentId": agent_card["id"],
        "endpointUrl": agent_card["endpoint"],
        "capabilities": [skill["name"] for skill in agent_card["capabilities"]],
        "healthStatus": "healthy",
        "lastHeartbeat": datetime.utcnow().isoformat(),
        "version": agent_card.get("version", "1.0.0"),
        "ttl": 300  # Expire after 5 minutes without heartbeat
    }
    
    container.upsert_item(registry_entry)
    print(f"Registered agent {agent_card['id']} in discovery registry")

# Capability-based agent discovery
def find_agents_by_capability(required_capability: str) -> list[dict]:
    """Query the registry for agents that provide a specific capability."""
    
    credential = DefaultAzureCredential()
    cosmos_client = CosmosClient(
        url=os.environ["COSMOS_ENDPOINT"],
        credential=credential
    )
    
    database = cosmos_client.get_database_client("agent-registry")
    container = database.get_container_client("agents")
    
    # Query for healthy agents with the required capability
    query = """
        SELECT c.agentId, c.endpointUrl, c.capabilities, c.lastHeartbeat
        FROM c
        WHERE ARRAY_CONTAINS(c.capabilities, @capability)
        AND c.healthStatus = 'healthy'
        AND c.lastHeartbeat > @cutoff
    """
    
    cutoff = (datetime.utcnow() - timedelta(minutes=2)).isoformat()
    parameters = [
        {"name": "@capability", "value": required_capability},
        {"name": "@cutoff", "value": cutoff}
    ]
    
    matching_agents = list(container.query_items(
        query=query,
        parameters=parameters,
        enable_cross_partition_query=True
    ))
    
    return matching_agents
```

This pattern decouples agent deployment from client configuration. When Contoso Capital launches a new market analysis agent in the West Europe region, it registers itself automatically. Clients in all regions discover it within seconds through their next registry query.

## Implement capability-based routing

The registry enables more sophisticated agent selection than simple endpoint lookup. A routing service analyzes task requirements and matches them against agent capability declarations to find the most appropriate handler. This transforms agent invocation from "call agent at address X" to "find agents that can perform task Y."

The routing service receives a task description from the orchestrator—for example, "analyze semiconductor sector trends for Q2 2026." It queries the registry for agents declaring `sector-analysis` capability, filters by health status, and returns candidate endpoints ranked by specialization. An agent specialized in technology sectors ranks higher than a generalist market agent, even though both declare the base capability.

Routing logic can incorporate multiple dimensions beyond capability matching. Geographic routing prefers agents in the same region as the requesting client to minimize latency. Version-aware routing enables canary deployments where only 5% of requests route to a new agent version while 95% continue using the stable version. Capacity-aware routing tracks concurrent request counts per agent and routes new requests to underutilized instances.

## Distribute load across equivalent agent instances

Production agent ecosystems run multiple instances of each agent type for both scale and resilience. Contoso Capital deploys four instances of their market analysis agent—two in East US, one in West Europe, one in Southeast Asia. When a client requests sector analysis, the routing service must select one instance from this pool.

Three load distribution strategies work well in agent ecosystems:

**Round-robin distribution** cycles through the instance list sequentially. This provides perfectly even distribution when all instances have equivalent capacity and response times. Round-robin works best for stateless agents where any instance can handle any request with identical results.

**Latency-based distribution** maintains a moving average of response times for each instance and routes new requests to the currently fastest instances. This automatically adapts to variable network conditions and uneven compute capacity. The routing service tracks the last 20 response times per instance and selects from the fastest quartile.

**Capability-weighted routing** prefers instances with specialized sub-capabilities even when multiple agents claim the same base capability. If the request mentions "semiconductor supply chain analysis," an instance with additional `supply-chain` capability gets higher weight than instances with only `sector-analysis`. This creates implicit specialization tiers within agent pools.

The routing service stores instance performance metrics in Azure Managed Redis for low-latency read operations during routing decisions. Each successful agent invocation updates the instance's response time metric. Each failed invocation increments an error counter that temporarily reduces that instance's routing weight.

## Design registry availability and failover

The discovery registry becomes a critical dependency once your ecosystem relies on it for all agent selection. If the registry becomes unavailable, no new agent invocations can start even though the agents themselves are healthy. Design for registry resilience requires two complementary strategies.

**Multi-region active-active replication** ensures the registry remains accessible during regional outages. Azure Cosmos DB's multi-write regions enable agents in East US to register in the East US replica while clients in Europe query the Europe replica, with automatic conflict-free replication between regions. The routing service connects to the nearest Cosmos DB region and fails over to alternate regions if the primary becomes unreachable.

**Client-side registry caching** provides continued operation during complete registry outages. Each routing service maintains an in-memory cache of the last successful registry query results, refreshed every 30 seconds under normal operation. If registry queries fail, the routing service continues using cached agent endpoints with gradually increasing staleness tolerance—fresh cache entries for 5 minutes, then stale entries for up to 15 minutes during extended outages. This trades potential routing to obsolete endpoints for continued system operation.

A circuit-breaker pattern protects the registry from cascading failures. After three consecutive registry query failures within 60 seconds, the routing service opens the circuit and serves all requests from cache for 5 minutes without attempting registry queries. This prevents retry storms that could delay registry recovery during overload conditions.

## Manage agent lifecycle with dynamic registration

Agents join and leave the ecosystem dynamically as Contoso Capital scales their platform. New agent deployments must integrate automatically without manual registry updates. Failed agents must be removed from routing consideration without human intervention.

The agent lifecycle pattern consists of four phases:

**Startup registration**: When an agent container starts, its initialization code retrieves its Agent Card definition and posts a registration document to the Cosmos DB registry. The registration includes a TTL of 300 seconds, meaning it automatically expires 5 minutes after creation unless refreshed.

**Heartbeat maintenance**: A background thread in each agent sends a heartbeat update every 60 seconds, which resets the TTL counter back to 300 seconds. The heartbeat includes current health metrics like queue depth and error rate, allowing the routing service to detect degraded agents before they fail completely.

**Graceful shutdown**: When an agent receives a termination signal (SIGTERM), it updates its registry entry to `healthStatus: "draining"` and stops accepting new requests while completing in-flight work. After active requests complete, it sets `healthStatus: "offline"` and exits. The registry entry expires naturally after 5 minutes through TTL.

**Orphan cleanup**: If an agent crashes without graceful shutdown, it leaves a stale registry entry. The TTL mechanism automatically removes these orphaned entries after 5 minutes without heartbeat updates. The routing service also actively excludes agents with `lastHeartbeat` older than 2 minutes from query results, ensuring crashed agents disappear from routing within the heartbeat interval.

This lifecycle pattern enables zero-downtime deployments. New agent versions register themselves and immediately begin receiving traffic through the routing service. Old versions drain their request queues and de-register. The routing service handles the transition automatically without configuration updates.

With a scalable discovery registry and capability-based routing in place, the next challenge emerges—multiple agents need to collaborate on shared research tasks by reading and writing common state. Traditional agent memory patterns break down when state must survive process restarts and remain consistent across concurrent agent updates. You need distributed shared state management.

## Key takeaways

- **Discovery registries** eliminate hardcoded agent endpoints by letting agents register their capabilities and be found dynamically at runtime.
- **Capability-based routing** matches incoming tasks to agents by what they can do, not by their deployment address—enabling transparent scaling and failover.
- **Load distribution** across equivalent agent instances uses round-robin, least-connections, or weighted routing to prevent hotspots.
- **Dynamic registration and deregistration** support zero-downtime deployments where new agent versions register, receive traffic, and old versions drain gracefully.
