When working with automation from SQL Server, it's common to use SQL Agent to schedule jobs for automation purposes. Although SQL MI and SQL VM still have that option, SQL Database doesn't, so you'll need to use alternative automation methods to achieve similar results on SQL Server.

## Azure Automation

Azure Automation allows for process automation, configuration management, full integration with Azure platform options, such as role-based access control and Azure AD, and can manage Azure and on-premises resources.

With Azure Automation, you can easily control resources in both Azure and on-premises VMs. For example, you can use hybrid runbooks to automate tasks like starting a VM, running a SQL Server backup, and shutting down the VM, making it cost-effective and efficient.

Another common scenario is to use Azure Automation for periodic maintenance operations, such as purging stale or old data, or reindex a SQL database.

### Components

[Azure Automation](/azure/automation/overview) supports both automation and configuration management activities. We're going to focus on the automation components, but you can also use Azure Automation to manage server updates and configurations.

| Component | Description |
| ------------- | ------------------- |
| **Runbook** | Runbooks are the unit of execution in Azure Automation. Runbooks are defined as one of three types: a graphical runbook based on PowerShell, a PowerShell script, or Python script. PowerShell runbooks are most commonly used to manage Azure SQL resources. |
| **Module** | Azure Automation defines an execution context for the PowerShell or Python code you're executing in your runbook. In order to execute your code, you need to import the supporting modules. For example, if you needed to run the `Get-AzSqlDatabase` PowerShell cmdlet, you would need to import the `Az.SQL` PowerShell module into your automation account. |
| **Credential** | Credentials store sensitive information that runbooks or configurations can use at runtime. |
| **Schedule** | Schedules are linked to runbooks and trigger a runbook at a specific time. |

To learn more about Azure CLI and Powershell commands available for managing Azure SQL Database and Azure SQL Managed Instance resources, refer to the following links: [PowerShell module for Azure SQL](/powershell/module/az.sql) and [Azure CLI for Azure SQL](/cli/azure/sql).

## Elastic jobs

One of the reasons why many DBAs became so familiar with Azure Automation is that Azure SQL Database initially lacked capabilities for scheduled jobs. 

This limitation meant that DBAs had to find alternative solutions to handle these essential tasks efficiently. Azure Automation emerged as a valuable tool in this scenario, offering the means to create and manage scheduled jobs, automate database migration processes, and perform routine maintenance tasks.

### Architecture

[Elastic jobs](/azure/azure-sql/database/job-automation-overview) feature allows you to run a set of T-SQL scripts against a collection of servers or databases as a one-time job, or by using a defined schedule. Elastic jobs work similarly to SQL Server Agent jobs, except that they're limited to executing T-SQL. The jobs work across all tiers of Azure SQL Database.

:::image type="content" source="../media/7-elastic-job-architecture.png" alt-text="Screenshot of the elastic job architecture diagram.":::

To configure Elastic Jobs, you need a Job agent and database dedicated to managing your jobs. The recommended service tier for the job database is S1 or higher, and the optimum service tier will be dependent on the number of jobs you're executing and the frequency of those jobs.

Let's review the elastic jobs components:

- **Elastic job agent** - your Azure resource for running and managing jobs.
- **Job database** - a database dedicated to manage your jobs.
- **Target group** - a collection of servers, elastic pools, and single databases in which a job will be run.
- **Job** - one or more T-SQL scripts that compose a job step.

If a server or elastic pool is the target, a credential within the master database of the server or pool should be created so that the job agent can enumerate the databases within. For a single database, a database credential is all that is needed. Credentials should have the least privileges necessary to perform the job step.

:::image type="content" source="../media/7-elastic-job-creation.png" alt-text="Screenshot of the elastic job agent creation page.":::

You can create an elastic job agent through the Azure portal. On the **Elastic Job agent** page, make sure you provide a name for your agent, and specify a SQL database for your job database.

The following PowerShell script creates an elastic job named *MyFirstElasticJob* adds a job step to it, and executes a SQL command to create a table if it doesn't exist in the database.

```powershell
Write-Output "Creating a new job..."
$jobName = "MyFirstElasticJob"
$job = $jobAgent | New-AzSqlElasticJob -Name $jobName -RunOnce

Write-Output "Creating job steps for $($jobName) job..."
$sqlText1 = "IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = object_id('MyTable')) CREATE TABLE [dbo].[MyTable]([Id] [int] NOT NULL);"

$job | Add-AzSqlElasticJobStep -Name "Step1" -TargetGroupName $serverGroup.TargetGroupName -CredentialName $jobCred.CredentialName -CommandText $sqlText1
```

Finally, run the *MyFirstElasticJob* elastic job.

```powershell
Write-Output "Start the job..."
$jobExecution = $job | Start-AzSqlElasticJob
$jobExecution
```

### Use case scenarios

Elastic jobs can be used in the following scenarios:

- Automate management tasks to run on a specific schedule.
- Deploy schema changes.
- Data movements.
- Collect, and aggregate data for reporting or other purposes.
- Load data from Azure Blob storage.
- Configure jobs to execute across a collection of databases on a recurring basis, such as during off-peak hours.
- Data processing over a large number of databases, for instance, telemetry collection. Results are then compiled into a single destination table for further analysis.

## Migrate SQL Agent jobs to Elastic Jobs

While it’s possible to create your own scripts for migrating your SQL Agent jobs to Elastic Jobs, there’s a more convenient option available. A downloadable script exists that facilitates the [copy existing SQL Agent jobs to Elastic Jobs](/download/details.aspx?id=103123). 

The script is a tool that automates the process of converting these jobs, saving you the time and effort of having to manually recreate them in the new environment.

The file is a zipped folder that contains the script and associated documentation. To use it, you'd download the file, and follow the instructions. 

After you've entered all the parameters listed in the instructions, the job list will appear. The script will then create each job individually in a disabled state, assuming it doesn't already exist. Following the creation of a job, the steps are added with the same IDs, Command Text, Retry Attempts, and Initial Retry Interval Seconds. The database linked to the job step will be the target group. If the target group doesn't exist, it'll be created automatically. The copy won’t include schedules, alerts, and notifications.

## Migrate SQL Agent jobs to SQL Agent on Azure

Migrating jobs from an on-premises SQL Server to Azure SQL Managed Instance  or SQL Server running on Virtual Machine follows a process that should feel familiar for most of the DBAs.

In our scenario, suppose we migrated our on-premises SQL Server to Azure SQL Managed Instance. We need to migrate and adjust several SQL Agent jobs to make them function seamlessly in the Azure environment.

| Step                              | Description |
| --------------------------------- | ----------------------------------- |
| **Assess dependencies**         | <ul><li>Identify the SQL Agent job you want to migrate.</li><li>List any dependencies, such as linked servers, credentials, and databases, that the job relies on.</li></ul> |
| **Script the SQL Agent Job**   | <ul><li>Script the SQL Agent job on the SQL Server as a SQL script. You can do this by right-clicking the job in SQL Server Management Studio (SSMS) and selecting **"Script Job as" -> "CREATE To" -> "New Query Editor Window."**</li></ul> |
| **Modify job dependencies**    | <ul><li>Review the SQL script and modify any job dependencies that may have changed due to the migration. For example, if the job references a linked server or a file path on the local server, update it to match the new environment.</li></ul> |
| **Azure SQL MI job creation**   | <ul><li>Open SSMS or Azure Data Studio and connect to your Azure SQL Managed Instance.</li><li>Create a new SQL Agent job using the script you generated previously.</li></ul> |
| **Create dependencies on Azure SQL MI** | <ul><li>If your SQL Agent job relies on linked servers or credentials, create them in the Azure SQL MI environment. Ensure they match the configuration from the on-premises SQL Server.</li></ul> |
| **Schedule the job** | <ul><li>Set up the job schedule in Azure SQL MI using SQL Server Agent. You can create a new schedule and link it to the job.</li></ul> |
| **Testing** | <ul><li>Test the SQL Agent job thoroughly in the Azure SQL MI environment to ensure it runs as expected. Check for any errors or issues that may arise due to differences between on-premises SQL Server and Azure SQL MI.</li></ul> |
| **Monitoring and maintenance**  | <ul><li>Monitor the job's performance and ensure it continues to meet your requirements in the Azure SQL MI environment.</li><li>Adjust any configurations or schedules as needed.</li></ul> |
