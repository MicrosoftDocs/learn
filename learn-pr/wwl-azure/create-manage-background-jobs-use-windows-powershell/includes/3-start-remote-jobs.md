You start each of the three job types—local, remote, and Common Information Model (CIM)/Windows Management Instrumentation (WMI)—differently.

## Local jobs

Start local jobs by running **Start-Job**. Use the `-ScriptBlock` parameter to specify a single command or a small set of commands, or use the `-FilePath` parameter to run an entire script on a background thread.

By default, jobs receive a sequential job identification (ID) number and a default job name. You can't change the job ID, but you can use the `-Name` parameter to specify a custom name. Custom names make it easier to retrieve and identify jobs.

> [!NOTE]
> At first, job ID numbers might not seem to be sequential. However, you'll learn the reason for this later in this module.

Use the `-Credential` parameter to run a job under a different user account. Other parameters let you run the command under a specific Windows PowerShell version, in a 32-bit session, or in other session configurations.

The following examples start local jobs:

```powershell
PS C:\> Start-Job -ScriptBlock { Dir C:\ -Recurse } -Name LocalDirectory

Id     Name            PSJobTypeName   State         HasMoreData     Location
--     ----            -------------   -----         -----------     --------
2      LocalDirectory  BackgroundJob   Running       True            localhost


PS C:\> Start-Job -FilePath C:\test.ps1 -Name TestScript

Id     Name            PSJobTypeName   State         HasMoreData     Location
--     ----            -------------   -----         -----------     --------
4      TestScript      BackgroundJob   Running       True            localhost

```

## Remote jobs

Start Windows PowerShell remote jobs by running **Invoke-Command**—the same cmdlet you use to send commands to remote computers. Add the `-AsJob` parameter to run the command in the background, and use the `-JobName` parameter to specify a custom job name. All other **Invoke-Command** parameters work the same way. Here's an example:

```powershell
PS C:\> Invoke-Command -ScriptBlock { Get-WinEvent -LogName System -MaxEvents 10 }
-ComputerName LON-DC1,LON-CL1,LON-SVR1 -AsJob -JobName RemoteLogs

Id     Name            PSJobTypeName   State         HasMoreData     Location
--     ----            -------------   -----         -----------     --------
6      RemoteLogs      RemoteJob       Running       True            LON-DC1...

```

> [!NOTE]
> The `-ComputerName` parameter belongs to **Invoke-Command**, not to **Get-WinEvent**. It causes the local computer to coordinate the Windows PowerShell remote connections to the three specified computers. Each computer receives only the **Get-WinEvent** command and runs it locally, returning results. **Get-WinEvent** is the modern replacement for the deprecated **Get-EventLog** cmdlet and uses `-MaxEvents` instead of `-Newest`.

The computer where you run **Invoke-Command** creates and manages remote jobs; this is the *initiating computer*. The initiating computer sends the commands to the remote computers, which run them and return the results. The initiating computer then stores those results in memory.

## CIM and WMI jobs

To use CIM commands in a job, you must launch the job with **Start-Job**. Here's an example:

```powershell
PS C:\> Start-Job  -ScriptBlock {Get-CimInstance -ClassName Win32_ComputerSystem}

Id     Name  PSJobTypeName  State   HasMoreData  Location   Command                  
--     ----  -------------  -----   -----------  --------   -------                  
3      Job3  BackgroundJob  Running True         localhost  Get-CimInstance -Class..

```

You can also run other CIM commands, such as **Invoke-CimMethod**, as background jobs by using **Start-Job**. CIM commands don't have an `-AsJob` parameter, so use **Start-Job** whenever you want to run CIM commands in the background.

> [!NOTE]
> The older `Get-WmiObject -AsJob` pattern is supported in Windows PowerShell 5.1 but `Get-WmiObject` has been superseded by `Get-CimInstance` since PowerShell 3.0. For new scripts, use `Start-Job` with `Get-CimInstance` as shown in the CIM example above.

## Job objects

Notice that each of the preceding examples results in a job object. It represents the running job, and you can use it to monitor and manage the job.

