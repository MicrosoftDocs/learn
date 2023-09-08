For a seamless and secure transition of your SQL resources to Azure, understanding and effectively managing the migration of security information is essential.

## Decide when to migrate SQL logins and groups

Imagine a large organization with a substantial on-premises SQL Server infrastructure that serves various business units. Each business unit has its own set of SQL logins, user roles, and permissions customized to their specific needs. The organization decides to migrate these databases to Azure SQL Database to leverage the cloud's scalability and efficiency benefits.

In this scenario, migrating the logins upfront, before the database migration, could introduce unnecessary complexity to the testing phase.

Migrating logins at the end of a database migration project can facilitate testing, especially in complex scenarios. Consider an organization with diverse permissions for different business units. If logins are migrated upfront, it can lead to testing delays due to evolving database schemas. Waiting to migrate logins allows security configurations to align with the final structure, simplifying the migration process, especially when table-dependent security is crucial for data protection.

### Considerations

 Here's why:

Certainly, here are shorter explanations:

| **Challenges**                   | **Explanation**                                                                                                                                                                                             |
|----------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Diverse Permissions Structure    | Migrating logins later allows for adapting permissions as the database structure evolves during migration.                                                                                                  |
| Testing Delays                   | Migrating logins early may slow down testing, complicating security validation alongside schema changes.                                                                                                  |
| Table-Dependent Security         | Delaying login migration enables adjusting security configurations to match final database structures if they change during migration.                                                                        |
| Data Sensitivity                 | Migrating logins after database creation aligns security with actual data and tables, reducing the risk of data breaches.                                                                                    |

By postponing the migration of logins until after the database is created and the schema is stable, you can simplify the testing and validation phase. This approach allows you to focus on ensuring that security measures align perfectly with the finalized database structure, reducing potential complications and making the migration project more manageable.

### Using the migration extension

[Azure migration extension in Azure Data Studio](/azure/dms/tutorial-login-migration-ads).

As part of the post-migration tasks, we're introducing a new user experience with an independent workflow you can use to migrate logins (preview) and server roles from your on-premises source SQL Server to the Azure SQL target. This login migration experience automates manual tasks such as the synchronization of logins with their corresponding user mappings and replicating server/securable permissions and server roles.

Currently the migration extension only supports an Azure SQL Managed Instance or SQL Server on Azure VM targets. Futhermore

Azure SQL Managed Instance - both Windows accounts and SQL logins.
SQL Server on Azure VM - only SQL logins

Important - If you have also migrated Windows accounts, make sure to check the option of Azure Active Directory - Password while logging into the target managed instance using the same password that the Windows account had on the source SQL Server.

If you haven’t completed the database migration and the login migration process is started, the migration of logins and server roles will still happen, but login/role mappings won’t be performed correctly. Nevertheless, the login migration process can be performed at any time, to update the user mapping synchronization for recently migrated databases.

You can use the Azure SQL Migration extension for Azure Data Studio, PowerShell or Azure CLI to start the login migration process. Here is a step-by-step guide on how to migrate logins using the migration extension in Azure Data Studio:

1. Start the SQL Server login migration wizard.

<image>

1. Select your logins from the source SQL Server instance.

<image>

1. Select and connect to your Azure SQL target.

<image>

1. Start your SQL Server login migration and monitor progress to completion.

### Using DMA




### Tool XPTO

This tool assists in transferring login information from on-premises SQL Servers to Azure SQL Database or other PaaS offerings.

The migration of SQL logins and groups are very important, given the complexity of permissions within SQL Server environments. While tools like the Data Migration Assistant (DMA) has the ability to transfer security information and does a full dependency graph to ensure permissions are transferred properly, the script offered here provides an additional option. It enables an Active Directory lookup for users, allowing you to obtain their User Principal Name (UPN), a feature currently not supported by DMA.

Move Login information from SQL Servers on premises to SQL Server running as Platform as a Service (PaaS).

https://www.microsoft.com/en-us/download/details.aspx?id=103111 
