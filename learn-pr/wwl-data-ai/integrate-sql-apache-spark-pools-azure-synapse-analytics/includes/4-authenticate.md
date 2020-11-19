Since you understand the integration methods between SQL and Spark pools, and hopefully have an understanding of the use cases it's involved with, it is imperative to understand how the services authenticate within Azure Synapse Analytics.
That's where the Azure Synapse Apache Spark Pool to Synapse SQL connector, comes in to play. 

The Authentication between the two systems is made seamless in Azure Synapse Analytics. 
The Token Service connects with Azure Active Directory to obtain security tokens for use when accessing the storage account or the data warehouse server.

For this reason, there's no need to create credentials or specify them in the connector API as long as Azure AD-Auth is configured at the storage account and the data warehouse server. 
If not, SQL Auth can be specified.
The only constraint that needs to be taken into account is that this connector is only working in scala. 

There are some Prerequisites in order to authenticate namely:
* It needs to be a member of db_exporter role in the database or SQL pool from which you to transfer data to or from.
* It needs to be a member of the Storage Blob Data Contributor role on the default storage account. 

If you want to create users, you need to connect to the SQL Pool database from which you want transfer data to/from. 
An example: 


```sql
--SQL User
CREATE USER Leo FROM LOGIN Leo;

--Azure Active Directory User
CREATE USER [chuck@contoso.com] FROM EXTERNAL PROVIDER;
```

To assign a role:

```sql
--SQL User
EXEC sp_addrolemember 'db_exporter', 'Leo';

--Azure Active Directory User
EXEC sp_addrolemember 'db_exporter',[chuck@contoso.com]
```

Import statements are not needed since they are pre-loaded in case you use the notebook experience. 

Once the authentication is in place, you are enabled to transfer data to or from a dedicated SQL pool attached within the workspace. 



