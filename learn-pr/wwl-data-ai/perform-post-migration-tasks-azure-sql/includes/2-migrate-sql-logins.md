For a seamless and secure transition of your SQL Server databases to Azure SQL, understanding and effectively managing the migration of security information is essential.

## Decide when to migrate SQL logins and groups

Imagine a large organization with a substantial on-premises SQL Server infrastructure that serves various business units. Each business unit has its own set of SQL logins, user roles, and permissions customized to their specific needs. The organization decides to migrate these databases to Azure SQL Database to use the cloud's scalability benefits.

In this scenario, migrating the logins upfront, before the database migration, could introduce unnecessary complexity to the testing phase.

Migrating logins at the end of a database migration project can facilitate testing, especially in complex scenarios. If logins are migrated upfront, it can lead to testing delays due to evolving database schemas. Waiting to migrate logins allows security configurations to align with the final structure, simplifying the migration process, especially when table-dependent security is crucial for data protection.

| **Challenges**| **Explanation**|
|----------------------------------|-------------------------------|
| **Complex permissions structure**    | Migrating logins later allows for adapting permissions as the database structure evolves during migration. 
| **Testing delays**                   | Migrating logins early may slow down testing, complicating security validation alongside schema changes.|
| **Table-dependent security**         | Delaying login migration enables adjusting security configurations to match final database structures if they change during migration.|

In our scenario, this approach allows you to focus on ensuring that security measures align perfectly with the finalized database structure, reducing potential complications and making the migration project more manageable.

### Using the Azure Migration extension

As part of the post-migration tasks, you can use [Azure migration extension in Azure Data Studio](/azure/dms/tutorial-login-migration-ads) to migrate logins and server roles from your on-premises SQL Server to the Azure SQL target. This login migration experience automates manual tasks such as the synchronization of logins with their corresponding user mappings and replicating server permissions and server roles.

Currently the migration extension only supports an Azure SQL Managed Instance or SQL Server on Azure VM targets.

- **Azure SQL Managed Instance -** both Windows accounts and SQL logins.
- **SQL Server on Azure VM -** only SQL logins

If you haven’t completed the database migration and the login migration process is started, the migration of logins and server roles will still happen, but login/role mappings won’t be performed correctly. This login migration process automates manual tasks, including syncing logins with their associated user mappings and replicating server permissions and roles.

You can use the Azure SQL Migration extension for Azure Data Studio, [PowerShell](/powershell/module/az.datamigration) or [Azure CLI](/cli/azure/datamigration) to start the login migration process. 

Follow these steps to migrate logins using the migration extension in Azure Data Studio:

1. Launch Azure SQL Migration extension from Azure Data Studio, and start the SQL Server login migration wizard.

    :::image type="content" source="../media/2-login-migration.png" alt-text="Screenshot showing the new login migration option from Azure Data Studio. ":::

1. On **Step 1: Azure SQL target**, connect to your Azure SQL target.

1. On **Step 2: Select login(s) to migrate**, select your logins from the source SQL Server instance.

1. In **Step 3: Migration Status**, monitor the login migration process. Once the login migration is successfully completed (or if it has failures), the page displays the relevant updates.

    :::image type="content" source="../media/2-login-migration-status.png" alt-text="Screenshot showing the login migration status in Azure Data Studio.":::

### MoveLogins script

The [MoveLogins script](https://www.microsoft.com/download/details.aspx?id=103111) assists in transferring login information from on-premises SQL Servers to Azure SQL Database or other PaaS offerings.

The *MoveLogins* script, enables an Active Directory lookup for users, allowing you to obtain their User Principal Name (UPN).

The script, written in PowerShell, generates a T-SQL script that can be applied to the target SQL environment to transfer logins, database users, roles and permissions. It doesn't execute the commands on the target environment. You need to carefully review the generated script output before applying it to the target environment.

The script generates different results depending on whether you're using Azure SQL Database, or Azure SQL Managed Instance. In Azure SQL Database, you can't create Microsoft Entra logins and related database users; instead, Microsoft Entra users are created at the database level. For Azure SQL Managed Instance, it's similar to on-premises SQL Server with server-level logins and database users.

>[!NOTE]
> We suggest starting with a dedicated migration tool like Azure Migration extension to transfer logins. If you encounter any issues with these recommended tools, you can consider alternative methods like using the MoveLogins script.
