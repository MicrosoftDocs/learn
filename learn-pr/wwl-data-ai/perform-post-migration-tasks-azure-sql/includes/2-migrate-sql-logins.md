For a seamless and secure transition of your SQL Server databases to Azure SQL, understanding and effectively managing the migration of security information is essential.

## Decide when to migrate SQL logins and groups

Imagine a large organization with a substantial on-premises SQL Server infrastructure that serves various business units. Each business unit has its own set of SQL logins, user roles, and permissions customized to their specific needs. The organization decides to migrate these databases to Azure SQL Database to leverage the cloud's scalability benefits.

In this scenario, migrating the logins upfront, before the database migration, could introduce unnecessary complexity to the testing phase.

Migrating logins at the end of a database migration project can facilitate testing, especially in complex scenarios. If logins are migrated upfront, it can lead to testing delays due to evolving database schemas. Waiting to migrate logins allows security configurations to align with the final structure, simplifying the migration process, especially when table-dependent security is crucial for data protection.

| **Challenges**| **Explanation**|
|----------------------------------|-------------------------------|
| **Complex permissions structure**    | Migrating logins later allows for adapting permissions as the database structure evolves during migration. 
| **Testing delays**                   | Migrating logins early may slow down testing, complicating security validation alongside schema changes.|
| **Table-dependent security**         | Delaying login migration enables adjusting security configurations to match final database structures if they change during migration.|

In our scenario, this approach allows you to focus on ensuring that security measures align perfectly with the finalized database structure, reducing potential complications and making the migration project more manageable.

### Using the migration extension

[Azure migration extension in Azure Data Studio](/azure/dms/tutorial-login-migration-ads).

As part of the post-migration tasks, we're introducing a new user experience with an independent workflow you can use to migrate logins (preview) and server roles from your on-premises source SQL Server to the Azure SQL target. This login migration experience automates manual tasks such as the synchronization of logins with their corresponding user mappings and replicating server/securable permissions and server roles.

Currently the migration extension only supports an Azure SQL Managed Instance or SQL Server on Azure VM targets. Futhermore

Azure SQL Managed Instance - both Windows accounts and SQL logins.
SQL Server on Azure VM - only SQL logins

Important - If you have also migrated Windows accounts, make sure to check the option of Azure Active Directory - Password while logging into the target managed instance using the same password that the Windows account had on the source SQL Server.

If you haven’t completed the database migration and the login migration process is started, the migration of logins and server roles will still happen, but login/role mappings won’t be performed correctly. Nevertheless, the login migration process can be performed at any time, to update the user mapping synchronization for recently migrated databases.

You can use the Azure SQL Migration extension for Azure Data Studio, PowerShell or Azure CLI to start the login migration process. Here is a step-by-step guide on how to migrate logins using the migration extension in Azure Data Studio:

1. Launch Azure SQL Migration extension from Azure Data Studio, and start the SQL Server login migration wizard.

    :::image type="content" source="../media/2-login-migration.png" alt-text="Screenshot showing the new login migration option from Azure Data Studio. ":::

1. On **Step 1: Azure SQL target**, connect to your Azure SQL target.

1. On **Step 2: Select login(s) to migrate**, select your logins from the source SQL Server instance.

1. In **Step 3: Migration Status**, monitor the login migration process. Once the login migration is successfully completed (or if it has failures), the page displays the relevant updates.

    :::image type="content" source="../media/2-login-migration-status.png" alt-text="Screenshot showing the login migration status in Azure Data Studio.png.":::

### Using DMA

 As part of login migration, Data Migration Assistant assigns the permissions to securables on the target SQL Server as they exist on the source SQL Server. If the login already exists on the target SQL Server, Data Migration Assistant migrates only the permissions assigned to securables and won’t re-create the whole login. Data Migration Assistant makes the best effort to map the login to database users if the login already exists on the target server.

Data Migration Assistant currently doesn’t support:

- Logins associated with a stand-alone security certificate (logins mapped to certificate)
- A stand-alone asymmetric key (logins mapped to asymmetric key) 
- Logins mapped to credentials. 
-  By default, Data Migration Assistant selects all the qualified logins to migrate. Optionally, you can select specific logins to migrate1.

> [!NOTE]
> Server principles with names enclosed by double hash marks (##), which are for internal use only are not migrated.

### Tool XPTO

This tool assists in transferring login information from on-premises SQL Servers to Azure SQL Database or other PaaS offerings.

The migration of SQL logins and groups are very important, given the complexity of permissions within SQL Server environments. While tools like the Data Migration Assistant (DMA) has the ability to transfer security information and does a full dependency graph to ensure permissions are transferred properly, the script offered here provides an additional option. It enables an Active Directory lookup for users, allowing you to obtain their User Principal Name (UPN), a feature currently not supported by DMA.

Move Login information from SQL Servers on premises to SQL Server running as Platform as a Service (PaaS).

https://www.microsoft.com/en-us/download/details.aspx?id=103111 
