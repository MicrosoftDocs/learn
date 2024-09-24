In this unit, we will explore the essential security features of Azure SQL Database, focusing on Microsoft Entra authentication, managed identity, firewall rules, and advanced data security. These features are designed to enhance the security and manageability of your database environment, ensuring that your data is protected and accessible only to authorized users.

## Understand security practices

Azure SQL Database offers a variety of security capabilities for developers to ensure the protection and integrity of their applications and data. Here are some of the key security features available for Azure SQL Database.

| Feature | Description | Benefit |
| --- | --- | --- |
| [**Microsoft Entra authentication**](/azure/azure-sql/database/authentication-aad-overview) | Integration with Azure AD for managed identity access, supporting single sign-on and multi-factor authentication. | Simplifies identity management and enhances security with MFA, reducing the risk of unauthorized access. |
| [**Dynamic Data Masking**](/azure/azure-sql/database/dynamic-data-masking-overview) | Dynamic Data Masking automatically hides sensitive data in query results without altering the actual data. | Protects sensitive data from exposure to unauthorized users, reducing the risk of data leakage. |
| [**Advanced Data Security**](/en-us/azure/azure-sql/database/azure-defender-for-sql) | Includes vulnerability assessment and advanced threat protection to detect anomalous activities. | Helps discover and track security vulnerabilities within the database, ensuring proactive threat management. |
| [**SQL Database auditing**](/en-us/azure/azure-sql/database/auditing-overview) | Tracks database events and writes them to an audit log for review and analysis. | Enables monitoring of database activity aiding in compliance and security analysis. |
| [**Always Encrypted**](/sql/relational-databases/security/encryption/always-encrypted-database-engine) | Data encryption at rest and in transit, with Azure Key Vault integration for key management. | Ensures sensitive data is never exposed in plaintext, enhancing data privacy and compliance. |
| [**Network Security**](/en-us/azure/azure-sql/database/network-access-controls-overview) | Virtual Network service endpoints and private links restrict database access to allowed networks. | Provides network-level security controls to prevent unauthorized access. |

Developers can leverage these features to build robust applications, ensuring a scalable and secure database service.

Whether you're migrating an existing application or building a new one from scratch, Azure SQL Database offers a powerful and flexible platform that empowers application developers to effortlessly build, deploy, and secure data-driven applications.
