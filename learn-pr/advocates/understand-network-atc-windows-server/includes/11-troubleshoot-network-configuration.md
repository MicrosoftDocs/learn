Separate provisioning failures from external fabric failures and workload failures. The same symptom, such as slow storage, can originate in several layers.

Start with scope and affected nodes. Don't begin by deleting configuration.

## Use a consistent diagnostic sequence

Follow this order to preserve evidence and avoid unnecessary changes.

1. Identify the affected intent, repository, nodes, workload, and recent change.
1. Inspect current status and compare it with the expected-node inventory.
1. Confirm features, module availability, service state, restart requirements, and management access.
1. Correlate ATC events with adapter, driver, cluster, and switch observations.
1. Check bindings, VLANs, addresses, routes, QoS, and RDMA operation.
1. Test the actual workload path and its authentication.
1. Correct the cause, request a scoped retry when appropriate, and repeat acceptance checks.

A failed query isn't a successful health check. An empty result can mean the wrong repository, unavailable components, or no matching records.

## Discover events and service state

Discover the installed ATC-related services rather than assuming that restarting an arbitrary networking service is appropriate.

```powershell
Get-Service | Where-Object {
    $_.Name -match 'Network.*ATC' -or
    $_.DisplayName -match 'Network.*ATC'
} | Select-Object Name, DisplayName, Status

Get-Module -ListAvailable NetworkATC
Get-WindowsFeature -Name NetworkATC
```

If the expected service or module isn't available, resolve installation or servicing first. The service query is discovery, not a pass/fail assertion that accepts an empty list.

Discover the enabled event channels and then query the selected ATC channel over a bounded interval.

```powershell
$logs = @(Get-WinEvent -ListLog '*NetworkAtc*' -ErrorAction Stop |
    Where-Object IsEnabled)
$logs | Select-Object LogName, RecordCount

$logName = Read-Host 'Exact ATC LogName from the preceding output'
if ($logName -notin $logs.LogName) {
    throw 'Select an enabled ATC channel from the discovered names.'
}

Get-WinEvent -FilterHashtable @{
    LogName = $logName
    StartTime = (Get-Date).AddMinutes(-30)
} -ErrorAction Stop |
    Select-Object TimeCreated, Id, LevelDisplayName, Message
```

Correlate timestamps with node and intent names. If no events match, investigate the query interval and channel. Don't silently reinterpret a query error as evidence that the system is healthy.

## Recognize common failure patterns

The following matrix directs investigation without prescribing blanket cleanup.

| Error or symptom | Likely investigation | Safe response |
|---|---|---|
| `PhysicalAdapterNotFound` | Missing hardware or an alias mismatch | Correct readiness and naming on the affected node |
| `AdapterBindingConflict` | Existing vSwitch or protocol binding | Identify its dependents before a planned release |
| `ConflictingTrafficClass` | Existing DCB classes or competing QoS policy | Compare effective policy and hardware class capacity |
| `RDMANotOperational` | Unsupported/inbox driver, BIOS RDMA/SR-IOV settings, or adapter state | Correct the supported platform configuration |
| `InvalidIsolationID` | VLAN invalid for the selected RDMA technology | Use a valid VLAN and supported transport design |
| No status or no progress | Wrong scope, remoting, service state, or pending restart | Resolve the control-plane problem before fabric tuning |
| Provisioned intent, no RDMA traffic | Inactive workload, wrong SMB path, endpoint capability, or fabric mismatch | Inspect active connections and both endpoints |
| Management or guest failure | Wrong interface, address, guest VLAN, switch attachment, or trunk | Restore the intended path and ownership |
| Wrong storage source path | Routes, DNS registration, or overlapping address ranges | Correct addressing and routing deliberately |
| Migration failure | Network selection, transport, bandwidth, or authentication | Diagnose the actual clustered or standalone operation |
| Repeated configuration changes | Competing owner or unapplied intent update | Establish one authoritative configuration owner |
| Resources remain after removal | Intent removal wasn't resource teardown | Perform dependency-aware retirement |

For `AdapterBindingConflict`, unbinding the adapter can disconnect its workloads. For `ConflictingTrafficClass`, clearing every QoS class can affect unrelated services. The documented error identifies a conflict, not permission to destroy all existing configuration.

An apparently healthy RDMA adapter can still carry no RDMA workload traffic. The client might have selected another interface, the server might lack capability, or no relevant connection might be active.

## Trace a bounded reproduction

Use tracing when ordinary status and events don't explain the operation. Coordinate the reproduction and avoid collecting unrelated activity.

The following pattern ensures that tracing is stopped when the interactive reproduction ends or fails.

```powershell
Set-NetIntentTracing -ComputerName HV01 -ErrorAction Stop
try {
    $null = Read-Host 'Reproduce the approved operation, then press Enter'
}
finally {
    Set-NetIntentTracing -ComputerName HV01 -StopTracing -ErrorAction Stop
}
```

Use the trace destination and support-collection procedure applicable to the installed build. Don't assume that a particular archive path or support-bundle command exists.

Collect a time-bounded cluster log from an elevated interactive Windows PowerShell console on `HV01`. Use an existing restricted directory local to that node for the capture.

> [!IMPORTANT]
> The `Get-ClusterLog` command reference states that the cmdlet can't be run remotely without CredSSP authentication on the server computer. For this example, run the block locally rather than copying it into an ordinary `Enter-PSSession` or `Invoke-Command` session. The `-Cluster` and `-Node` parameters select the logs to collect, not where the PowerShell console runs. Don't broadly enable credential delegation or disable Credential Guard just to collect this log. If remote collection is required, use a separately approved authentication path for that environment.

Run the following command block in that local console. The capture-directory prompt refers to a directory on `HV01`.

```powershell
$capture = Read-Host 'Existing restricted cluster-log directory'
if (-not (Test-Path -LiteralPath $capture -PathType Container)) {
    throw 'The restricted capture directory must already exist.'
}
Get-ClusterLog -Cluster HVCL01 -Node HV01 -TimeSpan 15 `
    -UseLocalTime -Destination $capture -ErrorAction Stop
```

`-TimeSpan` is in minutes. Preserve the time-zone context when correlating logs collected from different systems.

## Retry after correction

A retry asks Network ATC to reapply configuration. It doesn't repair a missing driver, incorrect switch VLAN, or absent NIC.

After correcting the fault on `HV01`, retry the affected intent on that node.

```powershell
Set-NetIntentRetryState -ClusterName HVCL01 `
    -Name Storage -NodeName HV01 -Wait -ErrorAction Stop

Get-NetIntentStatus -ClusterName HVCL01 -Name Storage
```

The cluster retry requires a node name. Querying status for the cluster isn't the same operation as resetting retry state for a particular node.

If the error returns, preserve the new evidence and revisit the cause. Repeating retries indefinitely can hide a persistent defect behind activity.

## Prepare an escalation package

Include the following evidence when the issue requires hardware-vendor or Microsoft support.

- OS build, installed updates, NetworkATC module version, and relevant feature state.
- Intent and global configuration, with the affected nodes explicitly identified.
- Adapter aliases, device descriptions, driver/firmware versions, and physical-port mappings.
- Time-correlated status, ATC events, bounded traces, and cluster logs.
- Relevant VLAN, MTU, DCB, QoS, addressing, route, and endpoint observations.
- The workload symptom, reproduction steps, expected behavior, and recent changes.

Review the package for sensitive internal information before sharing it through an approved support channel. A configuration export can disclose topology even when it contains no credentials.
