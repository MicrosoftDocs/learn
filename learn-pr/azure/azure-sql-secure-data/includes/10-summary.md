
# Summary 

> Looking for another bonus security activity? Try this tutorial: [Always Encrypted: Protect sensitive data and store encryption keys in Azure Key Vault](https://docs.microsoft.com/azure/sql-database/sql-database-always-encrypted-azure-key-vault?tabs=azure-powershell). You will need VS for this, you can download [Visual Studio Community for free here](https://visualstudio.microsoft.com/downloads/).  

In this module and throughout the activities, you got to get hands-on with many security features that are available for Azure SQL. In the next module, you'll take a look at how performance is different in Azure, and you'll see how you can optimize it in Azure SQL.  

### Learn more

* [Azure SQL Security Documentation](https://docs.microsoft.com/azure/sql-database/sql-database-security-overview)
* [Azure SQL Security Best Practices Playbook](https://docs.microsoft.com/azure/sql-database/sql-database-security-best-practice)
* [Configure security for Azure SQL Managed Instance](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-aad-security-tutorial)
* [Configure security for Azure SQL Database](https://docs.microsoft.com/azure/sql-database/sql-database-security-tutorial)


#### Network security

You can learn more about Private Link [in the documentation](https://docs.microsoft.com/azure/sql-database/sql-database-private-endpoint-overview).

Microsoft is actively investing heavily in Private Link for SQL and other services, to learn more refer to the [documentation](https://docs.microsoft.com/azure/private-link/index).

Create a subnet for Azure SQL Managed Instance with details [here](https://docs.microsoft.com/en-us/azure/azure-sql/managed-instance/virtual-network-subnet-create-arm-template).  

#### Authentication

To learn more about authentication, here are a few resources from the documentation:  

* [Azure SQL Security Playbook: Authentication](https://docs.microsoft.com/azure/sql-database/sql-database-security-best-practice#authentication)
* [Configure Azure AD](https://docs.microsoft.com/azure/security/fundamentals/database-best-practices#enable-database-authentication)  
* [Azure RBAC roles](https://docs.microsoft.com/azure/role-based-access-control/built-in-roles)
* [Security best practices related to RBAC](https://docs.microsoft.com/azure/security/fundamentals/database-best-practices#protect-your-data-by-using-encryption-and-row-level-security)

Auth methods

* [*Azure Active Directory - Integrated*](https://docs.microsoft.com/azure/sql-database/sql-database-aad-authentication-configure?tabs=azure-powershell#active-directory-integrated-authentication): A non-interactive method, which you can use if you are logged in to Windows using your Azure AD credentials from a federated domain.  
* [*Azure Active Directory - Password*](https://docs.microsoft.com/azure/sql-database/sql-database-aad-authentication-configure?tabs=azure-powershell#active-directory-password-authentication): A non-interactive method that allows you to connect with an Azure AD principal name using the Azure AD managed domain. From the documentation: *This can apply to native or federated Azure AD users. A native user is one explicitly created in Azure AD and being authenticated using user name and password, while a federated user is a Windows user whose domain is federated with Azure AD. The latter method (using user & password) can be used when a user wants to use their windows credential, but their local machine is not joined with the domain (for example, using a remote access). In this case, a Windows user can indicate their domain account and password and can authenticate to SQL DB/DW using federated credentials.*  
* [*Azure Active Directory - Universal with MFA*](https://docs.microsoft.com/azure/sql-database/sql-database-ssms-mfa-authentication): An interactive method that will safeguard access to data while meeting demand for a single sign-in process with Multi-factor Authentication (MFA).

You must connect to the **master** database to create and alter logins. For more details, see [this page](https://docs.microsoft.com/azure/sql-database/sql-database-manage-logins#administrator-access-path).  

For detailed information on contained database users (in SQL Server and Azure), refer to the [documentation](https://docs.microsoft.com/sql/relational-databases/security/contained-database-users-making-your-database-portable?view=sql-server-ver15).  

#### Networking

In reality, you'll want to partner with your networking team to ensure you have the most secure, functional network. A few handy resources include:  

* [Azure SQL Database network access controls](https://docs.microsoft.com/azure/sql-database/sql-database-networkaccess-overview)
* [Connecting your applications to Managed Instance](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-connect-app)
* [IP firewall rules for Azure SQL Database](https://docs.microsoft.com/azure/sql-database/sql-database-firewall-configure)
* [Data exfiltration prevention](https://docs.microsoft.com/azure/sql-database/sql-database-private-endpoint-overview#data-exfiltration-prevention)  
* [VNet endpoints and rules](https://docs.microsoft.com/azure/sql-database/sql-database-vnet-service-endpoint-rule-overview#anchor-how-to-by-using-firewall-portal-59j)  


#### Advanced data security

* [Data discovery & classification](https://docs.microsoft.com/azure/sql-database/sql-database-data-discovery-and-classification)  
* [Vulnerability assessment](https://docs.microsoft.com/azure/sql-database/sql-vulnerability-assessment)  
* [Advanced Threat Protection](https://docs.microsoft.com/azure/sql-database/sql-database-threat-detection-overview)  

