This article outlines the basics of securing the data tier of an application using [Azure SQL Database](https://learn.microsoft.com/azure/azure-sql/database/sql-database-paas-overview?view=azuresql), [Azure SQL Managed Instance](https://learn.microsoft.com/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview?view=azuresql), and [Azure Synapse Analytics](https://learn.microsoft.com/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-overview-what-is). The security strategy described follows the layered defense-in-depth approach as shown in the picture below, and moves from the outside in:

![Diagram of layered defense-in-depth. Customer data is encased in layers of network security, access management and threat and information protections.](../media/sql-security-layer.png)

## Network security

Microsoft Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics provide a relational database service for cloud and enterprise applications. To help protect customer data, firewalls prevent network access to the server until access is explicitly granted based on IP address or Azure Virtual network traffic origin.

### IP firewall rules

IP firewall rules grant access to databases based on the originating IP address of each request. 

### Virtual network firewall rules

[Virtual network service endpoints](https://learn.microsoft.com/azure/virtual-network/virtual-network-service-endpoints-overview) extend your virtual network connectivity over the Azure backbone and enable Azure SQL Database to identify the virtual network subnet that traffic originates from. To allow traffic to reach Azure SQL Database, use the SQL [service tags](https://learn.microsoft.com/azure/virtual-network/network-security-groups-overview) to allow outbound traffic through Network Security Groups.

[Virtual network rules](https://learn.microsoft.com/azure/azure-sql/database/vnet-service-endpoint-rule-overview?view=azuresql) enable Azure SQL Database to only accept communications that are sent from selected subnets inside a virtual network.

## Access management

### Authentication

Authentication is the process of proving the user is who they claim to be. Azure SQL Database and SQL Managed Instance support SQL authentication and Azure AD authentication. SQL Managed instance additionally supports Windows Authentication for Azure AD principals.

#### SQL authentication
    
SQL authentication refers to the authentication of a user when connecting to Azure SQL Database or Azure SQL Managed Instance using username and password. A **server admin** sign-in with a username and password must be specified when the server is being created. Using these credentials, a **server admin** can authenticate to any database on that server or instance as the database owner. After that, other SQL logins and users can be created by the server admin, which enable users to connect using username and password.
    
#### Azure Active Directory authentication
    
Azure Active Directory authentication is a mechanism of connecting to [Azure SQL Database](https://learn.microsoft.com/azure/azure-sql/database/sql-database-paas-overview?view=azuresql), [Azure SQL Managed Instance](https://learn.microsoft.com/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview?view=azuresql) and [Azure Synapse Analytics](https://learn.microsoft.com/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-overview-what-is) by using identities in Azure Active Directory (Azure AD). Azure AD authentication allows administrators to centrally manage the identities and permissions of database users along with other Azure services in one central location. This includes the minimization of password storage and enables centralized password rotation policies.
    
A server admin called the **Active Directory administrator** must be created to use Azure AD authentication with SQL Database. For more information, see [Connecting to SQL Database By Using Azure Active Directory Authentication](https://learn.microsoft.com/azure/azure-sql/database/authentication-aad-overview?view=azuresql). Azure AD authentication supports both managed and federated accounts. The federated accounts support Windows users and groups for a customer domain federated with Azure AD.
    
Additional Azure AD authentication options available are [Active Directory Universal Authentication for SQL Server Management Studio](https://learn.microsoft.com/azure/azure-sql/database/authentication-mfa-ssms-overview?view=azuresql) connections including [multi-factor authentication](https://learn.microsoft.com/azure/active-directory/authentication/concept-mfa-howitworks) and [Conditional Access](https://learn.microsoft.com/azure/azure-sql/database/conditional-access-configure?view=azuresql).
    
#### Windows Authentication for Azure AD Principals
    
[Kerberos authentication for Azure AD Principals](https://learn.microsoft.com/azure/azure-sql/managed-instance/winauth-azuread-overview?view=azuresql) enables Windows Authentication for Azure SQL Managed Instance. Windows Authentication for managed instances empowers customers to move existing services to the cloud while maintaining a seamless user experience and provides the basis for infrastructure modernization.

To enable Windows Authentication for Azure Active Directory (Azure AD) principals, you'll turn your Azure AD tenant into an independent Kerberos realm and create an incoming trust in the customer domain. Learn [how Windows Authentication for Azure SQL Managed Instance is implemented with Azure Active Directory and Kerberos](https://learn.microsoft.com/azure/azure-sql/managed-instance/winauth-implementation-aad-kerberos?view=azuresql).
    
### Authorization

Authorization refers to controlling access on resources and commands within a database. This is done by assigning permissions to a user within a database in Azure SQL Database or Azure SQL Managed Instance. Permissions are ideally managed by adding user accounts to [database roles](https://learn.microsoft.com/sql/relational-databases/security/authentication-access/database-level-roles) and assigning database-level permissions to those roles. Alternatively an individual user can also be granted certain [object-level permissions](https://learn.microsoft.com/sql/relational-databases/security/permissions-database-engine).

As a best practice, create custom roles when needed. Add users to the role with the least privileges required to do their job function. Do not assign permissions directly to users. The server admin account is a member of the built-in db_owner role, which has extensive permissions and should only be granted to few users with administrative duties. To further limit the scope of what a user can do, the [EXECUTE AS](https://learn.microsoft.com/sql/t-sql/statements/execute-as-clause-transact-sql) can be used to specify the execution context of the called module. Following these best practices is also a fundamental step towards Separation of Duties.

### Row-level security

Row-Level Security enables customers to control access to rows in a database table based on the characteristics of the user executing a query (for example, group membership or execution context). Row-Level Security can also be used to implement custom Label-based security concepts. 

![Diagram showing that Row-Level Security shields individual rows of a SQL database from access by users via a client app.](../media/azure-database-rls.png)

## Threat protection

SQL Database and SQL Managed Instance secure customer data by providing auditing and threat detection capabilities.

### SQL auditing in Azure Monitor logs and Event Hubs

SQL Database and SQL Managed Instance auditing tracks database activities and helps maintain compliance with security standards by recording database events to an audit log in a customer-owned Azure storage account. Auditing allows users to monitor ongoing database activities, as well as analyze and investigate historical activity to identify potential threats or suspected abuse and security violations. For more information, see Get started with [SQL Database Auditing](https://learn.microsoft.com/azure/azure-sql/database/auditing-overview?view=azuresql).

### Advanced Threat Protection

Advanced Threat Protection is analyzing your logs to detect unusual behavior and potentially harmful attempts to access or exploit databases. Alerts are created for suspicious activities such as SQL injection, potential data infiltration, and brute force attacks or for anomalies in access patterns to catch privilege escalations and breached credentials use. Alerts are viewed from the [Microsoft Defender for Cloud](https://azure.microsoft.com/services/security-center/), where the details of the suspicious activities are provided and recommendations for further investigation given along with actions to mitigate the threat. Advanced Threat Protection can be enabled per server for an additional fee. 

![Diagram showing SQL Threat Detection monitoring access to the SQL database for a web app from an external attacker and malicious insider.](../media/azure-database-threat-protection.jpg)

## Information protection and encryption

### Transport Layer Security (Encryption-in-transit)

SQL Database, SQL Managed Instance, and Azure Synapse Analytics secure customer data by encrypting data in motion with [Transport Layer Security (TLS)](https://support.microsoft.com/help/3135244/tls-1-2-support-for-microsoft-sql-server).

SQL Database, SQL Managed Instance, and Azure Synapse Analytics enforce encryption (SSL/TLS) at all times for all connections. This ensures all data is encrypted "in transit" between the client and server irrespective of the setting of **Encrypt** or **TrustServerCertificate** in the connection string.

As a best practice, recommend that in the connection string used by the application, you specify an encrypted connection and _**not**_ trust the server certificate. This forces your application to verify the server certificate and thus prevents your application from being vulnerable to man in the middle type attacks.

For example when using the ADO.NET driver this is accomplished via **Encrypt=True** and **TrustServerCertificate=False**. If you obtain your connection string from the Azure portal, it will have the correct settings.

### Transparent Data Encryption (Encryption-at-rest)

[Transparent data encryption (TDE) for SQL Database, SQL Managed Instance, and Azure Synapse Analytics](https://learn.microsoft.com/azure/azure-sql/database/transparent-data-encryption-tde-overview?view=azuresql) adds a layer of security to help protect data at rest from unauthorized or offline access to raw files or backups. Common scenarios include data center theft or unsecured disposal of hardware or media such as disk drives and backup tapes. TDE encrypts the entire database using an AES encryption algorithm, which doesn't require application developers to make any changes to existing applications.

In Azure, all newly created databases are encrypted by default and the database encryption key is protected by a built-in server certificate. Certificate maintenance and rotation are managed by the service and require no input from the user. Customers who prefer to take control of the encryption keys can manage the keys in [Azure Key Vault](https://learn.microsoft.com/azure/key-vault/general/security-features).

### Key management with Azure Key Vault

[Bring Your Own Key](https://learn.microsoft.com/azure/azure-sql/database/transparent-data-encryption-byok-overview?view=azuresql) (BYOK) support for [Transparent Data Encryption](https://learn.microsoft.com/sql/relational-databases/security/encryption/transparent-data-encryption) (TDE) allows customers to take ownership of key management and rotation using [Azure Key Vault](https://learn.microsoft.com/azure/key-vault/general/security-features), Azure's cloud-based external key management system. If the database's access to the key vault is revoked, a database cannot be decrypted and read into memory. Azure Key Vault provides a central key management platform, leverages tightly monitored hardware security modules (HSMs), and enables separation of duties between management of keys and data to help meet security compliance requirements.

### Always Encrypted (Encryption-in-use)

![Diagram showing the basics of the Always Encrypted feature. An SQL database with a lock is only accessed by an app containing a key.](../media/azure-database-always-encrypted.png)

[Always Encrypted](https://learn.microsoft.com/sql/relational-databases/security/encryption/always-encrypted-database-engine) is a feature designed to protect sensitive data stored in specific database columns from access (for example, credit card numbers, national/regional identification numbers, or data on a _need to know_ basis). This includes database administrators or other privileged users who are authorized to access the database to perform management tasks, but have no business need to access the particular data in the encrypted columns. The data is always encrypted, which means the encrypted data is decrypted only for processing by client applications with access to the encryption key. The encryption key is never exposed to SQL Database or SQL Managed Instance and can be stored either in the [Windows Certificate Store](https://learn.microsoft.com/azure/azure-sql/database/always-encrypted-certificate-store-configure?view=azuresql) or in [Azure Key Vault](https://learn.microsoft.com/azure/azure-sql/database/always-encrypted-azure-key-vault-configure?view=azuresql).

### Dynamic data masking

![Diagram showing dynamic data masking. A business app sends data to a SQL database which masks the data before sending it back to the business app.](../media/azure-database-dynamic-data-masking.png)

Dynamic data masking limits sensitive data exposure by masking it to non-privileged users. Dynamic data masking automatically discovers potentially sensitive data in Azure SQL Database and SQL Managed Instance and provides actionable recommendations to mask these fields, with minimal impact to the application layer. It works by obfuscating the sensitive data in the result set of a query over designated database fields, while the data in the database is not changed. For more information, see [Get started with SQL Database and SQL Managed Instance dynamic data masking](https://learn.microsoft.com/azure/azure-sql/database/dynamic-data-masking-overview?view=azuresql).

## Security management

### Vulnerability assessment

[Vulnerability assessment](https://learn.microsoft.com/azure/defender-for-cloud/sql-azure-vulnerability-assessment-overview) is an easy to configure service that can discover, track, and help remediate potential database vulnerabilities with the goal to proactively improve overall database security. Vulnerability assessment (VA) is part of the Microsoft Defender for SQL offering, which is a unified package for advanced SQL security capabilities. Vulnerability assessment can be accessed and managed via the central Microsoft Defender for SQL portal.

### Data discovery and classification

Data discovery and classification (currently in preview) provides basic capabilities built into Azure SQL Database and SQL Managed Instance for discovering, classifying and labeling the sensitive data in your databases. Discovering and classifying your utmost sensitive data (business/financial, healthcare, personal data, etc.) can play a pivotal role in your organizational Information protection stature. It can serve as infrastructure for:

-   Various security scenarios, such as monitoring (auditing) and alerting on anomalous access to sensitive data.
-   Controlling access to, and hardening the security of, databases containing highly sensitive data.
-   Helping meet data privacy standards and regulatory compliance requirements.

### Compliance

In addition to the above features and functionality that can help your application meet various security requirements, Azure SQL Database also participates in regular audits, and has been certified against a number of compliance standards. For more information, see the [Microsoft Azure Trust Center](https://www.microsoft.com/trust-center/compliance/compliance-overview) where you can find the most current list of SQL Database compliance certifications.