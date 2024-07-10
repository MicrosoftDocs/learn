Because scheduled jobs can run when Windows PowerShell isn't running, results are stored on disk in XML files. If you create a job by using the *–MaxResultCount* parameter, the shell automatically deletes old XML files to make room for new ones. This deletion ensures that no more XML files exist than were specified in the *–MaxResultCount* parameter.

After a scheduled job finishes, running **Get-Job** in Windows PowerShell displays the scheduled job's results as a job object.

Here's an example:

```powershell
PS C:\> Get-Job

Id     Name      PSJobTypeName   State         HasMoreData     Location       Command
--     ----      -------------   -----         -----------     --------       -------
6      LocalDir  PSScheduledJob  Completed     True            localhost      Dir C:\

```

You can use **Receive-Job** to get a scheduled job's results. If you don't specify *–Keep*, you can receive a job's results only once per Windows PowerShell session. However, because the results are stored on disk, you can open a new Windows PowerShell session and receive the results again. For example:

```powershell
PS C:\> Receive-Job -id 6 -Keep


    Directory: C:\


Mode                LastWriteTime     Length Name                    
----                -------------     ------ ----                    
d----         7/26/2021  12:33 AM            PerfLogs                
d-r--        11/28/2021   1:54 PM            Program Files           
d-r--        12/28/2021   2:22 PM            Program Files (x86)     
d----        11/16/2021   9:33 AM            reports                 
d----         9/18/2021   7:28 AM            Review                  
d----          1/5/2022   7:49 AM            scr                     
d----          1/5/2022   7:50 AM            scrx                    
d-r--         9/15/2021   8:16 AM            Users                   
d----        12/19/2021   3:24 AM            Windows                 
-a---          1/1/2022   9:39 AM    2892628 EventReport.html        
-a---          1/2/2022  12:37 PM         82 Get-DiskInfo.ps1        
-a---        12/30/2021  12:33 PM        246 test.ps1

```

Each time the scheduled job runs, Windows PowerShell creates a new job object to represent the results of the most recent job that ran. You can use **Remove-Job** to remove a job and delete its results file from disk, as the following example depicts:

```powershell
PS C:\> Get-Job -id 6 | Remove-Job
```


