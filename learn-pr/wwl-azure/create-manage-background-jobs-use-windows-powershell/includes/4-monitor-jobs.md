When you start a job, you're given a job object that enables you to monitor and manage the job.

## Job objects

Each job consists of at least two job objects. The parent job is the top-level object and represents the entire job, regardless of the number of computers to which the job connects. The parent job contains one or more child jobs. Each child job represents a single computer. A local job contains only one child job. Windows PowerShell remoting and WMI jobs contain one child job for each computer that you specify.

## Retrieving jobs

Run **Get-Job** to list all current jobs. You can list a specified job by adding the *–ID* or *–Name* parameter and specifying the desired job ID or job name. Retrieve child jobs by using the job ID. Here are examples:

```powershell
PS C:\> Get-Job

Id     Name            PSJobTypeName   State         HasMoreData     Location
--     ----            -------------   -----         -----------     --------
2      LocalDirectory  BackgroundJob   Running       True            localhost
4      TestScript      BackgroundJob   Completed     True            localhost
6      RemoteLogs      RemoteJob       Failed        True            LON-DC1...
10     Job10           WmiJob          Failed        False           localho...


PS C:\> Get-Job -Name TestScript

Id     Name            PSJobTypeName   State         HasMoreData     Location
--     ----            -------------   -----         -----------     --------
4      TestScript      BackgroundJob   Completed     True            localhost


PS C:\> Get-Job -ID 5

Id     Name            PSJobTypeName   State         HasMoreData     Location
--     ----            -------------   -----         -----------     --------
5      Job5                            Completed     True            localhost

```

Notice that each job has a state. Parent jobs always display the state of any failed child jobs, even if other child jobs succeeded. In other words, if a parent job contains four child jobs, and three of those jobs finished successfully but one failed, the parent job status will be **Failed**.

## Listing jobs

List the child jobs of a specified parent job by retrieving the parent job object and expanding its **ChildJobs** property. In Windows PowerShell 3.0 and newer, use the *-IncludeChildJobs* parameter of **Get-Job** to display a job’s child jobs. Here's an example:

```powershell
C:\PS>Get-Job -Name RemoteJobs -IncludeChildJobs
   
Id     Name            PSJobTypeName   State         HasMoreData     Location
--     ----            -------------   -----         -----------     --------
7      Job7                            Failed        False           LON-DC1
8      Job8                            Completed     True            LON-CL1
9      Job9                            Failed        False           LON-SVR1

```

The earlier method uses the following example:

```powershell
PS C:\> Get-Job -Name RemoteLogs | Select -ExpandProperty ChildJobs

Id     Name            PSJobTypeName   State         HasMoreData     Location
--     ----            -------------   -----         -----------     --------
7      Job7                            Failed        False           LON-DC1
8      Job8                            Completed     True            LON-CL1
9      Job9                            Failed        False           LON-SVR1

```

This technique enables you to discover the job ID numbers and names of the child job objects. Notice that child jobs all have a default name that corresponds with their ID number. The preceding syntax will work in Windows PowerShell 2.0 and newer versions.

## Job-management commands

Manage jobs by using several available Windows PowerShell commands. Pipe one or more jobs to each of these commands or specify jobs by using the *–ID* or *–Name* parameters. Both parameters accept multiple values, which means that you can specify a comma-separated list of job ID numbers or names. The job-management commands include:

- **Stop-Job**, which halts a job that's running. Use this command to cancel a job that's in an infinite loop or that has run longer than you want.
- **Remove-Job**, which deletes a job object, including any command results stored in memory. Use this command when you're finished working with a job, so the shell releases memory.
- **Wait-Job**, which you typically use in a script. It pauses script processing until the jobs you indicate reach the specified state. Use this command in a script to start several jobs, and then make the script wait until those jobs complete before continuing.

The Windows PowerShell process manages remote, WMI, and local jobs. When you close a PowerShell session, Windows PowerShell removes all jobs and their results, and you can no longer access them.

