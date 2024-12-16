Scheduled jobs are a useful combination of Windows PowerShell background jobs and Windows **Task Scheduler** tasks. Similar to the latter, scheduled jobs are saved to disk. You can review and manage Windows PowerShell scheduled jobs in the **Task Scheduler**, enabling and disabling tasks or simply running the scheduled job. You can even use the scheduled job:

- As a template for creating other scheduled jobs.
- To establish a one-time schedule or periodic schedule for starting jobs.
- To set conditions under which jobs start again.

> [!NOTE]
> You can do all of these tasks from the **Task Scheduler**.

Windows PowerShell saves the results of scheduled jobs to disk and creates a running log of job output. Scheduled jobs have a customized set of commands that you can use to manage them. You can use these commands to create, edit, manage, disable, and re-enable scheduled jobs, job triggers, and job options.

To create a scheduled job, use the scheduled job commands. Note that anything created in **Task Scheduler** is considered a scheduled task even if it's in the **Microsoft\\Windows\\PowerShell\\ScheduledJobs** path in the **Task Scheduler**. After you create a scheduled job, review and manage it in the **Task Scheduler** by selecting a scheduled job to:

- Find the job triggers on the **Triggers** tab.
- Find the scheduled job options on the **General** and **Conditions** tabs.
- Review the job instances that have already been run on the **History** tab.

> [!NOTE]
> When you change a scheduled job setting in **Task Scheduler**, the change applies for all future instances of that scheduled job.

The commands that work with scheduled jobs in the **PSScheduledJob** module are included in the current versions of the Windows Server and Client operating systems. To review the complete list of commands, run the following command:

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

