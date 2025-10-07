Azure Key Vault addresses critical security challenges:

- **Secrets management:** Secure storage with granular access control for tokens, passwords, certificates, API keys, and credential material
- **Key management:** Comprehensive encryption key creation and control capabilities facilitating data protection operations
- **Certificate management:** Streamlined provisioning, management, and deployment of public and private SSL/TLS certificates for Azure and internal connected resources
- **Hardware security module backing:** Secret and key protection through software implementations or FIPS 140-2 Level 2 validated HSMs

  :::image type="content" source="../media/use-azure-key-vault-a9cc1c77.png" alt-text="Diagram of using Azure Key Vault.":::

## Why use Azure Key Vault?

## Centralize application secrets

Azure Key Vault centralized secret storage enables controlled distribution architectures.

Key Vault substantially reduces accidental secret disclosure risks.

Key Vault adoption eliminates application-embedded security information requirements removing code-level credential storage necessities.

Database connection scenarios demonstrate practical implementations: connection strings persisted in Key Vault replace application code storage patterns.

Applications access required information through URI-based retrieval operations supporting specific secret version specifications following Azure Key Vault storage.

Secret protection operations proceed without custom code implementation requirements.

## Securely store secrets and keys

Azure safeguards secrets and keys employing industry-standard algorithms, key lengths, and hardware security modules (HSMs).

HSM implementations maintain Federal Information Processing Standards (FIPS) 140-2 Level 2 validation.

Key vault access requires authentication and authorization completion before caller (user or application) access grants.

Authentication establishes caller identity while authorization determines permitted operations.

Azure Active Directory provides authentication mechanisms. Authorization employs role-based access control (RBAC) or Key Vault access policies.

RBAC governs vault management operations while Key Vault access policies control vault-stored data access attempts.

Azure Key Vaults support software-protected or hardware-HSM protected configurations.

Enhanced assurance requirements enable HSM-based key import or generation maintaining HSM boundary containment.

Microsoft employs Thales hardware security modules. Thales tools facilitate key migration from organizational HSMs to Azure Key Vault.

Azure Key Vault architecture ensures Microsoft data visibility and extraction prevention.

## Monitor access and use

Key Vault deployment scenarios necessitate key and secret access monitoring operations.

Logging enablement facilitates monitoring implementations. Azure Key Vault configuration options include:

- Storage account archival
- Event Hubs streaming
- Log Analytics transmission

Log ownership provides control mechanisms enabling access restriction implementations and obsolete log deletion operations.

## Simplified administration of application secrets

Valuable data storage requires security measures, lifecycle management, and high availability guarantees.

Azure Key Vault simplification capabilities:

- Hardware Security Module expertise elimination from organizational requirements
- Rapid scaling supporting organizational usage spike accommodations
- Regional and secondary region content replication ensuring high availability with automated failover eliminating administrator intervention
- Standard Azure administration interfaces through portal, Azure CLI, and PowerShell
- Public CA certificate task automation including enrollment and renewal operations

Azure Key Vaults enable application secret segregation.

Applications access authorized vaults exclusively performing permitted operations only.

Per-application Azure Key Vault creation facilitates secret restriction to specific applications and development teams.

## Integrate with other Azure services

Azure secure storage positioning enables Key Vault scenario simplification including Azure Disk Encryption, SQL Server and Azure SQL Database always encrypted functionality, and Azure web applications.

Key Vault native integration capabilities encompass storage accounts, Event Hubs, and log analytics services.
