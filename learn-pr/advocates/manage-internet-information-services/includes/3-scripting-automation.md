Windows Server 2025 provides two primary command-line tools for managing IIS: the **WebAdministration** PowerShell module and **AppCmd.exe**. The WebAdministration module exposes IIS configuration through a navigable PowerShell drive (IIS:\\) and a rich set of cmdlets, letting you create and configure sites, application pools, and bindings entirely from the command line. AppCmd.exe offers a lightweight alternative for quick queries and configuration backup and restore operations. Together, these tools let you automate routine IIS tasks, from bulk site provisioning to scheduled application pool recycling, so you can manage servers consistently and at scale.

The **WebAdministration** module ships with IIS on Windows Server 2025. It provides:

- A **PowerShell provider** (IIS:\) that exposes IIS configuration as a navigable drive, similar to the registry (HKLM:\) or the file system (C:\)
- A set of **cmdlets** for common IIS operations (New-Website, Remove-WebAppPool, Get-WebBinding, and others)

To work with the module, run the following code:

```powershell
# Import the module (required before use in a new session)
Import-Module WebAdministration
# Verify it loaded and list available cmdlets
Get-Command -Module WebAdministration
```

You use the module with the IIS provider located at IIS:\Sites. The following examples show how to view information about IIS:

```powershell
# List all websites
Get-ChildItem IIS:\Sites
# List all application pools
Get-ChildItem IIS:\AppPools
# Browse the contents of a specific site
Get-ChildItem 'IIS:\Sites\Default Web Site'
# View all properties of a site object
Get-Item 'IIS:\Sites\Default Web Site' | Select-Object *
```

The following code shows how to create a new application pool and configure it to use the .NET CLR version 4.0. It then creates a new website called ContosoSite and assigns the newly created application pool to that site:

```powershell
# Create a new application pool
New-WebAppPool -Name "ContosoPool"
# Set the .NET CLR version (use "" for .NET Core / no managed code)
Set-ItemProperty IIS:\AppPools\ContosoPool `
-Name managedRuntimeVersion -Value "v4.0"
# Set identity to ApplicationPoolIdentity (recommended)
Set-ItemProperty IIS:\AppPools\ContosoPool `
-Name processModel.identityType -Value 4
# Create the website
New-Website -Name "ContosoSite" `
-PhysicalPath "C:\inetpub\ContosoSite" `
-HostHeader "contoso.internal" `
-Port 80 `
-ApplicationPool "ContosoPool"
# Confirm the site is running
Get-Website -Name "ContosoSite" | Select-Object Name, State, PhysicalPath
```

Once the site is created, you can manage it with the `Website` PowerShell cmdlets:

```powershell
# Start and stop a website
Start-Website -Name "ContosoSite"
Stop-Website  -Name "ContosoSite"
# Remove a website and its application pool
Stop-Website     -Name "ContosoSite"
Remove-Website   -Name "ContosoSite"
Remove-WebAppPool -Name "ContosoPool"
```

You can configuring site settings with Set-ItemProperty and Set-WebConfigurationProperty. For example to change a site's path, disable directory browsing, and add a default document entry, run the following code:

```powershell
# Change a site's root physical path
Set-ItemProperty 'IIS:\Sites\ContosoSite' `
-Name physicalPath -Value "D:\WebContent\Contoso"
# Disable directory browsing on a site (recommended for production)
Set-WebConfigurationProperty `
-Filter "/system.webServer/directoryBrowse" `
-PSPath "IIS:\Sites\ContosoSite" `
-Name enabled -Value $false
# Add a default document entry
Add-WebConfiguration `
-Filter "//defaultDocument/files" `
-PSPath "IIS:\Sites\ContosoSite" `
-Value @{value = "default.aspx"}
```

To configure application pool recycling with PowerShell, run the following code:

```powershell
# Schedule a recycle at 03:00 AM daily (replaces any existing schedule entries)
$pool = Get-Item IIS:\AppPools\ContosoPool
$pool.recycling.periodicRestart.schedule.Clear()
$pool.recycling.periodicRestart.schedule.Add("03:00:00")
$pool | Set-Item
# Disable time-based recycling interval (0 = off)
Set-ItemProperty IIS:\AppPools\ContosoPool `
-Name recycling.periodicRestart.time -Value "00:00:00"
# Recycle when private memory exceeds 1 GB
Set-ItemProperty IIS:\AppPools\ContosoPool `
-Name recycling.periodicRestart.privateMemory -Value 1048576  # KB
# Confirm settings
Get-ItemProperty IIS:\AppPools\ContosoPool -Name recycling.periodicRestart
```

To manage bindings with PowerShell, run the following code:

```powershell
# List all bindings for a site
Get-WebBinding -Name "ContosoSite"
# Add an HTTPS binding with SNI enabled (SslFlags 1)
New-WebBinding -Name "ContosoSite" `
-Protocol "https" `
-Port 443 `
-HostHeader "contoso.internal" `
-SslFlags 1
# Assign a certificate to the HTTPS binding
$cert = Get-ChildItem Cert:\LocalMachine\My |
Where-Object { $_.Subject -like "*contoso.internal*" }
$binding = Get-WebBinding -Name "ContosoSite" -Protocol "https"
$binding.AddSslCertificate($cert.Thumbprint, "My")
# Remove a binding
Remove-WebBinding -Name "ContosoSite" -Protocol "http" -Port 80
```

## Bulk configuration with PowerShell

A common production task is applying the same setting across all sites. For example, you might disable directory browsing server-wide or create a fleet of sites from a CSV file.

To apply a setting to all sites, customize the following code to your needs:

```powershell
Import-Module WebAdministration
foreach ($site in Get-Website) {
Set-WebConfigurationProperty `
-Filter "/system.webServer/directoryBrowse" `
-PSPath "IIS:\Sites\$($site.Name)" `
-Name enabled -Value $false
Write-Host "Directory browsing disabled: $($site.Name)"
}
```

You can also provision multiple sites from a CSV file (The CSV should have columns: Name, PhysicalPath, HostHeader, Port, AppPool):

```powershell
Import-Module WebAdministration
$sites = Import-Csv -Path "C:\Scripts\sites.csv"
foreach ($s in $sites) {
if (-not (Test-Path "IIS:\AppPools\$($s.AppPool)")) {
New-WebAppPool -Name $s.AppPool
}
if (-not (Test-Path $s.PhysicalPath)) {
New-Item -ItemType Directory -Path $s.PhysicalPath | Out-Null
}
New-Website -Name $s.Name `
-PhysicalPath $s.PhysicalPath `
-HostHeader $s.HostHeader `
-Port $s.Port `
-ApplicationPool $s.AppPool
Write-Host "Created: $($s.Name)"
}
```

## Using AppCmd.exe

**AppCmd.exe** (%SystemRoot%\System32\inetsrv\appcmd.exe) is the native IIS command-line management tool. It's valuable for:

- Quick ad-hoc queries at a command prompt
- Configuration backup and restore operations
- Scripting in environments where loading a PowerShell module is undesirable

AppCmd.exe uses the following syntax:

```text
appcmd <command> <object-type> [options]
```

Common object types include: site, app, vdir, apppool, config, backup, request, wp

The following code bloch has a list of AppCmd command examples:

```cmd
REM List all sites and their states
%windir%\system32\inetsrv\appcmd list site
REM List all application pools
%windir%\system32\inetsrv\appcmd list apppool
REM List running worker processes
%windir%\system32\inetsrv\appcmd list wp
REM List currently executing HTTP requests
%windir%\system32\inetsrv\appcmd list requests
REM Create a site
%windir%\system32\inetsrv\appcmd add site ^
/name:"ContosoSite" ^
/physicalPath:"C:\inetpub\ContosoSite" ^
/bindings:"http/*:80:contoso.internal"
REM Start and stop a site
%windir%\system32\inetsrv\appcmd start site /site.name:"ContosoSite"
%windir%\system32\inetsrv\appcmd stop  site /site.name:"ContosoSite"
REM Recycle an application pool
%windir%\system32\inetsrv\appcmd recycle apppool /apppool.name:"ContosoPool"
REM Set an app pool to No Managed Code (.NET Core)
%windir%\system32\inetsrv\appcmd set apppool ^
/apppool.name:"ContosoPool" /managedRuntimeVersion:""
```

AppCmd.exe provides a built-in backup mechanism for the core IIS configuration files: applicationHost.config, redirection.config, and administration.config. Always create a named backup before making significant configuration changes. The following code block provides examples of how to perform backup operations with AppCmd.exe:

```cmd
REM Create a named backup
%windir%\system32\inetsrv\appcmd add backup "PreChangeBackup"
REM List all available backups
%windir%\system32\inetsrv\appcmd list backup
REM Restore from a backup
%windir%\system32\inetsrv\appcmd restore backup "PreChangeBackup"
```

Backups are stored at: %SystemRoot%\System32\inetsrv\backup\<BackupName>\

To perform backups with PowerShell, use the Backup-WebConfiguration cmdlet. For example:

```powershell
# Backup
Backup-WebConfiguration -Name "PreChangeBackup"
# List backups
Get-WebConfigurationBackup
# Restore
Restore-WebConfiguration -Name "PreChangeBackup"
```

> [!TIP]
> Create a named backup before installing or removing IIS modules, migrating sites, making large-scale configuration changes, or applying Windows updates that affect IIS.

## Scheduling routine tasks with PowerShell

To configure a nightly application pool recycle at 2:00 AM, run the following PowerShell code:

```powershell
Register-ScheduledJob -Name "NightlyPoolRecycle" -ScriptBlock {
Import-Module WebAdministration
Restart-WebAppPool -Name "ContosoPool"
Write-EventLog -LogName Application -Source "MSIISAdmin" `
-EventId 1001 -EntryType Information `
-Message "ContosoPool recycled by scheduled task."
} -Trigger (New-JobTrigger -Daily -At "2:00 AM")
```

To configure a certificate expiry check that provides a warning 30 days in advance, run the following code:

```powershell
$threshold = (Get-Date).AddDays(30)
Get-ChildItem Cert:\LocalMachine\My |
Where-Object { $_.NotAfter -lt $threshold -and $_.NotAfter -gt (Get-Date) } |
ForEach-Object {
Write-Warning "Certificate '$($_.Subject)' expires $($_.NotAfter.ToString('yyyy-MM-dd'))"
# Add alerting logic here (event log, email, monitoring system)
}
```

To archive IIS log files older than 30 days, run the following code:

```powershell
$logPath     = "C:\inetpub\logs\LogFiles"
$archivePath = "D:\LogArchives\IIS"
$cutoff      = (Get-Date).AddDays(-30)
if (-not (Test-Path $archivePath)) {
New-Item -ItemType Directory -Path $archivePath | Out-Null
}
Get-ChildItem -Path $logPath -Recurse -Filter "*.log" |
Where-Object { $_.LastWriteTime -lt $cutoff } |
ForEach-Object {
$dest    = $_.FullName.Replace($logPath, $archivePath)
$destDir = Split-Path $dest -Parent
if (-not (Test-Path $destDir)) {
New-Item -ItemType Directory -Path $destDir | Out-Null
}
Move-Item -Path $_.FullName -Destination $dest
Write-Host "Archived: $($_.FullName)"
}
```
