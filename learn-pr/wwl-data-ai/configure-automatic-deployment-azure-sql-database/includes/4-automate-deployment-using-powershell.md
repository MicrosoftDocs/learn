PowerShell is a modern, cross-platform command shell designed to simplify task management and enhance automation. It provides administrators with powerful command-line features that, when automated, help reduce operational costs.

PowerShell can handle both text and .NET objects, making it a versatile, all-in-one command-line tool.

Some key benefits of PowerShell include:

- Robust command-line history
- Tab completion and command prediction
- Support for command and parameter aliases
- Pipeline for chaining commands
- In-console help system

PowerShell's core module, the Az PowerShell module, is an open-source set of cmdlets. It allows you to manage Azure resources directly from PowerShell, enabling resource creation, modification, status retrieval, and template-based deployments.

## Az.Sql PowerShell module

The **Az.Sql** PowerShell module is a subset of the Az PowerShell module, enabling you to manage and deploy Azure SQL resources. With **Az.Sql** cmdlets, you can handle everything from creating databases to configuring geo-replication and full Azure SQL management.

You can use the **Az.Sql** PowerShell module in various environments, including PowerShellGet, Azure Cloud Shell, and an Az PowerShell Docker container.

No matter how you use PowerShell, the syntax remains consistent with the verb-noun structure.

```Powershell
<command-name> -<Required Parameter Name> <Required Parameter Value>
[-<Optional Parameter Name> <Optional Parameter Value>]
[-<Optional Switch Parameters>]
[-<Optional Parameter Name>] <Required Parameter Value>
```

Commands always begin with a command name, such as `Get-AzSqlServer`, which returns information about one or more logical servers for Azure SQL Database. The "command-name" is then followed by a Parameter Name with <-ServerName> being an applicable parameter for Get-AzSQLServer. This is then followed with a parameter value, which is written in a string form. The following example shows the usage of the `Get-AzSqlServer` command with multiple parameters with its return values:

```PowerShell
Get-AzSqlServer -ResourceGroupName "ResourceGroup01" -ServerName "Server01"
```

Here are a few more examples, such as how to create a new SQL Managed Instance and how to create a database on a specific server:

```Powershell
New-AzSqlInstance -Name managedInstance2 -ResourceGroupName ResourceGroup01 -Location westcentralus -AdministratorCredential (Get-Credential) -SubnetId "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/resourcegroup01/providers/Microsoft.Network/virtualNetworks/vnet_name/subnets/subnet_name" -LicenseType LicenseIncluded -StorageSizeInGB 1024 -VCore 16 -Edition "GeneralPurpose" -ComputeGeneration Gen4
```

```Powershell
New-AzSqlDatabase -ResourceGroupName "ResourceGroup01" -ServerName "Server01" -DatabaseName "Database01"
```

Here's an example that creates a new SQL Managed Instance with External Microsoft Entra administrator, Microsoft Entra-only authentication, and no *SqlAdministratorCredentials*:

```Powershell
New-AzSqlInstance -Name managedInstance2 -ResourceGroupName ResourceGroup01 -ExternalAdminName DummyLogin -EnableActiveDirectoryOnlyAuthentication -Location westcentralus -SubnetId "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/resourcegroup01/providers/Microsoft.Network/virtualNetworks/vnet_name/subnets/subnet_name" -LicenseType LicenseIncluded -StorageSizeInGB 1024 -VCore 16 -Edition "GeneralPurpose" -ComputeGeneration Gen4

$val = Get-AzSqlInstance -Name managedInstance2 -ResourceGroupName ResourceGroup01 -ExpandActiveDirectoryAdministrator

```

To learn more about the full list of command-names for the Az.Sql module, see [Azure PowerShell Az.Sql](/powershell/module/az.sql).
