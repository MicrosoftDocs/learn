Many DBA's became familiar with Azure Automation because Azure SQL Database initially lacked capabilities for scheduled jobs.

The elastic jobs capability allows you to run a set of T-SQL scripts against a collection of servers or databases either as a one-time job or on a defined schedule. Elastic Jobs function similarly to SQL Server Agent jobs but are limited to executing T-SQL. They work across all tiers of Azure SQL Database. SQL Agent jobs continue to be used for task automation in SQL Server and are also included with Azure SQL Managed Instances.

:::image type="content" source="../media/module-66-automation-final-28.png" alt-text="Screenshot of the elastic job architecture diagram.":::

To configure Elastic Jobs, you need a Job Agent and a dedicated database to manage your jobs. The recommended service tier for the job database is S1 or higher, depending on the number and frequency of jobs you're executing.

Let's review the components of Elastic Jobs:

- **Elastic job agent**: Your Azure resource for running and managing jobs.
- **Job database**: A dedicated database to manage your jobs.
- **Target group**: A collection of servers, elastic pools, and single databases where a job will be run.
- **Job**: One or more T-SQL scripts that make up a job step.

If a server or elastic pool is the target, you need to create a credential within the `master` database of the server or pool so the job agent can enumerate the databases. For a single database, only a database credential is needed. Credentials should have the least privileges necessary to perform the job step.

:::image type="content" source="../media/module-66-automation-final-29.png" alt-text="Screenshot of the elastic job agent creation page.":::

You can create an elastic job agent through the Azure portal, PowerShell, or REST API. To create an Elastic Job agent from the Azure portal, navigate to the **Elastic Job Agent** page. Here, provide a name for your agent and specify an SQL database for your job database.

You can create a target group using PowerShell, T-SQL, or Azure CLI. The following snippet creates a *MyServerGroup* target group, including all databases on the server at the time of execution. This snippet assumes the variables `$jobAgent` and `$targetServerName` were previously provided.

```powershell
# create MyServerGroup target group
$serverGroup = $jobAgent | New-AzSqlElasticJobTargetGroup -Name 'MyServerGroup'
$serverGroup | Add-AzSqlElasticJobTarget -ServerName $targetServerName -RefreshCredentialName $masterCred.CredentialName
```

This script sets up an elastic job target group and adds a target server to it, allowing you to run jobs against the specified server.

The following code snippet creates an elastic job and adds job steps using PowerShell. *Step1* is responsible for creating the *MyTable* table if it doesn't already exist.

```powershell
Write-Output "Creating a new job..."
$jobName = "MyFirstElasticJob"
$job = $jobAgent | New-AzSqlElasticJob -Name $jobName -RunOnce

Write-Output "Creating job steps for $($jobName) job..."
$sqlText1 = "IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = object_id('MyTable')) CREATE TABLE [dbo].[MyTable]([Id] [int] NOT NULL);"

$job | Add-AzSqlElasticJobStep -Name "Step1" -TargetGroupName $serverGroup.TargetGroupName -CredentialName $jobCred.CredentialName -CommandText $sqlText1
```

The T-SQL scripts executed by elastic jobs should be idempotent. This means that if the job runs multiple times, whether accidentally or due to a job failure, it won't fail or produce unintended results. You should be able to run the same script multiple times without encountering errors.

Finally, run the elastic job *MyFirstElasticJob* using PowerShell.

```powershell
Write-Output "Start the job..."
$jobExecution = $job | Start-AzSqlElasticJob
$jobExecution
```

## Use case scenarios

Elastic jobs can be used in the following scenarios:

- Automate management tasks to run on a specific schedule.
- Deploy schema changes seamlessly.
- Move data efficiently.
- Collect and aggregate data for reporting or other purposes.
- Load data from Azure Blob storage.
- Configure jobs to execute across multiple databases on a recurring basis, such as during off-peak hours.
- Process data across numerous databases, such as telemetry collection, and compile results into a single destination table for further analysis.

SQL Agent jobs and Elastic Jobs serve different purposes across Azure SQL platforms. SQL Agent jobs, available in SQL Server and Azure SQL Managed Instances, offer robust scheduling and automation. Elastic Jobs, designed for Azure SQL Database and elastic pools, run T-SQL scripts across multiple databases. 