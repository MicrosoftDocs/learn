Scheduled jobs are a combination of Windows PowerShell background jobs and Windows **Task Scheduler** tasks. Similar to background jobs, you define scheduled jobs in Windows PowerShell. Additionally, like tasks, job results are saved to disk, and scheduled jobs can run even if Windows PowerShell isn't running.

## Scheduled tasks

Scheduled tasks are part of the Windows core infrastructure components. Other Windows components and products that run on Windows extensively use scheduled tasks. They're generally simpler than scheduled jobs. The **Task Scheduler** enables you to configure a schedule for running almost any program or process, in any security context, triggered by various system events or a particular date or time.

Scheduled tasks can't capture and manipulate task output. A scheduled task can run almost anything on a Windows device, making it impossible to anticipate and capture its output. Because a Windows PowerShell scheduled job is always a Windows PowerShell script—even if that script runs a non-PowerShell program—it can capture output and return a Windows PowerShell object at the end of the script block. A scheduled task consists of:

- The **Action**, which specifies the program to run.
- The **Principal**, which identifies the context for running an action.
- The **Trigger**, which defines the time or system event that determines when the program runs.
- The **Additional settings**, which further configure the task and control how the action runs.

Commands that work with scheduled tasks are in the **ScheduledTasks** module that's included with Windows 11 and Windows Server 2022 and later. To review the complete list of commands, run the following command:

```powershell
Get-Command –Module ScheduledTasks
```

To check available scheduled tasks, run the **Get-ScheduledTask** command. This lists all scheduled tasks, regardless of whether they're enabled or disabled.

To get information on a specific task, run **Get-ScheduledTask** with the `-TaskPath` parameter. Always enclose the path in quotes. For more detail on a particular task, use **Get-ScheduledTaskInfo**. Combine these commands in a pipeline to get additional information. For example, to retrieve detailed information about the **Automatic Update** task on your system, enter the following command:

```powershell
Get-ScheduledTask -TaskPath "\Microsoft\Windows\WindowsUpdate\" | Get-ScheduledTaskInfo
```

You can also create and run scheduled tasks from the **Task Scheduler**. If you're running Windows PowerShell commands or scripts, or Windows tools that don't write output to a file, a Windows PowerShell scheduled job is a better choice. Once the job appears in the **Task Scheduler**, start, stop, or further manage it from there. To create multiple scheduled jobs or tasks locally or on remote computers, use the scheduled job or scheduled task commands to automate their creation and maintenance.

Adding Windows PowerShell scripts as scheduled jobs in the **Task Scheduler** improves your productivity. PowerShell Gallery contains thousands of scripts organized into categories that you can use or adapt for your needs.

For example, hundreds of scripts work with Active Directory Domain Services (AD DS) and other Active Directory services. One such script finds user accounts that haven't been used for more than 90 days and disables them, strengthening domain security. Modify the script for your domain, create it as a scheduled job, and schedule it to run weekly to generate a report on any disabled accounts. After configuration, manage the job in the **Task Scheduler**.

