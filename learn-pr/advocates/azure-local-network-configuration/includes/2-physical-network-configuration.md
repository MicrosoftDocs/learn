Azure Local networking has two related parts: the connections that let physical hosts operate as a system, and the networks that let their workloads communicate with users and other services. A working host management connection does not automatically provide the addressing, routing, or security that an application needs.

>[!NOTE]
> This unit introduces both parts before you examine their design and troubleshooting in detail. The examples focus on connected, **hyperconverged** deployments, where the hosts provide both compute and storage. Deployments that use external storage have different requirements and need their own reference design.

## Physical host connections

Each Azure Local host uses physical network adapters, cables, and switch ports to carry traffic. Together with the switches and their interconnections, these form the **network fabric**. The design determines which traffic shares physical ports, which traffic uses dedicated ports, and whether an alternative path remains available after a failure.

The following table summarizes common layouts. These are starting points for selecting a supported reference design, not complete cabling instructions:

| Deployment configuration | Basic physical layout | Effect on host networking |
| --- | --- | --- |
| Single node | Host adapters connect to the access network for management and workloads. | No inter-node storage connections are needed. Redundant network links do not protect against failure of the only host. |
| Two nodes with switchless storage | Dedicated storage ports connect the hosts directly; separate ports connect management and workloads to access switches. | Storage traffic stays on the direct links. Management and workload connectivity still depend on the access network. |
| Multiple nodes with switched, separated storage | Dedicated host ports carry storage through switches, while other ports carry management and workloads. | Storage has separate physical interfaces and bandwidth from management and workload traffic. |
| Multiple nodes with switched, fully converged networking | The same supported host ports carry management, storage, and workload traffic through redundant switches. | Logical interfaces and traffic policies separate purposes while sharing physical capacity. |

For the single-rack switched hyperconverged patterns described here, management, compute, and storage traffic use the same multichassis link aggregation (MLAG)-configured top-of-rack (ToR) switch pair. A separated-storage design uses dedicated host ports, not a separate storage-only switch pair. Rack-aware and external-storage architectures require their own supported topology.

Corresponding adapters and their configuration must be consistent across hosts. Where a baseboard management controller (BMC) provides hardware administration, give it an appropriately secured out-of-band management connection, separate from workload access.

## Hyperconverged deployment considerations

In a **hyperconverged** deployment, the same hosts provide virtualization and storage. Storage Spaces Direct pools supported local drives across the system; moving and protecting data between nodes creates storage-network demand. A **live migration** moves a running VM's execution to another host by transferring memory and state. It creates additional network demand even when the VM's disks remain on shared cluster storage.

Several infrastructure components also originate important network traffic flows:

| Component | Role and network implication |
| --- | --- |
| Azure Arc resource bridge | An appliance VM that connects local VM-management infrastructure to Azure. Its own DNS, proxy, and service connectivity must work; it is not the path for every workload packet. |
| Cloud witness | An Azure Storage-backed witness used in cluster quorum decisions. Quorum helps a cluster determine whether it can continue operating; a witness is not a storage-data replica or a substitute for redundant storage links. |
| Azure Key Vault | A service for secrets, keys, and certificates. Deployment and management operations that depend on the deployment's vault need their documented service access. |

Azure Local uses the following terms for network traffic and infrastructure:

| Term | Definition |
| --- | --- |
| Management traffic | Host administration, cluster management, and infrastructure-service communication, including required Azure connections |
| Storage traffic | Host-to-host data movement for the hyperconverged storage system |
| Compute traffic | VM or workload networking carried through the host's virtual networking |
| East-west traffic | Traffic between local peers, such as storage nodes or application and database VMs |
| North-south traffic | Traffic entering or leaving the branch's local network |
| Quality of service, or QoS | Classification and scheduling mechanisms used to manage contention between traffic classes |
| Control plane | Components that calculate, distribute, or reconcile configuration |
| Data plane | Components that forward, classify, or enforce policy on actual packets |

These categories are not universal port lists. Management traffic can be east-west or north-south. VM traffic can remain on one host or cross physical switches after migration. Classify the actual flow.

## Physical host network configuration

Each physical Azure Local node needs a unique, stable **management IP address** for administration, cluster communication, and access to infrastructure services. Configure the initial management connection during operating system setup, before registering the node with Azure Arc. Use the Server Configuration tool (SConfig) and the supported PowerShell preparation steps to configure the address, subnet prefix, default gateway, and Domain Name System (DNS) servers. If management traffic uses a tagged virtual local area network (VLAN), configure it during this preparation and ensure that the physical switch ports carry the same VLAN.

Node management addresses can be assigned statically or obtained from an existing Dynamic Host Configuration Protocol (DHCP) service. With static addressing, reserve each node's address and configure it explicitly. With DHCP, use reservations to keep node addresses stable; Azure Local does not deploy the DHCP server for you. The supported DHCP preparation creates a Switch Embedded Teaming (SET) virtual switch and a host management virtual adapter so that only that management adapter obtains an address and default gateway. Once management uses a virtual switch, its IP configuration belongs to the host's management virtual adapter, not separately to every physical member of the team. Multiple physical uplinks therefore do not require multiple management addresses or default gateways for the node.

During deployment through the Azure portal or an Azure Resource Manager template, provide a separate **infrastructure IP pool** containing at least six consecutive, available addresses in the same subnet as the node management addresses. Keep the node addresses outside this pool. Azure Local allocates static addresses from it to infrastructure components such as Azure Arc resource bridge, even when the nodes use DHCP. Exclude the pool from DHCP allocation and other reservations to prevent conflicts. With statically addressed nodes, deployment also allocates the cluster IP from this pool; with DHCP-addressed nodes, the cluster IP uses DHCP. The cluster IP identifies the cluster rather than an individual host.

Storage addressing is managed separately from the management connection. In supported hyperconverged configurations, Network ATC applies the storage VLANs and automatically assigns storage IP addresses as part of the storage intent. Depending on the design, those addresses belong to dedicated physical storage interfaces or host storage virtual adapters. If custom storage addressing is required, declare it through the supported deployment configuration instead of manually assigning competing addresses to automatically managed interfaces. These storage networks normally carry local host-to-host traffic and should not receive a default gateway merely because the management network has one.

The network team remains responsible for address reservations, DHCP configuration, DNS services, and upstream routing; Azure Local manages the host networking and infrastructure allocations within the supplied design. Use the same DNS servers for the nodes and infrastructure pool, with at least one DNS server available outside the Azure Local instance so that startup does not depend entirely on its own workload VMs. Record allocations in the organization's IP address management system or approved register. Plan carefully before deployment: changing the management VLAN or the infrastructure DNS server addresses afterward is not supported in the release covered by this module. Any other proposed address change must follow the supported lifecycle procedure rather than an ad hoc edit to a managed interface. A BMC address is configured separately through the hardware management interface and does not replace the host operating system's management address.

## Host networking through Network ATC

Azure Local uses **Network ATC** to apply and maintain host network configuration. During deployment, an **intent** associates physical adapters with management traffic, compute traffic for workloads, storage traffic, or a supported combination. An adapter belongs to one intent; a combined intent can carry several traffic types.

Network ATC configures the host components required by that design, including virtual switches, adapter settings, host virtual interfaces, and storage networking. A **Hyper-V virtual switch** connects virtual adapters in the host or its VMs to the appropriate network. **Switch Embedded Teaming (SET)** combines supported physical uplinks for the virtual switch using switch-independent teaming, rather than a host-facing Link Aggregation Control Protocol (LACP) bundle.

In a separated-storage design, storage uses dedicated physical interfaces. In a fully converged design, host storage virtual interfaces share the physical adapters with management and VM traffic. These host interfaces are distinct from the virtual adapters inside a VM. Sharing physical ports does not mean that all traffic uses one IP address or subnet.

Plan a management address for each node and a separate infrastructure address pool for components such as Azure Arc resource bridge. Network ATC can configure storage addresses automatically in supported designs. Workload addresses are planned separately; they are not simply taken from the host management or storage interfaces.

Network ATC manages the hosts, not the physical switches, upstream routers, or application firewall rules. The network team must configure the corresponding switch ports and paths. Maintain intent-managed settings through supported interfaces rather than manually creating competing host configurations. 

An intent describes the desired host configuration rather than a one-time sequence of commands. Network ATC applies that configuration consistently across cluster nodes and checks that corresponding adapters have matching characteristics, such as make, model, and speed. It then monitors the configuration and can reapply managed settings when they drift from the intent. This ongoing process is called **reconciliation**.

Network ATC uses defaults for settings such as storage VLANs and IP addresses, bandwidth prioritization, and live-migration behavior. For example, it can configure the network and transport used to move a running VM between hosts. These defaults reduce the number of settings you must configure individually, but they do not choose the physical network design or reserve address ranges across your organization. A supported **override** changes a specific intent-managed setting when the deployment requires a different value, while keeping Network ATC responsible for applying it.

A successfully applied intent confirms that the intended host configuration is in place. It does not confirm that physical switches allow the required traffic, that a workload's access rules are correct, or that the remaining bandwidth is sufficient after a link failure. Those requirements must be planned and assessed separately.
