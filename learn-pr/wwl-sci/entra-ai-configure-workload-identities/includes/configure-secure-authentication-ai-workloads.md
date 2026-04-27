The first setup decision is how the workload authenticates. The answer depends on where the workload runs, because the hosting environment determines which credential types are available.

## Select the credential type based on where the workload runs

Use the workload's hosting model to determine how it should authenticate.

| Workload scenario | Preferred credential type | Why it fits |
| --- | --- | --- |
| Azure-hosted AI workload on a resource that supports managed identity | Managed identity | Azure manages the credential lifecycle. No secrets to store or rotate. |
| Workload outside Azure, or workload using an app registration with a trust relationship to another identity provider | Federated identity credential | The application trusts an external token instead of storing a secret. |
| Scenario where federation is unavailable but strong production credentials are required | Certificate credential | Certificates are a stronger production fallback than client secrets. |
| Local development or temporary testing only | Client secret | Simplest to configure for short-lived scenarios. Not recommended for production. |

The hosting environment determines the options. A workload running on Azure App Service or Azure Functions can use a managed identity directly. A workload running on a Kubernetes cluster outside Azure can use workload identity federation. A workload that can't use either option falls back to certificate credentials for production.

## Enable a managed identity for Azure-hosted AI workloads

Most Azure compute resources support managed identities: App Service, Functions, Container Apps, virtual machines, and AKS all qualify. If your workload deploys to any of these, managed identity is available and eliminates secrets from the design entirely.

Enable a system-assigned or user-assigned managed identity on the hosting resource. The workload can then authenticate to services like Azure AI, Key Vault, and Microsoft Graph using a single identity without storing a secret.

:::image type="content" source="../media/managed-identity-authentication-flow.png" alt-text="Diagram of managed identity flow from Azure workload through Microsoft Entra ID to Key Vault, Azure AI, and Storage." border="false":::

1. Confirm the Azure resource hosting the AI workload supports managed identities.
1. Enable a system-assigned managed identity on the resource, or create and assign a user-assigned managed identity.
1. Test token acquisition from the workload's hosting environment to confirm the managed identity can authenticate.

System-assigned managed identities are tied to the lifecycle of the Azure resource. When the resource is deleted, the identity is removed. User-assigned managed identities have an independent lifecycle and can be shared across related workloads when the sharing pattern is deliberate and documented.

## Configure workload identity federation for external workloads

If the workload runs outside Azure and the hosting environment can issue identity tokens, federation is likely available. GitHub Actions runners, Kubernetes clusters with OIDC issuers, and other cloud platforms with supported identity providers all qualify. The key indicator is whether the environment can present a token that Microsoft Entra can validate.

Workload identity federation avoids storing secrets by trusting tokens from the external identity provider instead of managing a credential directly.

1. Create or select the app registration that represents the workload.
1. Add a federated identity credential on the app registration. Configure the issuer, subject, and audience to match the external identity provider's token claims.
1. Test token exchange from the workload's actual hosting environment.

> [!IMPORTANT]
> Workload identity federation depends on case-sensitive exact matching of issuer, subject, and audience claims. If any value doesn't match the incoming token, token exchange fails.

The application trusts the external token and exchanges it for a Microsoft Entra token without storing a secret.

## Use certificate credentials when federation is unavailable

If the workload needs an app registration but the hosting environment doesn't issue tokens from a supported identity provider, federation isn't an option. This is the scenario when the workload runs on infrastructure you control but that infrastructure has no OIDC issuer or federated trust path. Certificate credentials are the strongest remaining alternative.

1. Create or select the app registration that represents the workload.
1. Generate or obtain a certificate. Upload the certificate's public key to the app registration.
1. Configure the workload to use the certificate's private key for authentication.
1. Test token acquisition to confirm the certificate-based authentication works.

Certificates are a stronger production credential than client secrets because they require possession of the private key. Store the private key securely, such as in Azure Key Vault or a hardware security module, and plan for certificate rotation before expiration.

## Limit client secrets to constrained development scenarios

If managed identity, federation, and certificate credentials are all unavailable, a client secret is the remaining option. This usually means the scenario is local development, a short-lived proof of concept, or a temporary test environment where the other credential types aren't available yet.

Client secrets are the simplest credential to configure but the hardest to keep secure in production. A workload running with a secret stored in application code creates a credential that must be tracked, rotated, and protected for as long as the workload exists. Use client secrets only when:

- The scenario is short-lived development or testing.
- Managed identity, federation, and certificate credentials are all unavailable.
- The secret has a short expiration and a documented rotation plan.

For any production workload, replace client secrets with a stronger credential type before the workload goes live.

## Understand the relationship between the app registration and the service principal

Credential and permission configuration errors often come from confusing these two objects. When you create an app registration, Microsoft Entra also creates a service principal in the home tenant. They serve different purposes:

- The **app registration** holds the application's configuration, including credentials, redirect URIs, and API permissions that require consent.
- The **service principal** is the identity that authenticates and receives role assignments in the tenant.

Credential configuration happens on the app registration. Role assignments and permission grants happen on the service principal. Confusing these objects leads to credentials configured in the wrong place or permissions that don't take effect.

## Confirm the credential model before moving on

Before treating authentication as complete, confirm:

- Token acquisition succeeds from the workload's actual hosting environment, not just from a developer workstation.
- The credential type matches the hosting scenario. If the workload runs on a resource that supports managed identity, it should be using managed identity, not a client secret.
- No unnecessary secret remains in the design.
- You can identify which object holds the credential (the managed identity, the app registration, or both).

A successful sign-in from the actual hosting environment confirms the credential model works as intended. If authentication fails at this point, no amount of permission configuration fixes it. Once the identity can authenticate, the next decision is what it should be allowed to access.
