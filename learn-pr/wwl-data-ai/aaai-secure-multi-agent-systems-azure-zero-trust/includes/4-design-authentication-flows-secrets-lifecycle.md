Microsoft Entra ID supports four authentication flows for multi-agent systems—managed identity, on-behalf-of, OAuth2 with PKCE, and key-based fallback—each suited to a different agent-to-resource relationship. Azure Key Vault manages the secrets, certificates, and cryptographic keys these flows depend on. In this unit, you select the right authentication pattern for each scenario and design a secrets lifecycle that prevents credential exposure.

## Agent authentication flow taxonomy

Four flows cover the authentication scenarios that multi-agent systems encounter. The selection table at the end of this section provides a decision framework for choosing the right pattern.

### Service-to-service: managed identity

Managed identity is the baseline pattern for agent-to-Azure-service connections. The agent's Azure compute resource (Container App, AKS pod, Azure Function) receives a system-assigned identity from Entra ID. The agent requests access tokens from the Azure Instance Metadata Service (IMDS) without handling credentials. Azure rotates the tokens automatically.

You already configured this pattern in Unit 2 (per-agent managed identities). The key principle: use managed identity for all agent connections to Azure services (Cosmos DB, Microsoft Foundry, Azure Storage, Key Vault). Managed identity eliminates credentials from code and satisfies the zero-trust requirement for cryptographic identity proof on every connection.

For service-to-service scenarios, the agent's identity is the *service identity*, not any individual user's identity. This is appropriate for:
- Agent connections to internal Azure resources (databases, AI endpoints, storage).
- Agent-to-agent calls within the same Azure trust boundary.
- Background processing with no user context (nightly analysis jobs, batch enrichment).

**When managed identity is insufficient:** When the agent must access a resource on behalf of a specific user and respecting that user's access permissions matters—for example, reading a user's SharePoint documents or accessing their Azure DevOps repositories—managed identity grants the agent's service-level access, which may be broader than the user's permissions. This creates a privilege escalation risk if you use service identity where user-delegated identity is required.

### Service-to-user-resource: on-behalf-of (OBO)

The on-behalf-of token exchange enables an agent to act as a specific user when accessing downstream resources. The flow:

1. User authenticates to the calling application and receives an access token (`token_A`) scoped to your application.
2. Your orchestrator agent exchanges `token_A` for a new token (`token_B`) scoped to the downstream resource (for example, Microsoft Graph), using the Entra ID OBO flow.
3. The agent uses `token_B` to call the downstream resource. The resource sees the call as coming from the *user*, not from the service. The user's permissions are enforced.

```python
from azure.identity import OnBehalfOfCredential
import os

def get_obo_credential(user_assertion: str, downstream_scope: str):
    """Exchange a user assertion token for an OBO token for a downstream resource."""
    credential = OnBehalfOfCredential(
        tenant_id=os.environ["AZURE_TENANT_ID"],
        client_id=os.environ["AZURE_CLIENT_ID"],
        client_secret=os.environ["AZURE_CLIENT_SECRET"],
        user_assertion=user_assertion
    )
    # Request a token for the downstream resource scope
    token = credential.get_token(downstream_scope)
    return token.token

# Usage: agent accesses developer's Azure DevOps as the developer
# user_assertion comes from the incoming request's Authorization header
obo_token = get_obo_credential(
    user_assertion=incoming_request_token,
    downstream_scope="499b84ac-1321-427f-aa17-267ca6975798/.default"  # Azure DevOps scope
)
```

OBO requires your application to be registered with the delegated permissions for the downstream resource. The user must have granted consent (either at sign-in or through admin pre-consent). OBO is appropriate for:
- Agents that access user-specific cloud resources (SharePoint, OneDrive, Azure DevOps, Exchange).
- Scenarios where audit logs must show the *user* as the actor, not the service.
- Compliance requirements that demand user-level permission enforcement on downstream resources.

### User-delegated: OAuth2 authorization code flow with PKCE

For interactive scenarios where a user must explicitly grant the agent permission to access a third-party resource (not a Microsoft resource), use the OAuth2 authorization code flow with PKCE (Proof Key for Code Exchange). Unlike OBO (which exchanges an existing token), this flow requires user interaction to obtain initial consent:

1. The agent constructs an authorization URL and redirects the user to the resource provider's consent screen.
2. The user grants consent and is redirected back with an authorization code.
3. The agent exchanges the code (plus PKCE verifier) for an access token.
4. The agent stores the refresh token securely (in Key Vault) for subsequent calls without user interaction.

Use this flow for third-party API integrations where the provider uses their own identity platform (GitHub, Google Workspace, Salesforce, other SaaS platforms that don't accept Entra ID tokens). PKCE is mandatory for public clients and recommended for all authorization code flows to prevent authorization code interception attacks.

Store refresh tokens in Azure Key Vault, never in application code or environment variables. Refresh tokens are long-lived credentials equivalent in sensitivity to passwords.

### Key-based fallback

When managed identity and OAuth2 are unavailable—typically for third-party APIs or legacy systems that only accept API keys—use key-based authentication. Three disciplines make key-based authentication acceptable in a zero-trust architecture:

1. **Store keys exclusively in Azure Key Vault.** Never in environment variables, container images, configuration files, or source code. Retrieve at startup via managed identity access to Key Vault.
2. **Rotate on a defined schedule.** Key Vault rotation policies can automate rotation for supported resources. For manually rotated keys: quarterly rotation minimum; immediate rotation on any suspected compromise.
3. **Use separate keys per environment and per downstream service.** A breach of one key limits blast radius to one environment and one service, not the entire agent ecosystem.

### Authentication flow selection criteria

| Scenario | Recommended flow | Reason |
|---|---|---|
| Agent calls Azure service (Cosmos DB, Microsoft Foundry, Storage) | Managed identity | No credentials to manage; automatic rotation; zero-trust compliant |
| Agent calls agent within same Azure trust boundary | Managed identity + workload identity | Service-to-service; no user context needed |
| Agent accesses user's Microsoft 365 or Azure resources on their behalf | On-behalf-of (OBO) | Enforces user permissions; audit log shows user as actor |
| Agent accesses third-party SaaS on user's behalf (first login required) | OAuth2 authorization code + PKCE | User must grant explicit consent; refresh token stored in Key Vault |
| Agent accesses partner API that doesn't support Entra ID | Key-based fallback | Only option; mitigate with Key Vault storage + rotation policy |

## Secrets lifecycle management

Authentication flows require secrets: client secrets for OBO flows, refresh tokens for OAuth2, API keys for key-based access. Secrets lifecycle design determines whether a compromised credential causes a security incident or a catastrophic breach.

### Secrets versus certificates

Azure Key Vault stores three types of secrets objects with different lifecycle management:

- **Secrets** (plain-text strings)—API keys, connection strings, OAuth2 client secrets. Manually rotated or rotated via Key Vault rotation policies with custom rotation functions. Lowest overhead, lowest cryptographic strength.
- **Keys** (asymmetric or symmetric cryptographic keys)—used for data encryption, digital signing, and envelope encryption. Key Vault HSM-backed keys never leave the HSM. Rotatable via Key Vault key rotation policies. Use for any encryption operation rather than deriving keys from secrets.
- **Certificates** (X.509 certificates with integrated private keys)—used for TLS/mTLS mutual authentication (Unit 5's service mesh). Key Vault manages certificate issuance through integrated CAs (DigiCert, GlobalSign), renewal 30-90 days before expiry, and private key storage. Use certificates rather than shared secrets for service-to-service mutual authentication where both parties need cryptographic proof of identity.

Choose certificates over secrets for service-to-service authentication when the protocol supports it—certificates provide non-repudiation (the private key never leaves Key Vault) and automatic renewal.

### Automated key rotation

Key Vault rotation policies define automatic rotation behavior:

```python
from azure.keyvault.secrets import SecretClient
from azure.identity import DefaultAzureCredential

# Configure rotation policy (via ARM template or Bicep in production)
# This shows the rotation notification pattern in application code
class KeyVaultSecretManager:
    """Manages secrets with blue-green rotation support."""
    
    def __init__(self, vault_url: str):
        self.client = SecretClient(vault_url=vault_url, credential=DefaultAzureCredential())
    
    def get_current_api_key(self, secret_name: str) -> str:
        """Get the current active API key, supporting blue-green rotation."""
        # Primary key: current version
        try:
            primary = self.client.get_secret(f"{secret_name}-primary")
            if primary.properties.enabled:
                return primary.value
        except Exception:
            pass
        
        # Fallback to secondary during rotation transition
        secondary = self.client.get_secret(f"{secret_name}-secondary")
        return secondary.value
    
    def handle_rotation_event(self, secret_name: str) -> None:
        """Called when Key Vault rotation event fires—refresh cached credentials."""
        # Invalidate any in-memory cache of this secret
        self._invalidate_cache(secret_name)
        # Re-fetch from Key Vault on next use
```

**Blue-green secret rotation** prevents downtime during rotation: Key Vault creates a new secret version (blue) while the old version (green) remains active. Your application uses the blue-green retrieval pattern to try the primary version first and fall back to secondary during the brief window when the external system is being updated. After confirming the new key works, disable the old version.

For external APIs that don't support Key Vault rotation policies, implement rotation via Azure Functions triggered by a Key Vault expiry notification event. The rotation function: calls the external API to provision a new key, stores it in Key Vault as the new primary, tests connectivity, then disables the old primary and updates the secondary.

### RBAC granularity for Key Vault access

Apply least-privilege RBAC to Key Vault access at the secret level, not at the Key Vault level:

- **Key Vault Secrets User** role (read secrets)—each agent's managed identity gets this role only for the specific secrets it needs. The style-checker agent has no access to the compliance-checker's API key secret.
- **Key Vault Secrets Officer** role (manage secrets)—restricted to the CI/CD service principal that provisions secrets during deployment. Agents never hold this role.
- **Key Vault Administrator**—restricted to the platform team for break-glass scenarios. Never used in normal operations.

Use Azure RBAC (not legacy Key Vault access policies) for all permission grants—Azure RBAC provides audit logs, conditional access integration, and Just-In-Time (PIM) elevation for administrative access.

### Encryption choices

Data encryption in transit (TLS 1.2+, mTLS for inter-agent) is mandatory and covered in Unit 5. For data at rest, three encryption tiers address different regulatory requirements:

- **Microsoft-managed keys (MMK)**—Azure manages key rotation automatically. Meets most regulatory frameworks. Default for all Azure services.
- **Customer-managed keys (CMK)**—customer controls key rotation and revocation. Revoke the CMK and all encrypted data becomes inaccessible immediately—the "crypto-shred" capability required by GDPR erasure for data that can't be deleted (backup copies). Required for HIPAA and EU AI Act high-risk classifications in some interpretations.
- **Double encryption**—encrypt data with CMK, then encrypt the CMK with a Microsoft-managed HSM key. Required for specific government and high-security regulated workloads. Higher cost and operational overhead.

For Fabrikam's GDPR compliance, CMK is recommended for the Cosmos DB multi-tenant storage (enables crypto-shred for erasure requests) and optional for Azure AI Search indexes (data is already minimized and pseudonymized at ingestion).

## Key takeaways

- **Authentication flow taxonomy** covers four patterns: managed identity (service-to-Azure-service, baseline), on-behalf-of (service accesses user's resources respecting user permissions), user-delegated OAuth2 + PKCE (third-party resource with initial user consent), and key-based fallback (APIs that don't support Entra ID—always paired with Key Vault storage and rotation).
- **Managed identity isn't sufficient** when user-level permission enforcement on downstream resources is required—OBO flow enforces user permissions and records the user as the actor in audit logs.
- **Key-based authentication** is acceptable in zero-trust architectures only when paired with Key Vault storage (never environment variables), scheduled rotation, and per-service key isolation.
- **Secrets lifecycle design** chooses between secrets, keys, and certificates based on cryptographic strength requirements—certificates provide non-repudiation and automated renewal; secrets are simplest but provide no cryptographic identity proof.
- **Blue-green rotation** prevents downtime by maintaining primary and secondary versions during the rotation window; rotation event handlers refresh in-memory caches to prevent stale credential failures.
- **CMK encryption** enables crypto-shred for GDPR erasure compliance on data that can't be physically deleted (backup copies, immutable storage); configure at the storage-service level using Azure RBAC-governed Key Vault key access.
