Now that you understand the integration methods between SQL and Apache Spark pools, and hopefully understand the use case it works with, it is imperative to understand how the services authenticate within Azure Synapse Analytics. The authentication between the two systems is made seamless in Azure Synapse Analytics. The Token Service connects with Microsoft Entra ID to obtain the security tokens to be used when accessing the storage account or the data warehouse in the dedicated SQL pool.

For this reason, there's no need to create credentials or specify them in the connector API if Microsoft Entra auth is configured at the storage account and the dedicated SQL pool. If not, SQL Authentication can be specified. The only constraint is that this connector only works in Scala. 

There are some prerequisites to authenticate correctly:
- The account user needs to be a member of the db_exporter role in the database or SQL pool from which you want to transfer data to or from.
- The account user needs to be a member of the Storage Blob Data Contributor role on the default storage account. 

If you want to create users, you need to connect to the dedicated SQL pool database from which you want transfer data to or from as shown in the following example: 

```sql
--SQL Authenticated User
CREATE USER Leo FROM LOGIN Leo;

--Azure Active Directory User
CREATE USER [chuck@contoso.com] FROM EXTERNAL PROVIDER;
```

When you want to assign the user account to a role, you can use the following script as an example:

```sql
--SQL Authenticated user
EXEC sp_addrolemember 'db_exporter', 'Leo';
--Azure Active Directory User
EXEC sp_addrolemember 'db_exporter',[chuck@contoso.com]
```

Once the authentication is in place, you can transfer data to or from a dedicated SQL pool attached within the workspace.
