In this module and throughout the exercises, you got hands on with many security capabilities and scenarios that are enabled for Azure SQL.

When you're securing Azure SQL, you should first consider your network and identity access, allowing only connections and access from the right places, people, and applications, depending on your organization and infrastructure. Additionally, you can encrypt and mask sensitive data and apply security management tools, such as those available in the Advanced Data Security suite.

In the next module in this learning path, you'll take a look at the performance capabilities and tasks that can help you monitor and tune performance for Azure SQL as it compares to SQL Server. You'll also learn new capabilities in Azure SQL that can help you automate and accelerate performance.

### Learn more

You'll find general and detailed guidance on security for Azure SQL in the [Azure SQL security documentation](/azure/sql-database/sql-database-security-overview?azure-portal=true) and the [Azure SQL security best practices playbook](/azure/sql-database/sql-database-security-best-practice?azure-portal=true).

### Video series: Azure SQL for beginners

People learn in different ways. With that in mind, we created a video series related to this learning path with Channel 9 on YouTube. [Access all 60+ videos](https://aka.ms/azuresql4beginnersyt?azure-portal=true).

#### Network security

For more information about Private Link, see [Azure Private Link for Azure SQL Database and Azure Synapse Analytics](/azure/sql-database/sql-database-private-endpoint-overview?azure-portal=true).

For more information about the subnet requirements for Azure SQL Managed Instance, see [Create a virtual network for Azure SQL Managed Instance](/azure/azure-sql/managed-instance/virtual-network-subnet-create-arm-template?azure-portal=true).  

Your networking environment and configuration can get complex quickly. You'll want to partner with your networking team to ensure that you have the most secure, functional network. A few handy resources include:  

* [Azure SQL Database network access controls](/azure/sql-database/sql-database-networkaccess-overview?azure-portal=true)
* [Connecting your applications to Azure SQL Managed Instance](/azure/sql-database/sql-database-managed-instance-connect-app?azure-portal=true)
* [IP firewall rules for Azure SQL Database](/azure/sql-database/sql-database-firewall-configure?azure-portal=true)
* [Data exfiltration prevention](/azure/sql-database/sql-database-private-endpoint-overview#data-exfiltration-prevention?azure-portal=true)  
* [Virtual network endpoints and rules](/azure/sql-database/sql-database-vnet-service-endpoint-rule-overview#anchor-how-to-by-using-firewall-portal-59j?azure-portal=true)  

#### Authentication

To learn more about authentication, see:  

* [Azure SQL security playbook: Authentication](/azure/sql-database/sql-database-security-best-practice#authentication?azure-portal=true)
* [Configure Azure Active Directory](/azure/security/fundamentals/database-best-practices#enable-database-authentication?azure-portal=true)  
* [Azure role-based access control (RBAC) roles](/azure/role-based-access-control/built-in-roles?azure-portal=true)
* [Security best practices related to RBAC](/azure/security/fundamentals/database-best-practices#protect-your-data-by-using-encryption-and-row-level-security?azure-portal=true)

For information about contained database users in SQL Server and Azure, see [Contained database users: Make your database portable](/sql/relational-databases/security/contained-database-users-making-your-database-portable?azure-portal=true&view=sql-server-ver15).  

#### Data protection

For more information about Azure SQL Transparent Data Encryption (TDE) with Bring Your Own Key (BYOK), see [Azure SQL TDE with customer-managed key](/azure/sql-database/transparent-data-encryption-byok-azure-sql?azure-portal=true&view=sql-server-ver15). 

If you're interested in using Azure Key Vault for BYOK, see [Always Encrypted: Protect sensitive data and store encryption keys in Azure Key Vault](/azure/sql-database/sql-database-always-encrypted-azure-key-vault?azure-portal=true&tabs=azure-powershell). This tutorial uses Azure PowerShell.

#### Managing security

For more information about some of the features discussed for managing security, see:  

* [Data Discovery & Classification](/azure/sql-database/sql-database-data-discovery-and-classification?azure-portal=true)  
* [Vulnerability Assessment](/azure/sql-database/sql-vulnerability-assessment?azure-portal=true)  
* [Advanced Threat Protection](/azure/sql-database/sql-database-threat-detection-overview?azure-portal=true)  

For information about how to query various [Azure Monitor logs](/azure/azure-monitor/log-query/log-query-overview?azure-portal=true) with Kusto Query Language, see the [Overview of Kusto queries](/azure/kusto/query/?azure-portal=true).

To learn more about Microsoft Defender for Cloud and how you can use it to monitor and manage your entire Azure estate, see [What is Microsoft Defender for Cloud?](/azure/security-center/security-center-intro?azure-portal=true).
