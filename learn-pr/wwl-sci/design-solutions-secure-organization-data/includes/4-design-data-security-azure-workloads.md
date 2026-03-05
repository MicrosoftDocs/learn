Azure data workloads including Azure SQL, Azure Synapse Analytics, and Azure Cosmos DB require security architectures that address their unique characteristics and threat models. This unit covers design considerations for securing data in these Azure services, aligned with MCSB controls and security best practices.

## Design considerations for securing data in Azure workloads

Before examining individual services, understand the common security patterns that apply across Azure data workloads. These patterns align with the defense-in-depth approach recommended by the WAF Security pillar and MCSB controls.

### Defense in depth for data services

Implement multiple security layers to protect your data workloads. The following diagram illustrates the layered defense-in-depth approach, showing how customer data is protected by successive layers of network security, access management, and threat and information protections:

:::image type="content" source="../media/sql-security-layer.png" alt-text="Diagram of layered defense-in-depth showing customer data encased in layers of network security, access management, and threat and information protections." lightbox="../media/sql-security-layer.png":::

Each layer provides specific protections:

| Layer | Purpose | Common controls |
|-------|---------|-----------------|
| **Network security** | Control access paths to data services | Private endpoints, firewalls, VNet integration |
| **Access management** | Verify and authorize who accesses data | Microsoft Entra authentication, RBAC, row-level security |
| **Threat protection** | Detect and respond to security threats | Microsoft Defender, auditing, threat detection |
| **Information protection** | Protect data confidentiality and integrity | TDE, CMK, Always Encrypted, TLS 1.2+ |

### Zero Trust principles for data workloads

Apply Zero Trust principles consistently across all data services:

- **Verify explicitly**: Use Microsoft Entra authentication rather than shared keys or connection strings where possible
- **Least privilege access**: Grant minimal permissions through RBAC rather than administrative accounts
- **Assume breach**: Enable threat detection, encrypt all data, and monitor for anomalies

### Common design decisions

When designing security for any Azure data workload, address these questions:

- **Network access**: Should the service be accessible from the internet, or only through private endpoints?
- **Authentication method**: Can you use Microsoft Entra ID, or do legacy requirements mandate other methods?
- **Key management**: Are platform-managed keys sufficient, or do regulations require customer-managed keys?
- **Threat detection**: What level of monitoring and alerting does the workload require?

## Design security for Azure SQL Database and Azure SQL Managed Instance

[Azure SQL Database and Azure SQL Managed Instance](/azure/azure-sql/database/security-overview) provide a relational database service for cloud and enterprise applications with comprehensive security capabilities.

### Network security for Azure SQL

Firewalls prevent network access to the server until you explicitly grant access based on IP address or Azure Virtual network traffic origin.

- **IP firewall rules**: Grant access to databases based on the originating IP address of each request
- **Virtual network firewall rules**: Use [virtual network service endpoints](/azure/virtual-network/virtual-network-service-endpoints-overview) to allow traffic only from selected subnets inside a virtual network
- **Private endpoints**: Assign a private IP address from your VNet for complete network isolation through Azure Private Link
- **Network security perimeter**: Create logical network boundaries around your PaaS resources (preview for Azure SQL Database)

> [!NOTE]
> Controlling access with firewall rules doesn't apply to SQL Managed Instance. For more information about the networking configuration needed, see [Connecting to a managed instance](/azure/azure-sql/managed-instance/connect-application-instance).

### Authentication for Azure SQL

Azure SQL Database and SQL Managed Instance support multiple authentication methods:

- **Microsoft Entra authentication**: Centrally manage identities and permissions using Microsoft Entra ID. Supports multifactor authentication, Integrated Windows authentication, and Conditional Access. This is the preferred method for all new deployments.
- **Windows authentication (Kerberos)**: Available for Azure SQL Managed Instance only. Enables Windows authentication for Microsoft Entra principals, allowing customers to move existing services to the cloud while maintaining a seamless user experience.
- **SQL authentication**: Username and password authentication. Avoid for new deployments; use only for legacy applications that can't support Microsoft Entra authentication.

### Authorization and access management

Manage permissions by adding user accounts to [database roles](/sql/relational-databases/security/authentication-access/database-level-roles) and assigning database-level permissions to those roles. As a best practice, create custom roles when needed and add users to the role with the least privileges required to do their job function.

The following diagram shows how Row-Level Security shields individual rows of a SQL database from access by users through a client app:

:::image type="content" source="../media/row-level-security.png" alt-text="Diagram showing Row-Level Security shielding individual rows of an SQL database from access by users via a client app.":::

Authorization controls include:

- **Server-level roles**: Control administrative access (Azure SQL Managed Instance provides fixed and custom server-level roles)
- **Database-level roles**: Manage data access permissions
- **Row-level security**: Control access to rows based on user characteristics or execution context
- **Column-level permissions**: Restrict access to sensitive columns
- **Dynamic data masking**: Obfuscate sensitive data for nonprivileged users

### Information protection and encryption

Azure SQL provides comprehensive encryption capabilities:

**Transparent Data Encryption (TDE)**: Adds a layer of security to help protect data at rest from unauthorized or offline access to raw files or backups. In Azure, all newly created databases are encrypted by default with service-managed keys. You can also use [customer-managed keys (CMK)](/azure/azure-sql/database/transparent-data-encryption-byok-overview) stored in Azure Key Vault for greater control.

**Always Encrypted**: Protects sensitive data stored in specific database columns from access by database administrators or other privileged users. The data is always encrypted—decrypted only for processing by client applications with access to the encryption key.

:::image type="content" source="../media/always-encrypted.png" alt-text="Diagram showing the basics of Always Encrypted feature where an SQL database with a lock is only accessed by an app containing a key.":::

**Transport Layer Security (TLS)**: SQL Database, SQL Managed Instance, and Azure Synapse Analytics always enforce TLS encrypted connections. Use TLS 1.2 or higher, and use TDS 8.0 with Strict connection encryption when available.

### Threat protection for Azure SQL

**Auditing**: Tracks database activities and helps maintain compliance with security standards by recording database events to an audit log. Allows you to monitor ongoing database activities and analyze historical activity to identify potential threats.

**Advanced Threat Protection**: Analyzes logs to detect unusual behavior and potentially harmful attempts to access or exploit databases:

Advanced Threat Protection creates alerts for:

- SQL injection attempts
- Potential data infiltration
- Brute force attacks
- Anomalies in access patterns indicating privilege escalations and breached credentials

### Security management

- **Vulnerability assessment**: Discover, track, and help remediate potential database vulnerabilities as part of Microsoft Defender for SQL
- **Data discovery and classification**: Built-in capabilities for discovering, classifying, and labeling sensitive data in your databases
- **Microsoft Defender for SQL**: Unified package for advanced SQL security capabilities

## Design security for Azure Synapse Analytics

[Azure Synapse Analytics](/azure/synapse-analytics/guidance/security-white-paper-introduction) is a PaaS analytics service that brings together dedicated SQL pools, serverless SQL pools, Apache Spark pools, and data integration pipelines. Azure Synapse implements a multi-layered security architecture for end-to-end protection of your data.

### Security layers for Synapse

Azure Synapse implements five security layers:

:::image type="content" source="../media/azure-synapse-security-layers.png" alt-text="Diagram of the five layers of Azure Synapse security architecture: Data protection, Access control, Authentication, Network security, and Threat protection.":::

### Data protection

Data protection in Synapse covers data classification and encryption:

- **At rest (storage)**: Azure Storage encryption with SSE and optional CMK
- **At rest (database)**: TDE with service-managed or customer-managed keys
- **In transit**: TLS 1.2 with AES-256 encryption
- **Double encryption**: Infrastructure encryption at storage layer

### Access control

Synapse provides granular access controls to determine a user's right to interact with data:

- **Synapse RBAC roles**: Manage workspace and resource access
- **SQL permissions**: Control data access in SQL pools using row-level security and column-level security
- **Azure RBAC**: Manage control plane access
- **Data exfiltration protection**: Prevent unauthorized data export to external locations

### Authentication

Prove the identity of users and applications through Microsoft Entra integration:

- **Microsoft Entra authentication**: Centralized identity management with support for multifactor authentication
- **Managed identities**: Service-to-service authentication without credentials
- **Service principals**: Application authentication for automated processes

### Network security

Associate your Synapse workspace with a [managed workspace virtual network](/azure/synapse-analytics/security/synapse-workspace-managed-vnet) to:

- Isolate Spark and integration runtime resources inside the managed workspace virtual network
- Require managed private endpoints for outbound connections
- Ensure network isolation between workspaces for pipelines and Apache Spark workloads
- Prevent data exfiltration through network controls

### Threat protection

Identify potential security threats through monitoring and alerting:

- **Microsoft Defender for SQL**: Detect unusual access locations, SQL injection attacks, and authentication attacks
- **Auditing**: Track database activities and maintain compliance with security standards
- **Vulnerability assessment**: Discover and remediate potential security weaknesses

## Design security for Azure Cosmos DB

[Azure Cosmos DB](/azure/cosmos-db/secure-access-to-data) is a globally distributed, multi-model database service designed for mission-critical applications. While Azure Cosmos DB provides built-in security features, follow best practices to further enhance security.

### Network security for Cosmos DB

- **Disable public network access and use Private Endpoints only**: Deploy Azure Cosmos DB with a configuration that restricts network access to an Azure-deployed virtual network. Disable public network access for the entire account and use private endpoints exclusively. For more information, see [configure access from private endpoints](/azure/cosmos-db/how-to-configure-private-endpoints).
- **Enable Network Security Perimeter**: Use Network Security Perimeter (NSP) to restrict access to your Azure Cosmos DB account by defining network boundaries and isolating it from public internet access.

### Identity management for Cosmos DB

- **Use managed identities**: Eliminate the need to manage credentials by providing an automatically managed identity in Microsoft Entra ID. Use managed identities to securely access Azure Cosmos DB from other Azure services without embedding credentials in your code.
- **Use Azure control plane RBAC**: Apply Azure role-based access control to define fine-grained permissions for managing Azure Cosmos DB accounts, databases, and containers.
- **Use native data plane RBAC**: Implement data plane role-based access control to enforce least privilege access for querying, creating, and accessing items within Azure Cosmos DB containers.
- **Separate identities for data and control plane**: Use distinct Azure identities for control plane and data plane operations to reduce the risk of privilege escalation.

### Transport and data encryption for Cosmos DB

- **Enforce TLS 1.3**: Secure data in transit with the latest cryptographic protocols, ensuring stronger encryption and improved performance. For more information, see [Minimum TLS enforcement](/azure/cosmos-db/self-serve-minimum-tls-enforcement).
- **Encrypt data at rest**: Data stored in Azure Cosmos DB is automatically and seamlessly encrypted with keys managed by Microsoft (service-managed keys). For greater control, use [customer-managed keys](/azure/cosmos-db/how-to-setup-customer-managed-keys) stored in Azure Key Vault.
- **Use Always Encrypted**: Ensure sensitive data is encrypted on the client side before being sent to Azure Cosmos DB, providing an extra layer of security.

### Backup and data protection for Cosmos DB

- **Enable continuous backup and restore**: Protect your data by enabling continuous backup, which allows you to restore your Azure Cosmos DB account to any point in time within the retention period.
- **Test backup and recovery procedures**: Regularly test the restoration of databases, containers, and items to verify the effectiveness of backup processes.

### Threat detection for Cosmos DB

- **Enable Microsoft Defender for Azure Cosmos DB**: Automatically detect multiple security threats including data exfiltration attempts, potential SQL injection, and anomalous access patterns
- **Enable resource logs**: Monitor your activity through Azure Monitor or custom diagnostic logs that can be analyzed with Azure Log Analytics
