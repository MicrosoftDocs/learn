The new environment specification calls for a General Purpose Azure SQL Database with auditing to a storage account, [Microsoft Defender for SQL](/azure/azure-sql/database/azure-defender-for-sql?azure-portal=true) enabled, and a geo-secondary. If you write that Bicep from scratch and get the audit property names right, the work takes an hour. If you describe the requirements to Copilot and review the output, it takes 15 minutes.

A common DBA's daily work spans four different areas: Bicep for infrastructure provisioning, PowerShell for operational scripts that run across many databases, Azure CLI for pipeline automation, and T-SQL against `msdb` for SQL Server Agent jobs. The same Copilot workflow  applies to all four. This unit walks them one at a time, starting with the area you already opened: Bicep.

## Generate Bicep templates for Azure SQL infrastructure

Infrastructure-as-code is a DBA responsibility in most organizations. Copilot understands Bicep syntax and Azure resource provider schemas, which makes it practical for producing deployable templates from a plain-English description.

Describe your requirements in a comment block at the top of a `.bicep` file. Copilot generates the parameter declarations and resource blocks.

```bicep
// Deploy an Azure SQL Database, General Purpose tier, with SQL Audit to a storage account
// and Microsoft Defender for SQL enabled
// Parameters: serverName, databaseName, storageAccountName, location

// GitHub Copilot generates:
param serverName string
param databaseName string
param storageAccountName string
param location string = resourceGroup().location
param administratorLogin string
@secure()
param administratorLoginPassword string

resource sqlServer 'Microsoft.Sql/servers@2023-05-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2023-05-01-preview' = {
  parent: sqlServer
  name: databaseName
  location: location
  sku: {
    name: 'GP_Gen5_2'
    tier: 'GeneralPurpose'
  }
}

resource auditingSettings 'Microsoft.Sql/servers/auditingSettings@2023-05-01-preview' = {
  parent: sqlServer
  name: 'default'
  properties: {
    state: 'Enabled'
    storageEndpoint: 'https://${storageAccountName}.blob.core.windows.net/'
    retentionDays: 90
  }
}

resource defenderSettings 'Microsoft.Sql/servers/securityAlertPolicies@2023-05-01-preview' = {
  parent: sqlServer
  name: 'default'
  properties: {
    state: 'Enabled'
  }
}
```

From the description comment, Copilot generated a complete template covering the logical server, the database, the audit policy with a 90-day retention default, and the Defender security alert policy. Notice that the `administratorLoginPassword` parameter is decorated with [`@secure()`](/azure/azure-resource-manager/bicep/parameters#secure-parameters). Copilot applies that pattern automatically for credential parameters. The `@secure()` decorator instructs Bicep to omit the parameter value from deployment logs, the Azure portal's deployment history, and any `outputs` section. Without it, the password would appear in cleartext anywhere a deployment record is rendered.

> [!IMPORTANT]
> Validate the API versions and property names against the Azure Resource Manager REST API documentation before you deploy. Copilot's training data may reference a preview API version that has changed since the model was trained. Use the `az provider show` command or the Azure portal JSON view to confirm current property names.

## Generate PowerShell for DBA operational tasks

You used Copilot to generate Bicep for provisioning. Operational tasks (backup verification, encryption audits, anything that loops across all your databases at once) call for PowerShell instead. The workflow is the same one you used for Bicep: describe the intent in a comment, then review the script Copilot generates. Only the language is different.

PowerShell is the standard for multi-resource operational scripts in Azure SQL environments. Copilot generates `Az.Sql` module commands from descriptive comments with the same accuracy it applies to T-SQL.

### Enumerate databases and last backup times

At the start of each week, you want to verify backup coverage across every Azure SQL database in your subscription.

```powershell
# List all Azure SQL databases in the current subscription with their last backup time
# GitHub Copilot generates:
$databases = Get-AzSqlServer | ForEach-Object {
    $server = $_
    Get-AzSqlDatabase -ServerName $server.ServerName -ResourceGroupName $server.ResourceGroupName |
    Where-Object { $_.DatabaseName -ne 'master' } |
    Select-Object ServerName, DatabaseName,
        @{N='LastBackupTime'; E={ (Get-AzSqlDatabaseGeoBackup -ServerName $server.ServerName `
            -ResourceGroupName $server.ResourceGroupName `
            -DatabaseName $_.DatabaseName).LastAvailableBackupDate }}
}
$databases | Sort-Object LastBackupTime | Format-Table -AutoSize
```

The `master` database filter, the geo-backup cmdlet call, and the calculated property for `LastBackupTime` are all details Copilot includes automatically when the comment describes the intent clearly.

### Enable TDE on databases that are missing it

A compliance audit finds that some databases in a resource group have Transparent Data Encryption disabled. Rather than checking each database manually in the portal, you describe the remediation in a comment.

```powershell
# Enable TDE on all Azure SQL databases in a resource group that have TDE disabled
# GitHub Copilot generates:
$resourceGroup = "rg-production"
Get-AzSqlServer -ResourceGroupName $resourceGroup | ForEach-Object {
    $server = $_
    Get-AzSqlDatabase -ServerName $server.ServerName -ResourceGroupName $resourceGroup |
    Where-Object { $_.DatabaseName -ne 'master' } |
    ForEach-Object {
        $tde = Get-AzSqlDatabaseTransparentDataEncryption `
                   -ServerName $server.ServerName `
                   -ResourceGroupName $resourceGroup `
                   -DatabaseName $_.DatabaseName
        if ($tde.State -ne 'Enabled') {
            Set-AzSqlDatabaseTransparentDataEncryption `
                -ServerName $server.ServerName `
                -ResourceGroupName $resourceGroup `
                -DatabaseName $_.DatabaseName `
                -State 'Enabled'
            Write-Output "Enabled TDE on $($_.DatabaseName)"
        }
    }
}
```

Copilot structures the script with a read-then-conditionally-write pattern, ensuring you only call `Set-AzSqlDatabaseTransparentDataEncryption` on databases that actually need remediation. Review the output message logic and test against a nonproduction resource group before running at scale.

## Generate Azure CLI commands for common DBA operations

PowerShell handles ad-hoc operations across many databases from a workstation. For automation that runs in build pipelines or scheduled jobs, most teams reach for the Azure CLI instead. It's lighter, scripts in bash, and has cleaner exit-code handling for pipeline gates. Same Copilot workflow, different shell.

For teams that prefer the Azure CLI in pipelines or in the terminal, Copilot generates `az sql` commands from comments in `.sh` or `.azcli` files, and in VS Code's terminal when the shell is active.

### Create an elastic job agent

```bash
# Create an elastic job agent for scheduling maintenance jobs across many databases
# GitHub Copilot suggests:
az sql elastic-job agent create \
  --resource-group rg-production \
  --server sql-server-prod \
  --name elastic-job-agent \
  --database ai-job-db
```

The elastic job agent requires a dedicated control database. Copilot includes the `--database` parameter and uses the parameter name the CLI currently expects.

### Configure long-term retention

```bash
# Set 5-year long-term retention for monthly backups on a compliance database
# GitHub Copilot suggests:
az sql db ltr-policy set \
  --resource-group rg-production \
  --server sql-server-prod \
  --name compliance-db \
  --monthly-retention P5Y
```

The `P5Y` ISO 8601 duration format is easy to forget. Copilot applies it correctly when the comment describes retention in plain English.

> [!TIP]
> When Copilot generates Azure CLI commands, verify the parameter names against `az sql --help` output or the Azure CLI reference documentation. Parameter names occasionally change between minor releases, and Copilot's training data may be slightly behind the current release.

## Write SQL Server Agent job scripts with Copilot

The last area in the rotation is the one closest to home: T-SQL. SQL Server Agent jobs live in `msdb` and are created through a sequence of system stored procedure calls. Same Copilot workflow, but this time the generated output uses the language you already write every day.

SQL Server Agent job creation involves a sequence of `msdb` system stored procedure calls with nonobvious parameters, particularly the `@freq_interval` bitmask for weekly schedules. Copilot generates the full sequence from a natural-language description.

The `@freq_interval` parameter encodes a weekly schedule as a bitmask: each day is a power of 2 (Sunday = 1, Monday = 2, Tuesday = 4, Wednesday = 8, Thursday = 16, Friday = 32, Saturday = 64), and you add the values together to select multiple days. The encoding works in reverse too: if you inherited a job with `@freq_interval = 42`, which days does it run on? Work out your answer before you read on.

```sql
-- Create a SQL Server Agent job named "Weekly Index Maintenance"
-- that runs every Saturday at 01:00 AM and calls dbo.usp_CheckIndexFragmentation
-- Notify the DBATeam operator on failure

-- GitHub Copilot generates:
USE msdb;
GO
EXEC sp_add_job @job_name = N'Weekly Index Maintenance';

EXEC sp_add_jobstep
    @job_name       = N'Weekly Index Maintenance',
    @step_name      = N'Run fragmentation check',
    @subsystem      = N'TSQL',
    @command        = N'EXEC YourDatabase.dbo.usp_CheckIndexFragmentation @FragmentationThreshold = 30.0;',
    @database_name  = N'YourDatabase',
    @on_fail_action = 2;

EXEC sp_add_schedule
    @schedule_name         = N'Weekly Saturday 01:00',
    @freq_type             = 8,      -- weekly
    @freq_interval         = 64,     -- Saturday (bitmask: Sun=1, Mon=2, Tue=4, Wed=8, Thu=16, Fri=32, Sat=64)
    @active_start_time     = 010000; -- 01:00 AM

EXEC sp_attach_schedule @job_name = N'Weekly Index Maintenance', @schedule_name = N'Weekly Saturday 01:00';
EXEC sp_add_jobserver   @job_name = N'Weekly Index Maintenance';
GO
```

Copilot produces the full five-procedure sequence, including the `@on_fail_action = 2` (quit with failure) setting on the job step and the correct `@freq_interval` value of `64` for Saturday. To check the decode question: `42` is `32 + 8 + 2`, which is Friday, Wednesday, and Monday. Because the values add together, the same parameter handles any schedule, from a single day (`64`) to Monday through Friday (`62`).

> [!NOTE]
> Always review Copilot-generated `msdb` scripts against the documented [`sp_add_job`](/sql/relational-databases/system-stored-procedures/sp-add-job-transact-sql?azure-portal=true) parameter list. Copilot occasionally may reference parameter names from older SQL Server versions or substitutes deprecated defaults.

Generating scripts quickly is only valuable if the output meets your standards for correctness and security. In the next unit, you learn how to evaluate what Copilot produces: what to look for, what to question, and when to iterate.
