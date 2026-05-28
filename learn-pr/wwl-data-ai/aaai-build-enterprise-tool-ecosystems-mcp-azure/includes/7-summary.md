In this module, you built production MCP servers that meet Northwind Health's requirements for managed identity authentication, circuit-breaker protection, dynamic routing across instances, and semantic versioning governance.

Production MCP server architecture requires choosing hosting platforms based on latency tolerance and cost constraints. Azure Container Apps provides serverless scaling for variable load patterns, Azure Functions offers the lowest cost for infrequent invocations, and dedicated AKS deployments guarantee latency for critical tools that can't tolerate cold starts. Managed Identity authentication eliminates credential management while providing Azure AD audit trails that meet healthcare compliance requirements. Token validation happens at the hosting platform level—Azure Container Apps and Azure Functions built-in authentication validate the incoming bearer token before the request reaches your MCP handler, so your tool code receives only pre-authorized requests.

Reliability patterns handle downstream failures gracefully. Exponential backoff with jitter retries transient errors without overwhelming recovering services—waiting 1, 2, 4 seconds with random offsets that prevent retry storms. Circuit breakers detect repeated failures and fail fast, returning structured fallback responses that agents incorporate into their clinical guidance rather than cascading failures across the workflow. Health check endpoints enable proactive monitoring that opens circuit breakers before real invocations fail, triggering automatic scaling responses.

Dynamic routing distributes load across tool instances based on current performance and deployment strategy. The tool registry maintains instance endpoints, semantic versions, health status, and rolling P50/P95 latency metrics. Latency-based routing selects the instance with the best recent performance, adapting automatically to infrastructure changes. Weighted routing implements canary deployments, gradually shifting traffic from stable to new versions while monitoring error rates. Capability-based routing filters instances by minimum version to ensure the selected endpoint supports the requested features.

Governance workflows manage tool evolution without breaking deployed agents. Semantic versioning communicates change impact through version numbers—MAJOR for breaking changes, MINOR for backward-compatible additions, PATCH for bug fixes. CI/CD pipelines validate compatibility before deployment by querying the registry for agent dependencies and verifying the deploying version satisfies all constraints. Deprecation workflows announce sunsets 90 days in advance, log warnings on deprecated tool invocations, track which agents still depend on retiring versions, and enforce retirement by returning migration guidance instead of results after the sunset date.

These patterns give your team a repeatable way to evolve MCP tools without breaking deployed agents. New capabilities ship through MINOR versions that agents adopt on their own schedule. Breaking changes ship through MAJOR versions only after compatibility validation confirms no deployed agents are affected. Latency-based routing and canary weights adapt traffic distribution as your infrastructure changes, reducing the manual coordination needed to keep agent tools performing reliably.

## Learn more

- [Model Context Protocol specification](https://spec.modelcontextprotocol.io/)
- [Azure Managed Identity documentation](https://learn.microsoft.com/entra/identity/managed-identities-azure-resources/overview)
- [Azure Container Apps documentation](https://learn.microsoft.com/azure/container-apps/overview)
- [Semantic Versioning specification](https://semver.org/)
- [Circuit Breaker pattern](https://learn.microsoft.com/azure/architecture/patterns/circuit-breaker)
- [Retry pattern with exponential backoff](https://learn.microsoft.com/azure/architecture/patterns/retry)
