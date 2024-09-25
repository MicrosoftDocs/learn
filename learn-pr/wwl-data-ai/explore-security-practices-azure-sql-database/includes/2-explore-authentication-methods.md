Access to Azure SQL Database is protected with logins and firewalls. Azure SQL Database support users and logins for both SQL authentication and authentication with Microsoft Entra ID ([formerly Azure Active Directory](/entra/fundamentals/new-name?azure-portal=true)). 

SQL authentication is a conventional method where credentials are stored directly within the SQL database. On the other hand, Microsoft Entra ID enables users to sign-in using the same credentials they use for other Microsoft services, such as the Azure portal or Microsoft 365, offering a seamless and unified sign-in experience.

>[!NOTE]
> When SQL Server logins are used, both login names and encrypted passwords are transmitted across the network, which reduces their security.

## Microsoft Entra authentication

An essential feature of an identity platform is to authenticate user credentials when signing in to a device, application, or service. [Microsoft Entra ID](/entra/identity/authentication/overview-authentication?azure-portal=true) goes beyond verifying usernames and passwords by incorporating several components to enhance security and minimize help desk support. These components include self-service password reset, multifactor authentication, hybrid integration for syncing password changes and enforcing password protection policies in on-premises environments, and pass-through authentication.

### Configure Microsoft Entra authentication

Each Azure logical server hosting SQL Database, starts with a single server administrator account. This account is a contained database user in the master database and is part of the [*db_owner* role](/azure/azure-sql/database/logins-create-manage?azure-portal=true) in every user database. However, we recommend creating a Microsoft Entra user as an extra administrator to enhance security and simplify user management.

When using Microsoft Entra ID with geo-replication, you need to configure the Microsoft Entra administrator for both primary and secondary SQL servers. Without this configuration, Microsoft Entra logins and users encounter connection errors.

You can navigate to the SQL server page on Azure portal to configure a Microsoft Entra admin for your Azure SQL Database. This page provides a centralized location for managing various aspects of your SQL server, including security settings.

:::image type="content" source="../media/2-sql-admin.png" alt-text="Screenshot of the SQL server page on Azure portal for Azure SQL Database, showing where to configure a Microsoft Entra admin.":::

After provisioning a Microsoft Entra admin for your Azure SQL Database, you can begin to create Microsoft Entra server principals (logins) with the `CREATE LOGIN` syntax.

### Multifactor Authentication (MFA)

[Microsoft Entra multifactor authentication](/azure/azure-sql/database/authentication-mfa-ssms-overview?azure-portal=true) enhances security by requiring users to provide two or more authentication factors, such as a password, a smartphone, or biometric data. This extra layer of protection helps safeguard access to data and applications while ensuring a simple sign-in process, significantly reducing the risk of unauthorized access.

:::image type="content" source="../media/2-mfa.png" alt-text="Screenshot of the SQL Server Managed Studio dialog showing the MFA authentication type.":::

After providing the correct username and password, users must complete an extra verification step, such as responding to a push notification or entering an access code from the Microsoft Authenticator app. This process ensures that even if a user's primary credentials are compromised, unauthorized access is still prevented, therefore improving the security of the database.

To learn more about the authentication and verification methods available in Microsoft Entra ID, see [What authentication and verification methods are available in Microsoft Entra ID?](/entra/identity/authentication/concept-authentication-methods?azure-portal=true).

## Connect to Azure SQL Database using Microsoft Entra authentication

Microsoft Entra authentication uses identities in Microsoft Entra ID to access data sources like Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics. The `Microsoft.Data.SqlClient` namespace allows client applications to specify Microsoft Entra credentials in various authentication modes when connecting to these databases. To use Microsoft Entra authentication, you need to configure and manage it within Azure SQL.

When you set the `Authentication` connection property in the connection string, clients can choose their preferred Microsoft Entra authentication mode.

- **Password authentication:** `Active Directory Password` authentication mode allows native or federated Microsoft Entra users to authenticate to Azure data sources using Microsoft Entra ID. In this mode, user credentials must be included in the connection string.
    ```
    Server=myserver.database.windows.net;Authentication=Active Directory Password; Encrypt=True; Database=mydb;User Id=user@domain.com; Password=***";    
    ```
- **Integrated authentication:** To use `Active Directory Integrated` authentication mode, you need an on-premises Active Directory instance connected to Microsoft Entra ID in the cloud. When signed in to a domain-joined machine, you can access Azure SQL data sources without being prompted for credentials. For .NET Framework applications, you can't specify a username and password in the connection string. For .NET Core and .NET Standard applications, the username is optional.
    ```
    Server=myserver.database.windows.net;Authentication=Active Directory Integrated; Encrypt=True; Database=mydb;";    
    ```
- **Service principal authentication:** In `Active Directory Service Principal` authentication mode, the client application connects to Azure SQL data sources using the client ID and secret of a service principal.
    ```
    Server=myserver.database.windows.net;Authentication=Active Directory Service Principal; Encrypt=True;Database=mydb; User Id=AppId; Password=secret"
    ```

For more information about other authentication options, see [Connect to Azure SQL with Microsoft Entra authentication and SqlClient](/sql/connect/ado-net/sql/azure-active-directory-authentication?azure-portal=true).
