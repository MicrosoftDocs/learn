Your Network ATC-managed network must meet workload requirements during normal operation and continue providing acceptable service when a path fails. For a Hyper-V cluster, that means evaluating storage throughput and latency, live-migration behavior, and the availability of management and VM connections. This section explains how to establish a representative baseline, confirm that RDMA carries active traffic, interpret bandwidth reservations and limits, and safely assess a single-path failure. Use the results to decide whether both normal and degraded operation meet the design's acceptance criteria.

Performance assessment tests a hypothesis. Resilience assessment tests a failure boundary. Neither is satisfied by a successful provisioning record.

Measure a representative workload and keep the conditions comparable.

## Establish a baseline

Collect enough evidence to distinguish host-network behavior from storage and endpoint limits.

| Measure | What it helps explain |
|---|---|
| Throughput | Delivered transfer rate, not nominal link speed |
| Latency | Workload responsiveness and congestion effects |
| CPU use | Transport, compression, queuing, or offload cost |
| Migration duration | Whether the selected transport and policy meet operational needs |
| SMB connections and RDMA counters | Which paths carry the active traffic |
| Adapter errors and discards | Possible physical or congestion-related problems |

Control cache state, data size, file-service capacity, competing load, and test duration. A cached copy isn't directly comparable to a storage-bound copy. A slow backing store can cap throughput while the network remains healthy.

Inspect adapter statistics while collecting the workload measurements.

```powershell
Get-NetAdapterStatistics -Name pNIC03,pNIC04 -CimSession HV01,HV02
Get-SmbMultichannelConnection -IncludeNotSelected -CimSession HV01,HV02
```

Interpret errors and discards alongside switch counters and timing. A single cumulative count without a before/after interval doesn't show whether the current test caused it.

## Prove RDMA use

`Get-NetAdapterRdma` reports interface configuration and capability. To demonstrate use, observe active SMB connections and RDMA counters during traffic.

On an English-language host, discover available SMB Direct counters and sample the active RDMA byte counters.

```powershell
$counterSet = Get-Counter -ListSet 'SMB Direct Connection' `
    -ErrorAction Stop
$paths = @($counterSet.PathsWithInstances | Where-Object {
    $_ -match 'Bytes RDMA (Read|Written)/sec$'
})
if ($paths.Count -eq 0) {
    throw 'No matching active RDMA counters were found. Check the workload.'
}
Get-Counter -Counter $paths -SampleInterval 2 -MaxSamples 10 `
    -ErrorAction Stop
```

Counter names can be localized. Use the names returned on the target system. A nonzero RDMA rate during the relevant transfer is stronger evidence than administrative enablement alone.

Don't disable RDMA on managed production adapters just to create a comparison. Such a change affects ownership and workload availability as well as the measurement.

## Interpret bandwidth correctly

Two 25-Gbps ports don't guarantee 50 Gbps for a single flow. SET distributes traffic according to its teaming behavior. SMB Multichannel can create multiple connections. Storage endpoints, CPU, PCIe capacity, and switch congestion can still limit the result.

A QoS reservation isn't a hard cap. Unused capacity can be available to other traffic according to the scheduler and policy. Conversely, a reservation doesn't create capacity on a saturated upstream path.

SMB migration limits protect the shared SMB traffic class from migration consuming too much bandwidth. Judge the result by storage latency and migration duration together. Optimizing only the shortest migration can degrade the workloads being protected.

## Assess one-path failure safely

Use a disposable environment, an approved maintenance procedure, or captured results. Never disconnect an arbitrary production adapter to prove redundancy.

Follow this ordered assessment.

1. Identify exactly which physical path will fail and which workloads depend on it.
1. Confirm out-of-band access, endpoint redundancy, and sufficient surviving capacity.
1. Start a representative workload and record its baseline paths and measurements.
1. Introduce the approved single-path failure while observing connectivity and workload errors.
1. Restore the path and confirm interface, intent, and workload recovery.
1. Compare degraded and recovered behavior with the acceptance criteria.

Survival isn't the only result. Reduced throughput or increased latency might be expected, but it must remain within the service's operational requirements.

The following interpretation example uses qualitative observations, not captured benchmark data.

| Observation | Interpretation |
|---|---|
| Transfer continues through the surviving SMB path | The tested storage path has redundancy |
| Throughput falls within the surviving link's capacity | A degraded-state capacity effect, not necessarily an ATC fault |
| Guest connectivity fails while storage survives | The test exposed a different guest-network dependency |
| Restored link is up but unused | Recheck path selection and workload connections |
| All paths recover but latency remains high | Investigate remaining workload, endpoint, or congestion effects |

Retest management, guest connectivity, cluster communication, storage, and migration as applicable. A successful storage-path test doesn't certify every other traffic domain.
