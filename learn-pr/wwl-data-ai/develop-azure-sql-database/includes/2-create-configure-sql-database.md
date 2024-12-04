You can create Azure SQL Databases using code or manually through the Azure portal. Additionally, you can integrate database creation into an automated continuous integration (CI) process. This approach is beneficial for maintaining consistency, as writing code to create a database ensures that you're always generating the exact same specifications each time.

When you create an Azure SQL Database using code, there are four main steps:

1. Create a resource group
1. Create a SQL server
1. Configure firewall rules
1. Create a database

## Create a resource group

All resources in Azure are created within a resource group. When creating a resource group with code, you won't have the same visibility that you have when you create a database in the portal. If you need to include resource group creation in your automated deployment, consider using a randomized name. This approach helps prevent any duplication with existing resource group names in your tenant.

> [!NOTE]
> `$RANDOM` is a Bash function that returns a pseudorandom integer in the range 0 - 32767. This is a smaller range than that returned by PowerShell `Get-Random`. To ensure uniqueness, two `$RANDOM` results can be multiplied together.

For more information about creating a resource group using code, see [Manage Azure Resource Groups by using Azure CLI](/azure/azure-resource-manager/management/manage-resource-groups-cli?azure-portal=true) or [Manage Azure Resource Groups by using Azure PowerShell](/azure/azure-resource-manager/management/manage-resource-groups-powershell?azure-portal=true).

## Create a SQL server

When you create a SQL server, the server name must also be unique, and an Admin user must be created, with a strong password.

This example uses Azure CLI to create a SQL server:

```azurecli
serverName="svr-$randomId"
adminUser="azureadmin"
adminPassword="pw-$randomId"
az sql server create --name $serverName --resource-group $resourceGroup --location $location \
--admin-user $adminUser --admin-password $adminPassword
```

This example uses PowerShell to create a SQL server:

```powershell
$serverName = "svr-$randomId"
$adminUser = "azureadmin"
$adminPassword = "pw-$randomId"

$credentials = New-Object -TypeName System.Management.Automation.PSCredential `
-ArgumentList $adminUser, $(ConvertTo-SecureString -String $adminPassword -AsPlainText -Force)

$server = New-AzSqlServer -ServerName $serverName -ResourceGroupName $resourceGroup `
-Location $location -SqlAdministratorCredentials $credentials

$server
```

## Configure firewall rules

Firewall rules specify which traffic is allowed or denied access to the server.

This example uses Azure CLI to add a firewall rule:

```azurecli
startIpAddress="0.0.0.0"
endIpAddress="0.0.0.0"
firewallRuleName="AllowedIPRange"

az sql server firewall-rule create --server $serverName \
--resource-group $resourceGroup \
--name $firewallRuleName --start-ip-address $startIpAddress --end-ip-address $endIpAddress
```

This example uses PowerShell to add a firewall rule:

```powershell
$startIpAddress = "0.0.0.0"
$endIpAddress = "0.0.0.0"
$firewallRuleName = "AllowedIPRange"

$serverFirewallRule = New-AzSqlServerFirewallRule -ServerName $serverName `
-ResourceGroupName $resourceGroup `
-FirewallRuleName $firewallRuleName -StartIpAddress $startIpAddress -EndIpAddress $endIpAddress

$serverFirewallRule

```

## Create a database

You're now ready to create an Azure SQL Database on the server you created. In this code example, you'll create the sample database *AdventureWorksLT*. If you want to create an empty database, change the database name, and remove the line with the `--sample-name` parameter.

The following code snippet uses Azure CLI to create the *AdventureWorksLT* database.

```azurecli
az sql db create --name AdventureWorksLT
\ --resource-group $resourceGroup --server $serverName
\ --sample-name AdventureWorksLT
\ --edition GeneralPurpose --compute-model serverless --family Gen5 --capacity 2
```

The following code snippet uses PowerShell to create the *AdventureWorksLT* database.

```powershell
New-AzSqlDatabase -DatabaseName AdventureWorksLT `
-ResourceGroupName $resourceGroup -ServerName $serverName `
-SampleName AdventureWorksLT `
-Edition GeneralPurpose -ComputeModel Serverless -ComputeGeneration Gen5 -VCore 2

```

The code snippet demonstrates creating an Azure SQL Database for one particular service tier, and compute tier. To get more information about the service and compute tiers available, see [Service tiers](/azure/azure-sql/database/sql-database-paas-overview?azure-portal=true).

## Query the database

You can create an Azure SQL Database using T-SQL if you have a resource group and server already created in Azure. T-SQL doesn't provide the ability to create Azure resources.

You can, however, query an existing database using the **Query editor** in the Azure portal by going to your [Azure SQL dashboard](https://portal.azure.com/#view/HubsExtension/BrowseResource/resourceType/Microsoft.Sql%2Fazuresql?azure-portal=true).

To get started, sign in to the Azure portal and navigate to your database. From the left navigation pane, select **Query editor**. Then, sign in with your SQL administrator credentials. Once you're signed in, run the following T-SQL query against the *AdventureWorksLT* database.

```SQL
SELECT TOP 10 C.Name AS Category, SUM(S.OrderQty * S.UnitPrice) AS SalesValue
    FROM [SalesLT].[ProductCategory] AS C
        INNER JOIN [SalesLT].[Product] AS P
            ON C.ProductCategoryID = P.ProductCategoryID
        INNER JOIN [SalesLT].[SalesOrderDetail] AS S
            ON P.ProductID = S.ProductID
    GROUP BY C.Name
    ORDER BY SalesValue DESC;
```

For more information Azure SQL Database deployment models available, see [What is Azure SQL Database?](/azure/azure-sql/database/sql-database-paas-overview?azure-portal=true).
