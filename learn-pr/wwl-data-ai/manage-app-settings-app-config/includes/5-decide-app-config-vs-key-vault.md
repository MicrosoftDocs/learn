Azure App Configuration and Azure Key Vault serve complementary roles in managing the settings that AI applications need. Both services store values that control application behavior, but they're designed for different types of data with different security, lifecycle, and operational requirements. Making the right placement decision for each setting ensures that sensitive data gets the protection it needs while nonsensitive settings benefit from the configuration management features that App Configuration provides. This unit provides clear criteria for classifying each setting and shows how the two services work together in a unified architecture.

## Understand the design intent of each service

Azure App Configuration is built for application settings: nonsensitive key-value pairs that control how your application behaves at runtime. These settings include endpoints, feature flags, batch sizes, retry counts, timeout values, and display strings. App Configuration provides labels for environment differentiation, feature flag management, key-value snapshots for point-in-time rollback, and lightweight dynamic refresh through the provider library. These capabilities help developers manage the operational parameters of their applications across environments and deployment stages.

Azure Key Vault is built for sensitive data: secrets (API keys, connection strings, passwords), cryptographic keys, and certificates. Key Vault encrypts data at rest with HSM-backed protection, logs every access operation in an audit trail, enforces expiration policies, supports automated rotation, and provides soft delete with purge protection to prevent accidental data loss. These capabilities address the security and compliance requirements that sensitive credentials demand.

Each service excels at its intended purpose. Using App Configuration for all settings, including secrets, means sensitive data misses the security guarantees of Key Vault. Using Key Vault for all settings means nonsensitive data can't benefit from labels, feature flags, or App Configuration's higher throughput limits.

## Classify settings by sensitivity

The most important criterion for placement is whether a value grants access to a resource or contains credentials. Values that grant access are sensitive and belong in Key Vault. Values that control behavior without granting access are nonsensitive and belong in App Configuration.

**Non-sensitive settings for App Configuration:**

- Model endpoint URLs like `https://my-openai.openai.azure.com/`
- Model deployment names like `gpt-4o` or `text-embedding-ada-002`
- Embedding dimensions like `1536` or `3072`
- Batch sizes, retry counts, and timeout values
- Feature flags that toggle processing paths
- Logging levels and diagnostic settings
- Queue names, container names, and database names
- Pipeline stage configuration and routing rules

**Sensitive settings for Key Vault:**

- Azure OpenAI API keys
- Database connection strings that contain embedded credentials
- Storage account access keys
- Third-party service tokens and API keys
- TLS certificates and their private keys
- Encryption keys for data at rest
- Passwords and service principal secrets

The distinction is straightforward for most settings. If the value alone could let someone access a resource or perform an operation they shouldn't, it belongs in Key Vault. If the value controls how the application behaves but doesn't grant access to anything, it belongs in App Configuration.

## Consider rotation and audit requirements

Settings that require periodic rotation with audit trails and expiration policies benefit from Key Vault's lifecycle management features. Key Vault records every secret access in diagnostic logs, supports expiration dates that flag aging credentials, and integrates with automated rotation services. If a credential needs to rotate on a schedule, and you need proof that rotation occurred, Key Vault is the right place for that value.

Settings that change for operational reasons, like adjusting a batch size in response to load patterns or switching a model deployment name after a new model version passes validation, don't need rotation audit trails. These changes are operational decisions, not security events. App Configuration handles these changes through its label system and dynamic refresh, which lets operators update settings without redeploying the application.

## Evaluate access control granularity

Key Vault provides detailed audit logs that record which identity accessed which secret at what time. This per-object access tracking is essential for credentials that fall under compliance requirements or security policies. App Configuration provides store-level RBAC, which controls who can read or write settings across the entire store. If a specific value requires individual access tracking beyond what App Configuration's store-level RBAC provides, Key Vault is the appropriate choice.

For most AI application settings, store-level RBAC is sufficient. The application identity gets read access to the configuration store, and operators get write access. Secrets in Key Vault get their own access tracking and can be further restricted by assigning Key Vault roles at the individual key vault level. This layered approach provides detailed tracking for sensitive data without burdening nonsensitive settings with unnecessary access logging overhead.

## Use the complementary architecture pattern

The recommended architecture uses App Configuration as the single entry point for all application settings and Key Vault as the secure backend for sensitive values. Regular settings live directly in App Configuration as standard key-value pairs. Sensitive values live in Key Vault and are accessed through Key Vault references in App Configuration. The application calls `load()` once and receives both types of settings in a unified dictionary.

This pattern provides several benefits. Operators manage the full configuration surface in one place, App Configuration. They can see all the settings an application uses, including references to Key Vault secrets, without switching between services. Labels, feature flags, and key-value composition apply uniformly to both regular settings and Key Vault references. The application code stays simple because it accesses all settings through the same dictionary interface, regardless of where the values originate.

The following table summarizes how different types of settings map to services in this architecture:

| Setting type | Service | Example |
|---|---|---|
| Nonsensitive configuration | App Configuration (direct value) | `OpenAI:Endpoint`, `Pipeline:BatchSize` |
| Feature toggles | App Configuration (feature flag) | `UseNewEmbeddingsModel`, `EnableBatchProcessing` |
| API keys and tokens | Key Vault (via App Configuration reference) | `OpenAI:ApiKey`, `ThirdParty:ServiceToken` |
| Connection strings with credentials | Key Vault (via App Configuration reference) | `CosmosDB:ConnectionString`, `Storage:AccountKey` |
| Certificates | Key Vault (direct access) | TLS certificates for HTTPS endpoints |

## Avoid common anti-patterns

Developers sometimes make placement decisions that undermine the benefits of having both services. Recognizing these anti-patterns helps you avoid common pitfalls.

- **Storing secrets directly in App Configuration:** App Configuration doesn't provide per-object audit logging, HSM-backed encryption, expiration policies, or automated rotation. Placing secrets directly in App Configuration means those credentials miss critical security capabilities. Always use Key Vault references for values that grant access to resources.
- **Using Key Vault for non-sensitive settings:** Key Vault imposes stricter [throttling limits](/azure/key-vault/general/service-limits) than App Configuration and doesn't support labels, feature flags, or configuration snapshots. Storing batch sizes, feature flags, and endpoint URLs in Key Vault wastes its specialized security capabilities on values that don't need them and might trigger throttling under high-throughput scenarios.
- **Duplicating settings across both services without references:** If you store a value independently in both App Configuration and Key Vault, the two copies can drift apart. One gets updated while the other retains the old value, and the application might read the stale version. Key Vault references eliminate this risk because App Configuration stores only the pointer, not the value. There's a single source of truth for each setting.
- **Embedding all configuration in application code:** Moving settings into App Configuration and Key Vault is only effective if the application actually reads from these services. Hard-coding values in application code or static configuration files bypasses both services and loses the ability to update settings without redeployment.

## Additional resources

- [Azure App Configuration best practices](/azure/azure-app-configuration/howto-best-practices)
- [Best practices for using Azure Key Vault](/azure/key-vault/general/best-practices)
- [What is Azure App Configuration?](/azure/azure-app-configuration/overview)
