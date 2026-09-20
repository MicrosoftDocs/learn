Run validation before cluster creation. Correct failures before enabling Storage Spaces Direct.

> [!NOTE]
> Clusters that haven't been validated aren't supported by Microsoft.

Prior to running validation, confirm every node has:

- Windows Server 2025 Datacenter edition.
- The same supported update level.
- Matching BIOS settings.
- Matching adapter firmware and drivers.
- Matching storage firmware.
- Stable DNS and time.
- Active Directory domain membership.
- Administrative remoting.
- The intended network addresses and VLANs.
- Empty eligible data drives.

## Install required features

Run from an elevated management session:

```powershell
$nodes = 'S2D01', 'S2D02', 'S2D03', 'S2D04'

Invoke-Command -ComputerName $nodes {
    Install-WindowsFeature -Name Failover-Clustering, Hyper-V `
        -IncludeManagementTools
}
```

Install `FS-FileServer` only on nodes used for the converged Scale-Out File Server scenario.

Restart nodes if feature installation requires it. Don't continue while a node has a pending restart.

## Inspect candidate drives

Use the following command to inspect eligible physical disks on every node:

```powershell
Invoke-Command -ComputerName $nodes {
    Get-PhysicalDisk |
        Sort-Object FriendlyName, SerialNumber |
        Format-Table FriendlyName, SerialNumber, MediaType,
            CanPool, CannotPoolReason, HealthStatus
}
```

Candidate drives must be healthy, visible through a supported controller, and free of needed data.

> [!WARNING]
> Drive-cleaning commands permanently remove partitions and data. This module doesn't provide a copy-ready cleaning pipeline. Identify every target by server, serial number, and slot. Confirm backups and authorization before erasure.

## Run cluster validation

Use the following command to run the required cluster validation tests:

```powershell
Test-Cluster -Node $nodes `
    -Include 'Storage Spaces Direct', 'Inventory',
        'Network', 'System Configuration'
```

Retain the report. Review warnings in context. Don't treat a successful command exit as proof that every test passed.

Reject or correct:

- Unsupported controllers.
- Inconsistent firmware or drivers.
- Network partition risk.
- Missing redundant paths.
- Drive-count mismatch.
- Existing storage metadata.
- Pending restarts.
- Domain or DNS failures.

Document any accepted warning with:

- Exact validation test.
- Technical cause.
- Microsoft or hardware-vendor support statement.
- Risk owner.
- Expiration or remediation date.

## Verify network behavior

Use the following commands to verify RDMA and SMB server interfaces on every node:

```powershell
Invoke-Command -ComputerName $nodes {
    Get-NetAdapterRdma
    Get-SmbServerNetworkInterface
}
```

After cluster traffic starts, verify active multichannel connections:

```powershell
Get-SmbMultichannelConnection
```

Validation doesn't replace workload testing. It confirms configuration supportability and detects known defects.

## Define acceptance criteria

Proceed only when:

- Required validation tests pass.
- Nodes are symmetric.
- Eligible drives match the design.
- Two storage paths are operational per node.
- RDMA behavior matches the selected transport.
- Quorum witness prerequisites are ready.
- Repair reserve is documented.
- Deployment rollback is approved.

## Deploy Storage Spaces Direct

Deployment creates the failover cluster, configures quorum, enables the Software Storage Bus, creates the pool, and configures cache.

### Create the cluster

Run from an elevated management system:

```powershell
$clusterName = 'S2D-CL01'
$nodes = 'S2D01', 'S2D02', 'S2D03', 'S2D04'

New-Cluster -Name $clusterName -Node $nodes -NoStorage
```

Use `-StaticAddress` when the cluster requires a static management address. Cluster-name DNS registration can take time. Use a node name for management if the new cluster name hasn't propagated.

Inspect the cluster before enabling storage:

```powershell
Get-Cluster -Name $clusterName
Get-ClusterNode -Cluster $clusterName
Get-ClusterNetwork -Cluster $clusterName
```

Every node must be `Up`. Cluster networks must have the intended role and reachability.

### Configure quorum

S2D clusters typically use an independent **SMB file-share witness** or **Azure cloud witness** for quorum. S2D pool disks can’t serve as a disk witness. A witness is especially important for even-node clusters and should reside outside the cluster’s failure domains.

Select the witness by topology:

- A two-node cluster requires a witness.
- An even-node cluster normally uses a witness.
- A campus witness must be in a third physical location.
- Restricted-connectivity environments can use a file-share witness.
- Connected environments can use a cloud witness when organizational policy permits it.

Before configuring the witness, create a share dedicated to this cluster rather than using a spare folder in an existing share. Protect the share's permissions and availability, and host it outside the cluster's failure domains.

The following example assumes a domain-joined Windows file-server witness. For a domain-joined Windows file-share witness, grant the cluster name object (CNO), or an Active Directory group containing it, the following permissions:

- **Share permissions:** Change and Read
- **File-system permissions:** Modify, Read & execute, List folder contents, and Read

Remove **Everyone** from the share permissions unless your organization requires it. The account that configures the witness also needs **Full Control** permission on the failover cluster; the CNO doesn't need Full Control on the share.

After the share and permissions are ready, use the following commands to configure and verify the file-share witness:

```powershell
Set-ClusterQuorum -Cluster $clusterName `
    -FileShareWitness '\\Witness01\Quorum$'

Get-ClusterQuorum -Cluster $clusterName
```
The witness share should be dedicated to the cluster rather than using a spare folder in an existing share. Protect the share's permissions and availability.

### Enable Storage Spaces Direct

Use the following command to enable Storage Spaces Direct on the cluster:

```powershell
Enable-ClusterStorageSpacesDirect -CimSession $clusterName
```

The cmdlet:

- Enables Storage Spaces Direct mode.
- Discovers eligible drives.
- Creates one cluster storage pool.
- Selects cache devices.
- Binds cache to capacity devices.
- Creates default storage tiers when applicable.

The operation can take several minutes. Don't interrupt it because progress appears idle.

### Verify the result

Use the following commands to verify the pool, disks, tiers, and storage jobs:

```powershell
Get-ClusterS2D

Get-StoragePool -CimSession $clusterName -IsPrimordial $false |
    Format-Table FriendlyName, HealthStatus, OperationalStatus,
        Size, AllocatedSize

Get-PhysicalDisk -CimSession $clusterName |
    Sort-Object FriendlyName, SerialNumber |
    Format-Table FriendlyName, SerialNumber, MediaType,
        Usage, HealthStatus, OperationalStatus

Get-StorageTier -CimSession $clusterName
Get-StorageJob -CimSession $clusterName
```

Expected state:

- One nonprimordial cluster pool is healthy.
- Cache devices report `Journal` usage where applicable.
- HDDs report automatic or capacity use.
- Default tiers match the media design.
- No unexpected storage job remains active.

### Record the deployment baseline

Capture:

- Validation report.
- Cluster configuration.
- Quorum mode.
- Physical disks by serial number.
- Pool state.
- Tier state.
- Adapter firmware and drivers.
- SMB interface inventory.
- Initial capacity.

This baseline is the comparison point for later incidents.
