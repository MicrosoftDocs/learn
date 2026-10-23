A Hyper-V host is a control plane for its VMs. Its policy must protect that control plane without blocking the components that start, move, protect, and recover workloads.

Use a dedicated host configuration. Don't turn the host into an administrative workstation or install unrelated software merely to simplify policy authoring.

## Inventory the complete host workload

The required trust boundary extends beyond `vmms.exe`. VM worker processes, management components, drivers, and third-party integrations execute through different paths.

Use this inventory to discover dependencies that a single VM-start test would miss.

| Component | Why it matters | Representative evidence |
| --- | --- | --- |
| Hyper-V services and worker processes | Create and operate VMs | VM start, stop, restart, and management operations. |
| Virtual-switch extensions and networking | Carry management, storage, migration, and guest traffic | Network connectivity and extension operation. |
| NIC, HBA, storage, and filter drivers | Support boot and workload I/O | Restart, storage access, sustained I/O, and driver servicing. |
| Failover Clustering components | Coordinate clustered roles and node state | Node drain, migration, failover, and resume. |
| Backup and restore agents | Protect and recover host/guest workloads | Application-consistent backup and an isolated restore rehearsal. |
| Monitoring, EDR, and management agents | Detect issues and deliver approved changes | Agent health, remote management, and an approved update. |
| Hardware management/update tools | Service firmware and devices | A representative approved update workflow. |
| Recovery tools | Repair a policy or workload failure | Independent console access and a tested recovery path. |

Different hardware generations can require different drivers and vendor utilities. One host's audit evidence isn't automatically representative of every cluster node.

## Establish a baseline

Run read-only inventory before and after the policy change. On the host, these commands report basic Hyper-V state.

```powershell
$ErrorActionPreference = 'Stop'
Import-Module Hyper-V
Get-Service -Name vmms
Get-VM | Select-Object Name, State, Status
Get-VMSwitch | Select-Object Name, SwitchType
```

On a clustered host with the FailoverClusters module, use an explicit 5.1 worker for node and role inspection. Microsoft's PowerShell 7 compatibility matrix doesn't establish native compatibility for this module. Return inspection records rather than carrying live cluster objects between runtimes.

```powershell
$ErrorActionPreference = 'Stop'
$winPS51 = New-PSSession -UseWindowsPowerShell
try {
    Invoke-Command -Session $winPS51 -ScriptBlock {
        $ErrorActionPreference = 'Stop'
        Import-Module FailoverClusters
        Get-ClusterNode | Select-Object Name, State
        Get-ClusterGroup | Select-Object Name, State,
            @{Name = 'OwnerNode'; Expression = { $_.OwnerNode.Name }}
    } | Format-List *
} finally {
    Remove-PSSession -Session $winPS51
}
```

Running services and online VMs are necessary but insufficient. Existing processes can continue after a policy update while a newly launched helper or replacement driver is blocked.

## Validate standalone and clustered operation

A standalone host has no automatic capacity to absorb its workloads during maintenance. Arrange a supported migration destination or an approved outage before any required restart.

A cluster provides mobility, not immunity to policy failure. The destination node must allow the code needed to run and manage the arriving VM. Validate source and destination behavior in both directions.

The following tests expose different policy risks.

| Test | Pass condition | Policy risk exposed |
| --- | --- | --- |
| Create and operate a test VM | Creation, start, stop, and guest restart complete normally | Missing service or worker-process dependencies. |
| Restart the host | Host and required services recover | Boot-critical drivers and policy activation. |
| Live-migrate in both directions | VM remains available and manageable | Destination dependencies or inconsistent node policy. |
| Drain and resume a node | Roles move as expected and node rejoins safely | Cluster tooling, agents, and remaining capacity. |
| Fail over a representative workload | Role starts on the alternate node | Rarely exercised launch paths. |
| Back up and restore a test VM | Backup and isolated restore complete | Backup executables, plug-ins, scripts, and recovery tooling. |
| Update a driver or agent | Installation and post-update workload tests pass | New files, signers, versions, or generated helpers. |

Don't derive CI path allowances from Hyper-V antivirus exclusions. Allowing every executable under a VM-storage directory isn't necessary to permit VHDX access and can create a broad execution exception.

## Roll out one host at a time

For the fictional cluster, `HV25-01` is the canary and `HV25-02` provides validated remaining capacity. These names are examples, not a recommendation to use a two-node design for every environment.

Use this operational sequence:

1. Confirm cluster health, quorum, capacity, and independent management access.
1. Verify that the destination host's effective policies support the workloads to be moved.
1. Drain the canary using the approved cluster-maintenance procedure and verify role ownership.
1. Apply the approved policy release to the canary.
1. Perform any required restart and confirm policy identity, version, and active state.
1. Run the host, management, migration, networking, storage, and backup tests.
1. Resume the node without causing an unplanned bulk failback.
1. Proceed to the next node only after the workload owner approves the evidence.

If the management agent is blocked, don't assume it can deploy its own repair. Stop expansion and use the independent console or another previously approved path.

## Handle a host-agent update

Suppose HostAgent 5.3 introduces `MigrationHelper.dll`. The existing FilePublisher rule covers `HostAgent.exe` from version 5.2 onward, but it doesn't necessarily cover a new DLL with a different file identity.

Capture the failed helper load, correlate its signatures, and verify the file against the approved package. Add a specific rule through the workload supplement, preserve that supplement's ID, increment its version, and repeat migration tests.

Don't replace the scoped rule with a publisher-wide allow merely because both files share a signer. Don't attempt to repair an explicit deny by adding another supplemental allow.

A host carrying domain controller VMs is identity-critical. Its management, storage, backup, and recovery administrators can affect the directory infrastructure. Protect the host accordingly while retaining independent App Control policies inside the domain controller guests.
