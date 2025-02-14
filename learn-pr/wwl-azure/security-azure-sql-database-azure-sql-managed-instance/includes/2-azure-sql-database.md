This unit outlines the basics of securing the data tier of an application using Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics. The described security strategy employs a layered, defense-in-depth approach, moving from the outside in, as illustrated in the picture below.

:::image type="content" source="../media/security-layer-d6e3314b.png" alt-text="Diagram showing the layered defense in depth approach.":::


## Network security

Microsoft Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics provide a relational database service for cloud and enterprise applications. To help protect customer data, firewalls prevent network access to the server until access is explicitly granted based on IP address or Azure Virtual network traffic origin.

### IP firewall rules<br>

IP firewall rules grant access to databases based on the originating IP address of each request.

### Virtual network firewall rules<br>

Virtual network service endpoints extend your virtual network connectivity over the Azure backbone and enable Azure SQL Database to identify the virtual network subnet that traffic originates from. To allow traffic to reach Azure SQL Database, use the SQL service tags to allow outbound traffic through Network Security Groups.

Virtual network rules enable Azure SQL Database to only accept communications that are sent from selected subnets inside a virtual network.

## Access management

> [!IMPORTANT]
> Managing databases and servers within Azure is controlled by your portal user account's role assignments.

### Authentication

Authentication is the process of proving the user is who they claim to be. SQL Database and SQL Managed Instance support SQL authentication and authentication with Microsoft Entra ID. SQL Managed instance additionally supports Windows authentication for Microsoft Entra principals.

### SQL authentication:

SQL authentication refers to the authentication of a user when connecting to Azure SQL Database or Azure SQL Managed Instance using username and password. A **server admin** login with a username and password must be specified when the server is being created. Using these credentials, a **server admin** can authenticate to any database on that server or instance as the database owner. After that, additional SQL logins and users can be created by the server admin, which enable users to connect using username and password.

### Microsoft Entra authentication:

Microsoft Entra authentication is a mechanism to connect to Azure SQL Database, Azure SQL Managed Instance and Azure Synapse Analytics by using identities in Microsoft Entra ID. Microsoft Entra authentication allows administrators to centrally manage the identities and permissions of database users along with other Azure services in one central location. This minimizes password storage and enables centralized password rotation policies.

A server admin called the **Microsoft Entra administrator** must be created to use Microsoft Entra authentication with SQL Database. For more information, see Connecting to SQL Database with Microsoft Entra authentication. Microsoft Entra authentication supports both managed and federated accounts. The federated accounts support Windows users and groups for a customer domain federated with Microsoft Entra ID.

Microsoft Entra supports several different authentication options, including multifactor authentication, Integrated Windows authentication, and Conditional Access.

### Windows authentication for Microsoft Entra principals:

Kerberos authentication for Microsoft Entra principals enables Windows authentication for Azure SQL Managed Instance. Windows authentication for managed instances empowers customers to move existing services to the cloud while maintaining a seamless user experience and provides the basis for infrastructure modernization.

To enable Windows authentication for Microsoft Entra principals, you will turn your Microsoft Entra tenant into an independent Kerberos realm and create an incoming trust in the customer domain.

> [!IMPORTANT]
> Managing databases and servers within Azure is controlled by your portal user account's role assignments.

## Authorization

Authorization refers to controlling access on resources and commands within a database. This is done by assigning permissions to a user within a database in Azure SQL Database or Azure SQL Managed Instance. Permissions are ideally managed by adding user accounts to database roles and assigning database-level permissions to those roles. Alternatively an individual user can also be granted certain object-level permissions.

As a best practice, create custom roles when needed. Add users to the role with the least privileges required to do their job function. Do not assign permissions directly to users. The server admin account is a member of the built-in db\_owner role, which has extensive permissions and should only be granted to few users with administrative duties. To further limit the scope of what a user can do, the EXECUTE AS can be used to specify the execution context of the called module.

### Row-level security

Row-Level Security enables customers to control access to rows in a database table based on the characteristics of the user executing a query (for example, group membership or execution context). Row-Level Security can also be used to implement custom Label-based security concepts.

:::image type="content" source="../media/azure-database-0df938b4.png" alt-text="Digram showing how row level security Row-Level Security enables customers to control access to rows in a database table.":::


## Threat protection

SQL Database and SQL Managed Instance secure customer data by providing auditing and threat detection capabilities.

### SQL auditing in Azure Monitor logs and Event Hubs

SQL Database and SQL Managed Instance auditing tracks database activities and helps maintain compliance with security standards by recording database events to an audit log in a customer-owned Azure storage account. Auditing allows users to monitor ongoing database activities, as well as analyze and investigate historical activity to identify potential threats or suspected abuse and security violations.

### Advanced Threat Protection

Advanced Threat Protection is analyzing your logs to detect unusual behavior and potentially harmful attempts to access or exploit databases. Alerts are created for suspicious activities such as SQL injection, potential data infiltration, and brute force attacks or for anomalies in access patterns to catch privilege escalations and breached credentials use. Alerts are viewed from the Microsoft Defender for Cloud, where the details of the suspicious activities are provided and recommendations for further investigation given along with actions to mitigate the threat. Advanced Threat Protection can be enabled per server for an additional fee.

:::image type="content" source="../media/azure-database-threat-protection-97ea832e.jpg" alt-text="Diagram showing how Advanced Threat Protection analyzes your logs to detect unusual behavior.":::


## Information protection and encryption

### Transport Layer Security (Encryption-in-transit)

SQL Database, SQL Managed Instance, and Azure Synapse Analytics secure customer data by encrypting data in motion with Transport Layer Security (TLS).

SQL Database, SQL Managed Instance, and Azure Synapse Analytics enforce encryption (SSL/TLS) at all times for all connections. This ensures all data is encrypted "in transit" between the client and server irrespective of the setting of **Encrypt** or **TrustServerCertificate** in the connection string.

As a best practice, recommend that in the connection string used by the application, you specify an encrypted connection and ***not*** trust the server certificate. This forces your application to verify the server certificate and thus prevents your application from being vulnerable to man in the middle type attacks.

For example when using the ADO.NET driver this is accomplished via **Encrypt=True** and **TrustServerCertificate=False**. If you obtain your connection string from the Azure portal, it will have the correct settings.

> [!IMPORTANT]
> Note that some non-Microsoft drivers may not use TLS by default or rely on an older version of TLS (&lt;1.2) in order to function. In this case the server still allows you to connect to your database. However, we recommend that you evaluate the security risks of allowing such drivers and application to connect to SQL Database, especially if you store sensitive data.

### Transparent Data Encryption (Encryption-at-rest)

Transparent data encryption (TDE) for SQL Database, SQL Managed Instance, and Azure Synapse Analytics adds a layer of security to help protect data at rest from unauthorized or offline access to raw files or backups. Common scenarios include data center theft or unsecured disposal of hardware or media such as disk drives and backup tapes. TDE encrypts the entire database using an AES encryption algorithm, which doesn't require application developers to make any changes to existing applications.

In Azure, all newly created databases are encrypted by default and the database encryption key is protected by a built-in server certificate. Certificate maintenance and rotation are managed by the service and require no input from the user. Customers who prefer to take control of the encryption keys can manage the keys in Azure Key Vault.

### Key management with Azure Key Vault

Bring Your Own Key (BYOK) support for Transparent Data Encryption (TDE) allows customers to take ownership of key management and rotation using Azure Key Vault, Azure's cloud-based external key management system. If the database's access to the key vault is revoked, a database cannot be decrypted and read into memory. Azure Key Vault provides a central key management platform, leverages tightly monitored hardware security modules (HSMs), and enables separation of duties between management of keys and data to help meet security compliance requirements.

### Always Encrypted (Encryption-in-use)

:::image type="content" source="../media/azure-database-encryption-in-use-a7ac95ab.png" alt-text="Diagram showing how Bring Your Own Key support for Transparent Data Encryption allows customers to take ownership of key management.":::


Always Encrypted is a feature designed to protect sensitive data stored in specific database columns from access (for example, credit card numbers, national/regional identification numbers, or data on a need to know basis). This includes database administrators or other privileged users who are authorized to access the database to perform management tasks, but have no business need to access the particular data in the encrypted columns. The data is always encrypted, which means the encrypted data is decrypted only for processing by client applications with access to the encryption key. The encryption key is never exposed to SQL Database or SQL Managed Instance and can be stored either in the Windows Certificate Store or in Azure Key Vault.

### Dynamic data masking

:::image type="content" source="../media/azure-data-masking-cb789136.png" alt-text="Diagram showing how Always Encrypted is designed to protect sensitive data stored in specific database columns.":::


Dynamic data masking limits sensitive data exposure by masking it to non-privileged users. Dynamic data masking automatically discovers potentially sensitive data in Azure SQL Database and SQL Managed Instance and provides actionable recommendations to mask these fields, with minimal impact to the application layer. It works by obfuscating the sensitive data in the result set of a query over designated database fields, while the data in the database is not changed.

## Security management

### Vulnerability assessment

Vulnerability assessment is an easy to configure service that can discover, track, and help remediate potential database vulnerabilities with the goal to proactively improve overall database security. Vulnerability assessment (VA) is part of the Microsoft Defender for SQL offering, which is a unified package for advanced SQL security capabilities. Vulnerability assessment can be accessed and managed via the central Microsoft Defender for SQL portal.

### Data discovery and classification

Data discovery and classification (currently in preview) provides basic capabilities built into Azure SQL Database and SQL Managed Instance for discovering, classifying and labeling the sensitive data in your databases. Discovering and classifying your utmost sensitive data (business/financial, healthcare, personal data, etc.) can play a pivotal role in your organizational Information protection stature. It can serve as infrastructure for:

 -  Various security scenarios, such as monitoring (auditing) and alerting on anomalous access to sensitive data.
 -  Controlling access to, and hardening the security of, databases containing highly sensitive data.
 -  Helping meet data privacy standards and regulatory compliance requirements.
