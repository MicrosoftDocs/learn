Protection inspection asks whether usable recovery material exists and remains current. It doesn't authorize failover or establish application acceptance.

Collect three kinds of evidence: configuration, recent operations, and recovery results. Configuration shows what the system is intended to protect. Job history shows what the product attempted and completed. A restore exercise shows whether the retained state can actually support the required recovery outcome.

## Maintain protection coverage over time

Protection can drift into incomplete coverage as workloads change. A new VM might never enter a protection group, an added disk might be excluded, or a new database might use a different log policy. Existing jobs can continue to succeed while part of the business service is unprotected.

Compare your current workload inventory with the VMs, disks, and applications configured for protection in your backup product. Do this when you create a workload, after relevant changes, and at regular intervals. For each workload, confirm who owns its protection, what data is included, which local and offsite backup policies apply, and where it can be restored using a supported procedure.

An item can remain visible in the backup console because older recovery points are retained, even after new backups have stopped. Check that protection is still active, not just that the item appears in the console.

The following monitoring controls turn protection evidence into timely action.

| Signal | What to compare or observe | Required response |
| --- | --- | --- |
| Missing or changed coverage | Workload inventory against protected VMs, disks, and application data sources | Assign an owner to approve and enable supported protection or document an explicit exclusion |
| Aging recovery points | Age of the latest usable local and offsite application boundaries against their separate objectives | Warn early enough to investigate, escalate a breach, and record the affected recovery capability |
| Failed, delayed, or repeatedly retried jobs | Job history, expected completion time, and whether a complete recovery chain still exists | Resolve the cause and confirm a new usable point, not just a successful retry message |
| Replication backlog | Actual lag and usable recovery-point history against the intended RPO | Investigate change rate, connectivity, competing transfers, and destination performance |
| Repository or target capacity | Available space, growth, retention, and recovery workload headroom | Expand capacity or make an approved policy change before protection or recovery fails |
| Expiring access dependencies | Certificates, agent status, alert-delivery credentials, and emergency-access readiness | Renew and test the dependency before it prevents protection, notification, or recovery |
| Unexpected administrative changes | Protection stopped, data deleted, or retention reduced | Investigate the change and involve the security owner when appropriate |

Use both product-native and Azure views within their documented scope. In the MABS console, **Alerts**, **Jobs**, **Protection**, and **Management** expose different operational evidence. In Azure's MABS inventory, **Latest Recovery Point** refers to the latest disk point. Inspect item details for cloud points rather than interpreting that field as proof of current offsite protection.

Don't assume that Azure Backup's built-in job-failure alert coverage is identical for every workload. The documented built-in Azure Monitor support table includes MABS for backup-data deletion alerts, but doesn't list MABS/DPM for the same built-in backup- and restore-failure alerts available to some other workloads. Design job-failure notification through supported MABS mechanisms and confirm actual delivery. Historical Backup Reports aren't a substitute for timely operational alerts.

For the earlier policy example, a warning when the latest usable local point reaches eight minutes would leave little time before a ten-minute objective is breached. Decide whether that lead time is sufficient for your operators and automation. Monitor the offsite boundary separately, and test that notifications still reach the on-call team during the failures the plan is intended to handle.

Assign an on-call owner, escalation path, and acknowledgment expectation to each actionable alert. In MABS, **Alerts** identifies errors and warnings by protected computer or protection group, while **Jobs** shows the associated operation and progress. Use **Protection** to inspect schedules and data-source status, and **Management** to inspect agents and backup storage. Correlate these views before deciding whether a failure affects one item, an entire protection group, or the backup server. Close an alert only after confirming coverage and a usable recovery point.

Configure notification delivery separately from alert generation. MABS email settings are available through **Actions** > **Options** > **SMTP Server**. MABS V4 UR2 supports Microsoft 365 delivery through **OAuth (M365)**, using an approved Microsoft Entra application and authorized mailbox rather than a mailbox password. Protect and renew the application's client secret, and use **Send Test E-mail** to confirm delivery. For supported Azure Monitor alert categories, an action group defines notification recipients or automated actions, and alert-processing rules control routing. Seeing an alert in the portal doesn't prove that anyone was notified. Include an alternative escalation path when cloud authentication or email delivery is unavailable.

## Inspect an existing Hyper-V Replica relationship

Run the following read-only example in an authorized PowerShell session on the source host that owns the VM. It requires the Azure Local host's Hyper-V module and appropriate Hyper-V administrative rights. Replace `<VMName>` with the exact inventory name, removing the angle brackets.

The example inspects an existing Hyper-V Replica relationship. It doesn't inspect ASR or MABS protection.

```powershell
$ErrorActionPreference = 'Stop'
$relationship = @(Get-VMReplication -VMName '<VMName>')
if ($relationship.Count -ne 1) {
    throw 'Expected one existing replication relationship.'
}
$relationship |
    Select-Object VMName, State, Health, Mode, PrimaryServer, ReplicaServer
```

Expect one relationship with identity, state, health, direction, and server information. `Mode` helps distinguish the primary and replica roles. Compare the returned servers with the approved inventory so that you don't evaluate the wrong destination.

A missing relationship, unexpected state, warning, or critical health result requires investigation. Normal health doesn't establish application log replay, target network readiness, or access to destination identities. Inspect the product's replication statistics and recovery-point history to understand actual lag and usable recovery points.

If a relationship is ambiguous, don't select the first result and continue. Confirm the VM identity, host, and relationship scope with the protection owner.

## Inspect MABS jobs and recovery points

Use the management shell supplied with the approved MABS installation. This example assumes MABS V4 UR2 and authorized backup-administration access. MABS uses Data Protection Manager command names. Don't install an unrelated System Center module as a substitute for the commands shipped with MABS.

Before running the query, inspect the installed commands and their syntax. This read-only discovery also identifies the module or source and its version.

```powershell
Get-Command Get-DPMProtectionGroup, Get-DPMDatasource,
    Get-DPMJob, Get-DPMRecoveryPoint -ErrorAction Stop |
    Select-Object Name, Source, Version

Get-Command Get-DPMJob -Syntax -ErrorAction Stop
Get-Command Get-DPMRecoveryPoint -Syntax -ErrorAction Stop
```

Supply the real backup server and exact data source name from the approved inventory. In MABS, a *data source* is an object selected for protection, such as a VM or an application data set. The query fails if the name is missing or matches more than one object.

```powershell
$ErrorActionPreference = 'Stop'
$backupServer = Read-Host 'Approved MABS server name'
$sourceName = Read-Host 'Exact protected datasource name'
if ([string]::IsNullOrWhiteSpace($backupServer) -or
    [string]::IsNullOrWhiteSpace($sourceName)) {
    throw 'A backup server and exact datasource name are required.'
}

$groups = @(Get-DPMProtectionGroup -DPMServerName $backupServer)
$sources = @(foreach ($group in $groups) {
    Get-DPMDatasource -ProtectionGroup $group
})
$source = @($sources | Where-Object Name -eq $sourceName)
if ($source.Count -ne 1) {
    throw 'Datasource selection is missing or ambiguous.'
}

$until = Get-Date
Get-DPMJob -Datasource $source[0] `
    -From $until.AddDays(-1) -To $until

$points = @(Get-DPMRecoveryPoint -Datasource $source[0] -OnlyActive)
if ($points.Count -eq 0) {
    throw 'No active local recovery points were returned.'
}
$points
```

Expect job records and active local recovery-point objects. `-OnlyActive` filters out expired points. It doesn't select online points. The one-day job query is a bounded operational view, not a complete audit history, and the command can also limit the number of returned jobs. Use the supported reporting interface when a complete history is required.

If online protection is configured, run this separate query in the same shell after resolving `$source`. It explicitly requests online recovery points.

```powershell
$ErrorActionPreference = 'Stop'
$onlinePoints = @(
    Get-DPMRecoveryPoint -Datasource $source[0] -Online -OnlyActive
)
if ($onlinePoints.Count -eq 0) {
    throw 'No active online recovery points were returned.'
}
$onlinePoints
```

Confirm timestamps, status, consistency, source identity, and repository location in the product's restricted console. A local point doesn't prove that an online copy exists. An online listing doesn't prove that an alternate recovery operator can retrieve and decrypt it. Keep detailed inventory and job output in an approved evidence location rather than a public incident channel.

## Understanding backup reporting

The following examples show why backup reporting must be interpreted within the service's requirements.

| Observation | What it establishes | What it doesn't establish |
| --- | --- | --- |
| Backup job succeeded | The product completed that job's defined work | Application integrity or recovery within the RTO |
| A recent recovery point exists | A candidate retained state is available | That it predates corruption or includes every required disk |
| Replica health is normal | The configured relationship reports normal health | A guaranteed application RPO or a ready recovery network |
| Restored VM boots | The guest can start in that environment | User authentication, database integrity, or business acceptance |
| Azure Arc reports connected | A management connection is operating | Supported lifecycle management for every restored VM type |
