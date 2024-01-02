In this module and throughout the exercises, you got hands-on with many security capabilities and scenarios that are enabled for Azure SQL.

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

* [Azure SQL Database and Azure Synapse Analytics network access controls](/azure/azure-sql/database/network-access-controls-overview)
* [Connect your application to Azure SQL Managed Instance](/azure/azure-sql/managed-instance/connect-application-instance)
* [IP firewall rules for Azure SQL Database](/azure/azure-sql/database/firewall-configure)
* [Data exfiltration prevention](/azure/azure-sql/database/private-endpoint-overview#data-exfiltration-prevention)  
* [Virtual network endpoints and rules](/azure/azure-sql/database/vnet-service-endpoint-rule-overview)  

#### Authentication

To learn more about authentication, see:  

* [Azure SQL security playbook: Authentication](/azure/azure-sql/database/security-best-practice#authentication)
* [Configure Microsoft Entra authentication](/azure/azure-sql/database/authentication-aad-configure)  
* [Azure role-based access control (RBAC) roles](/azure/role-based-access-control/built-in-roles?azure-portal=true)

For information about contained database users in SQL Server and Azure, see [Contained database users: Make your database portable](/sql/relational-databases/security/contained-database-users-making-your-database-portable).  

#### Data protection

For more information about Azure SQL Transparent Data Encryption (TDE) with Bring Your Own Key (BYOK), see [Azure SQL TDE with customer-managed key](/azure/azure-sql/database/transparent-data-encryption-byok-overview). 

If you're interested in using Azure Key Vault for BYOK, see [Tutorial: Getting started with Always Encrypted](/sql/relational-databases/security/encryption/always-encrypted-tutorial-getting-started). This tutorial uses Azure PowerShell or SMSS.

#### Managing security

For more information about some of the features discussed for managing security, see:  

* [Data Discovery & Classification](/azure/azure-sql/database/data-discovery-and-classification-overview)  
* [SQL vulnerability assessment](/azure/defender-for-cloud/sql-azure-vulnerability-assessment-overview)  
* [SQL Advanced Threat Protection](/azure/azure-sql/database/threat-detection-overview)  

For information about how to query various [Azure Monitor logs](/azure/azure-monitor/log-query/log-query-overview?azure-portal=true) with Kusto Query Language, see the [Overview of Kusto queries](/azure/data-explorer/kusto/query/).

To learn more about Microsoft Defender for Cloud and how you can use it to monitor and manage your entire Azure estate, see [What is Microsoft Defender for Cloud?](/azure/defender-for-cloud/defender-for-cloud-introduction).
