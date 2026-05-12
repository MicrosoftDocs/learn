Contoso Retail's partner API accepts any request that reaches the gateway URL. The first enforcement boundary is authentication and authorization—requiring callers to prove their identity before API Management forwards the request to the backend.

## Control API access with subscription keys

A **subscription key** is a shared secret that callers include with every API request. API Management validates the key and rejects requests that omit it or provide an invalid value.

Subscription keys are tied to subscriptions in API Management. When you create a product, you can require a subscription to access it. API Management generates a primary and secondary key pair for each subscription. Callers pass the key in either the `Ocp-Apim-Subscription-Key` request header or the `subscription-key` query parameter—API Management checks both locations by default.

Subscription scope determines which APIs the key grants access to:

- **Product-level**: The key grants access to all APIs in the product. This is the most common model for partner-facing APIs.
- **API-level**: The key grants access to a single API, regardless of product membership.
- **Global**: The key grants access to all APIs across the gateway. Reserve this for internal tooling and monitoring pipelines.

Manage key lifecycle actively. When a partner offboards or a key is suspected compromised, revoke it immediately from the **Subscriptions** page in the API Management portal. The secondary key supports rotation—share the secondary key with the partner, wait for confirmation that they switched over, then revoke the primary—without interrupting service.

Subscription keys are a useful first access control layer, but they have limitations. They're shared secrets, not identity tokens. A leaked key grants access to anyone who has it until you revoke it, with no audit trail of which application used it. For production APIs with external partners, combine subscription key enforcement with token-based identity validation.

## Validate tokens with the validate-jwt policy

JSON Web Tokens (JWTs) carry verifiable identity claims signed by a trusted authority. When a caller presents a JWT in the `Authorization` header, API Management can validate the token before forwarding the request—confirming the token was issued by a trusted authority, isn't expired, and carries required claims.

The `validate-jwt` policy handles this validation in the inbound policy section. The following example validates a JWT issued by Microsoft Entra ID:

```xml
<inbound>
  <validate-jwt header-name="Authorization"
                failed-validation-httpcode="401"
                failed-validation-error-message="Unauthorized. Valid token required.">
    <openid-config url="https://login.microsoftonline.com/{tenant-id}/v2.0/.well-known/openid-configuration" />
    <required-claims>
      <claim name="aud">
        <value>{api-app-registration-client-id}</value>
      </claim>
    </required-claims>
  </validate-jwt>
  <base />
</inbound>
```

Key elements of this policy:

- **`header-name`**: Specifies where the token is read from. Use `Authorization` for standard Bearer tokens. You can also read tokens from custom headers or query parameters.
- **`openid-config`**: Points to the OpenID Connect discovery document for the token issuer. API Management retrieves signing keys from this URL to validate the token's signature.
- **`required-claims`**: Defines claims the token must contain. The `aud` (audience) claim must match the app registration client ID of your API—this prevents tokens issued for one application from being accepted by another.
- **`failed-validation-httpcode`**: Sets the HTTP response code returned on validation failure. Use `401` for authentication failures and `403` when the token is valid but lacks required permissions.

The policy rejects the request immediately if any validation check fails—before the request reaches the backend.

## Use tokens for Microsoft Entra scenarios

For APIs protected specifically by Microsoft Entra ID, the `validate-azure-ad-token` policy provides a purpose-built alternative to `validate-jwt`. It simplifies configuration by handling Microsoft Entra token format, signing key rotation, and multitenant scenarios automatically.

Configure the policy with your tenant ID and the allowed client application IDs—the app registrations permitted to call your API:

```xml
<inbound>
  <validate-azure-ad-token tenant-id="{tenant-id}">
    <client-application-ids>
      <application-id>{partner-app-client-id}</application-id>
    </client-application-ids>
  </validate-azure-ad-token>
  <base />
</inbound>
```

The policy validates the token's issuer against your Microsoft Entra tenant, checks the signature using Microsoft Entra published signing keys, and verifies that the calling application's client ID is in the allowed list. For Contoso Retail, this means only applications registered in the approved Microsoft Entra tenant can obtain tokens that pass validation—a credential from an unregistered application has no path through the gateway.

Prefer `validate-azure-ad-token` over `validate-jwt` for Microsoft Entra scenarios. The purpose-built policy handles token structure details automatically and is easier to configure, audit, and maintain.

> [!NOTE]
> When API Management sits in front of an Azure OpenAI endpoint, the `validate-azure-ad-token` policy validates the caller's identity before forwarding the request to the model backend. This prevents unauthenticated access to AI endpoints—a critical control when AI usage is tied to user identity for cost governance or audit.

## Apply policies at the right scope

API Management policies execute at four scopes, in this order: global, product, API, and operation. Policies at lower scopes inherit behavior from higher scopes using the `<base />` element, which passes execution up the chain.

The appropriate use for authentication policies at each scope:

- **Global**: Applied to all APIs in the gateway. Don't place authentication policies here—doing so enforces authentication on every API, including health check endpoints and documentation pages that should remain accessible without credentials.
- **Product**: Applied to all APIs in a product. Use this scope when every API in the product requires the same authentication model. Apply subscription key enforcement and `validate-azure-ad-token` at the product scope for Contoso Retail's partner product.
- **API**: Applied to a specific API and all its operations. Use when one API in a product requires stronger authentication than others in the same product.
- **Operation**: Applied to a single operation. Use sparingly—for endpoints with different trust requirements than the rest of the API.

For Contoso Retail, apply `validate-azure-ad-token` at the **product scope** to enforce token validation across all partner APIs in the product. Combine it with subscription key enforcement at the same scope to require both a valid subscription key and a valid Microsoft Entra token. Each layer adds defense in depth—an attacker with a stolen subscription key still can't call the API without a valid token, and a valid token without a subscription key is equally useless.
