Scheduled jobs combine Windows PowerShell background jobs and Windows **Task Scheduler** tasks. Like Task Scheduler tasks, scheduled jobs are saved to disk. Review and manage Windows PowerShell scheduled jobs in the **Task Scheduler**, enabling and disabling tasks or running the scheduled job. You can also use a scheduled job:

- As a template for creating other scheduled jobs.
- To establish a one-time or periodic schedule for starting jobs.
- To set conditions under which jobs start again.

Windows PowerShell saves the results of scheduled jobs to disk and creates a running log of job output. Scheduled jobs include a customized set of commands for creating, editing, disabling, and re-enabling scheduled jobs, job triggers, and job options.

To create a scheduled job, use the scheduled job commands. Anything created in **Task Scheduler** is considered a scheduled task, even if it's in the **Microsoft\\Windows\\PowerShell\\ScheduledJobs** path. After you create a scheduled job, review and manage it in the **Task Scheduler** by selecting a scheduled job to:

- Find the job triggers on the **Triggers** tab.
- Find the scheduled job options on the **General** and **Conditions** tabs.
- Review completed job instances on the **History** tab.

> [!NOTE]
> When you change a scheduled job setting in **Task Scheduler**, the change applies for all future instances of that scheduled job.

The commands that work with scheduled jobs in the **PSScheduledJob** module are included in the current versions of the Windows Server and Client operating systems.

> [!NOTE]
> The **PSScheduledJob** module is available in **Windows PowerShell 5.1 only**. It isn't included in PowerShell 7.x and can't be loaded via the PowerShell 7 compatibility layer. To use scheduled job cmdlets, ensure you're running `powershell.exe` (Windows PowerShell 5.1), not `pwsh.exe` (PowerShell 7).

To review the complete list of commands, run the following command:

```powershell
Get-Command –Module PSScheduledJob
```

Scheduled jobs consist of three components:

- The job itself defines the command that will run.
- Job options define options and running criteria.
- Job triggers define when the job will run.

You typically create a job option object and a job trigger object, and store those objects in variables. You then use those variables when creating the actual scheduled job.

> [!NOTE]
> The **ScheduledTasks** module includes commands that can manage all tasks in the Windows **Task Scheduler**. 

