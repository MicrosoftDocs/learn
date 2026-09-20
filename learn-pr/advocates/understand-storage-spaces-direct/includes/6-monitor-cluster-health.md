Monitoring must expose loss of redundancy before a second fault occurs. Collect health, capacity, performance, drive reliability, repair state, and network-path state.

## Establish a baseline

Capture a baseline:

- After deployment.
- After every firmware or driver change.
- After adding drives or nodes.
- After changing network configuration.
- After changing volume layout.

Record enough detail to compare healthy behavior with an incident.

## Read Health Service faults

Use the following commands to retrieve Health Service faults and reports:

```powershell
Get-HealthFault
Get-StorageHealthAction

Get-StorageSubSystem |
    Get-StorageHealthReport

Get-StorageSubSystem |
    Debug-StorageSubSystem
```

Prioritize faults by:

1. Data availability.
1. Loss of redundancy.
1. Repair blockage.
1. Capacity risk.
1. Performance degradation.

Don't clear a fault merely to remove an alert. Correct the cause and confirm that health converges.

## Inspect each storage layer

Use the following commands to inspect each storage layer:

```powershell
Get-PhysicalDisk |
    Format-Table FriendlyName, SerialNumber, MediaType, Usage,
        HealthStatus, OperationalStatus

Get-StoragePool -IsPrimordial $false |
    Format-Table FriendlyName, HealthStatus, OperationalStatus,
        Size, AllocatedSize

Get-VirtualDisk |
    Format-Table FriendlyName, ResiliencySettingName,
        ProvisioningType, HealthStatus, OperationalStatus,
        DetachedReason

Get-Volume
Get-ClusterSharedVolumeState
```

Interpret status combinations. `Healthy` with a transient operational state can be less urgent than a virtual disk reporting lost redundancy. Use current state documentation rather than guessing from one property.

## Monitor repair

Use the following command to monitor active storage jobs:

```powershell
Get-StorageJob |
    Format-Table Name, JobState, PercentComplete,
        BytesProcessed, BytesTotal, ElapsedTime
```

Watch:

- Percent completion.
- Throughput.
- Repeated restarts.
- Jobs waiting for free capacity.
- Workload latency during repair.

A slow repair can be caused by capacity pressure, another fault, network loss, overloaded HDDs, or workload contention.

## Monitor capacity

Use the following commands to monitor physical pool usage and virtual-disk allocation:

```powershell
$pool = Get-StoragePool -IsPrimordial $false

$pool |
    Select-Object FriendlyName, Size, AllocatedSize,
        @{Name='FreeBytes'; Expression={$_.Size - $_.AllocatedSize}}

Get-VirtualDisk |
    Select-Object FriendlyName, ProvisioningType,
        Size, FootprintOnPool
```

For thin volumes, track:

- Logical size.
- Current pool footprint.
- Growth rate.
- Pool free space.
- Expansion lead time.

Trigger action before repair headroom is consumed.

## Monitor drive reliability

Use the following command to collect available drive reliability counters:

```powershell
Get-PhysicalDisk |
    Get-StorageReliabilityCounter |
    Format-Table DeviceId, Temperature, Wear,
        ReadErrorsTotal, WriteErrorsTotal, PowerOnHours
```

Trend values. One sample can't reveal deterioration.

## Monitor performance

Start performance history if it isn't running:

```powershell
Start-ClusterPerformanceHistory
```

Query cluster history:

```powershell
Get-ClusterPerformanceHistory
```

Query a specific volume:

```powershell
Get-Volume -FileSystemLabel 'VirtualMachines01' |
    Get-ClusterPerformanceHistory
```

Track:

- Read and write IOPS.
- Read and write throughput.
- Average and tail latency.
- CPU cost.
- Queue depth.
- Cache behavior.
- Repair throughput.

Measure steady state and failure state. A design that meets latency targets only when fully healthy lacks operational margin.

## Monitor storage paths

Use the following commands to inspect SMB Multichannel connections and RDMA state:

```powershell
Get-SmbMultichannelConnection
Get-NetAdapterRdma
```

Confirm:

- Multiple active paths.
- Expected interface speed.
- RDMA use on intended paths.
- No silent fallback that increases CPU cost.

If Network ATC manages the host, use its status commands and documentation as a separate diagnostic source.

## Define thresholds

Create actionable thresholds for:

- Pool free capacity.
- Thin-provisioned growth.
- Volume latency.
- Missing SMB paths.
- Drive temperature or wear.
- Repair duration.
- Lost redundancy.

Every alert needs an owner, evidence query, immediate action, escalation condition, and closure condition.
