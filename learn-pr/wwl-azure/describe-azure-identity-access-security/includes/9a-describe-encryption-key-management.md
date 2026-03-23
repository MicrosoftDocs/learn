Encryption helps protect data confidentiality by making data unreadable to unauthorized users.

## Encryption at rest and in transit

In Azure, encryption is commonly discussed in two forms:

 -  Encryption at rest protects data when it is stored, such as in databases, disks, and storage accounts.
 -  Encryption in transit protects data while it moves between services, applications, and users.

A strong security posture generally includes both.

:::image type="content" source="../media/encryption-key-mgmt-option-split.png" alt-text="Diagram showing encryption at rest protecting databases, disks, and storage, and encryption in transit protecting data moving between application tiers and users, with Azure Key Vault managing secrets, encryption keys, and certificates for both.":::

## Practical example

Consider a line-of-business application that stores customer records in Azure Storage and Azure SQL. Data should be encrypted while stored in those services and while moving between application tiers, APIs, and user devices.

## Key management with Azure Key Vault

Azure Key Vault is a service for securely storing and controlling access to:

 -  Secrets (such as connection strings and passwords)
 -  Encryption keys
 -  Certificates

Using Key Vault helps centralize secret and key management instead of storing sensitive values directly in application code or configuration files.

:::image type="content" source="../media/encryption-key-mgmt-option-hub.png" alt-text="Diagram showing Azure Key Vault as a central hub managing three categories: secrets such as passwords and connection strings, encryption keys for at-rest and in-transit protection, and certificates for TLS and SSL. Benefits include access control, key rotation, and usage auditing.":::

## Why key management matters

Key management supports security and compliance goals by helping you:

 -  Control who can access keys and secrets
 -  Rotate and update keys over time
 -  Audit key and secret usage

You can also separate duties by limiting who can view, use, and rotate keys. This approach helps reduce risk and supports compliance reporting.

Another common practice is to set key rotation policies and alerting so teams are notified before keys expire. This helps avoid service disruption while maintaining secure key hygiene.

When applications retrieve secrets from Key Vault at runtime by using managed identities, teams can reduce hard-coded credentials and improve overall secret governance.

At a fundamentals level, remember that Azure Key Vault is the primary Azure service for secure key and secret storage.

