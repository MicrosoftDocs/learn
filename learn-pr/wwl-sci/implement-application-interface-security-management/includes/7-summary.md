Contoso Retail's partner-facing API had four distinct security gaps at the start of this module. Each one addressed a different enforcement layer that Azure API Management provides.

You configured authentication and authorization policies that closed the first gap. Subscription keys established a baseline access control layer requiring callers to present a shared secret with every request. The `validate-azure-ad-token` policy extended that with identity-based token validation, ensuring only applications registered in the approved Microsoft Entra tenant can obtain tokens that pass the gateway. Policy scope gave you precise placement control—product scope for partner APIs, leaving internal health endpoints untouched.

You applied network security controls that address the second gap. The `ip-filter` policy restricts which source IP ranges can reach the gateway. The `rate-limit` and `rate-limit-by-key` policies cap consumption per subscription and per caller, preventing burst abuse. The `quota` policy enforced monthly volume commitments aligned with partner contract tiers. Virtual network integration modes—External for internet-facing APIs, Internal for fully private workloads—gave you a model for reducing or eliminating the public attack surface for APIs that don't require internet exposure.

You secured backend connections using client certificates and mutual Transport Layer Security (TLS), which closed the third gap. API Management presents a client certificate to the backend on every outbound call, and the `validate-client-certificate` policy requires callers to present certificates to the gateway. Both ends of the connection are now cryptographically authenticated. Azure Key Vault integration removed manual certificate lifecycle management from the equation.

You configured AI Gateway capabilities to close the fourth gap. Managed identity authentication eliminated Azure OpenAI API keys from the configuration. The `azure-openai-token-limit` policy governs consumption at the token level—the actual cost driver for Large Language Model (LLM) workloads. Semantic caching reduced redundant calls for similar prompts. All AI consumers, including autonomous agents, pass through the same enforcement point.

## Learn more

- [Authentication and authorization overview - Azure API Management](/azure/api-management/authentication-authorization-overview)
- [Secure APIs using mutual certificates in Azure API Management](/azure/api-management/api-management-howto-mutual-certificates-for-clients)
- [AI gateway capabilities in Azure API Management](/azure/api-management/genai-gateway-capabilities)
