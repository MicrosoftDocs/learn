APIs are the connective tissue of modern applications. They expose business logic, enable integrations, and often handle sensitive data. As the number of APIs in an organization grows, so does the attack surface. Unsecured APIs are a leading cause of data breaches because they often bypass traditional perimeter defenses.

As a cybersecurity architect, you need to design an API security strategy that provides centralized governance, consistent authentication and authorization, and protection against common API-specific threats. Azure API Management is the core service for this purpose.

## Azure API Management overview

Azure API Management (APIM) provides a unified API gateway, management plane, and developer portal that sits between API consumers and your backend services. It acts as a policy enforcement point where you apply security controls consistently across all APIs, regardless of where the backends are hosted.

The key components are:

- **API gateway:** the endpoint that accepts API calls and routes them to backends. It enforces policies for authentication, rate limiting, transformation, and logging.
- **Management plane:** the administrative interface for importing APIs, defining policies, and managing users and subscriptions.
- **Developer portal:** a customizable website where API consumers discover and test APIs, obtain API keys, and view documentation.

:::image type="content" source="../media/api-management-components.png" alt-text="Diagram showing key components of Azure API Management." lightbox="../media/api-management-components.png":::

For architectures that require data sovereignty or reduced latency, APIM also supports a **self-hosted gateway** that runs as a container in your own infrastructure, including on-premises or in other clouds, while still reporting to the centralized management plane.

## Designing API authentication and authorization

Authentication and authorization are the most critical security controls for APIs. APIM supports several approaches, and your design should select the appropriate mechanism based on the API's consumer type and sensitivity.

### OAuth 2.0 with Microsoft Entra ID

For most enterprise scenarios, configure OAuth 2.0 token validation in APIM using Microsoft Entra ID as the identity provider. The API gateway validates JSON Web Token (JWT) tokens on every request, verifying the issuer, audience, expiration, and required scopes or roles before forwarding to the backend. This approach works for both user-delegated permissions (users accessing APIs through client applications) and application permissions (service-to-service calls).

Design your OAuth scopes to enforce least privilege. Instead of a single broad scope like "api.access," define granular scopes that map to specific capabilities (for example, "Orders.Read," "Orders.Write," "Inventory.Manage").

### Subscription keys

APIM can require API keys (subscription keys) for API access. While simpler than OAuth, subscription keys are shared secrets and don't identify individual callers. Use subscription keys primarily for rate limiting and usage tracking, not as the sole authentication mechanism. Scope subscription keys to specific APIs or products rather than granting all-API access.

### Client certificates and mutual TLS (mTLS)

For high-security scenarios, require mutual TLS between clients and the gateway or between the gateway and backends. APIM can validate client certificates against trusted CAs, check certificate revocation, and enforce specific certificate attributes.

### Backend authentication

Protect the connection between APIM and backend services as well. Configure managed identities on the APIM instance to authenticate to backend Azure services. This eliminates the need to store backend credentials in APIM configuration. For non-Azure backends, store credentials in Azure Key Vault and reference them in APIM policies.

## Network security for APIs

Restrict network access to your APIM instance based on the deployment model and sensitivity of the APIs.

- **Virtual network integration (internal mode)** places the APIM gateway inside a virtual network with no public IP address. API consumers access the gateway through private endpoints or ExpressRoute/VPN connections. Use this mode for internal APIs that should never be internet-accessible.
- **Virtual network integration (external mode)** places APIM in a virtual network but retains a public gateway IP. Backend services are accessible only within the virtual network. Use this for APIs that serve external consumers but need private backend connectivity.
- **Private endpoints** provide private IP connectivity to APIM from within a virtual network without full virtual network injection.
- **IP filtering and network security groups (NSGs)** restrict inbound access to known IP ranges.

As an architect, select the network topology that matches your API's exposure requirements. Internet-facing APIs that serve external partners need different network configurations than internal APIs called only by other Azure services.

## API threat protection with policies

APIM policies run at the gateway and provide defense against common API threats:

- **Rate limiting and throttling** prevent abuse and denial-of-service attacks. Configure rate limits per subscription, per caller IP, or per API operation to ensure fair usage and protect backend capacity.
- **Request validation** checks incoming requests against the API's OpenAPI specification, rejecting requests with unexpected parameters, oversized payloads, or invalid content types before they reach the backend.
- **IP filtering** restricts access to APIs from known IP ranges or virtual networks.
- **CORS policies** control cross-origin resource sharing to prevent unauthorized browser-based API access.
- **Header and payload transformation** strips sensitive headers, redacts data in responses, and normalizes requests to prevent injection attacks.

## Secrets management for APIs

Store all sensitive configuration data, including API keys, certificates, and connection strings, as APIM named values backed by Azure Key Vault. This ensures that secrets are encrypted, audited, and can be rotated without redeploying APIM configuration.

Never store secrets directly in APIM policy expressions or API configuration. The Microsoft Cloud Security Benchmark v2 (MCSBv2) specifically requires that "API Management secret named values should be stored in Azure Key Vault" (control IM-8).

## API lifecycle and governance

Effective API security includes governance across the API lifecycle:

- **API versioning** ensures that deprecated API versions with known vulnerabilities can be retired without breaking consumers. Establish a versioning strategy and communicate deprecation timelines.
- **Unused endpoint removal** reduces attack surface. The MCSBv2 recommends that "API endpoints that are unused should be disabled and removed from the Azure API Management service" (control AM-3).
- **Subscription scoping** prevents individual subscription keys from accessing all APIs. Scope subscriptions to specific products or APIs to enforce separation of concerns.

## Microsoft Defender for APIs

Microsoft Defender for APIs, available as part of Microsoft Defender for Cloud, provides API-specific threat detection and posture management:

- Discovers and inventories all APIs managed by APIM.
- Identifies APIs that expose sensitive data, such as personally identifiable information (PII).
- Detects runtime threats including authentication attacks, suspicious data exfiltration, and volumetric attacks.
- Prioritizes API vulnerabilities based on actual exposure and potential impact.

Integrate Defender for APIs with your broader Defender for Cloud deployment to correlate API threats with other cloud security findings.


