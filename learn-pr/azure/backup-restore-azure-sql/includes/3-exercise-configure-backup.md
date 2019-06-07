Let's use the Azure CLI to create a resource group, and then to create an Azure Sql Server and database instance into this resource group.

[!include[](../../../includes/azure-sandbox-activate.md)]

1. Create a resource group for the new Azure SQL instance

``` cli
    az group create --location westeurope --name rg-sql-erp
```

1. Create an Azure SQL server

``` cli
    az sql server create --resource-group rg-sql-erp --name sql-erp --location westeurope --admin-user dbadmin123 --admin-password StrongPassword123
```

1. Create an Azure SQL server and database instance using the CLI

``` cli
    az sql db create --resource-group rg-sql-erp --name sql-erp-db --server sql-erp --edition Standard
```

1. Use the portal to view the newly create Azure SQL server and database. View the default policy for PITR (Point In Time Restore) configuration that was setup automatically for this database.

1. In the Azure portal, select the newly created SQL server database and under settings click **Manage Backups**
1. Under the **Configure policies** click the **Configure retention** tab and making sure your SQL server database is selected
1. Click the **Point In Time Restore Configuration** drop down and select **28**
1. Click **Apply** and the policy is updated within seconds.

![Screenshot of the Azure portal showing the database restore options for PITR](../media/3-configure-backup-point-in-time-backup.PNG)

    Lets add a table and a few sample records to the database. Make sure that the database (with the new table and data) is backed up.

``` SQL
-- Create Person table
CREATE TABLE Person
(
    PersonId INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL
)
-- Add the following record
INSERT INTO PERSON (FirstName, LastName, DateOfBirth)
VALUES ('Lucas', 'Ball', '1987-11-03');

  ```