MCP servers expose a tool manifest endpoint (`GET /tools`) and a tool invocation endpoint (`POST /tools/call`) that agents use to discover and invoke external capabilities. You've consumed pre-built MCP servers in previous work, where the agent called `GET /tools` to enumerate available tools and `POST /tools/call` to invoke them. This unit covers what you need when designing an MCP server for production use — hosting choices, authentication patterns, versioning strategies, and observability requirements that transform a proof-of-concept tool wrapper into an enterprise-grade service.

| Design Decision | Impact | Healthcare Example |
|----------------|--------|-------------------|
| Hosting choice | Latency, cost, scalability | Container Apps for variable load, Functions for infrequent calls |
| Authentication | Compliance, security | Managed Identity for HIPAA compliance, API keys for partner tools |
| Versioning strategy | Breaking changes, rollback | Semantic versioning prevents agent breakage |
| Observability | Debugging, SLA tracking | Correlation IDs link agent spans to tool invocations |

## Choose hosting options for MCP servers

Your hosting choice determines latency characteristics, scaling behavior, and operational costs. Azure Container Apps provides serverless scaling with fast startup times, making it suitable for clinical tools with variable invocation patterns. When drug interaction lookups spike during morning rounds, Container Apps scales instances automatically. When usage drops in the evening, it scales to zero to minimize costs.

Azure Functions offers event-driven execution with the lowest cost for infrequent invocations. For Northwind Health's monthly report generation tools that run once per billing cycle, Functions provides execution without maintaining idle capacity. The cold-start latency (500-1000ms) doesn't impact monthly workflows.

Dedicated Azure Container Registry with Azure Kubernetes Service supports latency-sensitive tools that can't tolerate cold starts. Real-time clinical decision support tools that must respond within 200ms run on warm AKS pods with predictable performance. This approach trades higher baseline costs for guaranteed latency.

## Implement authentication patterns for MCP servers

Managed Identity represents the recommended authentication pattern for MCP servers accessing Azure resources. The MCP server receives a system-assigned managed identity during deployment, and callers must present a valid Azure AD token to invoke tools. This approach eliminates credential management and meets healthcare compliance requirements for audit trails.

With Managed Identity, you validate the caller's identity within the MCP server request handler before executing tool logic. The validation checks the token's issuer, audience, and signature to ensure the request originates from an authorized agent. Azure AD provides automatic token rotation and revocation, reducing security operational overhead.

```python
from azure.identity import ManagedIdentityCredential
from mcp.server.fastmcp import FastMCP
import jwt
from functools import wraps

mcp = FastMCP("Northwind Clinical Tools")

def validate_azure_ad_token(f):
    """Decorator to validate Azure AD tokens on incoming MCP requests"""
    @wraps(f)
    async def wrapper(request, *args, **kwargs):
        auth_header = request.headers.get("Authorization")
        if not auth_header or not auth_header.startswith("Bearer "):
            return {"error": "missing_token", "status": 401}
        
        token = auth_header.split(" ")[1]
        try:
            # Validate token signature and claims
            decoded = jwt.decode(
                token,
                options={"verify_signature": False},  # Use JWKS in production
                audience="api://northwind-clinical-tools",
                algorithms=["RS256"]
            )

<!-- TODO NOTE for drift detector: SECURITY ISSUE — The jwt.decode() call above uses verify_signature=False, which skips cryptographic signature verification on the JWT. This is a security anti-pattern. An attacker could forge a token with valid-looking claims (correct aud, iss, roles) if signature verification is skipped. In a healthcare context (HIPAA), this is especially problematic. Replace this code sample with proper JWKS-based signature validation using python-jose or msal. Example: use JWKSClient to fetch signing keys from https://login.microsoftonline.com/{tenant_id}/discovery/v2.0/keys, then pass the signing key to jwt.decode(). The comment "Use JWKS in production" is insufficient — the code must demonstrate the correct production pattern, not the insecure shortcut. -->
            # Attach validated identity to request context
            request.state.caller_identity = decoded.get("oid")
            request.state.tenant_id = decoded.get("tid")
        except jwt.InvalidTokenError as e:
            return {"error": "invalid_token", "status": 401, "detail": str(e)}
        
        return await f(request, *args, **kwargs)
    return wrapper

@mcp.tool()
@validate_azure_ad_token
async def lookup_drug_interaction(request, drug_a: str, drug_b: str):
    """Check for interactions between two medications"""
    caller_id = request.state.caller_identity
    # Tool implementation with validated caller identity
    return {"interaction": "moderate", "caller": caller_id}
```

API key authentication supports external and partner tools where managed identity isn't available. Store API keys in Azure Key Vault, not environment variables, and rotate them on a quarterly schedule. For Northwind Health's integration with third-party lab systems, the MCP server retrieves the lab API key from Key Vault at startup and caches it with a 4-hour expiration.

OAuth 2.0 client credentials flows handle B2B tool integration where the tool provider requires their own authorization server. The MCP server acts as an OAuth client, requesting access tokens before forwarding tool invocations to the provider's API. This pattern maintains the provider's audit trail while abstracting OAuth complexity from agents.

## Version MCP servers for backward compatibility

MCP tool schemas evolve as requirements change. A drug interaction tool initially checking two medications might expand to support multi-drug interactions. You design for backward compatibility by ensuring new optional parameters don't break existing agents that call the tool with the original parameter set.

Version the entire MCP server, not individual tools. The URL pattern `https://tools.northwind.health/v1/tools` indicates version 1 of the entire tool catalog. When you introduce breaking changes — removing a required parameter, changing a response field type, or removing a tool — you deploy `/v2/tools` alongside `/v1/tools`. Agents explicitly opt into the new version during their deployment cycle.

```python
# Version 1: Original drug interaction tool
@mcp.tool(version="1.0")
async def lookup_drug_interaction(drug_a: str, drug_b: str):
    """Check interactions between two drugs"""
    return {"interaction": "moderate", "severity": "moderate"}

# Version 2: Expanded to support multiple drugs (backward compatible)
@mcp.tool(version="1.1")

<!-- TODO NOTE for drift detector: SUSPECT API — The @mcp.tool(version="1.0") and @mcp.tool(version="1.1") decorator parameters shown above likely do not exist in the FastMCP SDK. The standard @mcp.tool() decorator does not accept a 'version' keyword argument. Verify against the current mcp Python package (mcp.server.fastmcp). If the version parameter is not supported, restructure this example to use URL-prefix versioning (e.g., separate /v1/tools and /v2/tools MCP server registrations) as described in the surrounding prose, rather than decorator-level versioning. Learners who try to replicate @mcp.tool(version="1.0") will get an 'unexpected keyword argument' TypeError. -->
async def lookup_drug_interaction(
    drug_a: str, 
    drug_b: str,
    additional_drugs: list[str] = None  # Optional parameter
):
    """Check interactions between multiple drugs"""
    drugs = [drug_a, drug_b] + (additional_drugs or [])
    # Implementation checks all combinations
    return {"interaction": "moderate", "severity": "moderate", "drugs_checked": len(drugs)}
```

Breaking changes require a major version increment and a deprecation period. When Northwind Health restructures the drug interaction response format from `{"severity": "moderate"}` to `{"severity": {"level": "moderate", "clinical_significance": "monitor"}}`, this constitutes a breaking change. Deploy version 2.0 with the new format while maintaining version 1.0 for six months, allowing agent teams time to update their response parsing logic.

## Implement structured logging for MCP servers

Production MCP servers log every tool invocation with structured data that supports debugging, security audits, and performance analysis. Log the tool name, input parameters (scrubbed of PHI), response time, success or failure status, and the caller's agent ID. Use correlation IDs from the caller to link agent spans to tool spans in distributed tracing.

Structured JSON logs to Application Insights enable querying across invocations. When a drug interaction tool starts failing for a specific medication pair, you query logs filtering by `tool_name: "lookup_drug_interaction"` and `parameters.drug_a: "warfarin"` to identify the pattern. Correlation IDs let you trace the entire request path from agent decision to tool invocation to downstream API call.

```python
import logging
import json
import time
from functools import wraps

# Configure structured logging
logger = logging.getLogger("mcp_server")
handler = logging.StreamHandler()
handler.setFormatter(logging.Formatter('%(message)s'))
logger.addHandler(handler)
logger.setLevel(logging.INFO)

def log_mcp_invocation(f):
    """Decorator to log MCP tool invocations with structured data"""
    @wraps(f)
    async def wrapper(*args, **kwargs):
        start_time = time.time()
        correlation_id = kwargs.get("correlation_id", "unknown")
        tool_name = f.__name__
        
        # Scrub PII from parameters before logging
        safe_kwargs = {k: v for k, v in kwargs.items() if k != "patient_id"}
        
        try:
            result = await f(*args, **kwargs)
            duration_ms = (time.time() - start_time) * 1000
            
            logger.info(json.dumps({
                "event": "mcp_tool_invocation",
                "tool_name": tool_name,
                "correlation_id": correlation_id,
                "duration_ms": duration_ms,
                "status": "success",
                "parameters": safe_kwargs,
                "timestamp": time.time()
            }))
            return result
        except Exception as e:
            duration_ms = (time.time() - start_time) * 1000
            logger.error(json.dumps({
                "event": "mcp_tool_invocation",
                "tool_name": tool_name,
                "correlation_id": correlation_id,
                "duration_ms": duration_ms,
                "status": "error",
                "error_type": type(e).__name__,
                "error_message": str(e),
                "parameters": safe_kwargs,
                "timestamp": time.time()
            }))
            raise
    return wrapper

@mcp.tool()
@log_mcp_invocation
async def lookup_drug_interaction(drug_a: str, drug_b: str, correlation_id: str = None):
    """Check for interactions between two medications"""
    # Tool implementation
    return {"interaction": "moderate"}
```

These structured logs feed performance dashboards that track P50, P95, and P99 latencies per tool. When Northwind Health commits to 500ms P95 latency for drug interaction lookups, Application Insights dashboards show real-time compliance. Correlation IDs enable end-to-end tracing: an agent timeout investigation starts with the agent's correlation ID and traces through MCP server logs to identify which downstream API call exceeded SLA.

## Extended hosting options for MCP servers

The three hosting tiers (Container Apps, Functions, AKS) cover most workloads. Two additional Azure services serve specialized roles in MCP architectures:

- **Azure API Management (APIM)** \u2014 acts as a gateway in front of your MCP server fleet, providing policy enforcement (rate limiting, IP filtering, JWT validation at the edge), product-level API keys, and a developer portal for tool discovery. APIM is not an MCP server host itself; it fronts Container Apps or AKS-hosted MCP servers to add governance without modifying server code. Use it when you serve multiple external partners each needing their own API key and quota.
- **Azure Logic Apps** \u2014 provides a low-code option for simple tool wrappers around enterprise connectors (SharePoint, ServiceNow, SAP). If your MCP tool's only function is to read/write a SharePoint list, Logic Apps eliminates the need to write and host a Python MCP server. The tradeoff is reduced control over error handling and latency.

## When to use MCP versus direct integration

Not every tool needs an MCP server. Wrapping each integration in MCP adds architectural overhead — authentication, versioning, discovery — that delivers value when multiple agents share tools, when tools evolve independently of agents, or when governance requirements demand a structured tool registry. The decision framework:

| Criterion | Use MCP | Use direct integration |
|---|---|---|
| **Number of consuming agents** | 2 or more agents need the same tool | Only one agent ever calls this integration |
| **Tool reuse and discovery** | Tools are discoverable and used across teams | One-off integration specific to one agent |
| **Independent versioning** | Tool and agent evolve on different release cycles | Tool and agent deploy together always |
| **Governance requirements** | Tools must be audited, rate-limited, or approved before agent use | No governance gate required |
| **Ecosystem complexity** | Integrating 5+ external systems | Integrating a single well-defined API |

For Northwind Health, drug interaction lookups and formulary access are shared across five different clinical agents \u2014 MCP is justified. A one-time ETL pipeline that the data-ingestion agent alone uses is better served by a direct function call with no MCP overhead.

Now that you understand production MCP server architecture — hosting choices, authentication patterns, versioning strategies, and observability requirements — you're ready to implement reliability features that handle failures gracefully.

## Unit summary

- **Hosting choice** determines latency and cost characteristics — Container Apps for variable-load tools with auto-scaling, Functions for infrequent invocations, and AKS for latency-sensitive tools requiring warm pods
- **Managed Identity authentication** eliminates credential management and meets compliance requirements, while OAuth 2.0 client credentials handle B2B integrations with external tool providers
- **Server-level versioning** (URL-prefix `/v1/`, `/v2/`) is preferred over individual tool versioning — deploy breaking changes as new versions alongside existing ones with deprecation periods
- **Structured JSON logging** with correlation IDs enables end-to-end distributed tracing from agent decision through MCP server to downstream API calls, supporting both debugging and SLA compliance dashboards
- **Backward compatibility** is preserved by adding optional parameters rather than changing required ones — new capabilities extend the tool schema without breaking existing agent integrations
