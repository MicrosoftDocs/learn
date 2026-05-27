Azure-hosted MCP servers depend on external APIs that can fail, slow down, or become temporarily unavailable. Retry patterns, circuit breakers, and graceful degradation responses keep your MCP server functional when dependencies fail, preventing cascading failures that disrupt entire agent workflows.

| Error Type | Retry Strategy | Example Scenario |
|------------|----------------|------------------|
| Transient | Exponential backoff with jitter | Network timeout on drug lookup |
| Permanent | Return structured error immediately | Invalid medication code |
| Degraded | Log warning, proceed with limited data | API responds slowly but successfully |

## Distinguish error types for appropriate handling

Not all errors warrant retry logic. Transient errors—network timeouts, HTTP 503 service unavailable, rate limit 429 responses—represent temporary conditions where retry with backoff succeeds. When Northwind Health's drug interaction API returns 503 during a brief deployment, retrying after 2 seconds reaches the newly deployed instance.

Permanent errors indicate problems that won't resolve through retry. A 400 bad request with "invalid medication code" means the requested drug identifier doesn't exist in the formulary. Retrying this request wastes compute and delays the error response to the agent. Return a structured error immediately with enough detail for the agent to formulate an appropriate response to the clinician.

Degraded service represents a third category where the tool remains functional but performs below SLA. When the drug interaction API responds in 800ms instead of the 500ms target, log this as a warning in Application Insights but proceed with the result. The agent receives valid interaction data, and the performance logs trigger investigation into the degradation root cause.

## Implement retry with exponential backoff and jitter

Exponential backoff spaces retry attempts with increasing delays, preventing retry storms that overwhelm recovering services. Start with a base delay of 1 second. After the first failure, wait 1 second before retry. After the second failure, wait 2 seconds. After the third failure, wait 4 seconds. This pattern gives downstream services time to recover between retry attempts.

Add jitter to prevent thundering herd problems when multiple agents experience the same failure simultaneously. Without jitter, agents that receive the same 503 error retry simultaneously, overwhelming a recovering service and cascading the failure. With jitter, each agent adds a random offset (0–1000ms) to the calculated delay, distributing retries across time.

```python
import asyncio
import random
from functools import wraps
from tenacity import retry, stop_after_attempt, wait_exponential_jitter

def mcp_retry_with_backoff(
    max_attempts=3,
    base_delay_seconds=1,
    max_delay_seconds=30
):
    """Decorator for MCP tool methods that implements retry with exponential backoff and jitter"""
    return retry(
        stop=stop_after_attempt(max_attempts),
        wait=wait_exponential_jitter(
            initial=base_delay_seconds,
            max=max_delay_seconds,
            jitter=1.0  # Full jitter range
        ),
        reraise=True
    )

@mcp.tool()
@mcp_retry_with_backoff(max_attempts=3, base_delay_seconds=1, max_delay_seconds=10)
async def lookup_drug_interaction(drug_a: str, drug_b: str):
    """Check for interactions between two medications with automatic retry"""
    async with httpx.AsyncClient() as client:
        response = await client.post(
            "https://api.northwind.health/drug-interactions",
            json={"drug_a": drug_a, "drug_b": drug_b},
            timeout=2.0
        )
        
        # Raise on transient errors to trigger retry
        if response.status_code in [429, 500, 502, 503, 504]:
            response.raise_for_status()
        
        # Don't retry permanent errors
        if response.status_code == 400:
            return {
                "status": "error",
                "error_type": "invalid_input",
                "message": response.json().get("detail")
            }
        
        return response.json()
```

Maximum retry limits prevent infinite retry loops. Set the limit based on tool urgency: drug interaction lookups critical to prescribing decisions warrant 5 retry attempts over 31 seconds (1 + 2 + 4 + 8 + 16), while appointment scheduling tolerates 3 attempts over 7 seconds (1 + 2 + 4). The agent timeout should exceed the maximum possible retry duration to avoid prematurely canceling retry sequences.

## Implement circuit breaker for fast failure

Circuit breakers prevent cascading failures by detecting repeated failures and failing fast instead of waiting for timeout after timeout. The circuit breaker maintains three states: Closed (normal operation, requests flow through), Open (failing, reject requests immediately), and Half-Open (testing recovery with limited requests).

Trip the circuit to Open state after N consecutive failures or when the error rate exceeds a threshold. For Northwind Health's drug interaction tool, open the circuit after 5 consecutive timeouts or when 30% of requests fail within a 60-second window. Opening the circuit returns structured errors immediately without attempting network calls, preventing agent threads from blocking on doomed requests.

```python
import time
from enum import Enum
from dataclasses import dataclass
from typing import Optional

class CircuitState(Enum):
    CLOSED = "closed"
    OPEN = "open"
    HALF_OPEN = "half_open"

@dataclass
class CircuitBreakerConfig:
    failure_threshold: int = 5  # Consecutive failures to open
    recovery_timeout: float = 30.0  # Seconds before testing recovery
    success_threshold: int = 2  # Successes in half-open to close

class CircuitBreaker:
    def __init__(self, config: CircuitBreakerConfig):
        self.config = config
        self.state = CircuitState.CLOSED
        self.failure_count = 0
        self.success_count = 0
        self.last_failure_time: Optional[float] = None
    
    def call(self, func, *args, **kwargs):
        """Execute function through circuit breaker"""
        if self.state == CircuitState.OPEN:
            # Check if recovery timeout elapsed
            if time.time() - self.last_failure_time >= self.config.recovery_timeout:
                self.state = CircuitState.HALF_OPEN
                self.success_count = 0
            else:
                raise CircuitBreakerOpenError(
                    f"Circuit open, next attempt in {self._time_until_recovery():.1f}s"
                )
        
        try:
            result = func(*args, **kwargs)
            self._on_success()
            return result
        except Exception as e:
            self._on_failure()
            raise
```

The state management methods track successes and failures to determine circuit transitions. In Half-Open state, consecutive successes close the circuit back to normal operation, while any failure reopens it immediately.

```python
    def _on_success(self):
        """Handle successful call"""
        if self.state == CircuitState.HALF_OPEN:
            self.success_count += 1
            if self.success_count >= self.config.success_threshold:
                self.state = CircuitState.CLOSED
                self.failure_count = 0
        elif self.state == CircuitState.CLOSED:
            self.failure_count = 0
    
    def _on_failure(self):
        """Handle failed call"""
        self.failure_count += 1
        self.last_failure_time = time.time()
        
        if self.failure_count >= self.config.failure_threshold:
            self.state = CircuitState.OPEN
        elif self.state == CircuitState.HALF_OPEN:
            self.state = CircuitState.OPEN
    
    def _time_until_recovery(self) -> float:
        """Calculate seconds until recovery attempt"""
        if self.last_failure_time is None:
            return 0
        elapsed = time.time() - self.last_failure_time
        return max(0, self.config.recovery_timeout - elapsed)

class CircuitBreakerOpenError(Exception):
    """Raised when circuit breaker is open"""
    pass
```

With the circuit breaker class defined, create a global instance configured for Northwind Health's drug interaction service. The MCP tool wraps API calls through the circuit breaker and returns structured fallback responses when the circuit opens, allowing agents to communicate service unavailability gracefully.

```python
# Global circuit breaker for drug interaction service
drug_interaction_circuit = CircuitBreaker(
    CircuitBreakerConfig(
        failure_threshold=5,
        recovery_timeout=30.0,
        success_threshold=2
    )
)

@mcp.tool()
async def lookup_drug_interaction(drug_a: str, drug_b: str):
    """Check for interactions between two medications with circuit breaker protection"""
    try:
        result = drug_interaction_circuit.call(
            _call_drug_interaction_api,
            drug_a,
            drug_b
        )
        return result
    except CircuitBreakerOpenError as e:
        # Return structured fallback when circuit is open
        return {
            "status": "unavailable",
            "reason": "service_circuit_open",
            "fallback": "consult_pharmacist",
            "retry_after_seconds": drug_interaction_circuit._time_until_recovery(),
            "message": str(e)
        }

def _call_drug_interaction_api(drug_a: str, drug_b: str):
    """Internal method that actually calls the drug interaction API"""
    response = requests.post(
        "https://api.northwind.health/drug-interactions",
        json={"drug_a": drug_a, "drug_b": drug_b},
        timeout=2.0
    )
    response.raise_for_status()
    return response.json()
```

After the recovery timeout expires (30 seconds), transition to Half-Open state and allow one test request through. If the test succeeds, close the circuit and resume normal operation. If it fails, immediately reopen the circuit for another recovery timeout period. This prevents prematurely reopening service that remains unstable.

## Design graceful degradation fallback responses

When a tool remains unavailable after retries and the circuit opens, return structured fallback responses that agents can handle gracefully rather than generic errors. For Northwind Health's drug interaction tool, the fallback response includes `"status": "unavailable"`, `"reason": "service_circuit_open"`, and `"fallback": "consult_pharmacist"`. The agent incorporates this guidance into its response: "I'm unable to check for drug interactions automatically right now. Please consult with the pharmacy team before prescribing."

Fallback responses preserve workflow continuity while maintaining safety. The agent doesn't pretend no interaction exists (unsafe), nor does it refuse to assist entirely (poor user experience). Instead, it escalates to manual review—appropriate when automated checks fail. The `retry_after_seconds` field lets the agent provide specific guidance: "The interaction checker will be available again in approximately 25 seconds."

Health check endpoints support proactive circuit management. Production MCP servers expose a `/health` endpoint that checks downstream dependencies before they fail. The health check connects to the drug interaction database, validates API keys, and tests downstream service availability with lightweight requests. Agent health monitoring polls this endpoint every 30 seconds to preemptively open circuit breakers before real tool invocations fail.

```python
from fastapi import FastAPI
from typing import Dict

app = FastAPI()

@app.get("/health")
async def health_check() -> Dict[str, str]:
    """Health check endpoint for MCP server and dependencies"""
    health_status = {"status": "healthy", "checks": {}}
    
    # Check drug interaction API connectivity
    try:
        response = requests.get(
            "https://api.northwind.health/health",
            timeout=1.0
        )
        health_status["checks"]["drug_interaction_api"] = (
            "healthy" if response.status_code == 200 else "degraded"
        )
    except requests.RequestException:
        health_status["checks"]["drug_interaction_api"] = "unhealthy"
        health_status["status"] = "unhealthy"
    
    # Check circuit breaker state
    health_status["checks"]["drug_interaction_circuit"] = (
        drug_interaction_circuit.state.value
    )
    if drug_interaction_circuit.state == CircuitState.OPEN:
        health_status["status"] = "degraded"
    
    return health_status
```

These health checks enable external monitoring systems to detect failures before they impact agent performance. When the drug interaction API health check fails three consecutive times, Azure Monitor sends alerts to the on-call engineer and automatically scales additional API instances. By the time the circuit breaker would have opened, the scaling response has already restored service capacity.

> [!TIP]
> **Pause and reflect:** Your MCP server's drug interaction tool has a circuit breaker that opens after 5 consecutive failures with a 30-second recovery timeout. During a 10-minute network partition, the circuit keeps cycling between Open and Half-Open states. How would you adjust the circuit breaker configuration and fallback strategy to provide the best clinician experience during extended outages?

Now that you understand reliability patterns for individual tools—retry, circuit breakers, and graceful degradation—you're ready to implement dynamic routing that distributes load across multiple tool instances based on health and performance metrics.

## Unit summary

- **Error classification** determines the response—transient errors (timeouts, 503s) warrant exponential backoff with jitter, permanent errors (400 bad request) return structured errors immediately, and degraded responses proceed with a logged warning
- **Exponential backoff with jitter** prevents retry storms by spacing attempts with increasing delays and random offsets, distributing retry load across time when multiple agents fail simultaneously
- **Circuit breakers** maintain three states (Closed, Open, Half-Open) to fail fast when services are down—open after N consecutive failures, test recovery after a timeout, and close after successful test requests
- **Graceful degradation fallbacks** preserve workflow continuity by returning structured guidance (like "consult pharmacist") rather than generic errors, enabling agents to escalate appropriately when automated checks fail
- **Health check endpoints** enable proactive circuit management by detecting dependency failures before real tool invocations fail, allowing monitoring systems to trigger scaling responses preemptively

## Check your understanding

**1. A clinical MCP tool for drug interaction checking has failed 3 consecutive times due to a downstream API timeout. What should happen on the next invocation?**

- A. Retry the request immediately with a longer timeout
- B. The circuit breaker should be open, returning a fast failure response without calling the downstream API
- C. Queue the request and process it when the downstream API recovers

***Correct answer: B.*** After consecutive failures exceed the threshold, the circuit breaker opens and stops sending requests to the failing dependency. This prevents cascading failures and returns a fast, predictable response (such as a "consult pharmacist" fallback) instead of waiting for another timeout.
