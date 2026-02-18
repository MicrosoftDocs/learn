Azure Key Vault is a cloud-hosted service that provides centralized storage and management for sensitive data such as API keys, connection strings, encryption keys, and TLS certificates. AI solutions on Azure handle credentials across every layer of their architecture. A RAG pipeline, for example, might store an Azure OpenAI API key, a Cosmos DB connection string, a storage account key, and a TLS certificate for its public endpoint. Azure Key Vault gives developers a single, secure location to store all of these credentials and retrieve them at runtime through SDK calls, without embedding secrets in application code or configuration files.

## Understand Key Vault capabilities and service tiers

Azure Key Vault provides three core capabilities: secrets management, key management, and certificate management. Each capability addresses a different type of sensitive data, and understanding the distinctions helps you choose the right object type for each credential in your AI application. Key Vault encrypts all stored objects at rest and controls access through Microsoft Entra ID authentication combined with Azure role-based access control (RBAC) authorization.

Key Vault operates in two service tiers that determine how cryptographic keys are protected:

- **Standard tier:** Encrypts keys using software libraries validated to FIPS 140 Level 1. This tier is suitable for most application scenarios where software-protected keys provide sufficient security.
- **Premium tier:** Protects keys using FIPS 140-3 Level 3 validated hardware security modules (HSMs). Key material never leaves the HSM boundary. You can choose this tier when regulatory or compliance requirements mandate HSM-protected keys.

> [!NOTE]
> Key Vault tiers, features, and pricing change regularly. For the latest details, see [Key Vault pricing](https://azure.microsoft.com/pricing/details/key-vault/).

Developers interact with Key Vault through REST APIs, Azure SDKs (available for Python, .NET, Java, JavaScript, and Go), the Azure CLI, and the Azure portal. The Python SDK is the primary client library used throughout this module.

## Choose the right object type for your credentials

Key Vault stores three object types: secrets, keys, and certificates. Each type serves a distinct purpose, and AI applications often use all three. Selecting the correct object type ensures that your credentials benefit from the appropriate storage, access control, and lifecycle management features.

**Secrets** store arbitrary string values up to 25 KB, such as API keys, connection strings, passwords, and tokens. AI applications use secrets for model endpoint keys, database credentials, and third-party service tokens. Key Vault treats secret values as opaque byte sequences and doesn't enforce any particular structure on the stored data. You can set a `content_type` property (up to 255 characters) to help consumers interpret the value. For example, a `content_type` of `text/plain` signals a simple string, while `application/json` indicates a structured JSON payload.

```python
# Code fragment - focus on setting a secret with content_type
client.set_secret(
    "openai-api-key",
    "sk-abc123def456",
    content_type="text/plain",
    tags={"environment": "production", "team": "ai-platform"}
)
```

**Keys** store cryptographic keys for encryption, signing, and key wrapping operations. Key Vault performs cryptographic operations server-side, so the key material never leaves the vault boundary. AI pipelines that encrypt training data at rest or sign model artifacts use Key Vault keys. Keys support RSA (2048, 3072, and 4096 bit), elliptic curve (P-256, P-256K, P-384, P-521), and symmetric (oct) key types. Because the vault performs the cryptographic operations rather than exposing raw key material, you get stronger security guarantees than managing key files locally.

**Certificates** store and manage X.509 certificates along with their private keys. Key Vault handles certificate lifecycle operations including issuance, renewal, and revocation through integration with certificate authorities. AI services that expose HTTPS endpoints or use mutual TLS for service-to-service authentication benefit from certificate management in Key Vault. When Key Vault stores a certificate, it creates a corresponding key and secret object that you can access through the key and secret APIs respectively.

## Organize vaults and objects for AI solutions

A well-organized vault structure simplifies secret management as your AI application scales across environments and teams. Key Vault doesn't restrict the number of secrets, keys, or certificates you can store in a single vault, but organizing objects with clear boundaries reduces security risk and operational complexity.

**Vault-per-application boundary:** You can create separate vaults for each application and environment combination. For example, a RAG pipeline might use `kv-ragpipeline-dev`, `kv-ragpipeline-staging`, and `kv-ragpipeline-prod`. This separation limits the blast radius of a security incident. A compromised vault exposes only the secrets for one application in one environment. Vault-per-application boundaries also simplify RBAC assignments because you can grant a development team access to the development vault without exposing production credentials.

**Naming conventions:** You can use descriptive, hyphenated names that encode the resource type and purpose. Examples include `cosmosdb-connection-string`, `openai-api-key`, and `blob-storage-account-key`. Consistent naming simplifies programmatic lookups and reduces errors when referencing secrets in code. Vault names themselves must be globally unique within Azure, three to 24 characters long, and contain only alphanumeric characters and hyphens. Vault names must begin with a letter, end with a letter or digit, and can't contain consecutive hyphens.

**Tags for metadata:** You can attach tags to secrets for filtering and management. Each secret supports up to 15 tags, with tag names limited to 512 characters and values limited to 256 characters. Tags like `environment=production`, `team=ai-platform`, and `rotation-policy=90-days` enable bulk operations and reporting across large numbers of vault objects. Anyone with `list` or `get` permission on secrets can read tags, so don't store sensitive data in tag values.

## Control access with Azure RBAC

Azure Key Vault supports two authorization models: Azure RBAC and legacy access policies. Azure RBAC is the recommended approach because it provides granular permission control at the Azure resource level, supports Privileged Identity Management (PIM) for just-in-time access, and works consistently across both the control plane (vault management) and the data plane (secret, key, and certificate operations).

Key Vault defines several built-in data plane roles that map to common access patterns. The following roles are the most relevant for secret management in AI applications:

- **Key Vault Secrets User:** Grants read-only access to secret values, including the ability to read certificate private keys stored as secrets. Assign this role to application managed identities that need to retrieve credentials at runtime.
- **Key Vault Secrets Officer:** Grants full management permissions on secrets, including create, update, delete, and list operations. Assign this role to operators or CI/CD pipelines responsible for secret lifecycle management.
- **Key Vault Administrator:** Grants all data plane operations on keys, secrets, and certificates. This role doesn't grant control plane permissions to manage the vault resource itself or modify role assignments.
- **Key Vault Reader:** Grants read access to vault metadata (such as secret names and properties) without revealing secret values or key material. Useful for monitoring and discovery tools that need to verify which secrets exist without accessing their contents.

You can use managed identities for application-to-vault authentication. A managed identity eliminates the need to store any credential in your application code or configuration. The application authenticates to Key Vault through Microsoft Entra ID, and the RBAC role assignment determines what operations the identity can perform. This pattern means your application needs zero stored credentials to access the vault that holds all of its other credentials.

> [!IMPORTANT]
> The `Key Vault Contributor` role is a control plane role only. It grants permissions to manage the vault resource (create, delete, update vault properties) but doesn't grant access to data plane operations such as reading secrets, keys, or certificates. Always use the data plane roles listed previously for secret access.

## Protect against accidental deletion with soft delete and purge protection

Key Vault enables soft delete by default on all new vaults, and you can't disable it once enabled. When you delete a secret, key, or certificate, Key Vault retains the object in a deleted state for a configurable retention period between seven and 90 days (the default is 90 days). You set the retention period at vault creation, and you can't change it afterward. During the retention window, you can recover deleted objects to their previous state.

Purge protection is an optional feature that prevents permanent deletion of soft-deleted objects during the retention period. When purge protection is enabled, no one can permanently remove a secret until the retention period expires. Purge protection is especially important for AI solutions where losing an encryption key or certificate can render stored data permanently inaccessible. Consider enabling purge protection on production vaults to guard against both accidental and malicious data loss.

When a Key Vault itself is soft-deleted, its RBAC role assignments and Event Grid subscriptions are also deleted. These resources aren't automatically restored when you recover the vault, so you need to recreate them manually after recovery.

## Additional resources

- [About Azure Key Vault](/azure/key-vault/general/overview)
- [About Azure Key Vault secrets](/azure/key-vault/secrets/about-secrets)
- [Azure RBAC for Key Vault data plane operations](/azure/key-vault/general/rbac-guide)
