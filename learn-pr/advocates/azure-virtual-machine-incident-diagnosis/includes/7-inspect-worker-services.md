Both VMs sent heartbeats after `10:00 UTC`, but neither shows a new completion in the workspace. To answer the order desk without relying on log delivery, the engineer checks ContosoLinuxA's journal for a completion the filter may have excluded and ContosoWinSrvB's service history for a worker stop.

Use a management connection that doesn't depend on AMA: approved private SSH for Linux or RDP for Windows, directly or through Azure Bastion. Keep public administrative access closed. If the guest is unreachable, boot diagnostics can provide startup evidence, not proof that an order completed.

On either OS, distinguish the Azure VM Agent, which manages extensions inside the guest, from AMA, which collects monitoring data. A successful extension installation proves neither that AMA downloaded the current rule nor that a completion reached the workspace. Record the guest OS, agent versions, associated rules, and workspace ID.

First establish whether this stream ever worked. If it did, compare the current configuration with the last known good one. If not, check OS and agent support, whether the intended event exists locally, and whether the DCR is in the workspace's region. If provisioning failed, have the deployment owner check regional availability, resource-provider registration, and quota. Those checks explain a resource that never became available, not a gap in a stream that was healthy yesterday.

## Linux: check service state with systemd and find worker events in the journal

The following read-only Bash commands illustrate checks on a systemd-based Linux VM with rsyslog and AMA. `systemctl` asks the service manager about a process; `journalctl -u` reads entries about a service, while `journalctl -t` finds messages from a particular application tag. Substitute the actual service, tag, and incident times. Use approved guest privileges where journal or agent log access requires them.

```bash
unit=order-worker.service
tag=order-worker
start='2026-11-14 09:45:00 UTC'
end='2026-11-14 10:15:00 UTC'
systemctl show "$unit" rsyslog.service azuremonitoragent.service \
  --property=Id,ActiveState,SubState
journalctl -u "$unit" --since "$start" --until "$end" --utc --no-pager
journalctl -t "$tag" --since "$start" --until "$end" --utc --no-pager -o verbose
```

Find the entry with the chosen completion ID. In verbose journal output, `SYSLOG_IDENTIFIER=order-worker`, `SYSLOG_FACILITY=1` and `PRIORITY=4` are the tag, `user` facility and Warning severity. If the fields are missing, check how the worker emits the message and which rsyslog ruleset handles that input. Neither the tag nor the word "warning" in a message establishes its priority. Inputs bound to a nondefault ruleset can bypass AMA's default forwarding rule.

`systemctl` shows **current** state. For a past stop, use the service journal and unit settings to distinguish an unexpected exit from a schedule or runtime limit. If the worker maintains a health file, `stat` shows when it last changed; the contents tell you which completion it represents.

If local events are current but central records are missing, inspect the agent's cached configuration and recent errors. These are common Linux AMA paths; check the installed version if they differ:

```bash
sudo ls -lt /etc/opt/microsoft/azuremonitoragent/config-cache/configchunks/
sudo cat /var/opt/microsoft/azuremonitoragent/log/mdsd.err | less
```

Use the listing to locate and read the matching configuration chunk; compare the facilities, levels and destination with the intended DCR. File times don't establish when a filter became effective. In DCR JSON, the portal minimum **Warning** for `user` corresponds to `logLevels` of `["Warning","Error","Critical","Alert","Emergency"]`; `["Warning"]` alone excludes more severe events. Preserve the selection for any other facilities sharing the source entry. Never edit the cache. In the error log, find the incident interval using its recorded time zone; consult retained rotated logs if necessary. The latest lines alone might cover a different interval.

If the event qualified, distinguish a delayed upload from a dropped message:

- **Before AMA receives it:** inspect the installed rsyslog forwarding action, its queue and the rsyslog journal for the incident interval. If AMA can't receive, rsyslog can buffer messages for later forwarding.
- **After AMA receives it:** when upload fails, AMA can queue selected events under `/var/opt/microsoft/azuremonitoragent/events`. On a default installation, `df -h /var/opt/microsoft/azuremonitoragent/events` shows free space on the filesystem holding that queue. A no-space persistence error in `mdsd.err` means a write failed. Events can also be lost at the agent's effective cache quota even if the filesystem has space.

A nonempty queue proves neither loss nor delivery of a specific ID. After connectivity returns, preserve the original incident search. If the known ID is absent, search the same VM, worker and table again over the plausible upload period. Adjust **both** the portal time picker and the KQL bounds. If filtering on `ingestion_time()`, use a wider `TimeGenerated` range covering the relevant source and receipt times. Compare the payload's corroborated `source_utc`, `_TimeReceived`, approximate ingestion time and the time you observed the row. A delayed copy proves delivery of the old occurrence. Follow a *different* ID emitted after repair to show fresh delivery. Don't clear either queue to test it. Unlike a buffered event, a warning excluded by the DCR won't be replayed when the filter is restored.

## Windows: check worker status and inspect the Application and System logs

In Event Viewer, **Windows Logs > Application** contains this provider's completions. **Windows Logs > System** can contain service transitions from **Service Control Manager**. You don't need to forward the System log to read it locally. Equivalent read-only PowerShell checks are shown below. Substitute the installed service name, provider, Event ID, and incident interval:

```powershell
$worker = Get-Service -Name 'OrderWorker'
$worker | Select-Object Name, DisplayName, Status
Get-Service -Name 'EventLog'
Get-Process -Name 'MonAgentCore'

$start = ([datetimeoffset]'2026-11-14T09:45:00Z').UtcDateTime
$end   = ([datetimeoffset]'2026-11-14T10:15:00Z').UtcDateTime
$app = @{ LogName='Application'; ProviderName='OrderWorker'; Id=4100
          StartTime=$start; EndTime=$end }
Get-WinEvent -FilterHashtable $app |
    Select-Object @{n='Utc';e={$_.TimeCreated.ToUniversalTime()}}, ProviderName, Id, Level, RecordId, Message

$scm = @{ LogName='System'; ProviderName='Service Control Manager'; Id=7031,7034,7036
          StartTime=$start; EndTime=$end }
Get-WinEvent -FilterHashtable $scm |
    Where-Object { $_.Properties[0].Value -eq $worker.DisplayName } |
    Select-Object @{n='Utc';e={$_.TimeCreated.ToUniversalTime()}}, Id, Message
```

`Get-Service` reports the worker's state now; a matching System record can establish when it stopped or terminated. The absence of a transition record doesn't establish that the service stayed up. `MonAgentCore` is an AMA process, not the application. In the Application results, check for provider `OrderWorker`, ID `4100` and Information (`Level=4`). "No events were found" means no retained local record matched; access denied or an invalid query means you couldn't perform the check.

If Application is readable in Event Viewer but collection never worked, or stopped when the log was relocated, inspect its backing file:

```powershell
Get-WinEvent -ListLog Application | Select-Object LogName, IsEnabled, LogFilePath
```

AMA supports Windows Event Log files on local disk only. If `LogFilePath` points to a network share, including a UNC path, record the unsupported location and refer it to the Windows owner. A valid XPath doesn't make that source supported. Don't move the live file, change its permissions or start forwarding the System log to test it.

If the event exists locally but not in the workspace, distinguish a **downloaded DCR** from the **event subscription AMA applied**. Under `C:\WindowsAzure\Resources\AMADataStore.<VM-name>`, `mcs\configchunks` shows the downloaded configuration. Open `mcs\mcsconfig.lkg.xml` read-only and look for a `Subscription` whose query selects the local Application event. If it's missing or different, inspect the agent diagnostics under `Configuration` in that data store and the extension logs under `C:\WindowsAzure\Logs\Plugins\Microsoft.Azure.Monitor.AzureMonitorWindowsAgent`. Don't edit the files. Record when you observed the subscription, not when you assume it took effect. A fresh matching workspace row confirms delivery.

## Confirm that a local event represents a newly completed order

For either OS, match the VM and the same `event_id` locally and in the workspace. For example, `event_id=ContosoLinuxA-1842 seq=6 source_utc=2026-11-14T10:05:50Z status=complete` identifies one emission. Its workspace copy proves delivery. It doesn't by itself prove a business transaction committed. The worker's counter can reset, and its health file shows local activity unless its update is part of the business commit. On Windows, `RecordId` is local to a log and `Id=4100` identifies an event type; neither is an order key.

Ask the order owner for two sets of stable order keys: orders already outstanding when the incident began, including work in flight, and orders accepted during the interval. Use the application's due time or processing expectation to identify which were due by the UTC cutoff; keep not-yet-due orders separate. Map retries and reassignments to the original key. For each due order, record the authoritative outcome as of the cutoff: committed, pending, failed or unknown.

For example, an order the Windows worker claimed at `09:59:55Z`, due at `10:01Z`, belongs in the assessment even if its worker stopped before logging a completion. A later commit by the Linux worker settles that order; it doesn't show the Windows worker resumed. Two deliveries for order A still refer to one order. Don't resubmit it because a log was missing. If the opening backlog, assignment history or order results are unavailable, report what you could reconcile and give the order owner the remaining keys or gap.

Inspect downloaded settings as evidence, not as an editing interface. Compare their source selection and destination with the approved DCR. Make authorized corrections to the DCR, not its local cache. Don't share entire configurations or identity material, and don't interpret an error-free log excerpt as proof of delivery.
