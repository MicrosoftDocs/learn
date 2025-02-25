Both on-premises SQL Server and SQL Server in Azure VMs support SQL Server authentication and Windows Authentication. SQL Server authentication stores login details within SQL Server, while Windows Authentication uses Microsoft Entra ID (formerly Active Directory) accounts.

Microsoft Entra ID authentication is more secure and simplifies user management. If a user leaves, only the Microsoft Entra ID account needs to be locked.

Azure SQL Database also supports SQL Server authentication and Microsoft Entra authentication. Microsoft Entra authentication uses the same credentials for other resources like the Azure portal or Microsoft 365.

Microsoft Entra ID can sync with on-premises Active Directory, providing consistent credentials for both environments. It also supports multi-factor authentication (MFA) for added security. MFA options include push notifications via the Microsoft Authenticator app, text messages, or access codes. Users with MFA must use the Universal Authentication with MFA option in SQL Server Management Studio.

You can set SQL admin permissions on an Azure SQL Database using the Azure portal.

:::image type="content" source="../media/module-33-security-final-02.png" alt-text="Screenshot showing how to set admin permissions on a SQL Database.":::

It is a best practice to make this account a Microsoft Entra group, so access is not dependent on a single login. The Microsoft Entra admin account grants special permissions and allows the account or group that holds that permission to have `sysadmin` like access to the server and all of the databases within the server. The admin account is only set using Azure Resource Manager and not at the database level. In order to change the account or group, you have to use the Azure portal, PowerShell, or Azure CLI.

## Role-based access control

All Azure types of operations for Azure SQL Database are controlled through role-based access control (RBAC). RBAC is currently decoupled from Azure SQL security, but you can think of it as security rights outside of your database in SQL Database, with a scope that includes subscription, resource group, and resource. The rights apply to operations in the Azure portal, the Azure CLI, and Azure PowerShell. RBAC allows for separation of duties between deployment, management, and usage.

Built-in roles are available to reduce the need for higher-level RBAC roles, such as **Owner** or **Contributor**. Effectively, you can use these roles to have certain individuals deploy Azure SQL resources (or manage security policies) but grant other users actual access to use or manage the database.  For example, a **SQL Server Contributor** could deploy a server and assign a user to be the admin of the server and databases. The built-in roles for Azure SQL Database include:  

- **SQL DB Contributor**: Can create and manage databases but can't access the database (for example, can't connect and read data)
- **SQL Security Manager**:  Can manage security policies for databases and instances (such as auditing) but can't access them
- **SQL Server Contributor**: Can manage servers and databases but can't access them.
