When Fabrikam's code review agents serve 20+ enterprise tenants from shared Azure OpenAI deployments, resource contention becomes inevitable. A single tenant running a large batch code review—processing 500 files simultaneously during a sprint retrospective—can exhaust available tokens per minute (TPM) quota, causing request failures and timeouts for all other tenants trying to submit code. Without quota enforcement and rate limiting, one customer's usage surge degrades service quality for everyone. Implementing fair resource allocation requires multi-level quota architecture, tenant-based rate limiting, priority-tier allocation, and resilient quota-exceeded handling in agent code.

| Resource Control | Uncontrolled System | Quota-Governed System |
|------------------|---------------------|----------------------|
| Capacity allocation | First-come, first-served (unfair) | Proportional by tier (fair) |
| Overload behavior | Global degradation | Isolated to heavy users |
| Cost predictability | Unlimited spikes | Capped per tenant |

## Understand the quota storm problem

The quota storm scenario occurs when resource demand exceeds supply, and no controls prevent one consumer from monopolizing capacity. In Fabrikam's multi-agent deployment, the bottleneck is Azure OpenAI API quota measured in tokens per minute. Each model deployment has a maximum TPM determined by Azure capacity allocation. For example, the GPT-4 Turbo deployment might have 240,000 TPM available across all tenants.

During normal operation, tenant usage stays well below capacity—most code submissions are small individual file reviews consuming 2,000-5,000 tokens each. Requests process quickly, and quota headroom remains high. However, when one tenant triggers batch processing of an entire microservice repository (200 files, 500,000 tokens total), the quota consumption spikes. If that batch processes as 50 concurrent requests, it attempts to consume 50,000+ TPM for several minutes.

Without quota controls, this surge causes cascading failures. Other tenants submitting code reviews receive 429 (Too Many Requests) errors because the quota is exhausted. Concurrent agent invocations within the orchestrator retry failed requests, amplifying the load. The batch job itself experiences partial failures as some requests succeed while others fail, creating inconsistent review results. During the 3-5 minute quota storm, all tenants experience degraded service.

The problem compounds in multi-agent workflows because each agent in the pipeline makes separate API calls. A single code submission flows through preprocessing (1 API call), quality assessment (1 call), security analysis (1 call), and architectural review (1 call)—consuming quota at four different points. When batch processing hits the pipeline, it's not just one tenant's requests competing for quota, but one tenant's multi-stage workflow overwhelming the system.

## Design multi-level quota architecture

Effective quota governance requires controls at three levels: model API quotas at the Azure OpenAI service level, agent-level quotas controlling access to individual agents, and tenant-level quotas capping total consumption per customer.

**Model API quotas** are configured in Azure OpenAI service deployments. Each model deployment has a TPM limit set based on your subscription allocation. You create separate deployments for different purposes: a `gpt-4-turbo-production` deployment with 200,000 TPM for customer-facing agents, a `gpt-4-turbo-batch` deployment with 40,000 TPM specifically for batch processing workloads, and a `gpt-4-turbo-internal` deployment with 20,000 TPM for Fabrikam's internal testing and development.

This separation prevents batch workloads from impacting interactive usage. When a tenant runs a large batch review, it routes to the batch deployment with lower TPM but dedicated capacity. Interactive single-file reviews use the production deployment with higher capacity optimized for latency. The deployments are isolated—exhausting quota on the batch deployment doesn't affect the production deployment.

**Agent-level quotas** control requests per minute to each agent API. You implement these using Azure API Management (APIM) rate-limit policies. Each agent has a published API endpoint through APIM, and you configure rate limits based on the agent's capacity and typical usage. The security analyzer endpoint allows 1,000 requests per minute globally. The preprocessing agent, which handles higher volume since it's the entry point for all code reviews, allows 2,000 requests per minute.

These limits are global across all tenants, preventing any coordination failure in the orchestrator from overwhelming a single agent with requests. Even if orchestrator code has a bug that creates an infinite loop calling the security analyzer, APIM enforces the 1,000 RPM limit, rejecting excess requests rather than cascading the failure to the agent.

**Tenant-level quotas** cap individual customer resource consumption. Each tenant has allocated request limits based on their subscription tier: Enterprise Premium tier gets 500 requests per hour, Enterprise Standard gets 200 requests per hour, and Developer tier gets 50 requests per hour. You also set token consumption caps: Premium tier can consume up to 2 million tokens per day, Standard tier 750,000 tokens per day, and Developer tier 100,000 tokens per day.

These quotas prevent cost surprises and ensure resource fairness. A Developer tier tenant running excessive requests can't exhaust capacity needed by Premium tier customers who pay for higher allocations. The quota enforcement happens at the API gateway before requests reach agents, providing early rejection with clear error messages.

## Implement tenant-based rate limiting with APIM

Azure API Management enforces tenant quotas using the `rate-limit-by-key` policy keyed on tenant identifiers. Each API request to Fabrikam's agent endpoints includes a tenant ID in the request headers (injected by the orchestrator based on the code submission source). APIM extracts this tenant ID and applies quota rules.

```xml
<policies>
    <inbound>
        <!-- Extract tenant ID from request header -->
        <set-variable name="tenantId" value="@(context.Request.Headers.GetValueOrDefault("X-Tenant-ID", "unknown"))" />
        
        <!-- Look up tenant quota tier from APIM named values or external cache -->
        <set-variable name="quotaTier" value="@{
            var tenantId = (string)context.Variables["tenantId"];
            // In production, look up from cache or database
            // Simplified example:
            if (tenantId.StartsWith("premium-")) return "premium";
            if (tenantId.StartsWith("standard-")) return "standard";
            return "developer";
        }" />
        
        <!-- Apply rate limit based on tier -->
        <choose>
            <when condition="@((string)context.Variables["quotaTier"] == "premium")">
                <rate-limit-by-key calls="500" renewal-period="3600" 
                                 counter-key="@((string)context.Variables["tenantId"])" />
            </when>
            <when condition="@((string)context.Variables["quotaTier"] == "standard")">
                <rate-limit-by-key calls="200" renewal-period="3600" 
                                 counter-key="@((string)context.Variables["tenantId"])" />
            </when>
            <otherwise>
                <rate-limit-by-key calls="50" renewal-period="3600" 
                                 counter-key="@((string)context.Variables["tenantId"])" />
            </otherwise>
        </choose>
        
        <!-- Allow burst capacity: short-term exceeds with lower sustained rate -->
        <quota-by-key calls="600" renewal-period="3600" 
                     counter-key="@((string)context.Variables["tenantId"])" />
    </inbound>
    <backend>
        <forward-request />
    </backend>
    <outbound>
        <!-- Include quota usage in response headers -->
        <set-header name="X-Quota-Remaining" exists-action="override">
            <value>@(context.Response.Headers.GetValueOrDefault("RateLimit-Remaining", "0"))</value>
        </set-header>
    </outbound>
    <on-error>
        <!-- Return structured error for quota exceeded -->
        <return-response>
            <set-status code="429" reason="Too Many Requests" />
            <set-header name="Retry-After" exists-action="override">
                <value>60</value>
            </set-header>
            <set-body>@{
                return new JObject(
                    new JProperty("error", "quota_exceeded"),
                    new JProperty("message", "Tenant request quota exceeded. Current tier allows " + 
                                 context.Variables["quotaTier"] + " requests per hour."),
                    new JProperty("retry_after_seconds", 60)
                ).ToString();
            }</set-body>
        </return-response>
    </on-error>
</policies>
```

This policy implements several sophisticated controls. The `rate-limit-by-key` provides short-term rate limiting preventing request bursts, while `quota-by-key` enforces longer-term capacity limits. The burst allowance means a Premium tier tenant can briefly exceed 500 requests per hour during a legitimate spike, but sustained overuse is blocked.

The quota counters are scoped per tenant—each tenant's quota consumption increments independently. When tenant A exhausts their quota, they receive 429 responses while tenant B's requests continue succeeding. This isolation prevents one tenant's behavior from affecting others.

## Allocate quota by priority tier

Fair doesn't always mean equal. Premium tier customers paying higher subscription fees expect better service quality than Developer tier users. You implement priority-based quota allocation where premium customers get preferential access to capacity during high-demand periods.

The priority allocation works through reserved capacity and dynamic allocation. Premium tier customers have reserved capacity: 60% of total model quota is reserved exclusively for premium tenants. Standard tier customers have 30% reserved capacity. Developer tier gets 10% reserved capacity. During normal operation when demand is below capacity, all tiers access the full quota pool—a Developer tier tenant can use more than 10% if it's available.

When total demand exceeds capacity—approaching the model deployment's TPM limit—the reservation enforcement activates. Premium requests are prioritized in the queue. Standard tier requests may experience throttling to stay within their 30% allocation. Developer tier requests are most aggressively throttled to ensure they don't exceed 10% of capacity.

This dynamic allocation is implemented through weighted rate limiting in APIM combined with Azure OpenAI's automatic throttling. You configure priority headers in agent requests that Azure OpenAI consults during high-load periods:

```python
# When invoking Azure OpenAI from agent code, include priority header
headers = {
    "api-key": azure_openai_key,
    "Content-Type": "application/json",
    "X-Request-Priority": get_tenant_priority(tenant_id)  # Returns: high, medium, low
}

response = requests.post(
    f"{azure_openai_endpoint}/openai/deployments/{deployment_name}/chat/completions",
    headers=headers,
    json=payload
)
```

Azure OpenAI honors the priority header during throttling—high-priority requests are more likely to succeed when quota is constrained. This doesn't guarantee premium tenants never experience throttling, but ensures they're throttled last and least aggressively.

## Handle quota exceeded gracefully in agent code

When an agent invocation receives a 429 response indicating quota exceeded, the agent must handle this gracefully rather than failing immediately. You implement exponential backoff with jitter, request queuing, and structured error reporting.

```python
import time
import random
import logging
from typing import Dict, Any

class QuotaAwareAgentClient:
    """Agent client wrapper with quota-exceeded handling and exponential backoff."""
    
    def __init__(self, agent_endpoint: str, max_retries: int = 5):
        self.agent_endpoint = agent_endpoint
        self.max_retries = max_retries
        self.logger = logging.getLogger(__name__)
    
    def invoke_agent(self, payload: Dict[str, Any], tenant_id: str) -> Dict[str, Any]:
        """
        Invoke agent with automatic retry on quota exceeded (429).
        
        Implements exponential backoff with jitter to prevent thundering herd.
        """
        attempt = 0
        base_delay = 2  # Start with 2 second delay
        
        while attempt < self.max_retries:
            try:
                response = self._make_request(payload, tenant_id)
                
                if response.status_code == 200:
                    return response.json()
                
                elif response.status_code == 429:
                    # Quota exceeded - implement exponential backoff
                    retry_after = int(response.headers.get('Retry-After', base_delay * (2 ** attempt)))
                    
                    # Add jitter: randomize delay between 50%-100% of calculated backoff
                    jitter = random.uniform(0.5, 1.0)
                    delay = retry_after * jitter
                    
                    self.logger.warning(
                        f"Quota exceeded for tenant {tenant_id}. "
                        f"Attempt {attempt + 1}/{self.max_retries}. "
                        f"Retrying in {delay:.2f} seconds."
                    )
                    
                    # Log quota event for monitoring
                    self._log_quota_event(tenant_id, attempt, delay)
                    
                    time.sleep(delay)
                    attempt += 1
                
                else:
                    # Non-quota error - fail immediately
                    response.raise_for_status()
            
            except Exception as e:
                self.logger.error(f"Agent invocation failed: {e}")
                if attempt >= self.max_retries - 1:
                    raise
                attempt += 1
        
        # Max retries exceeded - return structured error
        return {
            'error': 'quota_exceeded_persistent',
            'message': f'Agent quota exceeded after {self.max_retries} retry attempts',
            'tenant_id': tenant_id,
            'retry_count': self.max_retries,
            'recommendation': 'Request queued for later processing or upgrade subscription tier'
        }
    
    def _make_request(self, payload: Dict[str, Any], tenant_id: str):
        """Make HTTP request to agent endpoint with tenant context."""
        import requests
        
        headers = {
            'X-Tenant-ID': tenant_id,
            'Content-Type': 'application/json'
        }
        
        return requests.post(self.agent_endpoint, json=payload, headers=headers)
    
    def _log_quota_event(self, tenant_id: str, attempt: int, delay: float):
        """Log quota event to Application Insights for monitoring."""
        from applicationinsights import TelemetryClient
        
        telemetry = TelemetryClient('<instrumentation-key>')
        
        telemetry.track_event(
            'QuotaExceeded',
            {
                'tenant_id': tenant_id,
                'retry_attempt': attempt,
                'backoff_delay_seconds': delay,
                'agent_endpoint': self.agent_endpoint
            },
            {
                'delay_seconds': delay
            }
        )
        telemetry.flush()
```

The exponential backoff prevents the "thundering herd" problem where all throttled requests retry simultaneously, creating another quota surge. By adding jitter—randomizing the delay between 50% and 100% of the calculated backoff—requests spread out over time. When 100 requests hit quota limits simultaneously, they retry at staggered intervals rather than all retrying at exactly the same moment.

The structured error response ensures quota failures are visible to the orchestrator. If an agent can't complete after max retries, the orchestrator can make routing decisions: queue the code review for later processing when quota availability improves, notify the tenant that their quota is exhausted with options to upgrade their subscription tier, or route to a fallback agent using a different model deployment with available quota.

> [!TIP]
> **Pause and reflect:** A premium-tier customer submits a 500-file batch review at the same time a standard-tier customer submits a single urgent security scan. Your shared Azure OpenAI deployment is at 85% TPM capacity. How would you configure your quota architecture to ensure both customers get acceptable service?

With comprehensive quota governance in place—multi-level architecture separating batch and interactive workloads, tenant-based rate limiting with priority tiers, and resilient quota handling with exponential backoff—you ensure Fabrikam's multi-agent platform provides fair, predictable resource allocation across all enterprise customers. The next governance challenge is making AI costs transparent and attributable so teams understand and can optimize their spending.

## Unit summary

- **Quota storms** occur when one tenant's batch processing exhausts shared Azure OpenAI TPM capacity, causing cascading 429 errors for all tenants.
- **Multi-level architecture** separates model API quotas, agent-level rate limits, and tenant-level consumption caps to isolate overload to individual consumers.
- **APIM rate limiting** applies tenant-specific quotas using `rate-limit-by-key` policies that enforce tier-based request and token limits at the API gateway.
- **Priority-tier allocation** reserves capacity proportionally—60% for premium, 30% for standard, 10% for developer—with dynamic enforcement during high-demand periods.
- **Exponential backoff with jitter** prevents thundering herd retries when quota is exceeded, spreading retry attempts over time to avoid amplifying load spikes.

## Check your understanding

**1. A premium tenant and a developer tenant both submit requests when the system is at 90% capacity. How should the quota system handle this?**

- A. Process both requests equally on a first-come, first-served basis
- B. The premium tenant's request proceeds using its reserved capacity allocation, while the developer tenant's request is rate-limited or queued based on its lower priority tier
- C. Reject both requests until capacity drops below 80%

***Correct answer: B.*** Priority-tier allocation reserves capacity proportionally (e.g., 60% premium, 30% standard, 10% developer). During high demand, each tier is enforced — premium tenants access their reserved capacity while lower-priority requests are throttled.
