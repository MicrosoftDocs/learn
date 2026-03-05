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

### Migrate logins using PowerShell or Azure CLI

You can use the Azure Database Migration Service with [PowerShell](/powershell/module/az.datamigration/new-azdatamigrationloginsmigration) (Az.DataMigration module) or [Azure CLI](/cli/azure/datamigration) to migrate logins and server roles from your on-premises SQL Server to the Azure SQL target. This login migration process automates manual tasks such as the synchronization of logins with their corresponding user mappings and replicating server permissions and server roles.

Currently login migration supports Azure SQL Managed Instance or SQL Server on Azure VM targets.

- **Azure SQL Managed Instance** - both Windows accounts and SQL logins.
- **SQL Server on Azure VM** - only SQL logins.

If you haven't completed the database migration and the login migration process is started, the migration of logins and server roles will still happen, but login/role mappings won't be performed correctly.

The following example shows how to migrate logins using PowerShell:

```powershell
New-AzDataMigrationLoginsMigration `
    -SourceSqlConnectionString "<YourSourceConnectionString>" `
    -TargetSqlConnectionString "<YourTargetConnectionString>" `
    -ListOfLogin "login1" "login2" `
    -AADDomainName "<YourAADDomainName>"    # Required for Windows logins
```

For Azure CLI, use the `az datamigration login-migration` command:

```azurecli
az datamigration login-migration \
    --src-sql-connection-str "<YourSourceConnectionString>" \
    --tgt-sql-connection-str "<YourTargetConnectionString>" \
    --list-of-login "login1" "login2" \
    --aad-domain-name "<YourAADDomainName>"
```

For large numbers of logins, you can use the `--csv-file-path` parameter to pass a CSV file containing the list of logins to migrate.

### MoveLogins script

The [MoveLogins script](https://www.microsoft.com/download/details.aspx?id=103111) assists in transferring login information from on-premises SQL Servers to Azure SQL Database or other PaaS offerings.

The *MoveLogins* script enables an Active Directory lookup for users, allowing you to obtain their User Principal Name (UPN).

The script, written in PowerShell, generates a T-SQL script that can be applied to the target SQL environment to transfer logins, database users, roles and permissions. It doesn't execute the commands on the target environment. You need to carefully review the generated script output before applying it to the target environment.

The script generates different results depending on whether you're using Azure SQL Database, or Azure SQL Managed Instance. In Azure SQL Database, you can't create Microsoft Entra logins and related database users; instead, Microsoft Entra users are created at the database level. For Azure SQL Managed Instance, it's similar to on-premises SQL Server with server-level logins and database users.

>[!NOTE]
> We suggest starting with PowerShell or Azure CLI to transfer logins. If you encounter any issues with these recommended tools, you can consider alternative methods like using the MoveLogins script.