Each active application pool in IIS runs one or more w3wp.exe worker processes. The **Worker Processes** feature in IIS Manager lets you observe them in real time.

1. In the Connections pane, select the **server node**.
1. In the Features View (IIS section), double-click **Worker Processes**.
1. The Worker Processes view displays:

- **Application Pool Name**
- **Process ID (PID)**
- **State**
- **CPU** and **Private Memory (KB)**

To view active requests:

1. Select a worker process in the list.
1. In the Actions pane, select **View Current Requests**.
1. The Requests view shows each in-flight HTTP request with its URL, client IP address, HTTP method, time elapsed (ms), and current pipeline stage.
This view is invaluable for diagnosing hung requests. A request that has been in a particular pipeline stage for an unusually long time indicates where processing is stalled.

To view the same information using PowerShell, run the following code:

```powershell
# List all running w3wp processes with resource usage
Get-Process w3wp | Select-Object Id, CPU, WorkingSet, ProcessName
# Correlate PIDs to application pool names using AppCmd
& "$env:windir\system32\inetsrv\appcmd.exe" list wp
# Query worker process details via CIM (preferred over deprecated Get-WmiObject)
Get-CimInstance Win32_Process -Filter "Name = 'w3wp.exe'" |
Select-Object ProcessId, WorkingSetSize, KernelModeTime, UserModeTime
```

## Configure IIS logging

IIS logging captures a record of every HTTP request. Correct logging configuration is foundational for security auditing, troubleshooting, and capacity planning.

The default log file location is `%SystemDrive%\inetpub\logs\LogFiles\W3SVC<SiteID>\`

`<SiteID>` is the numeric site identifier visible in IIS Manager (for example, `W3SVC1` for the Default Web Site).

To configure IIS logging, perform the following steps:

1. Select the site in the Connections pane.
1. Double-click **Logging** in the Features View.
1. Set:

    - **Format:** W3C (recommended)
    - **Directory:** Path for log files
    - **Log File Rollover:** Period (Daily recommended) or maximum file size

1. Select **Select Fields** to choose which W3C fields to log.
1. Select **Apply** in the Actions pane.

[![Screenshot of the IIS Logging feature page showing the Format dropdown set to W3C, the Directory field, the Log File Rollover section with Period set to Daily, and the Select Fields button.](../media/logging.png)](../media/logging.png#lightbox)

Recommended W3C fields for production logging include:

| Field | Description |
| --- | --- |
| date, time | Timestamp of the request |
| cs-method | HTTP method (GET, POST, etc.) |
| cs-uri-stem | Requested URL path |
| cs-uri-query | Query string (review for sensitive data before enabling) |
| sc-status | HTTP response status code |
| sc-substatus | Substatus (critical for diagnosing 500 errors) |
| sc-win32-status | Win32 error code |
| c-ip | Client IP address |
| cs(User-Agent) | Client browser/application identifier |
| time-taken | Request processing time in milliseconds |

To configure log fields for a site with PowerShell, run the following command:

```powershell
Set-WebConfigurationProperty `
-Filter "system.applicationHost/sites/site[@name='ContosoSite']/logFile" `
-Name logExtFileFlags `
-Value "Date,Time,ClientIP,UserName,SiteName,ServerIP,Method,UriStem,UriQuery,HttpStatus,Win32Status,SubStatus,TimeTaken,ServerPort,UserAgent,Referer"
```

To configure daily log rollover with PowerShell, run the following command:

```powershell
Set-WebConfigurationProperty `
-Filter "system.applicationHost/sites/site[@name='ContosoSite']/logFile" `
-Name period `
-Value "Daily"
```

## Review IIS log files

IIS W3C log files are plain-text, space-delimited files. Each begins with comment lines that identify the software version, date, and field names:

```text
#Software: Microsoft Internet Information Services 10.0
#Version: 1.0
#Date: 2026-04-01 00:00:01
#Fields: date time c-ip cs-username s-port cs-method cs-uri-stem sc-status sc-substatus sc-win32-status time-taken
2026-04-01 08:15:43 192.168.1.50 - 80 GET /index.html 200 0 0 134
2026-04-01 08:16:01 192.168.1.51 - 80 GET /missing.html 404 0 2 46
2026-04-01 08:16:45 192.168.1.52 - 80 GET /app/data 500 0 0 2341
```

The table lists common status codes to monitor:

| Status | Meaning | Recommended action |
| --- | --- | --- |
| 200 | Success | Normal |
| 301 / 302 | Redirect | Verify redirect rules are behaving as intended |
| 401 | Unauthorized | Check authentication configuration |
| 403 | Forbidden | Review NTFS permissions and request filtering rules |
| 404 | Not Found | Check file paths, handler mappings, and URL rewrite rules |
| 500 | Internal Server Error | Review substatus code and Application event log |
| 503 | Service Unavailable | Application pool is stopped, failed, or queue is full |

The following code allows you to perform a quick log analysis with PowerShell:

```powershell
# Get the most recent IIS log file for the Default Web Site
$logFile = Get-ChildItem "C:\inetpub\logs\LogFiles\W3SVC1" -Filter "*.log" |
Sort-Object LastWriteTime -Descending |
Select-Object -First 1
# Count requests by HTTP status code
Get-Content $logFile.FullName |
Where-Object { $_ -notlike "#*" } |
ForEach-Object { ($_ -split " ")[7] } |   # sc-status (index 7 per the #Fields line above)
Group-Object |
Sort-Object Count -Descending |
Format-Table Name, Count -AutoSize
# Top 10 most requested URL paths
Get-Content $logFile.FullName |
Where-Object { $_ -notlike "#*" } |
ForEach-Object { ($_ -split " ")[6] } |   # cs-uri-stem (index 6 per the #Fields line above)
Group-Object |
Sort-Object Count -Descending |
Select-Object -First 10 |
Format-Table Name, Count -AutoSize
# Find slow requests (> 3000 ms)
Get-Content $logFile.FullName |
Where-Object { $_ -notlike "#*" } |
ForEach-Object {
$f = $_ -split " "
if ([int]$f[-1] -gt 3000) { $_ }
}
```

> [!TIP]
> The field indexes used in these scripts (such as `[7]` for sc-status and `[6]` for cs-uri-stem) correspond to the specific `#Fields` line shown in the example log. If your IIS logging configuration includes different fields, adjust the indexes to match your log file's `#Fields` header.

## IISReset

iisreset.exe stops and restarts the Windows Process Activation Service (WAS), World Wide Web Publishing Service (W3SVC), and all worker processes simultaneously. This causes a brief service outage and drops all active connections.

Use IISReset only in the event:

- IIS configuration files were modified directly outside IIS Manager (for example, by a deployment script editing applicationHost.config) and the changes aren't reflected in IIS Manager
- IIS Manager is unresponsive or displaying stale state that survives a browser refresh
- No other targeted approach has resolved an unusual IIS service-level issue

Example IISReset commands include:

```cmd
REM Restart all IIS services
iisreset
REM Stop IIS services
iisreset /stop
REM Start IIS services
iisreset /start
REM Restart IIS on a remote server
iisreset <ServerName>
REM Restart with a custom timeout (seconds to wait before aborting)
iisreset /timeout:60
```

Alternatives to using IISReset include:

| Scenario | Preferred command |
| --- | --- |
| A single app pool is misbehaving | Restart-WebAppPool -Name "WebAppDescriptor" |
| A single site needs restarting | Stop-Website then Start-Website |
| Restart only the web service | Restart-Service W3SVC |

## Routine administration checklist

Consistent, scheduled maintenance prevents many common IIS issues.

You should consider performing the following tasks on a daily basis:

- Check site and application pool states (Get-Website / Get-ChildItem IIS:\AppPools)
- Review Application and System event logs for IIS-related errors (sources: IIS-W3SVC-WP, WAS)
- Scan IIS logs for unexpected spikes in 4xx or 5xx responses

You should consider performing the following tasks on a weekly basis:

- Review application pool recycling events in the System event log (source: WAS)
- Check IIS log directory disk usage and archive or delete old files as needed
- Verify all SSL certificates are healthy and at least 30 days from expiry

You should consider performing the following tasks on a monthly basis:

- Apply Windows Server patches (including IIS fixes) in a maintenance window
- Test restoration of the most recent AppCmd or PowerShell IIS configuration backup
- Review IIS module installations and remove any modules that are no longer required

The following PowerShell code is a basic automated daily health check script:

```powershell
Import-Module WebAdministration
Write-Host "=== IIS Health Check — $(Get-Date -Format 'yyyy-MM-dd HH:mm') ===" -ForegroundColor Cyan
# Site status
Write-Host "`n[Sites]"
Get-Website | ForEach-Object {
$colour = if ($_.State -eq "Started") { "Green" } else { "Red" }
Write-Host "  $($_.Name): $($_.State)" -ForegroundColor $colour
}
# Application pool status
Write-Host "`n[Application Pools]"
Get-ChildItem IIS:\AppPools | ForEach-Object {
$colour = if ($_.State -eq "Started") { "Green" } else { "Red" }
Write-Host "  $($_.Name): $($_.State)" -ForegroundColor $colour
}
# IIS log directory size
Write-Host "`n[Log Directory]"
$logRoot = "C:\inetpub\logs"
if (Test-Path $logRoot) {
$sizeGB = (Get-ChildItem $logRoot -Recurse -File |
Measure-Object Length -Sum).Sum / 1GB
Write-Host "  Total size: $([math]::Round($sizeGB, 2)) GB"
}
# WAS errors in the last 24 hours
Write-Host "`n[WAS Errors — Last 24 Hours]"
$events = Get-WinEvent -FilterHashtable @{
    LogName      = 'System'
    ProviderName = 'WAS'
    Level        = 2,3  # Error, Warning
    StartTime    = (Get-Date).AddHours(-24)
} -ErrorAction SilentlyContinue
if ($events) {
$events | Select-Object TimeGenerated, Message | Format-Table -AutoSize
} else {
Write-Host "  No WAS errors found." -ForegroundColor Green
}
```

## IIS High availability

For IIS servers where downtime isn't acceptable, consider the following architectural patterns:

- **Windows Network Load Balancing (NLB):** Distributes incoming HTTP/HTTPS requests across multiple IIS servers. All nodes must run identical IIS configurations and serve identical web content. You can also use load balancers made by organizations other than Microsoft rather than relying on Windows NLB.
- **IIS Shared Configuration:** Stores applicationHost.config on a shared network path (UNC path) so all nodes in a web farm read from a single authoritative configuration. Changes made on one server are immediately effective on all nodes.

To implement the shared configuration, use the following script to copy the relevant config files to a location accessible to each node:

```powershell
# Copy the IIS configuration files to a shared UNC path
Copy-Item "$env:SystemRoot\System32\inetsrv\config\applicationHost.config" -Destination "\\FILESERVER\IISConfig\"
Copy-Item "$env:SystemRoot\System32\inetsrv\config\administration.config" -Destination "\\FILESERVER\IISConfig\"
Copy-Item "$env:SystemRoot\System32\inetsrv\config\redirection.config" -Destination "\\FILESERVER\IISConfig\"
```

Then on each node, in IIS Manager:

1. Server node > Features View > **Shared Configuration**
1. Check **Enable shared configuration** and point to the UNC path.

**Content synchronization:** Use shared storage (such as an SMB-mounted Azure Files share) to ensure web content is consistent across all nodes.

> [!NOTE]
> Full NLB and web farm implementation is outside the scope of this IIS-focused module. Refer to Windows Server documentation on Network Load Balancing for detailed deployment guidance.
