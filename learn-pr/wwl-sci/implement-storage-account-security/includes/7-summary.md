In this module, you implemented defense-in-depth security for Azure Storage by addressing vulnerabilities at the access layer. You started by configuring foundational account-level security settings—requiring secure transfer, enforcing Transport Layer Security (TLS) 1.2, disabling anonymous blob access, and preventing cross-tenant replication. These settings create a baseline that protects data in transit and prevents unintended public exposure.

You then evaluated authorization models and learned why managed identities with RBAC roles are the preferred approach for AI workloads. By migrating Contoso's Azure Functions from storage account keys to managed identities, you eliminated the highest-risk credential type from application configurations. You explored stored access policies as a solution for scenarios requiring revocable service SAS tokens, providing operational flexibility for external access without relying on storage account keys.

Finally, you learned how to disable Shared Key authorization entirely and enforce this configuration at scale using Azure Policy. This approach ensures that all storage accounts in your environment reject any authentication attempts using storage account keys, forcing modern identity-based access across all applications.

The techniques you applied in this module address access control and authentication. In the next module, you configure network security for Azure Storage, restricting which networks and IP addresses reach storage accounts and implementing private endpoint connectivity for AI workloads.

## Learn more

- [Authorize access to data in Azure Storage](/azure/storage/common/authorize-data-access)
- [Prevent Shared Key authorization for an Azure Storage account](/azure/storage/common/shared-key-authorization-prevent)
