VMware HCX Cloud Manager deploys as an add-on option in Azure VMware Solution. After deployment, the next step involves planning to deploy VMware HCX Connector on-premises. To connect on-premises VMware vSphere environments with Azure VMware Solution, you need to configure a *site pair* between the source and destination. A site pair establishes the management relationship for authentication and orchestration of VMware HCX services. Routed network connectivity must already be in place.

## What is VMware HCX?

VMware HCX is a workload-mobility platform that provides a set of network features to simplify virtual machine (VM) migrations. These features ease challenges with connecting on-premises vSphere datacenters to Azure. The VMware HCX appliance links on-premises VMware vSphere environments to Azure VMware Solution at the networking layer.

As a migration tool, VMware HCX abstracts both on-premises and cloud resources to present them as a single resource for VMware vSphere VM workloads. VMware HCX also allows for bidirectional migration of virtual machines from on-premises VMware vSphere environments to Azure VMware Solution directly.

HCX Cloud Manager is installed through the Azure VMware Solution private cloud's HCX add-on. Confirm that add-on installation has completed before downloading the Connector or configuring site pairing. In the on-premises VMware vSphere datacenter, you must deploy, activate, and configure the Connector.

A single HCX manager system supports up to 25 site pairings and 10 service meshes, including inbound and outbound relationships. A site pairing connects the managers, while a service mesh deploys the service appliances that provide the selected HCX services between sites. They are different resources, so don't use the two limits interchangeably.

## VMware HCX versions and compatibility

This scenario uses an on-premises vSphere 8 environment. Before deploying HCX, record the exact vCenter Server, ESXi, and HCX versions at the source and destination. Verify that the combination is supported for the migration method you intend to use.

The following checks distinguish software compatibility from lifecycle support.

| Check | What to confirm |
| :---- | :-------------- |
| Source HCX Connector | Its release is supported with the source vCenter Server and ESXi builds. |
| Azure VMware Solution | Use the Microsoft-provided HCX Connector distribution and the private cloud's supported HCX Cloud Manager release. Don't assume that the newest vendor release is available or approved in the service. |
| Interoperability | The exact source and destination product combinations are listed as compatible in the Product Interoperability Matrix, including NSX when it's used. |
| Lifecycle and migration features | The releases remain within their supported lifecycle and satisfy the requirements for the selected migration and network-extension features. Compatibility alone doesn't establish lifecycle support. |

Don't treat a version-number minimum as a permanent support guarantee. If a source environment isn't supported, stop and agree on a supported platform upgrade or migration plan with the relevant support teams. Don't downgrade HCX as a generic compatibility workaround.

> [!NOTE]
> As of November 2026, Microsoft's software-version table lists HCX 4.11.4 for new Azure VMware Solution private clouds. This doesn't establish the version of an existing private cloud or Connector. Check the current Microsoft-validated release against the exact builds deployed at both sites.
>
> Microsoft manages HCX Cloud Manager upgrades. You manage the on-premises Connector and service-mesh appliance updates. Back up the Connector configuration and coordinate a maintenance window with no active migrations. Update the service appliances only after the paired managers are updated and healthy. Service-appliance updates can interrupt the data path, including extended-network traffic. A compute-profile Resync isn't a software upgrade.

## Network connectivity and ports

Confirm the generation of the Azure VMware Solution private cloud you've already deployed. The following connectivity choices depend on that generation.

| Private-cloud generation | Connectivity preparation |
| :----------------------- | :----------------------- |
| Generation 1 | The private cloud uses Microsoft-managed ExpressRoute connectivity. Configure the required virtual-network connection and a supported on-premises path, such as ExpressRoute Global Reach. If Global Reach isn't available or doesn't meet your network requirements, use a supported transit or VPN design. |
| Generation 2 | The private cloud attaches directly to an Azure virtual network. Configure virtual-network routing and an on-premises ExpressRoute or site-to-site VPN path. Reserve two additional nonoverlapping /24 subnets, one for cloud-side HCX management and one for uplink networking, as required by Generation 2 deployment guidance. |

The on-premises HCX Connector must be able to reach the actual HCX Cloud Manager endpoint over TCP 443. Obtain that endpoint from the deployed private cloud's HCX configuration. Don't construct it by substituting values into an example IP address. Establish the routed connection before configuring site pairing.

> [!NOTE]
> The on-premises traffic-profile examples in this module aren't the cloud-side Generation 2 subnet layout. Use the design requirements for each side of the connection.

For VPN-connected deployments, Azure VMware Solution HCX guidance specifies an uplink network-profile MTU of 1350 to account for encapsulation overhead. Configure the profiles on both sides consistently. The default MTU of 1500 is sufficient for most ExpressRoute deployments, but confirm the effective path MTU with the connectivity provider before migration.

Build firewall rules from the port matrix for the installed HCX release and the services you enable. Record each rule's source, destination, protocol, port, and direction. Don't treat local appliance-to-vCenter or appliance-to-host traffic as traffic that must cross the connection between sites.

The following examples identify important flows. They aren't a complete firewall specification.

| Purpose | Source | Destination | Protocol and destination port |
| :------ | :----- | :---------- | :---------------------------- |
| Site pairing and management | On-premises HCX Connector | Azure VMware Solution HCX Cloud Manager | TCP 443 |
| Service-appliance tunnel transport | HCX service-appliance uplink addresses at either site | Peer service-appliance uplink addresses at the other site | UDP 4500 |
| Connector service UI | Authorized administration host | On-premises HCX Connector | TCP 443 |
| Connector appliance administration | Authorized administration host | On-premises HCX Connector | TCP 9443 |

Also allow the release-specific local vCenter, ESXi, and replication flows, and provide working DNS, time synchronization, and the activation/update connectivity required by your deployment mode. Validate both the rules and effective routing before pairing the sites or deploying the service mesh.

## IP addresses for network segmentation

The address counts below are starting points for a pilot or small deployment, not a fixed total for every HCX installation. Reserve the Connector management address separately from the address pools used by service appliances. Size those pools for the selected services and number of appliances in your design. Include additional capacity for growth or high availability if you enable it.

Management, Uplink, and Replication can reuse network infrastructure or a compatible network profile where the design and reachability requirements permit. Use the dedicated replication VMkernel network if your hosts have one. Separate traffic profiles don't automatically require four separate subnets.

Use the following network-segment guidance when planning the on-premises HCX address allocations.

| Network segment | Notes |
| :-------------- | :---- |
| Management network | Use the same management network as the on-premises VMware cluster. Identify at least two available IP addresses as a small-deployment planning starting point, then verify the allocation against the Connector and service-appliance inventory. For larger environments, consider a new /26 segment and present it as a port group to the on-premises cluster. |
| Uplink network | You can reuse the management network if it meets the uplink routing, security, and MTU requirements. Allocate addresses for the uplink interfaces of the planned service appliances. |
| vMotion network | Use the on-premises cluster's vMotion network and make it available through a distributed virtual switch or vSwitch0 for the documented setup. Start with two available IP addresses and allocate more as needed for the planned scale. A nonrouted vMotion segment can be used when the local connectivity requirements are met. |
| Replication network | You can reuse the management and uplink network segment. If the hosts use a dedicated replication VMkernel network, use that segment instead and reserve two addresses as a small-deployment starting point. Increase the pool as needed for the planned appliances. |

## Different migration types

Choose a migration method according to the VM's compatibility, the number of VMs, and the permitted outage. The following table compares the methods used for vSphere workloads.

| Method | When to use it | Cutover behavior |
| :----- | :------------- | :--------------- |
| HCX vMotion | A small number of powered-on VMs that need a live migration. VMs migrate serially. | Transfers active memory and execution state without a planned guest shutdown. Validate application behavior and migration compatibility. |
| Cold Migration | Workloads, such as dev/test VMs, that can remain powered off while they're copied. | Uses the same network path as HCX vMotion, but requires downtime for the copy and subsequent startup. |
| Bulk Migration | Parallel replication and scheduled cutover of workloads with an approved outage. | Replicates VM data while the source VM runs. At cutover, shuts down the source VM, completes final synchronization and target preparation, and starts the destination VM. Plan an application outage that depends on the VM, storage, network, and application startup and can exceed a normal reboot. Use a pilot to estimate the switchover window. |
| Replication Assisted vMotion (RAV) | Parallel replication followed by a live cutover for compatible powered-on VMs. | Uses replication to transfer disk data and vMotion for the final live transition. Requires HCX Enterprise entitlement and the RAV service to be available and enabled in the applicable compute profiles and service mesh. |

HCX vMotion and Cold Migration can preserve a VM's IP and MAC addresses. Retaining an address doesn't establish destination connectivity: prepare the destination network and use Network Extension only when your network plan requires it. Migration duration depends on factors such as workload size, available bandwidth, and latency. Neither live-migration method guarantees an application SLA.

## Scenario readiness and preparation for Azure VMware Solution

Your company's production environment maintains a strict SLA. Evaluate HCX vMotion or RAV against the application's availability requirements. This module uses RAV for the production live-migration example and shows Bulk as an alternative for workloads with an approved outage. A supported software version and open ports are necessary, but don't establish workload readiness on their own.

> [!IMPORTANT]
> On Azure VMware Solution Generation 2, RAV and Bulk Migration can experience slower performance and stalls during Base Sync and Online Sync. Allow longer replication windows and size migration waves from pilot results. For suitable workloads, evaluate HCX vMotion when host compatibility and network conditions permit. Don't change an approved migration method without reassessing its requirements and application impact.

Use the following readiness checks as gates before migrating production VMs:

- Confirm that the selected HCX, vCenter Server, and ESXi versions are compatible with the migration method. Review each VM's virtual hardware, devices, guest operating system, and application support requirements.
- For RAV, confirm hardware version 9 or later and source and destination CPU/EVC compatibility for the live vMotion transition. Include reverse-migration compatibility in the recovery plan, including the effect of per-VM EVC or virtual-hardware changes.
- For Bulk Migration, confirm that a supported VMware Tools version is installed and the VM meets the method's hardware and device requirements. Verify guest shutdown behavior during the pilot.
- Identify VMs with vTPM, VM encryption, special disks or controllers, or other configurations restricted by the selected method. Establish a supported migration and key-management plan before proceeding. Don't remove protection or change virtual hardware to bypass validation.
- Confirm sufficient destination CPU, memory, and datastore capacity, including temporary capacity needed during replication and cutover.
- Give every virtual network adapter a valid destination mapping. Verify DNS, authentication, required application connections, and firewall rules from the target network.
- After configuring HCX, confirm that site pairing, the service mesh, and required services are healthy. Run the available service-mesh diagnostics and measure the underlay's performance before estimating the migration window.
- Document application dependencies, migration order, cutover approval, recovery criteria, and a usable backup.

Plan recovery for the selected method and current application data. Successful RAV removes the source VM. Bulk Migration retains a powered-off source VM that doesn't include subsequent destination writes, so don't assume it's safe to power on. Use a supported reverse migration or restore where appropriate.

Run a pilot with a low-risk VM before production migration waves. Record transfer time, cutover behavior, application availability, and post-migration performance. Use the results to adjust production wave sizes and maintenance windows.

> [!NOTE]
> Azure Migrate can help discover and assess the source environment and its dependencies. In this procedure, VMware HCX performs the migration into Azure VMware Solution.

In the next unit, we'll cover how to deploy and install VMware HCX Connector so you can begin migrating workloads to Azure VMware Solution.
