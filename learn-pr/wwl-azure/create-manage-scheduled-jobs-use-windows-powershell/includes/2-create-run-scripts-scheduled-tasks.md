Scheduled jobs are a combination of Windows PowerShell background jobs and Windows **Task Scheduler** tasks. Similar to background jobs, you define scheduled jobs in Windows PowerShell. Additionally, like tasks, job results are saved to disk, and scheduled jobs can run even if Windows PowerShell isn't running.

## Scheduled tasks

Scheduled tasks are part of the Windows core infrastructure components. Other Windows components and products that run on Windows extensively use scheduled tasks. They're generally simpler than scheduled jobs. The **Task Scheduler** enables you to configure a schedule for running almost any program or process, in any security context, triggered by various system events or a particular date or time.

However, scheduled tasks can't capture and manipulate task output. A scheduled task can run almost anything runnable on a Windows device, so it's impossible to anticipate and capture the scheduled task’s output. However, because a Windows PowerShell scheduled job is always a Windows PowerShell script, even if that script runs a non-Windows PowerShell program, the system is able to capture output. In this case, a Windows PowerShell object is returned at the end of the script block. A scheduled task consists of:

- The **Action**, which specifies the program to be run.
- The **Principal**, which identifies the context to use to run an action.
- The **Trigger**, which defines the time or system event that determines when the program is to be run.
- The **Additional settings**, which further configure the task and control how the action is run.

Commands that work with scheduled tasks are in the **ScheduledTasks** module that's included with Windows 10 and Windows Server 2019. To review the complete list of commands, run the following command:

```powershell
Get-Command –Module ScheduledTasks
```

As an example, check on the available scheduled tasks by running the **Get-ScheduledTask** command. This will list all available scheduled tasks, regardless of whether they're enabled or disabled.

Get information on a specific task by running **Get-ScheduledTask** with the *-TaskPath* parameter. For best practices, ensure that you put the actual path in quotes. Get further information about a particular task by using the **Get-ScheduledTaskInfo** command. You can then combine these commands using a pipeline to get additional information. For example, retrieve detailed information about the **Automatic Update** task running on your system by entering the following command:

```powershell
Get-ScheduledTask -TaskPath "\Microsoft\Windows\WindowsUpdate\" | Get-ScheduledTaskInfo
```

You also can create and run scheduled tasks from the **Task Scheduler**. However, what if you're running Windows PowerShell commands or scripts, or Windows tools that don't write their output to a file? If output is important to you, a better choice is using a Windows PowerShell scheduled job. After that job is in the **Task Scheduler**, you can manipulate it further. You can start or stop it in the **Task Scheduler**. If you want to create multiple scheduled jobs or tasks locally, or even on remote computers, automate their creation and maintenance with the scheduled job or the scheduled task commands.

Adding Windows PowerShell scripts as scheduled jobs in the **Task Scheduler** can greatly improve your productivity. PowerShell Gallery contains thousands of scripts that you can use or modify for your specific use, and these scripts are separated into various categories.

For example, there are hundreds of viable scripts that you can run against Active Directory Domain Services (AD DS) and other Active Directory services. Some of these scripts can be very useful. An example is the script that finds user accounts that haven't been used for more than 90 days and then disables them, which can help strengthen domain security. You can modify this script to your specific domain, and then create it as a scheduled job. After you configure this task, you can then find and manipulate the job in the **Task Scheduler**. Schedule it to run every week and provide a report about what accounts, if any, were disabled.

