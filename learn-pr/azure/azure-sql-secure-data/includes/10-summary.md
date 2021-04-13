In this module and throughout the exercises, you got hands on with many security capabilities and scenarios that are enabled for Azure SQL. 

When you're securing Azure SQL, you should first consider your network and identity access, allowing only connections and access from the right places, people, and applications, depending on your organization and infrastructure. Additionally, you can encrypt and mask sensitive data and apply security management tools, such as those available in the Advanced Data Security suite.

In the next module in this learning path, you'll take a look at the performance capabilities and tasks that can help you monitor and tune performance for Azure SQL as it compares to SQL Server. You'll also learn new capabilities in Azure SQL that can help you automate and accelerate performance.

### Learn more

You'll find general and detailed guidance on security for Azure SQL in the [Azure SQL security documentation](https://docs.microsoft.com/azure/sql-database/sql-database-security-overview?azure-portal=true) and the [Azure SQL security best practices playbook](https://docs.microsoft.com/azure/sql-database/sql-database-security-best-practice?azure-portal=true).

### Video series: Azure SQL for beginners

People learn in different ways. With that in mind, we created a video series related to this learning path with Channel 9 on YouTube. [Access all 60+ videos](https://aka.ms/azuresql4beginnersyt?azure-portal=true).

#### Network security

For more information about Private Link, see [Azure Private Link for Azure SQL Database and Azure Synapse Analytics](https://docs.microsoft.com/azure/sql-database/sql-database-private-endpoint-overview?azure-portal=true). 

For more information about the subnet requirements for Azure SQL Managed Instance, see [Create a virtual network for Azure SQL Managed Instance](https://docs.microsoft.com/azure/azure-sql/managed-instance/virtual-network-subnet-create-arm-template?azure-portal=true).  

Your networking environment and configuration can get complex quickly. You'll want to partner with your networking team to ensure that you have the most secure, functional network. A few handy resources include:  

* [Azure SQL Database network access controls](https://docs.microsoft.com/azure/sql-database/sql-database-networkaccess-overview?azure-portal=true)
* [Connecting your applications to Azure SQL Managed Instance](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-connect-app?azure-portal=true)
* [IP firewall rules for Azure SQL Database](https://docs.microsoft.com/azure/sql-database/sql-database-firewall-configure?azure-portal=true)
* [Data exfiltration prevention](https://docs.microsoft.com/azure/sql-database/sql-database-private-endpoint-overview#data-exfiltration-prevention?azure-portal=true)  
* [Virtual network endpoints and rules](https://docs.microsoft.com/azure/sql-database/sql-database-vnet-service-endpoint-rule-overview#anchor-how-to-by-using-firewall-portal-59j?azure-portal=true)  

#### Authentication

To learn more about authentication, see:  

* [Azure SQL security playbook: Authentication](https://docs.microsoft.com/azure/sql-database/sql-database-security-best-practice#authentication?azure-portal=true)
* [Configure Azure Active Directory](https://docs.microsoft.com/azure/security/fundamentals/database-best-practices#enable-database-authentication?azure-portal=true)  
* [Azure role-based access control (RBAC) roles](https://docs.microsoft.com/azure/role-based-access-control/built-in-roles?azure-portal=true)
* [Security best practices related to RBAC](https://docs.microsoft.com/azure/security/fundamentals/database-best-practices#protect-your-data-by-using-encryption-and-row-level-security?azure-portal=true)

For information about contained database users in SQL Server and Azure, see [Contained database users: Make your database portable](https://docs.microsoft.com/sql/relational-databases/security/contained-database-users-making-your-database-portable?view=sql-server-ver15&azure-portal=true).  

#### Data protection

For more information about Azure SQL Transparent Data Encryption (TDE) with Bring Your Own Key (BYOK), see [Azure SQL TDE with customer-managed key](https://docs.microsoft.com/azure/sql-database/transparent-data-encryption-byok-azure-sql?view=sql-server-ver15&azure-portal=true). 

If you're interested in using Azure Key Vault for BYOK, see [Always Encrypted: Protect sensitive data and store encryption keys in Azure Key Vault](https://docs.microsoft.com/azure/sql-database/sql-database-always-encrypted-azure-key-vault?tabs=azure-powershell&azure-portal=true). This tutorial uses Azure PowerShell.

#### Managing security

For more information about some of the features discussed for managing security, see:  

* [Data Discovery & Classification](https://docs.microsoft.com/azure/sql-database/sql-database-data-discovery-and-classification?azure-portal=true)  
* [Vulnerability Assessment](https://docs.microsoft.com/azure/sql-database/sql-vulnerability-assessment?azure-portal=true)  
* [Advanced Threat Protection](https://docs.microsoft.com/azure/sql-database/sql-database-threat-detection-overview?azure-portal=true)  

For information about how to query various [Azure Monitor logs](https://docs.microsoft.com/azure/azure-monitor/log-query/log-query-overview?azure-portal=true) with Kusto Query Language, see the [Overview of Kusto queries](https://docs.microsoft.com/azure/kusto/query/?azure-portal=true). 

To learn more about Azure Security Center and how you can use it to monitor and manage your entire Azure estate, see [What is Azure Security Center?](https://docs.microsoft.com/azure/security-center/security-center-intro?azure-portal=true).
