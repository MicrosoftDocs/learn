In this module, you learned about scheduled jobs. The following are the key takeaways:

- Scheduled jobs are a combination of Windows PowerShell background jobs and Windows Task Scheduler tasks. Similar to background jobs, you define scheduled jobs in Windows PowerShell. 

- Scheduled tasks are part of the Windows core infrastructure components.

- Scheduled jobs are a useful combination of Windows PowerShell background jobs and Windows Task Scheduler tasks. Similar to the latter, scheduled jobs are saved to disk. You can review and manage Windows PowerShell scheduled jobs in the Task Scheduler, enabling and disabling tasks or simply running the scheduled job.

- Use **New-ScheduledJobOption** to create a new job option object. 

- A job trigger defines when a job will run. You create a trigger object by using the **New-JobTrigger** command. 

- Use **Register-ScheduledJob** to create and register a new scheduled job.

- Use the **Receive-Job** command to get a scheduled job's results.
