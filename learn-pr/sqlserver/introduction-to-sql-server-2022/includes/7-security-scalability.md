[SQL Server 2025](/sql/relational-databases/security/security-center-for-sql-server-database-engine-and-azure-sql-database) provides security features for data protection, identity management, and compliance. This unit covers security improvements and scalability enhancements.

## Configure security cache

[SQL Server security](/sql/relational-databases/security/authentication-access/database-level-roles) includes optimizations to the security cache, reducing authentication latency and improving scalability for environments with many users or frequent permission changes. These improvements help ensure that access checks remain fast and reliable, even as your database grows.

## Implement encryption and password protection

[SQL Server encryption](/sql/relational-databases/security/encryption/sql-server-encryption) now includes support for OAEP (Optimal Asymmetric Encryption Padding) is now available, providing stronger encryption for sensitive data and aligning with modern cryptographic standards. SQL Server 2025 also introduces PBKDF (Password-Based Key Derivation Function) password hashing, which makes stored passwords more resistant to brute-force and dictionary attacks by using advanced hashing algorithms and configurable iteration counts.

## Use managed identities

[Managed identities](/azure/active-directory/managed-identities-azure-resources/overview)  simplify secure connections to Azure services by eliminating the need for manual credential management. You can now authenticate to SQL Server using system-assigned managed identities, simplifying access control for applications running in Azure. Managed identities are also supported for:

- Backing up databases to URL destinations
- Using Extensible Key Management (EKM) modules
- Accessing AI models securely

These enhancements reduce the need for hard-coded secrets and manual credential management, improving both security and operational efficiency.

## Set up flexible authentication and login options

[Microsoft Entra authentication](/sql/relational-databases/security/authentication-access/authentication-microsoft-entra-id) in SQL Server 2025 supports logins with nonunique display names, making it easier to manage users in large organizations. On Linux, you can now define custom password policies, allowing you to enforce organization-specific complexity and rotation requirements for local SQL logins.

## Enable modern protocols

[Network protocols](/sql/database-engine/configure-windows/enable-or-disable-a-server-network-protocol) in SQL Server 2025 introduces support for TDS 8.0 and TLS 1.3 in client tools and drivers. These protocols provide stronger encryption, improved handshake performance, and better compatibility with modern security infrastructure.

## Monitor security and compliance

[SQL Server Audit](/sql/relational-databases/security/auditing/sql-server-audit-database-engine) SQL Server 2025 includes these security monitoring capabilities:

| Feature | Purpose | Documentation |
|---------|----------|--------------|
| Extended Events | Track security-related events | [Extended Events](/sql/relational-databases/extended-events/extended-events) |
| Threat Detection | Identify potential security threats | [Advanced Threat Protection](/sql/relational-databases/security/sql-advanced-threat-protection) |
| Compliance Tools | Meet regulatory requirements | [Compliance Guide](/sql/relational-databases/security/compliance-guide) |
| Activity Monitoring | Track user and system actions | [Activity Monitoring](/sql/relational-databases/security/monitoring-activity) |