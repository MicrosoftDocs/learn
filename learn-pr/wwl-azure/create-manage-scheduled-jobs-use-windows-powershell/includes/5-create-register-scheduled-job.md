Use **Register-ScheduledJob** to create and register a new scheduled job. Specify any of the following parameters:

- *–Name* is required and specifies a display name for the job.
- *–ScriptBlock* is required and specifies the command or commands that the job runs. You also could specify *–FilePath* and provide the path and name of a Windows PowerShell script file that the job will run.
- *–Credential* is optional and specifies the user account that will be used to run the job.
- *–InitializationScript* accepts an optional script block. The command or commands in that script block will run before the job starts.
- *–MaxResultCount* is optional and specifies the maximum number of result sets to store on disk. After this number is reached, the shell deletes older results to make room for new ones. The default value for the *-MaxResultCount* parameter is 32.
- *–ScheduledJobOption* accepts a job option object.
- *–Trigger* accepts a job trigger object.

To register a new job by using an option object in `$opt` and a trigger object in `$trigger`, use the following example:

```powershell
PS C:\> $opt = New-ScheduledJobOption -WakeToRun

PS C:\> $trigger = New-JobTrigger -Once -At (Get-Date).AddMinutes(5)

PS C:\> Register-ScheduledJob -Trigger $trigger -ScheduledJobOption $opt -ScriptBlock { Dir C:\ } -MaxResultCount 5 -Name "LocalDir"

Id         Name            JobTriggers     Command       Enabled   
--         ----            -----------     -------        -------   
1          LocalDir        1                Dir C:\        True

```

Windows PowerShell registers the resulting job in the Windows **Task Scheduler** and creates the job definition on disk. Job definitions are XML files stored in your profile folder in **\\AppData\\Local\\Microsoft\\Windows\\PowerShell\\ScheduledJobs.**

You can run **Get-ScheduledJob** to review a list of scheduled jobs on the local computer. If you know a scheduled job’s name, you can use **Get-JobTrigger** and the *–Name* parameter to retrieve a list of that job’s triggers.
