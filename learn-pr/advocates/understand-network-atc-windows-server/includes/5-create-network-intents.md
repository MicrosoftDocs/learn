Treat intent creation as a controlled change to shared infrastructure. Readiness, scope, and recovery come before the command. Status inspection and workload acceptance follow it.

The commands in this unit are alternatives or separate stages. They aren't intended to be pasted into one unattended script.

## Discover the installed interface

Use the installed module to inspect the supported command and parameter sets.

```powershell
Import-Module NetworkATC -ErrorAction Stop
Get-Command -Module NetworkATC
Get-Command Add-NetIntent -Syntax
Get-Help Add-NetIntent -Detailed
```

The syntax distinguishes standalone, cluster, and global parameter sets. Don't add `-WhatIf` or `-Confirm` to a command unless its installed syntax supports them.

## Create the management/compute intent

Use prepared, unclaimed adapters and an approved management addressing design. Run this example from an elevated local session on a cluster node, or through the correctly configured remoting path. The mutation is cluster-wide.

```powershell
Add-NetIntent -ClusterName HVCL01 -Name HostVM `
    -Management -Compute -AdapterName pNIC01,pNIC02 `
    -ManagementVlan 10 -Wait -ErrorAction Stop

Get-NetIntentStatus -ClusterName HVCL01 -Name HostVM |
    Format-Table IntentName, Host, ProvisioningStatus, ConfigurationStatus
```

The roles request a switch supporting host management and VM connectivity. `-ManagementVlan 10` deliberately specifies the management VLAN. Without that override, Network ATC preserves the configured management VLAN by default.

Inspect every expected node and verify management access through the resulting interface. Stop if a node is missing, provisioning failed, or the management route changed unexpectedly. A returned command prompt isn't the acceptance gate.

## Create the separate storage intent

Create the storage intent only after confirming that the `HostVM` intent has been applied successfully on every cluster node and that host management access and VM network connectivity work as intended. Confirm that the planned storage VLANs (711 and 712), IP subnets, and physical switch configuration provide a path to the existing SMB file-service endpoints. After applying the storage intent, verify connectivity from each node over both storage paths before using them for workloads.

```powershell
Add-NetIntent -ClusterName HVCL01 -Name Storage `
    -Storage -AdapterName pNIC03,pNIC04 `
    -StorageVlans 711,712 -Wait -ErrorAction Stop

Get-NetIntentStatus -ClusterName HVCL01 -Name Storage
Get-NetIPAddress -InterfaceAlias pNIC03,pNIC04 -AddressFamily IPv4
```

Adapter ordering determines which storage VLAN Network ATC assigns to each adapter. It pairs the entries in `-AdapterName` with the entries in `-StorageVlans` by position. In this example, `pNIC03` uses VLAN 711 and `pNIC04` uses VLAN 712. Reversing the adapter order without also reversing the VLAN order swaps those assignments. If the assigned VLAN isn't carried by the adapter's physical switch port, that storage path can't reach its file-service endpoint. Keep adapter aliases, cabling, and VLAN assignments consistent with the design on every cluster node.

In this storage-only intent, Network ATC configures the dedicated physical adapters rather than storage vNICs on a Hyper-V virtual switch. Automatic storage IP addressing remains enabled unless overridden.

The `Get-NetIPAddress` command queries only the host on which it runs. The `-ClusterName HVCL01` parameter on the preceding status command doesn't change the scope of this separate command. Run the IP query on every cluster node, or add `-CimSession HV01,HV02` to query both nodes remotely by using Common Information Model (CIM) sessions.

For each node, compare the IPv4 address and subnet prefix length on both `pNIC03` and `pNIC04` with the approved storage addressing plan. The prefix length determines which addresses the host treats as being on the same subnet. Each address must be unique within its subnet, and any required routing must provide a path to the corresponding SMB file-service endpoint. Don't assume that automatically generated addresses are compatible with the existing file service's networks. Before moving workloads, test both storage paths from every node and confirm that traffic uses the intended storage interfaces rather than an alternative management route. A listed IP address alone doesn't prove connectivity.

## Fully converged alternative

The following declaration combines all three roles on a single adapter pair. Use it only in a separate prepared design, not on the pair already assigned to `HostVM`.

```powershell
Add-NetIntent -ClusterName HVCL01 -Name Converged `
    -Management -Compute -Storage -AdapterName pNIC01,pNIC02 `
    -ManagementVlan 10 -StorageVlans 711,712 `
    -Wait -ErrorAction Stop
```

The switch now carries guest traffic and host storage vNICs as well as management. The physical links are shared, so storage reservations and migration bandwidth policy become especially important.

## Standalone alternative

A standalone host uses local intent scope. The example below uses a different server with prepared adapters and no cluster membership.

```powershell
Add-NetIntent -ComputerName HVSTAND01 -Name HostVM `
    -Management -Compute -AdapterName pNIC01,pNIC02 `
    -ManagementVlan 10 -Wait -ErrorAction Stop

Get-NetIntentStatus -ComputerName HVSTAND01 -Name HostVM
```

The host receives local management/compute configuration. Cluster-global policy and cluster intent propagation aren't part of this operation. Joining a cluster later changes the applicable ownership model.

## Idempotent and repeatable execution

An idempotent operation can be repeated without an unintended additional change. For ATC automation, idempotence requires comparing desired values with the current intent and effective configuration. Merely finding an intent named `HostVM` doesn't establish that its adapters, roles, VLANs, or overrides are correct.

Inspect the complete intent object before building a projection for comparison.

```powershell
$intent = Get-NetIntent -ClusterName HVCL01 -Name HostVM `
    -ErrorAction Stop
$intent | Get-Member
$intent | Format-List *
```

Retain the unformatted object for logic. Formatting cmdlets produce display records, not the configuration object you should compare or serialize.

Use a small desired-state record for the operation you intend to submit.

```powershell
$desired = @{
    ClusterName    = 'HVCL01'
    Name           = 'HostVM'
    AdapterName    = @('pNIC01', 'pNIC02')
    Management     = $true
    Compute        = $true
    ManagementVlan = 10
}

$desired.GetEnumerator() | Sort-Object Name
```

Map the returned intent properties to this record using the schema exposed by the installed module. Compare adapter membership, traffic roles, VLANs, and retained exceptions, not timestamps or display strings. Keep global settings in a separate comparison because they aren't named-intent properties.

Choose the next operation from the actual state.

| Observed condition | Response |
|---|---|
| Intent absent, prerequisites satisfied | Submit the approved creation parameters |
| Intent and effective state already match | Make no mutation and retain the evidence |
| Supported setting differs | Apply a scoped update and verify it |
| Adapter or role membership differs | Use the relevant update command after impact review |
| Intent exists but provisioning failed | Correct the cause, then retry |
| Caller timed out or lost connectivity | Query actual state before deciding whether to resubmit |

Use `-ErrorAction Stop` for operations whose failure invalidates the next step. Don't catch an exception merely to continue. A timeout can occur after the change was accepted, so an automatic repeat can create ambiguity rather than recovery.

`-Wait` simplifies an interactive walkthrough. Production orchestration also needs a bounded observation period and an explicit expected-node list. The validation unit shows a polling pattern that doesn't treat empty output as success.
