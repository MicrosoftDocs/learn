Network ATC can detect several host inconsistencies. It can't repair an unsupported driver, create a missing adapter, or configure a switch port that blocks the selected VLAN.

Complete readiness work before submitting an intent. This is especially important for management adapters because changing their bindings can interrupt the session performing the change.

## Keep deployment and operational records

Before collecting inventory, choose an organization-approved, access-controlled location for the cluster's operational records. Use the cluster's configuration-management record or a controlled internal operations runbook as the main reference, with links to supporting files. Whenever this module asks you to record or retain information, save it in these approved locations. Console output, a personal folder, or files stored only on a cluster node aren't sufficient as the sole record.

Use the following locations for the different types of records.

| Record type | Where to keep it |
|---|---|
| Hardware and software inventories, adapter and physical-port mappings, addressing and VLAN plans, design decisions, and configuration ownership | The cluster's configuration-management record or controlled operations runbook |
| Approved intent definitions, overrides, automation, and reconstruction commands | An access-controlled internal version-control repository, linked from the main cluster record |
| Before-and-after configuration exports, status output, logs, and connectivity or performance results | A restricted evidence folder in an approved shared repository, linked from the main cluster record and the relevant change or incident record |

Organize evidence by cluster, change or incident identifier, and capture time. Identify the source node for each capture and distinguish pre-change, post-change, and recovery data. Assign an owner to update the records after approved changes. Retain previous versions according to your organization's retention policy, and keep the known-good configuration and supporting evidence throughout the recovery window.

Ensure authorized operators can access recovery instructions and evidence even if the affected cluster or its management network is unavailable. Protect these records because they can disclose internal addresses, topology, and system names. Keep credentials and other secrets in an approved secrets-management system, not in runbooks, scripts, or evidence files.

## Establish the software baseline

Use Windows Server 2025 on every target cluster node. Generic support for a rolling OS upgrade doesn't establish Network ATC support for a mixed-version cluster.

Record the OS build and NetworkATC module version on each host. Use the installed command syntax when preparing automation rather than assuming that every environment has identical tooling.

Run the following inventory from an authorized management session.

```powershell
$nodes = 'HV01', 'HV02'
Invoke-Command -ComputerName $nodes -ErrorAction Stop -ScriptBlock {
    Get-ComputerInfo |
        Select-Object WindowsProductName, OsVersion, OsBuildNumber
    Get-Module -ListAvailable NetworkATC |
        Select-Object Name, Version
    $PSVersionTable.PSVersion
}
```

The returned records identify the software baseline for each node. A missing module is a prerequisite failure, not an empty healthy configuration.

The example uses these Windows Server features.

| Feature name | Purpose |
|---|---|
| `NetworkATC` | Intent-based host configuration and management |
| `Hyper-V` | Virtual switches, host vNICs, and the example VM workload |
| `Failover-Clustering` | Cluster membership and cluster-scoped operation |
| `Data-Center-Bridging` | Host DCB and traffic-class configuration |
| `FS-SMBBW` | SMB bandwidth-management support |

Inspect the features before installing them.

```powershell
Invoke-Command -ComputerName HV01,HV02 -ErrorAction Stop -ScriptBlock {
    Get-WindowsFeature -Name NetworkATC, Hyper-V, Failover-Clustering,
        Data-Center-Bridging, FS-SMBBW
}
```

On prepared hosts, install missing features during the approved maintenance window.

```powershell
Invoke-Command -ComputerName HV01,HV02 -ErrorAction Stop -ScriptBlock {
    Install-WindowsFeature -Name NetworkATC, Hyper-V,
        Failover-Clustering, Data-Center-Bridging, FS-SMBBW `
        -IncludeManagementTools -ErrorAction Stop
}
```

Inspect `Success` and `RestartNeeded` in the result. Complete required restarts before relying on the new components. Installing features isn't evidence that the intended host network has been deployed.

Production deployment uses supported physical hosts and adapters. A nested demonstration doesn't reproduce physical RDMA, switch behavior, or failure domains. Disabling NetworkDirect in a test VM isn't a production remedy for nonoperational RDMA.

## Verify adapter symmetry

Adapters in the same intent must be symmetric in make, model, speed, and configuration. The required adapters must also be available on every cluster node with the same aliases.

The management/compute pair doesn't have to represent the same traffic design as the storage pair. Evaluate symmetry within the applicable intent and across its target nodes.

Inspect physical identity and link state across the two nodes.

```powershell
$nodes = 'HV01', 'HV02'
Get-NetAdapter -Physical -CimSession $nodes -ErrorAction Stop |
    Select-Object PSComputerName, Name, InterfaceDescription,
        Status, LinkSpeed

Get-NetAdapter -Physical -CimSession $nodes -ErrorAction Stop |
    Format-Table -View Driver

Get-NetAdapterRdma -Name pNIC03,pNIC04 -CimSession $nodes
Get-NetAdapterAdvancedProperty -Name pNIC03,pNIC04 -CimSession $nodes
```

Expect all intended links to be up and the identities to match the approved design. RDMA capability and configuration must fit the chosen transport. Review firmware and BIOS settings with the hardware vendor because PowerShell link state alone doesn't establish platform readiness.

Use network adapter drivers supplied and supported by the hardware vendor for Windows Server 2025. Drivers bundled with Windows (inbox drivers) might lack the required RDMA support and can cause Network ATC to report `RDMANotOperational`. Determine minimum port speeds and supported firmware versions from the vendor's requirements for your hardware and network design, rather than assuming the same requirements apply to every deployment.

Before deployment, give corresponding physical adapters the same names on every cluster node, such as `pNIC01` through `pNIC04` in this example. These names are adapter aliases. They appear in the `Name` column of `Get-NetAdapter` and are the values you pass to `Add-NetIntent -AdapterName`. Don't confuse the alias with `InterfaceDescription`, which describes the device model, or `ifIndex`, which is a numeric interface identifier assigned by Windows. The interface index can change after an adapter replacement or OS reinstallation, so don't use it to identify corresponding adapters across nodes.

The following comparison detects missing or unexpected physical aliases. It deliberately compares the complete example inventory, not merely whether any adapter was returned.

```powershell
$expected = 'pNIC01', 'pNIC02', 'pNIC03', 'pNIC04'
foreach ($node in 'HV01', 'HV02') {
    $actual = @(Get-NetAdapter -Physical -CimSession $node `
        -ErrorAction Stop | Select-Object -ExpandProperty Name)
    $difference = @(Compare-Object -ReferenceObject $expected `
        -DifferenceObject $actual)
    if ($difference.Count -gt 0) {
        $difference
        throw "Physical adapter inventory differs on $node."
    }
}
```

If your hosts have additional physical adapters, add their aliases to `$expected` before running this example, even if those adapters won't be used in a Network ATC intent. The script compares all physical adapters and reports any unlisted adapter as a mismatch. A successful comparison confirms only that the adapter names match the expected inventory. Separately verify that adapters in each intent have matching makes, models, and link speeds, use supported firmware, and connect through cabling and physical switch ports configured for the approved network design.

## Identify existing ownership

Before assigning physical adapters to a Network ATC intent, identify the resources that currently use them and the tools that manage their settings. An adapter might already be an uplink for a Hyper-V virtual switch or a member of a Load Balancing and Failover (LBFO) team. Creating an intent doesn't automatically convert those resources or release adapters from conflicting bindings.

Check the dependent configuration as well. Host virtual network adapters (vNICs) attached to an existing switch might carry management, storage, or live-migration traffic. Quality of Service (QoS) policies and traffic classes might already allocate bandwidth or prioritize traffic. Group Policy, management agents, and scripts can also reapply settings that conflict with Network ATC's desired configuration.

Plan how to migrate or remove only the conflicting configuration before handing those adapters to Network ATC. Preserve resources that serve unrelated workloads. Removing a switch, team, or host vNIC can disconnect the host or interrupt VM and storage traffic, so establish an out-of-band management path before making disruptive changes.

Inspect current resources locally on each host before changing bindings.

```powershell
Get-VMSwitch
Get-VMSwitchTeam
Get-NetLbfoTeam
Get-NetAdapterBinding -Name pNIC01,pNIC02,pNIC03,pNIC04
Get-VMNetworkAdapter -ManagementOS
Get-NetIPAddress
Get-NetQosPolicy -PolicyStore ActiveStore
Get-NetQosTrafficClass
```

For each resource returned, record which tool or administrator manages its configuration and which host services or VMs depend on it. Load Balancing and Failover (LBFO) is the traditional Windows Server network adapter teaming feature, which groups physical adapters to distribute traffic and provide redundancy. If `Get-NetLbfoTeam` completes successfully but returns no objects, no LBFO teams are configured on that host. This doesn't rule out Switch Embedded Teaming (SET), which you inspect with `Get-VMSwitchTeam`. If any inventory command fails, treat that part of the inventory as incomplete. Resolve the error and rerun the command before concluding that no matching resources exist.

Preserve the management interface's IP address, prefix, gateway, routes, DNS servers, and DNS registration behavior. After convergence, inspect the host vNIC that actually carries management traffic. Don't assume that the old physical-interface index still identifies it.

Use the following commands to capture the addressing and name-resolution view.

```powershell
Get-NetIPConfiguration
Get-NetRoute -AddressFamily IPv4
Get-DnsClient
Get-DnsClientServerAddress
```

Incorrect source routes or DNS registration can make a host appear reachable through the wrong network. Storage interfaces on isolated subnets shouldn't receive gateways or DNS registration indiscriminately.

## Prepare the switch fabric

Configure the physical network first. A correctly provisioned host still fails if its switch port blocks a required VLAN or applies incompatible DCB policy.

The fabric readiness review covers the following decisions.

| Item | Required agreement |
|---|---|
| VLANs | The correct VLANs traverse every relevant port and path |
| Port mode | Tagged and untagged behavior matches the host design |
| Teaming | SET uplinks aren't configured as an LACP bundle |
| MTU | Hosts, switches, and endpoints support compatible frame sizes |
| RDMA/DCB | Transport, priorities, flow control, and scheduling align |
| Failure paths | Surviving links reach the required peers and endpoints |
| Capacity | Normal and degraded workloads fit the available resources |

Review applicable cluster-validation results. `Test-Cluster -List` exposes available tests so you can select the network checks appropriate to the change.

```powershell
Test-Cluster -List
```

Schedule selected tests according to their impact. Don't launch an indiscriminate validation suite against production storage simply because the current task concerns networking.
