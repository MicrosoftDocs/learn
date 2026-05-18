Contoso Retail exposes a partner-facing API through Azure API Management that provides access to product catalog, pricing, and inventory data. Any caller with a valid URL can make requests—no subscription key required, no token validation enforced, and no rate limits applied. Backend APIs accept any inbound HTTPS request without verifying the caller's identity at the connection level.

The team is also evaluating API Management as the secure gateway for a new Azure OpenAI-based product recommendation engine that serves internal applications. Each of these represents a distinct security gap that you need to close.

API Management doesn't protect APIs automatically. The platform provides the policies, network controls, certificate handling, and AI-specific capabilities to build strong API security—but that protection must be configured deliberately. Leaving these gaps open means a leaked partner credential grants unlimited access, backend services accept requests from any caller that bypasses the gateway, and AI model costs can escalate unchecked from a single high-volume consumer.

This module walks through four layers of API security that address Contoso's gaps. You start with authentication and authorization—configuring subscription keys, JSON Web Token (JWT) validation, and Microsoft Entra ID token policies to control who can call your APIs. You then apply network security controls—IP filtering, rate limiting, and virtual network integration—to govern how much callers consume and from what location. You then secure backend connections using client certificate authentication and mutual TLS (mTLS), ensuring that only API Management can call your backend services. Finally, you configure AI Gateway capabilities to secure and govern Azure OpenAI endpoints behind API Management, using token-based rate limits and managed identity authentication.

By the end of this module, you're able to configure API authentication and authorization policies, implement network security controls, enforce backend connection security with mutual TLS, and set up AI Gateway to govern AI model endpoints.

## In this module, you will:

- Configure API authentication and authorization policies including JWT validation and OAuth 2.0 with Microsoft Entra ID
- Implement network security controls including IP filtering, rate limiting, and virtual network integration for API Management
- Enforce backend connection security using client certificate authentication and mutual TLS
- Configure AI Gateway in API Management to secure and govern AI model endpoints
