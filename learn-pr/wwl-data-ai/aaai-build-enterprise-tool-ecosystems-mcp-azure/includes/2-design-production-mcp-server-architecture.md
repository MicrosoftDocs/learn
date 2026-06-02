Azure provides several hosting options for MCP servers—including Container Apps, App Service, Azure Functions, and AKS—each with different scaling, cost, and authentication characteristics. Selecting the right combination of hosting, authentication, versioning, and observability patterns determines whether your MCP server meets production reliability and compliance requirements.

| Design Decision | Impact | Healthcare Example |
|----------------|--------|-------------------|
| Hosting choice | Latency, cost, scalability | Container Apps for variable load, App Service for existing web apps, Functions for event-driven tools |
| Authentication | Compliance, security | Managed Identity for HIPAA compliance, API keys for partner tools |
| Versioning strategy | Breaking changes, rollback | Semantic versioning prevents agent breakage |
| Observability | Debugging, SLA tracking | Correlation IDs link agent spans to tool invocations |

## Choose hosting options for MCP servers

Your hosting choice determines latency characteristics, scaling behavior, and operational costs. Azure Container Apps provides serverless scaling with fast startup times, making it suitable for clinical tools with variable invocation patterns. When drug interaction lookups spike during morning rounds, Container Apps scales instances automatically. When usage drops in the evening, it scales to zero to minimize costs. For production MCP servers serving agents with latency requirements, scale-to-zero introduces cold-start delays that can break SLAs—set `--min-replicas 1` to keep at least one warm instance running.

Azure Functions offers event-driven execution for stateless, independent tools with per-invocation pricing. The Azure Functions MCP extension maps function triggers directly to MCP tools and exposes them at `/runtime/webhooks/mcp`, making it the recommended hosting path when integrating MCP servers with Foundry Agent Service. For interactive clients with latency requirements, use a Flex Consumption or Premium plan rather than the standard Consumption plan to avoid cold-start delays. Azure Functions also supports a second, self-hosted approach—building MCP servers with the official MCP Python, TypeScript, C#, or Java SDKs and deploying them as Flex Consumption plan apps, where the endpoint is `/mcp` instead of `/runtime/webhooks/mcp`. This self-hosted SDK approach is currently in public preview; the MCP extension approach is the recommended GA path.

Azure Kubernetes Service (AKS) is appropriate when your team already manages an AKS cluster and wants to colocate MCP servers with existing AI workloads, or when you need capabilities beyond managed container platforms—GPU node pools, custom Kubernetes networking (CNI, Istio service mesh), or fine-grained KEDA-based autoscaling. Container Apps with `--min-replicas 1` achieves warm-pod latency with significantly less operational overhead for most clinical tool scenarios.

Azure App Service provides code-based deployment without a Dockerfile or container registry, making it the lowest-friction path for teams adding MCP capabilities to an existing web application. Mount the FastMCP endpoint alongside your existing FastAPI or Flask routes and redeploy. App Service supports built-in Microsoft Entra ID authentication at the platform level, so token validation happens before requests reach your MCP code.

## Implement authentication patterns for MCP servers

Managed Identity represents the recommended authentication pattern for MCP servers accessing Azure resources. The MCP server receives a system-assigned managed identity during deployment, and callers must present a valid Azure AD token to invoke tools. This approach eliminates credential management and meets healthcare compliance requirements for audit trails.

With Managed Identity, you configure authentication at the hosting platform level rather than writing token validation code in your MCP server. Azure Container Apps and Azure Functions both support built-in Entra ID authentication that validates the incoming bearer token—checking the issuer, audience, and cryptographic signature against your tenant's JWKS endpoint—before the request reaches your MCP handler. Your tool functions receive only pre-validated, authorized requests.

```python
from mcp.server.fastmcp import FastMCP
from fastapi import FastAPI

mcp = FastMCP("Northwind Clinical Tools", stateless_http=True)

# Platform-level Entra ID authentication is configured on the Azure Container
# App or Azure Function host—not in the MCP server code itself.
# The hosting platform validates the bearer token before forwarding the
# request to this handler. No manual JWT parsing is needed or recommended.

@mcp.tool()
async def lookup_drug_interaction(drug_a: str, drug_b: str) -> dict:
    """Check for interactions between two medications.

    This tool is protected by platform-level Entra ID authentication.
    The caller identity is available in the request context.
    """
    # Tool implementation—the platform has already authenticated the caller
    return {"interaction": "moderate"}

app = FastAPI()
app.mount("/", mcp.streamable_http_app())
```

API key authentication supports external and partner tools where managed identity isn't available. Store API keys in Azure Key Vault, not environment variables, and rotate them on a quarterly schedule. For Northwind Health's integration with third-party lab systems, the MCP server retrieves the lab API key from Key Vault at startup and caches it with a 4-hour expiration.

OAuth 2.0 client credentials flows handle B2B tool integration where the tool provider requires their own authorization server. The MCP server acts as an OAuth client, requesting access tokens before forwarding tool invocations to the provider's API. This pattern maintains the provider's audit trail while abstracting OAuth complexity from agents.

OAuth identity passthrough is a third authentication pattern supported by Foundry Agent Service when connecting to MCP servers. Unlike Managed Identity (which grants the agent or project identity uniform access) or client credentials (service-to-service), passthrough is per-user and interactive. The first time a specific user interacts with an agent that calls your MCP server, Foundry Agent Service generates a consent link. The user signs in through their Microsoft Entra credentials, and Foundry securely stores their token. All subsequent MCP invocations for that user use the stored token automatically. This makes the MCP server's downstream resources—patient portals, SharePoint, or line-of-business APIs—authorize based on the *calling user's* identity rather than the agent's identity. For healthcare scenarios where different clinicians have different access scopes, this satisfies both least-privilege and per-user audit requirements that Managed Identity alone can't provide. To configure OAuth identity passthrough, you supply the Client ID, Client Secret, Auth URL, Token URL, Refresh URL, and Scopes from the Entra app registration on your Azure Function or Container App.



MCP tool schemas evolve as requirements change. A drug interaction tool initially checking two medications might expand to support multi-drug interactions. You design for backward compatibility by ensuring new optional parameters don't break existing agents that call the tool with the original parameter set.

Version the entire MCP server, not individual tools. The URL pattern `https://tools.northwind.health/v1/tools` indicates version 1 of the entire tool catalog. When you introduce breaking changes—removing a required parameter, changing a response field type, or removing a tool—you deploy `/v2/tools` alongside `/v1/tools`. Agents explicitly opt into the new version during their deployment cycle.

```python
from mcp.server.fastmcp import FastMCP
from fastapi import FastAPI

# Version the entire MCP server using URL-prefix routing.
# Each version is a separate FastMCP instance mounted at a distinct path.

# v1.0 server—original drug interaction tool
mcp_v1 = FastMCP("Northwind Clinical Tools v1", stateless_http=True)

@mcp_v1.tool()
async def lookup_drug_interaction(drug_a: str, drug_b: str) -> dict:
    """Check interactions between two drugs."""
    return {"interaction": "moderate", "severity": "moderate"}

# v1.1 server—adds optional multi-drug support (backward compatible, MINOR increment)
mcp_v1_1 = FastMCP("Northwind Clinical Tools v1.1", stateless_http=True)

@mcp_v1_1.tool()
async def lookup_drug_interaction(
    drug_a: str,
    drug_b: str,
    additional_drugs: list[str] | None = None,  # Optional—agents on v1 still work
) -> dict:
    """Check interactions between multiple drugs."""
    drugs = [drug_a, drug_b] + (additional_drugs or [])
    return {"interaction": "moderate", "severity": "moderate", "drugs_checked": len(drugs)}

# Mount both versions at distinct URL prefixes.
# Agents on v1 call /v1/mcp; agents adopting v1.1 call /v1.1/mcp.
app = FastAPI()
app.mount("/v1", mcp_v1.streamable_http_app())
app.mount("/v1.1", mcp_v1_1.streamable_http_app())
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

## Extended ecosystem services for MCP servers

The four hosting options (Container Apps, App Service, Functions, AKS) cover most workloads. Three additional Azure services add governance, discovery, and low-code integration:

- **Azure API Center**—registers MCP servers in an organizational inventory and exposes them as private tool catalogs discoverable in the Foundry portal (currently in public preview). When you register an MCP server in API Center, agent teams can find and add it to their Foundry agents without needing the endpoint URL directly. API Center stores version metadata, authentication schemes, and lifecycle status—the managed equivalent of the custom tool registry you build in the governance unit. Use it to make MCP servers discoverable across your organization.
- **Azure API Management (APIM)**—acts as a policy enforcement gateway in front of your MCP server fleet, applying rate limiting, IP filtering, and token validation at the edge before requests reach your server code. APIM isn't a hosting service. It proxies Container Apps, App Service, or AKS-hosted MCP servers. It can also expose existing REST APIs as MCP servers without rewriting them. Use it when you need per-partner API keys, quota enforcement, or centralized policy governance across multiple MCP servers.
- **Azure Logic Apps**—provides a low-code option for simple tool wrappers around enterprise connectors (SharePoint, ServiceNow, SAP). If your MCP tool's only function is to read or write a SharePoint list, Logic Apps eliminates the need to write and host a Python MCP server. The tradeoff is reduced control over error handling and latency.

## When to use MCP versus direct integration

Not every tool needs an MCP server. Wrapping each integration in MCP adds architectural overhead—authentication, versioning, discovery—that delivers value when multiple agents share tools, when tools evolve independently of agents, or when governance requirements demand a structured tool registry. The decision framework:

| Criterion | Use MCP | Use direct integration |
|---|---|---|
| **Number of consuming agents** | 2 or more agents need the same tool | Only one agent ever calls this integration |
| **Tool reuse and discovery** | Tools are discoverable and used across teams | One-off integration specific to one agent |
| **Independent versioning** | Tool and agent evolve on different release cycles | Tool and agent deploy together always |
| **Governance requirements** | Tools must be audited, rate-limited, or approved before agent use | No governance gate required |
| **Ecosystem complexity** | Integrating 5+ external systems | Integrating a single well-defined API |

For Northwind Health, drug interaction lookups and formulary access are shared across five different clinical agents \u2014 MCP is justified. A one-time ETL pipeline that the data-ingestion agent alone uses is better served by a direct function call with no MCP overhead.

Now that you understand production MCP server architecture—hosting choices, authentication patterns, versioning strategies, and observability requirements—you're ready to implement reliability features that handle failures gracefully.

## Unit summary

- **Hosting choice** determines latency and cost characteristics—Container Apps for variable-load tools (set `--min-replicas 1` in production), App Service for code-based deployment without containers, Functions for stateless event-driven tools and Foundry Agent Service integration, and AKS for teams with existing Kubernetes clusters or GPU requirements
- **Managed Identity authentication** eliminates credential management and meets compliance requirements, while OAuth 2.0 client credentials handle B2B integrations with external tool providers
- **Server-level versioning** (URL-prefix `/v1/`, `/v2/`) is preferred over individual tool versioning—deploy breaking changes as new versions alongside existing ones with deprecation periods
- **Structured JSON logging** with correlation IDs enables end-to-end distributed tracing from agent decision through MCP server to downstream API calls, supporting both debugging and SLA compliance dashboards
- **Backward compatibility** is preserved by adding optional parameters rather than changing required ones—new capabilities extend the tool schema without breaking existing agent integrations
