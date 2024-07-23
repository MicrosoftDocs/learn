When a job runs, Windows PowerShell stores all command outputs in memory, starting with the first output that the command produced. You don't have to wait for a command to complete before output becomes available.

The job list indicates whether a job has stored results that you haven’t yet retrieved. Here's an example:

```powershell
PS C:\> Get-Job

Id     Name            PSJobTypeName   State         HasMoreData     Location
--     ----            -------------   -----         -----------     --------
13     Job13           BackgroundJob   Running       True            localhost

```

In this example, job ID 13 is still running, but the **HasMoreData** column indicates that results already have been stored in memory. To receive a job's results, use the **Receive-Job** command.

By default, job results are removed from memory after they're delivered to you. That means that you can use **Receive-Job** only once per job. Add the *–Keep* parameter to retain a copy of the job results in memory, so that you can retrieve them again.

If you retrieve the results of a parent job, you'll receive the results from all child jobs. You also can retrieve the results of a single child job or multiple child jobs.

You also can retrieve the results of a job that's still running. However, unless you specify *–Keep*, the job object’s results will be empty until the job’s command adds new output.

Here's an example:

```powershell
Receive-Job –ID 13 -Keep | Format-Table –Property Name,Length
```

