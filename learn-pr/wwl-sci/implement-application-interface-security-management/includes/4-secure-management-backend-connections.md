Authentication policies and network controls protect the inbound side of API Management—they govern who can reach the gateway and how much they can consume. The outbound side carries a separate risk: when API Management forwards a request to your backend service, that backend needs to verify that the request genuinely came from API Management and not from a caller who bypassed the gateway. Client certificates and mutual Transport Layer Security (TLS) address this gap.

## Authenticate API Management to backend services

When API Management makes an outbound request to a backend service, it can present a **client certificate** as proof of its identity. The backend validates the certificate against a trusted certificate authority (CA) or a specific certificate thumbprint, and rejects any request that arrives without a matching certificate.

To configure client certificate authentication for a backend:

1. In API Management, go to **Certificates** and upload the client certificate as a Private Key Certificate File (PFX) file containing the certificate and private key.
2. In the **Backend** configuration for the target service, select the uploaded certificate to present on outbound calls to that backend URL.

The backend API's TLS configuration must be set to trust the certificate's CA or accept the specific certificate thumbprint. Any request reaching the backend without the matching certificate fails the TLS handshake before application logic runs.

This establishes one-way client authentication from the gateway's perspective: API Management proves its identity to the backend, but only the backend's server certificate is validated by standard TLS. The backend can be confident the request came from your API Management instance—not a developer calling the backend URL directly or an attacker who has bypassed the gateway.

## Require callers to present client certificates

The `validate-client-certificate` policy enforces client certificate authentication on the **inbound** side. When callers must present a certificate to API Management, you add a layer of authentication on top of subscription keys and token validation—the caller must also possess a certificate that API Management trusts.

Add the policy to the inbound section to enforce certificate validation:

```xml
<inbound>
  <validate-client-certificate validate-revocation="true"
                               validate-not-before="true"
                               validate-not-after="true">
    <identities>
      <identity thumbprint="{trusted-certificate-thumbprint}" />
    </identities>
  </validate-client-certificate>
  <base />
</inbound>
```

The policy validates certificates by one of two methods:

- **Thumbprint**: Matches the presented certificate against a specific known thumbprint. Use this for tightly controlled environments where you manage the exact set of trusted certificates.
- **Issuer and subject**: Validates that the certificate was issued by a trusted CA and matches an expected subject name. Use this when you operate a CA that issues certificates to known partners, so that any certificate issued by your CA with the correct subject passes validation automatically.

Set `validate-revocation`, `validate-not-before`, and `validate-not-after` to `true` in production. These checks confirm the certificate isn't been revoked, isn't being used before its valid start date, and isn't expired.

## Establish mutual TLS for two-way authentication

**Mutual TLS (mTLS)** extends the standard TLS handshake so that both parties verify each other's identity using certificates. In a standard TLS connection, only the server presents a certificate—the client verifies the server's identity, but the server doesn't verify the client identity. In mTLS, both the client and the server present certificates, and both validate the other's certificate before the connection is established.

In the API Management context, mTLS applies at two points in the request path:

1. **Caller to API Management**: The calling application presents a client certificate. API Management validates it using the `validate-client-certificate` policy. Only callers whose certificates pass validation proceed past the gateway.
2. **API Management to backend**: API Management presents its client certificate when forwarding the request to the backend. The backend validates it. Only requests carrying API Management's certificate complete the connection.

Together, these two certificate checks create a fully authenticated channel. The caller proves its identity to the gateway, and the gateway proves its identity to the backend. An attacker who intercepts the network path between API Management and the backend must present the correct certificate to complete the connection—which they can't, because the private key never leaves the API Management instance.

> [!TIP]
> mTLS at the API Management-to-backend layer is especially valuable in zero-trust architectures where backend services shouldn't rely on network location (such as virtual network membership) as proof of caller identity. The certificate check provides cryptographic evidence of identity regardless of where the request originated.

## Manage certificates with Azure Key Vault

Uploading certificate PFX files directly to API Management creates a lifecycle management burden: when certificates expire, you update them manually in each environment. Azure Key Vault integration removes this friction.

Configure API Management to reference certificates stored in Key Vault rather than uploading PFX files:

1. Upload the certificate to the **Certificates** section of a Key Vault instance. Enable automatic renewal if the certificate is issued by a CA that Key Vault supports for managed renewal.
2. Grant the API Management instance's managed identity the **Key Vault Secrets User** role on the Key Vault.
3. In API Management, add a Key Vault reference under **Certificates** and point it to the Key Vault certificate identifier.

When the certificate renews in Key Vault, API Management picks up the new version automatically—no manual update or redeployment required. This is especially important for backend client certificates that appear in multiple API configurations across environments.

The **backend entity** in API Management centralizes connection configuration for each backend service. Rather than embedding certificate references, authentication headers, and backend URLs in individual API policies, you define a named backend entity with all connection details. Policies reference the backend by name. When connection details change—such as a certificate renewal path or a backend URL update—you update the backend entity once. All APIs and operations that reference it pick up the change without touching individual policy documents.

With mTLS configured in both directions and certificate lifecycle delegated to Key Vault, Contoso Retail's backend APIs can reject any request that doesn't carry API Management's certificate—providing cryptographic assurance that every backend call originated from the authorized gateway.
