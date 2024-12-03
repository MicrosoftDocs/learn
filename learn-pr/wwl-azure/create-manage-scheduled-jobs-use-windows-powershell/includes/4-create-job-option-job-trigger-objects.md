To further configure jobs, you can use parameters for job options and define job triggers.

## Job options

Use **New-ScheduledJobOption** to create a new job option object. This command has several parameters that let you define options for the job, such as:

- *–HideInTaskScheduler*, which prevents the job from displaying in the **Task Scheduler**. If you don't include this option, the final job will display in the **Task Scheduler** graphical user interface (GUI).
- *–RunElevated*, which configures the job to run under elevated permissions.
- *–WakeToRun*, which wakes the computer when the job is scheduled to run.

Use other parameters to configure jobs that run when the computer is idle and other options. Many parameters correspond to options in the **Task Scheduler** GUI.

Create a new option object and store it in a variable by using the following command:

```powershell
$opt = New-ScheduledJobOption –RequireNetwork –RunElevated -WakeToRun
```

You don't need to create an option object if you don't want to specify any of its configuration items.

## Job triggers

A job trigger defines when a job will run. Each job can have multiple triggers. You create a trigger object by using the **New-JobTrigger** command. There are five basic types of triggers:

- *–Once* specifies a job that runs one time only. You can also specify a *–RandomDelay*, and you must specify the *–At* parameter to define when the job will run. That parameter accepts a System.DateTime object or a string that can be interpreted as a date.
- *–Weekly* specifies a job that runs weekly. You can specify a *–RandomDelay*, and you must specify both the *–At* and *–DaysOfWeek* parameters. *–At* accepts a date and time to define when the job will run. *–DaysOfWeek* accepts one or more days of the week to run the job. You'll typically use *–At* to specify a time and use *–DaysOfWeek* to define the days the job should run.
- *–Daily* specifies a job that runs every day. You must specify *–At* and provide a time when the job will run. You can also specify a *–RandomDelay*.
- *–AtLogOn* specifies a job that runs when the user logs on. This kind of job is similar to a logon script, except that it's defined locally rather than in the domain. You can specify *–User* to limit the user accounts that trigger the job, and *–RandomDelay* to add a random delay.
- *–AtStartUp* is similar to *–AtLogOn*, except that it runs the job when the computer starts. That typically runs the job before a user signs in.

For example, the following command creates a trigger that runs on Mondays and Thursdays every week, at 3:00 PM local time:

```powershell
$trigger = New-JobTrigger -Weekly -DaysOfWeek Monday,Thursday -At '3:00PM'
```

