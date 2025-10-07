SQL Server 2025 provides security features for data protection, identity management, and compliance. This unit covers security improvements and scalability enhancements.

## Configure security cache

[SQL Server security](/sql/relational-databases/security/security-center-for-sql-server-database-engine-and-azure-sql-database) includes optimizations to the security cache, reducing authentication latency and improving scalability for environments with many users or frequent permission changes. These improvements help ensure that access checks remain fast and reliable, even as your database grows.

## Implement encryption and password protection

[SQL Server encryption](/sql/relational-databases/security/encryption/sql-server-encryption) now includes support for OAEP (Optimal Asymmetric Encryption Padding) is now available, providing stronger encryption for sensitive data and aligning with modern cryptographic standards. SQL Server 2025 also introduces PBKDF (Password-Based Key Derivation Function) password hashing, which makes stored passwords more resistant to brute-force and dictionary attacks by using advanced hashing algorithms and configurable iteration counts.

## Use managed identities

SQL Server 2025 adds support for Microsoft Entra [managed identities](/sql/sql-server/azure-arc/managed-identity), making it easier to connect securely to Azure services without storing or managing credentials. Managed identities are automatically handled by Azure and can authenticate to any service that supports Microsoft Entra authentication. With this release, SQL Server can use managed identities for both inbound connections and outbound calls to Azure resources. When your SQL Server instance is onboarded to Azure Arc, a system-assigned managed identity is created for the server. After creation, you need to link the identity to the SQL Server instance and your Microsoft Entra tenant by updating the registry settings.

Managed identities are also supported for:

- Backing up databases to URL destinations
- Using Extensible Key Management (EKM) modules
- Accessing AI models securely

These enhancements reduce the need for hard-coded secrets and manual credential management, improving both security and operational efficiency.

## Set up flexible authentication and login options

[Microsoft Entra authentication](/sql/relational-databases/security/authentication-access/azure-ad-authentication-sql-server-overview) in SQL Server 2025 supports logins with nonunique display names, making it easier to manage users in large organizations. On Linux, you can now define custom password policies, allowing you to enforce organization-specific complexity and rotation requirements for local SQL logins.

## Enable modern protocols

[Network protocols](/sql/database-engine/configure-windows/enable-or-disable-a-server-network-protocol) in SQL Server 2025 introduces support for TDS 8.0 and TLS 1.3 in client tools and drivers. These protocols provide stronger encryption, improved handshake performance, and better compatibility with modern security infrastructure.

## Monitor security and compliance

[SQL Server Audit](/sql/relational-databases/security/auditing/sql-server-audit-database-engine) provides comprehensive monitoring capabilities. SQL Server 2025 enhances these security monitoring features:

| Feature | Purpose | Documentation |
|---------|----------|--------------|
| Server Audit | Track server-level actions and changes | [Server Audit Specification](/sql/t-sql/statements/create-server-audit-specification-transact-sql) |
| Database Audit | Monitor database-level events | [Database Audit Specification](/sql/t-sql/statements/create-database-audit-specification-transact-sql) |
| Extended Events | Capture detailed audit data | [Extended events](/sql/relational-databases/extended-events/quick-start-extended-events-in-sql-server) |
| Audit Log Management | Configure audit log storage and retention | [View audit logs](/sql/relational-databases/security/auditing/view-a-sql-server-audit-log) |