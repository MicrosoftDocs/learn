PowerShell is a modern, cross-platform command shell that simplifies task management and provides powerful features for automation. It was created using widely used languages  to provide administrators with command-line features, which, when used with automation, supports the reduction of ongoing operational cost.

PowerShell can accept and return both text and .NET objects that allow it to be a dynamic, one-stop command-line tool.

Some of the many benefits of PowerShell include:

- Robust command-line history
- Tab completion and command prediction
- Supports command and parameter aliases
- Pipeline for chaining commands
- In-console help system

PowerShell provides a core module known as Az PowerShell module, which is an open-source set of cmdlets that replaces AzureRM and are used to manage Azure resources directly from PowerShell.  The Az PowerShell module allows for Azure resource creation, modification, status retrieval, and template-based deployments.

## Az.Sql PowerShell module

The Az.Sql PowerShell module is a subset of Az PowerShell that allows you to manage and deploy Azure SQL resources. Everything from the creation of a database to configuring geo replication to full Azure SQL management can be accomplished with the Az.Sql cmdlets.

The Az.Sql PowerShell module can be used however you use PowerShell including PowerShellGet, the Azure Cloud Shell and an Az PowerShell Docker container.

Regardless of how you use PowerShell, the syntax used is still the same with the verb-noun structure as seen below:

```Powershell
<command-name> -<Required Parameter Name> <Required Parameter Value>
[-<Optional Parameter Name> <Optional Parameter Value>]
[-<Optional Switch Parameters>]
[-<Optional Parameter Name>] <Required Parameter Value>
```

Commands always begin with a command name, such as `Get-AzSqlServer`, which returns information about one or more Azure SQL Database servers. The "command-name" is then followed by a Parameter Name with <-ServerName> being an applicable parameter for Get-AzSQLServer. This is then followed with a parameter value, which is written in a string form.  Below is an example usage of the `Get-AzSqlServer` command with multiple parameters with its return values:

```PowerShell
Get-AzSqlServer -ResourceGroupName "ResourceGroup01" -ServerName "Server01"
```

You can see below a few other examples like how to create a new SQL Managed Instance, and how to create a database on a specific server:

```Powershell
New-AzSqlInstance -Name managedInstance2 -ResourceGroupName ResourceGroup01 -Location westcentralus -AdministratorCredential (Get-Credential) -SubnetId "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/resourcegroup01/providers/Microsoft.Network/virtualNetworks/vnet_name/subnets/subnet_name" -LicenseType LicenseIncluded -StorageSizeInGB 1024 -VCore 16 -Edition "GeneralPurpose" -ComputeGeneration Gen4
```

```Powershell
New-AzSqlDatabase -ResourceGroupName "ResourceGroup01" -ServerName "Server01" -DatabaseName "Database01"
```

Here's an example that creates a new SQL Managed Instance with External Microsoft Entra administrator, Microsoft Entra-only authentication and no *SqlAdministratorCredentials*:

```Powershell
New-AzSqlInstance -Name managedInstance2 -ResourceGroupName ResourceGroup01 -ExternalAdminName DummyLogin -EnableActiveDirectoryOnlyAuthentication -Location westcentralus -SubnetId "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/resourcegroup01/providers/Microsoft.Network/virtualNetworks/vnet_name/subnets/subnet_name" -LicenseType LicenseIncluded -StorageSizeInGB 1024 -VCore 16 -Edition "GeneralPurpose" -ComputeGeneration Gen4

$val = Get-AzSqlInstance -Name managedInstance2 -ResourceGroupName ResourceGroup01 -ExpandActiveDirectoryAdministrator

```

To learn more about the full list of command-names for the Az.Sql module, see [Azure PowerShell Az.Sql.](/powershell/module/az.sql)
