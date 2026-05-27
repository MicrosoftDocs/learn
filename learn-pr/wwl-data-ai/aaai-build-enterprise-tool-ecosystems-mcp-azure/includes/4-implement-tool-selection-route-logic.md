Northwind Health runs multiple instances of critical tools — a primary drug interaction service in East US and a backup instance in West US, three lab reference API replicas with different performance characteristics, and canary deployments for new tool versions serving 5% of traffic. Static tool lists point to a single endpoint, forcing all agents to call the same instance regardless of load, health, or latency. You implement dynamic routing that selects the best instance at runtime based on current health metrics, latency characteristics, and deployment strategy.

| Routing Strategy | Decision Criteria | Use Case |
|-----------------|-------------------|----------|
| Capability-based | Feature availability | Route v2-capable requests to upgraded instances |
| Latency-based | Recent P95 response time | Minimize agent wait time |
| Weighted | Traffic percentage | Canary deployment with gradual rollout |

## Design tool registries for dynamic resolution

A tool registry maintains the authoritative list of available tool instances with their endpoints, versions, health status, and performance metrics. Rather than hardcoding `https://drugs-api.northwind.health` in agent configuration, the agent queries the registry to resolve "lookup_drug_interaction" to a specific instance endpoint at runtime. This indirection enables zero-downtime instance replacement and performance-based routing.

The registry stores tool name, available instances with their endpoint URLs, semantic version for each instance, current health status (healthy, degraded, unhealthy), and rolling performance metrics including P50, P95 latency over the last 5 minutes. When an agent needs to invoke `lookup_drug_interaction`, it queries the registry with the tool name and receives a prioritized list of healthy instances ranked by recent performance.

```python
from dataclasses import dataclass
from typing import List, Optional
from datetime import datetime

@dataclass
class ToolInstance:
    endpoint: str
    version: str
    health_status: str  # "healthy", "degraded", "unhealthy"
    p50_latency_ms: float
    p95_latency_ms: float
    last_updated: datetime

@dataclass
class ToolRegistration:
    tool_name: str
    instances: List[ToolInstance]
    
class ToolRegistry:
    def __init__(self):
        self._tools = {}
    
    def register_instance(
        self,
        tool_name: str,
        endpoint: str,
        version: str,
        health_status: str = "healthy"
    ):
        """Register a new tool instance in the registry"""
        if tool_name not in self._tools:
            self._tools[tool_name] = ToolRegistration(
                tool_name=tool_name,
                instances=[]
            )
        
        instance = ToolInstance(
            endpoint=endpoint,
            version=version,
            health_status=health_status,
            p50_latency_ms=0.0,
            p95_latency_ms=0.0,
            last_updated=datetime.now()
        )
        self._tools[tool_name].instances.append(instance)
    
    def update_metrics(
        self,
        tool_name: str,
        endpoint: str,
        p50_latency: float,
        p95_latency: float,
        health_status: str
    ):
        """Update performance metrics for a tool instance"""
        if tool_name not in self._tools:
            return
        
        for instance in self._tools[tool_name].instances:
            if instance.endpoint == endpoint:
                instance.p50_latency_ms = p50_latency
                instance.p95_latency_ms = p95_latency
                instance.health_status = health_status
                instance.last_updated = datetime.now()
                break

# Initialize registry with Northwind Health tool instances
registry = ToolRegistry()
registry.register_instance(
    "lookup_drug_interaction",
    "https://drugs-east.northwind.health",
    "1.0.0",
    "healthy"
)
registry.register_instance(
    "lookup_drug_interaction",
    "https://drugs-west.northwind.health",
    "1.0.0",
    "healthy"
)
```

Registry updates flow from health check polling and telemetry ingestion. Every 30 seconds, a background process queries each tool instance's `/health` endpoint and updates the health_status field. Every 60 seconds, Application Insights exports P50 and P95 latency metrics to the registry. This continuous updating ensures routing decisions reflect current conditions rather than stale configuration.

## Implement latency-based routing selection

Latency-based routing selects the tool instance with the best recent P95 latency to minimize agent wait time. When Northwind Health's drug interaction tool has three instances reporting P95 latencies of 450ms, 380ms, and 520ms, the router selects the 380ms instance for the next invocation. This dynamic selection adapts to changing performance characteristics without manual intervention.

Filter unhealthy instances before applying latency ranking. An instance reporting P95 of 200ms means nothing if its health status is "unhealthy" due to 50% error rate. The router considers only instances with "healthy" or "degraded" status, then ranks by P95 latency ascending. This ensures the selected instance can successfully complete the request even if it's not the absolute fastest.

```python
from typing import Optional

class ToolRouter:
    def __init__(self, registry: ToolRegistry):
        self.registry = registry
    
    def select_instance_latency_based(
        self,
        tool_name: str,
        required_version: Optional[str] = None
    ) -> Optional[str]:
        """Select tool instance with best P95 latency"""
        if tool_name not in self.registry._tools:
            return None
        
        instances = self.registry._tools[tool_name].instances
        
        # Filter to healthy/degraded instances
        viable_instances = [
            i for i in instances 
            if i.health_status in ["healthy", "degraded"]
        ]
        
        if not viable_instances:
            return None
        
        # Filter by version if specified
        if required_version:
            viable_instances = [
                i for i in viable_instances
                if i.version == required_version
            ]
        
        if not viable_instances:
            return None
        
        # Select instance with lowest P95 latency
        best_instance = min(
            viable_instances,
            key=lambda i: i.p95_latency_ms
        )
        
        return best_instance.endpoint
    
    def resolve_and_call(self, tool_name: str, **kwargs):
        """Resolve tool to instance and invoke"""
        endpoint = self.select_instance_latency_based(tool_name)
        
        if not endpoint:
            return {
                "status": "error",
                "message": f"No healthy instances available for {tool_name}"
            }
        
        # Log routing decision
        logger.info(json.dumps({
            "event": "tool_routing",
            "tool_name": tool_name,
            "selected_endpoint": endpoint,
            "routing_strategy": "latency_based"
        }))
        
        # Invoke the selected instance
        response = requests.post(
            f"{endpoint}/tools/call",
            json={"tool": tool_name, "arguments": kwargs},
            timeout=5.0
        )
        return response.json()

# Usage in MCP server
router = ToolRouter(registry)

@mcp.tool()
async def lookup_drug_interaction(drug_a: str, drug_b: str):
    """Route drug interaction lookup to best instance"""
    return router.resolve_and_call(
        "lookup_drug_interaction",
        drug_a=drug_a,
        drug_b=drug_b
    )
```

Capability-based routing extends this pattern for tools with feature variations. When Northwind Health deploys a new version of the drug interaction tool with multi-drug analysis, only instances running version 1.1+ support the `additional_drugs` parameter. The router filters instances by minimum version before applying latency ranking, ensuring the selected instance supports the requested capability.

## Implement weighted routing for canary deployments

Weighted routing distributes traffic across tool instances according to configured percentages, enabling gradual rollout of new versions. Northwind Health deploys drug interaction tool version 1.1 as a canary serving 5% of requests while version 1.0 handles 95%. After monitoring error rates and latency for 24 hours without issues, increase the canary weight to 25%, then 50%, then 100% over a week.

Assign each instance a weight representing its traffic share. Generate a random number between 0 and 100 for each request, then select the instance whose cumulative weight range contains the random number. With weights [95, 5] for [v1.0, v1.1], numbers 0-94 route to v1.0 and 95-99 route to v1.1, achieving the 95/5 split.

```python
import random

class WeightedRouter(ToolRouter):
    def __init__(self, registry: ToolRegistry):
        super().__init__(registry)
        self.weights = {}  # tool_name -> {endpoint: weight}
    
    def set_weights(self, tool_name: str, endpoint_weights: dict):
        """Configure traffic weights for tool instances"""
        total = sum(endpoint_weights.values())
        if abs(total - 100.0) > 0.01:
            raise ValueError(f"Weights must sum to 100, got {total}")
        self.weights[tool_name] = endpoint_weights
    
    def select_instance_weighted(self, tool_name: str) -> Optional[str]:
        """Select instance based on weighted distribution"""
        if tool_name not in self.registry._tools:
            return None
        
        if tool_name not in self.weights:
            # Fall back to latency-based if no weights configured
            return self.select_instance_latency_based(tool_name)
        
        instances = self.registry._tools[tool_name].instances
        healthy_instances = [
            i for i in instances
            if i.health_status in ["healthy", "degraded"]
        ]
        
        if not healthy_instances:
            return None
        
        # Build cumulative weight ranges
        cumulative_ranges = []
        cumulative = 0.0
        for instance in healthy_instances:
            weight = self.weights[tool_name].get(instance.endpoint, 0)
            if weight > 0:
                cumulative_ranges.append((
                    cumulative,
                    cumulative + weight,
                    instance.endpoint
                ))
                cumulative += weight
        
        # Select based on random number
        selection = random.uniform(0, 100)
        for start, end, endpoint in cumulative_ranges:
            if start <= selection < end:
                logger.info(json.dumps({
                    "event": "tool_routing",
                    "tool_name": tool_name,
                    "selected_endpoint": endpoint,
                    "routing_strategy": "weighted",
                    "selection_value": selection
                }))
                return endpoint
        
        # Fallback to first instance
        return healthy_instances[0].endpoint

# Configure canary deployment for drug interaction tool
weighted_router = WeightedRouter(registry)
weighted_router.set_weights("lookup_drug_interaction", {
    "https://drugs-east.northwind.health": 95.0,  # v1.0 stable
    "https://drugs-canary.northwind.health": 5.0   # v1.1 canary
})
```

Routing telemetry logs every decision with the strategy used, selected endpoint, and selection criteria (latency value or random weight). After 1,000 canary invocations, query Application Insights comparing error rates and P95 latencies between canary and stable instances. If the canary shows ≤5% higher error rate or ≤10% higher latency, proceed with weight increase. If metrics degrade significantly, roll back to 0% canary weight immediately.

Automated weight adjustment from performance data closes the loop. A background process runs hourly, compares rolling metrics for each instance, and adjusts weights to shift traffic toward better-performing instances. For Northwind Health, if the East US drug interaction instance consistently reports 420ms P95 while West US reports 350ms P95 over 4 hours, automatically adjust weights from [50, 50] to [30, 70] to favor the faster instance. This optimization happens continuously without manual intervention, adapting to infrastructure and network condition changes.

Now that you understand how to route tool invocations dynamically across instances based on health, latency, and canary weights, you're ready to implement governance workflows that manage tool versioning, compatibility validation, and deprecation lifecycles.

## Unit summary

- **Tool registries** provide runtime indirection from tool names to instance endpoints, enabling zero-downtime instance replacement by maintaining health status, version, and rolling latency metrics per instance
- **Latency-based routing** selects the instance with the best recent P95 latency after filtering out unhealthy instances, adapting to changing performance conditions without manual intervention
- **Weighted routing** distributes traffic by configured percentages for canary deployments — start at 5% canary weight, monitor error rates and latency for 24 hours, then gradually increase to 100%
- **Capability-based routing** extends latency selection by filtering instances by minimum version, ensuring requests requiring new features only reach instances that support them
- **Automated weight adjustment** closes the optimization loop — background processes compare rolling metrics across instances and shift traffic toward better-performing instances continuously
