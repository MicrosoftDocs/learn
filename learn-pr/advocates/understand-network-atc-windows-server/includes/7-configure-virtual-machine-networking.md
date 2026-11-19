The compute role creates host connectivity for VM traffic. It doesn't decide every guest network setting. Live migration adds another layer: network selection, transport, concurrency, bandwidth, and authentication must work together.

Keep host-owned and guest-owned settings distinct.

## Inspect switch and vNIC relationships

Discover the generated switch rather than constructing its name from the intent name.

```powershell
Get-VMSwitch
Get-VMSwitchTeam
Get-VMNetworkAdapter -ManagementOS
Get-VMNetworkAdapterVlan -ManagementOS
Get-VMNetworkAdapterTeamMapping -ManagementOS -Passthru
```

Correlate switch members with the physical aliases and intent. In the running design, the switch uses `pNIC01,pNIC02`. The dedicated storage adapters don't become VM uplinks.

In a fully converged design, host storage vNICs share the switch. Their team mappings associate storage interfaces with physical paths. A host vNIC is part of the management operating system. It isn't a guest vNIC.

Storage RDMA on the host doesn't automatically provide RDMA to an ordinary guest network adapter. Don't infer guest capability from a host-side SMB test.

## Attach an example VM

After Network ATC creates the compute switch, connect the VM's virtual network adapter to that switch so the VM can use the host's physical uplinks. Creating a compute intent doesn't automatically connect an existing VM or assign its workload VLAN. In this example, `App01` connects to the switch created for the `HostVM` intent and uses VLAN 120 for guest traffic. A switch with the same name and equivalent VLAN connectivity must be available on every node that can host the VM, so its network connection remains usable after live migration.

Use the verified switch name on both migration targets. The following commands inspect that prerequisite and then change `App01` on its current host, `HV01`.

```powershell
$switchName = Read-Host 'Verified ATC compute switch name'
Get-VMSwitch -ComputerName HV01,HV02 -Name $switchName `
    -ErrorAction Stop

Connect-VMNetworkAdapter -ComputerName HV01 -VMName App01 `
    -Name 'Network Adapter' -SwitchName $switchName -ErrorAction Stop

Set-VMNetworkAdapterVlan -ComputerName HV01 -VMName App01 `
    -VMNetworkAdapterName 'Network Adapter' -Access -VlanId 120 `
    -ErrorAction Stop

Get-VMNetworkAdapterVlan -ComputerName HV01 -VMName App01
```

Confirm the VM adapter name before applying the command. The example assumes an existing vNIC named `Network Adapter`.

The guest's access VLAN is 120. That setting isn't controlled by `-ManagementVlan` or `-StorageVlans`. The physical switch must carry the guest VLAN, and the guest must have an appropriate IP configuration.

## Cluster network and transport policy

Network ATC can name cluster networks according to their intended use, select live-migration networks, choose a migration transport, set migration concurrency, and limit SMB migration bandwidth.

The available transport choices address different bottlenecks.

| Transport | Behavior | Relevant tradeoff |
|---|---|---|
| TCP/IP | Transfers migration data over TCP | Straightforward transport without compression or SMB Direct benefits |
| Compression | Compresses migration data | Trades CPU work for lower network demand |
| SMB | Uses SMB transport, with Multichannel and RDMA when available | Depends on usable SMB paths and endpoint capability |

Network ATC calculates the default transport selection from the system configuration. It doesn't always choose SMB. Its documented migration-concurrency setting defaults to one and accepts values from one through ten. For clustered VM moves, verify the effective cluster limit rather than relying only on the host's migration setting.

The SMB bandwidth limit applies only when migration uses SMB. Increasing concurrency without reviewing storage contention and degraded capacity can make recovery worse rather than faster.

## Apply a global migration exception

The following cluster-wide exception requests SMB transport, a migration-concurrency setting of two, and an SMB migration bandwidth limit of 10 Gbps. These values illustrate the interface, not a universal tuning recommendation. The verification that follows must establish the effective policy before you accept the change.

```powershell
Get-NetIntent -ClusterName HVCL01 -GlobalOverrides |
    Format-List *

$migration = New-NetIntentGlobalClusterOverrides `
    -EnableVirtualMachineMigrationPerformanceSelection $false `
    -VirtualMachineMigrationPerformanceOption SMB `
    -MaximumVirtualMachineMigrations 2 `
    -MaximumSMBMigrationBandwidthInGbps 10

Set-NetIntent -ClusterName HVCL01 `
    -GlobalClusterOverrides $migration -Wait -ErrorAction Stop

Get-NetIntentStatus -ClusterName HVCL01 -GlobalOverrides
```

Disabling automatic performance selection makes the explicit transport choice meaningful. This example doesn't disable ATC's live-migration network selection. It also doesn't alter a named intent's adapter membership.

Verify the effective cluster, Hyper-V, and SMB settings after Network ATC has converged on every expected node.

```powershell
Get-Cluster -Name HVCL01 -ErrorAction Stop |
    Select-Object Name, MaximumParallelMigrations

Get-VMHost -ComputerName HV01,HV02 -ErrorAction Stop |
    Select-Object ComputerName, VirtualMachineMigrationPerformanceOption,
        MaximumVirtualMachineMigrations

Get-SmbBandwidthLimit -Category LiveMigration -CimSession HV01,HV02 `
    -ErrorAction Stop
Get-ClusterNetwork -Cluster HVCL01 -ErrorAction Stop
Get-ClusterNetworkInterface -Cluster HVCL01 -ErrorAction Stop
```

> [!NOTE]
> For clustered VM moves, the cluster property `MaximumParallelMigrations` takes precedence over the host's `MaximumVirtualMachineMigrations` setting. Its value limits the number of live migrations that each node can participate in. It isn't one total limit shared across all nodes of a larger cluster. For this two-node example, compare the effective cluster value with the requested value of two. A matching host value alone doesn't establish the effective cluster limit.

If the effective cluster value doesn't match the approved request, don't accept the concurrency change or begin a load test on that assumption. Inspect the global intent, its status, and the installed build's policy application. Resolve the discrepancy through the supported configuration owner rather than introducing a competing manual setting.

The override uses Gbps. The separate `Set-SmbBandwidthLimit -BytesPerSecond` interface uses bytes per second. Confusing these units produces a radically different cap. Don't manually change an ATC-owned setting through the other interface and expect that competing change to remain authoritative.

## Verify the selected migration networks

Transport, bandwidth, concurrency, and network selection are separate settings. `Get-ClusterNetwork` and `Get-ClusterNetworkInterface` show cluster networks and interfaces, but don't by themselves establish the live-migration exclusion policy or configured network order.

Run this read-only inspection from the elevated interactive console on `HV01`. It reads `HVCL01` explicitly and maps the cluster's migration exclusions to network names.

```powershell
$vmType = Get-ClusterResourceType -Cluster HVCL01 `
    -Name 'Virtual Machine' -ErrorAction Stop
$excludeParameter = @($vmType |
    Get-ClusterParameter -Name MigrationExcludeNetworks -ErrorAction Stop)
if ($excludeParameter.Count -ne 1) {
    throw "The cluster migration exclusion property couldn't be established."
}

$excludedIds = @(
    ([string]$excludeParameter[0].Value -split ';') |
        ForEach-Object { $_.Trim() } |
        Where-Object { $_ -ne '' }
)

$networks = @(Get-ClusterNetwork -Cluster HVCL01 -ErrorAction Stop)
if ($networks.Count -eq 0) {
    throw "No cluster networks were returned. Don't accept the migration policy."
}

$networks | Select-Object Name, ID, State, Role,
    @{Name = 'MigrationExclusion'; Expression = {
        if ([string]$_.ID -in $excludedIds) {
            'Excluded'
        }
        else {
            'Not explicitly excluded'
        }
    }}
```

An empty value in a successfully retrieved exclusion property means that no networks are explicitly excluded by that property. A missing property or failed query isn't the same result. "Not explicitly excluded" doesn't prove reachability, suitability, or use by the next migration.

On an authorized management system with Failover Cluster Manager installed, connect to `HVCL01`. Right-click **Networks** and select **Live Migration Settings**. Inspect the selected networks and their displayed order against the approved design, then close the dialog without saving changes. Don't infer an explicitly configured migration order from a list of cluster network metrics or substitute the standalone host's migration-network list.

This example leaves ATC's automatic live-migration network selection enabled. If the observed selection differs from the intended design, inspect the global intent and its status and resolve the discrepancy through the supported configuration owner. Don't use the dialog or `Set-ClusterParameter` to introduce a competing manual policy.

For SMB transport, also observe the active host-to-host SMB paths during the migration. Network eligibility is policy evidence, not proof of the interfaces that carried a particular workload.

## Authentication and security

Choosing SMB as the migration transport doesn't configure authentication or delegation. On eligible domain-joined Windows Server 2025 machines that aren't domain controllers, Credential Guard is enabled by default unless it was explicitly disabled. When Credential Guard is enabled, CredSSP can't use saved or single-sign-on credentials, although explicitly supplied credentials have different behavior. CredSSP-dependent live-migration workflows can fail in both standalone and clustered orchestration scenarios.

Inspect the configured host authentication method as part of diagnosing a migration failure:

```powershell
Get-VMHost -ComputerName HV01,HV02 -ErrorAction Stop |
    Select-Object ComputerName, VirtualMachineMigrationAuthenticationType
```

This query doesn't establish whether Credential Guard is running or whether Active Directory delegation is correctly configured. It also doesn't describe every management tool's authentication path.

For a workflow that requires delegation, coordinate an approved Kerberos constrained-delegation or resource-based constrained-delegation configuration with the identity administrator. Merely selecting Kerberos on the hosts doesn't configure the necessary directory permissions. Don't disable Credential Guard or broadly enable credential delegation to make a demonstration work.

> [!IMPORTANT]
> Authentication for the management command and authentication for host-to-host migration are separate concerns. The `Move-ClusterVirtualMachineRole` reference states that the cmdlet can't be run remotely without CredSSP authentication on the server computer. Changing Hyper-V's migration authentication method doesn't remove that command-specific requirement. Run this module's clustered migration example from an elevated interactive Windows PowerShell console on `HV01`, not by copying it into an ordinary remote PowerShell session. If you need remote orchestration, establish a separately approved authentication path for that tool and environment.

Clustered VM movement and standalone `Move-VM` workflows aren't interchangeable. Diagnose the operation you're actually performing. An authentication or delegation failure can occur even when the selected network is healthy.

Use trusted migration networks and the SMB signing or encryption policy required by the environment. SMB Direct can work with encryption on current Windows Server versions, but Network ATC alone doesn't establish the complete security policy.

## Observe a cluster migration

From an elevated interactive Windows PowerShell console on `HV01`, confirm that `App01` is the clustered VM role name, that `HV01` currently owns it, and that `HV02` has matching switch connectivity and storage access. Confirm that the cluster's live-migration exclusions and configured network preference also match the approved design before starting the move. Then perform the approved migration. If the current owner isn't `HV01`, stop and reconcile the example with the actual placement before proceeding.

```powershell
Get-ClusterGroup -Cluster HVCL01

Move-ClusterVirtualMachineRole -Cluster HVCL01 -Name App01 `
    -Node HV02 -MigrationType Live -ErrorAction Stop

Get-ClusterGroup -Cluster HVCL01 -Name App01
```

The final owner identifies the placement result. It doesn't establish application continuity by itself. Verify guest connectivity, storage access, migration duration, and the selected SMB paths during the operation.
