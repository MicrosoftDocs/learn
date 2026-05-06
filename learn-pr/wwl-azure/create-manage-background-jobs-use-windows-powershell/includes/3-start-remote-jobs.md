You start each of the three type of jobs, namely local, remote, and Common Information Model (CIM)/Windows Management Instrumentation (WMI), in a different way. The following sections describe specific methods for calling each job type.

## Local jobs

Start local jobs by running **Start-Job**. Provide either the *–ScriptBlock* parameter to specify a single command line or a small number of commands. Provide the *–FilePath* parameter to run an entire script on a background thread.

By default, jobs receive a sequential job identification (ID) number and a default job name. You can't change the assigned job ID number, but you can use the *–Name* parameter to specify a custom job name. Custom names make it easier to retrieve a job and identify it in the job list.

> [!NOTE]
> At first, job ID numbers might not seem to be sequential. However, you'll learn the reason for this later in this module.

You can specify the *–Credential* parameter to run a job under a different user account. Other parameters allow you to run the command under a specific Windows PowerShell version, in a 32-bit session, and in other sessions.

Here are examples of how to start local jobs:

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

Start Windows PowerShell remote jobs by running **Invoke-Command**. This is the same command that sends commands to a remote computer. Add the *–AsJob* parameter to make the command run in the background. Use the *–JobName* parameter to specify a custom job name. All other parameters of **Invoke-Command** are used in the same way. Here's an example:

```powershell
PS C:\> Invoke-Command -ScriptBlock { Get-WinEvent -LogName System -MaxEvents 10 }
-ComputerName LON-DC1,LON-CL1,LON-SVR1 -AsJob -JobName RemoteLogs

Id     Name            PSJobTypeName   State         HasMoreData     Location
--     ----            -------------   -----         -----------     --------
6      RemoteLogs      RemoteJob       Running       True            LON-DC1...

```

> [!NOTE]
> The *–ComputerName* parameter is a parameter of **Invoke-Command**, not of **Get-WinEvent**. The parameter causes the local computer to coordinate the Windows PowerShell remote connections to the three computers specified. Each computer receives only the **Get-WinEvent** command and runs it locally, returning results. **Get-WinEvent** is the modern replacement for the deprecated **Get-EventLog** cmdlet and uses `-MaxEvents` instead of `-Newest`.

The computer on which you run **Invoke-Command** creates and manages remote jobs. You can refer to that computer as the *initiating computer*. The commands inside the job are transmitted to remote computers, which then run them and return results to the initiating computer. The initiating computer stores the job’s results in its memory.

## CIM and WMI jobs

To use CIM commands in a job, you must launch the job with **Start-Job**. Here's an example:

```powershell
PS C:\> Start-Job  -ScriptBlock {Get-CimInstance -ClassName Win32_ComputerSystem}

Id     Name  PSJobTypeName  State   HasMoreData  Location   Command                  
--     ----  -------------  -----   -----------  --------   -------                  
3      Job3  BackgroundJob  Running True         localhost  Get-CimInstance -Class..

```

You also can run other commands that use CIM as jobs by using **Start-Job**. An example is **Invoke-CimMethod**.
The fact that CIM commands don't have an *–AsJob* parameter isn't important. You just need to remember to use the job commands when you want to run CIM commands as jobs.

> [!NOTE]
> The older `Get-WmiObject -AsJob` pattern is supported in Windows PowerShell 5.1 but `Get-WmiObject` has been superseded by `Get-CimInstance` since PowerShell 3.0. For new scripts, use `Start-Job` with `Get-CimInstance` as shown in the CIM example above.

## Job objects

Notice that each of the preceding examples results in a job object. It represents the running job, and you can use it to monitor and manage the job.

