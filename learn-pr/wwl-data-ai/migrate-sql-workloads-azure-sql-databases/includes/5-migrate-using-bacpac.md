A SQL Server database can be imported into an Azure SQL database using a **.bacpac** file. 

A **.bacpac** file is a compressed file containing the metadata and data from the database. The data can be imported from the Azure Blob Storage or from a local storage in an on-premises environment. 

For optimal scale and performance in production environments, it's  recommended to use the [**SQLPackage**](/sql/tools/sqlpackage/sqlpackage) utility. Running multiple `SqlPackage` commands in parallel for subsets of tables can significantly accelerate import/export operations.

### Import from a BACPAC file in the Azure portal

You can follow these steps to import a **.bacpac** file in Azure SQL Database.

1. To import from a BACPAC file into a new single database using the Azure portal, open the appropriate database server page and then, on the toolbar, select **Import database**.
1. Select the storage account and container for the BACPAC file, and then select the BACPAC file from which to import.
1. Specify the new database size (usually the same as the origin) and provide the destination SQL Server credentials, and then select **OK**.
1. To monitor an import's progress, open the database server page and, under **Settings**, select **Import/Export history**. When successful, the import has a **Completed** status.

Additionally, you can also use **`SqlPackage`** to import a BACPAC file as it's faster than using the Azure portal. The following command imports the **`AdventureWorks2019`** database from local storage to an Azure SQL Database server called **`mynewserver20230103`**. It creates a new database called **`myMigratedDatabase`** with a **Premium** service tier and a **P6** service objective. 

Change these values as appropriate for your environment.

```console
SqlPackage.exe /a:import /tcs:"Data Source=mynewserver20230103.database.windows.net;Initial Catalog=myMigratedDatabase;User Id=<your_server_admin_account_user_id>;Password=<your_server_admin_account_password>" /sf:AdventureWorks2019.bacpac /p:DatabaseEdition=Premium /p:DatabaseServiceObjective=P6
```

>[!TIP]
>To increase the speed of the import process, you can scale your database to a higher service tier and compute size, providing more and faster resources. Once the import is complete, you can scale down to your desired service tier and compute size. 
