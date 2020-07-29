In this module and throughout the exercises, you got to get hands-on with many security capabilities and scenarios that are enabled for Azure SQL. As a summary, when securing Azure SQL, you should first consider your network and identity access, allowing only connections and access from the right places, people, and applications, depending on your organization and infrastructure. Additionally, you can encrypt and mask sensitive data and leverage security management tools like those available in the Advanced data security suite.

In the next module in this learning path, you'll take a look at the performance capabilities and tasks to monitor and tune performance for Azure SQL as it compares to SQL Server. You will also learn new capabilities in Azure SQL to automate and accelerated performance.

### Learn more

General and detailed guidance on security for Azure SQL can be found in the [Azure SQL Security Documentation](https://docs.microsoft.com/azure/sql-database/sql-database-security-overview?azure-portal=true) and the [Azure SQL Security Best Practices Playbook](https://docs.microsoft.com/azure/sql-database/sql-database-security-best-practice?azure-portal=true).

### Video series: Azure SQL for beginners

People learn in different ways. With that in mind, a video series related to this learning path was created with Channel 9 on YouTube. [You can access all 60+ videos here](https://aka.ms/azuresql4beginnersyt?azure-portal=true).

#### Network security

You can learn more about Private Link [in the documentation](https://docs.microsoft.com/azure/sql-database/sql-database-private-endpoint-overview?azure-portal=true). You can also learn about the subnet requirements for Azure SQL Managed Instance with details [here](https://docs.microsoft.com/azure/azure-sql/managed-instance/virtual-network-subnet-create-arm-template?azure-portal=true).  

Your networking environment and configuration can get complex quickly. You'll want to partner with your networking team to ensure you have the most secure, functional network. A few handy resources include:  

* [Azure SQL Database network access controls](https://docs.microsoft.com/azure/sql-database/sql-database-networkaccess-overview?azure-portal=true)
* [Connecting your applications to Managed Instance](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-connect-app?azure-portal=true)
* [IP firewall rules for Azure SQL Database](https://docs.microsoft.com/azure/sql-database/sql-database-firewall-configure?azure-portal=true)
* [Data exfiltration prevention](https://docs.microsoft.com/azure/sql-database/sql-database-private-endpoint-overview#data-exfiltration-prevention?azure-portal=true)  
* [VNet endpoints and rules](https://docs.microsoft.com/azure/sql-database/sql-database-vnet-service-endpoint-rule-overview#anchor-how-to-by-using-firewall-portal-59j?azure-portal=true)  

#### Authentication

To learn more about authentication, here are a few key resources:  

* [Azure SQL Security Playbook: Authentication](https://docs.microsoft.com/azure/sql-database/sql-database-security-best-practice#authentication?azure-portal=true)
* [Configure Azure AD](https://docs.microsoft.com/azure/security/fundamentals/database-best-practices#enable-database-authentication?azure-portal=true)  
* [Azure RBAC roles](https://docs.microsoft.com/azure/role-based-access-control/built-in-roles?azure-portal=true)
* [Security best practices related to RBAC](https://docs.microsoft.com/azure/security/fundamentals/database-best-practices#protect-your-data-by-using-encryption-and-row-level-security?azure-portal=true)

For detailed information on contained database users (in SQL Server and Azure), refer to the [documentation](https://docs.microsoft.com/sql/relational-databases/security/contained-database-users-making-your-database-portable?view=sql-server-ver15&azure-portal=true).  

#### Data protection

For more information regarding Azure SQL TDE with BYOK, [refer here](https://docs.microsoft.com/azure/sql-database/transparent-data-encryption-byok-azure-sql?view=sql-server-ver15&azure-portal=true). If you're interested in leveraging Azure Key Vault for BYOK, you can check out this tutorial, which leverages PowerShell: [Always Encrypted: Protect sensitive data and store encryption keys in Azure Key Vault](https://docs.microsoft.com/azure/sql-database/sql-database-always-encrypted-azure-key-vault?tabs=azure-powershell&azure-portal=true).

#### Advanced data security

To read about the details of what's included in Advanced data security and how to get the most out of it, you can leverage the following resources:  

* [Data discovery & classification](https://docs.microsoft.com/azure/sql-database/sql-database-data-discovery-and-classification?azure-portal=true)  
* [Vulnerability assessment](https://docs.microsoft.com/azure/sql-database/sql-vulnerability-assessment?azure-portal=true)  
* [Advanced Threat Protection](https://docs.microsoft.com/azure/sql-database/sql-database-threat-detection-overview?azure-portal=true)  

For information on how to query various [Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/log-query/log-query-overview?azure-portal=true) logs with KQL, refer to the [KQL documentation](https://docs.microsoft.com/azure/kusto/query/?azure-portal=true). To learn more about Azure Security Center and how you can use it to monitor and manage your entire Azure estate, refer to the [documentation](https://docs.microsoft.com/azure/security-center/security-center-intro?azure-portal=true).
