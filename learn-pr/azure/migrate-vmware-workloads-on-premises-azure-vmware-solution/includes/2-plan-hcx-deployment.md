VMware HCX Advanced Cloud Manager deploys by default in Azure VMware Solution. After deployment, the next step involves planning to deploy VMware HCX Connector on-premises. To connect on-premises VMware environments with Azure VMware Solution, you need to configure a *site pair* between the source and destination. A site pair establishes the network connectivity needed for management, authentication, and orchestration of VMware HCX services.

## What is VMware HCX?

VMware HCX is a workload-mobility platform that provides a set of network features to simplify VM migrations. These features ease challenges with connecting on-premises datacenters to Azure. The VMware HCX appliance links on-premises VMware environments to Azure VMware Solution at the networking layer.

As a migration tool, VMware HCX abstracts both on-premises and cloud resources to present them as a single resource for VM workloads. VMware HCX also allows for bidirectional migration of virtual machines from on-premises VMware environments to Azure VMware Solution directly.

Because Azure VMware Solution deploys and configures VMware HCX Cloud Manager within the private cloud in Azure, there are steps you need to take in the on-premises VMware datacenter. You must download VMware HCX Connector, then activate and configure it. VMware HCX Advanced deploys with Azure VMware Solution and supports up to three site connections. If you require more than three site connections, submit a support request to enable the VMware HCX Enterprise add-on. VMware HCX Enterprise Edition provides up to 10 site pairs.

## VMware HCX versions and compatibility

For a supported migration pattern that uses VMware HCX, be aware that there are vSphere version-compatibility requirements that need to be met on-premises.

| Component type | HCX Connector environment requirements | HCX cloud environment requirements |
| :------| :------- | :---- |
| vSphere (includes vCenter and ESXi) | 6.0+ | 6.5.X, 6.7.X, and 7.0 |
| NSX | NSXv 6.4.4+ or NSX-T 2.4.0+. Interoperability with vSphere 7.0 requires NSX-T 3.0.1 | MSXv 6.4.5+ or NSX-T 2.5.0+. Interoperability with vSphere 7.0 requires NSX-T 3.0.1+

For older versions of vSphere (5.0+), VMware HCX Connector needs to be deployed and downgraded. VMware will then support the migration for a limited period of time.

## Network connectivity and ports

Azure VMware Solution configures an Azure ExpressRoute circuit during the resource's deployment in Azure. You then need to peer the circuit into an Azure virtual network for access to all resources in Azure.

Next, configure the Global Reach feature of ExpressRoute between the on-premises VMware environment and the Azure VMware Solution ExpressRoute by using a separate ExpressRoute circuit. Global Reach enables east-west connectivity between both ExpressRoute circuits by using BGP. That connectivity routes all traffic privately within the Microsoft global backbone. Before VMware HCX Connector can be deployed and a site pairing established, you must enable Global Reach.

All required network ports need to be open for communication between the on-premises VMware environment and Azure VMware Solution. The following table outlines all ports, protocols used, and what VMware components need open ports for configuration.

| Port   | Protocol | Notes |
| :------| :------- | :---- |
| 4500 | UDP | Used for VMs in the source network communicating with VMs in the HCX extended network, IX transport path carries HCX migration and disaster recovery traffic.
| 443 | TCP | Configure and manage the following: HCX services, activation and service updates, HCX initiated connections, VPXA listener, HCX vMotion control, traffic control for vMotion migration operations, ESX authentication, vCloud Director API, HCX metrics for vRealize Operations, virtual machine data transfer, HCX HTTPS communication, and NSX-T API.
| 9443 | TCP | HCX service appliance configuration and control, HCX internal control, activate, and register vCenter and management servers.
| 45000 to 44600 | TCP | Virtual machine data transfer. |
| 5672 | TCP | Advanced message queue protocol. |
|31031, 44046 | TCP | HCX bulk migration, disaster recovery. |
| 514 | TCP/UDP | Syslog originator to syslog collector. |
| 80 | TCP | OVF import, service appliance deployment, ESX authentication. |
| 22 | TCP | Secure shell connection used to launch the HCX central CLI. |
| 902 | TCP | HCX cold migration (bidirectional), OVF import, service appliance deployment. |

## IP addresses for network segmentation

Next, you need to factor in the following network segments in the on-premises VMware HCX environment:

| Network segment | Notes |
| :-------------- | :---- |
| Management network | - Use the same management network as the on-premises VMware cluster. <br>- At a minimum, select two IPs on this network segment for HCX. <br>- Create a new /26 network segment for larger environments. <br>- Present that network segment as a port group to the on-premises VMware cluster. |
Uplink network | - Use the same management network for the uplink network segment. |
| vMotion network | - Use the same network as vMotion by the on-premises VMware cluster. <br>- At a minimum, identify two IPs on this network segment for VMware HCX. <br>- You might need more IPs, depending on the scale of the deployment. <br>- The vMotion network should be exposed to a distributed virtual switch or vSwitch0. <br>- If the vMotion isn't configured that way, you'll need to modify the configuration. <br>- VMware environments typically use non-routed network segments for vMotion, which doesn't cause a problem.
| Replication network | - Use the same network segment as the management and uplink network segments. <br>- If the on-premises hosts use a dedicated replication VMkernel network, reserve two IP addresses in this network segment. <br>- Use the replication VMkernel network for the replication network segment.

## Different migration types

VMware HCX offers a few different ways to migrate workloads:

| Migration type | Use cases | Capabilities |
| :------------- | :-------- | :-------- |
| Live migration | Production VMs that need to remain online with minimal downtime. | - Migrates a powered-on VM. <br>- Needs an HCX-enabled vCenter configured. <br>- Needs an HCX-enabled destination site configuration. <br>- vMotion captures the VM's active memory, execution state, IP address, and MAC address. <br>- Migration duration depends on connectivity. <br>- Connectivity includes bandwidth available and the latency between both sites. <br>- The VM never powers off, there's no service disruption, and workloads remain online.
| Cold migration | Dev/test workloads that might not be online during migration, but need to be migrated. | <br>- Transfers a powered-off VM. <br>- Uses same network path as VMware HCX vMotion. <br>- VM IP address and MAC address are preserved. |
| Bulk migration | Many VMs that need to be migrated on a schedule. | - Moves VMs in parallel. <br>- Pre-defined schedule. <br>- VMs run at the source site until the cutover begins. <br>- The service interruption is equivalent to a reboot. |

## Scenario readiness and preparation for Azure VMware Solution

Your company's production environment maintains a strict SLA. You need to select live migration to achieve minimal downtime as workloads move from on-premises to Azure VMware Solution. The on-premises VMware environment has vSphere 6.0 installed and the required ports have been allowed in the on-premises networking environment. As a result, there shouldn't be an issue with connectivity or functionality with HCX Cloud Manager in Azure VMware Solution.

In the next unit, we'll cover how to deploy and install HCX Connector so you can begin migrating workloads to Azure VMware Solution.
