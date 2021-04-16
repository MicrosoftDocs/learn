VMware's Hybrid Cloud Exchange (HCX) Advanced Connector deploys by default in Azure VMware Solution (AVS). After AVS deployment, the next step involves planning to deploy the HCX connector on-premises. To connect on-premises VMware environments with AVS, a site pair needs to be configured between the source and destination. A site pair establishes the network connectivity needed for management, authentication, and orchestration of HCX services.

## What is Hybrid Cloud Exchange?

VMware's HCX is a workload mobility platform that provides a set of network features to simplify VM migrations. These features ease challenges with connecting on-premises data centers to Azure. The appliance links on-premises VMware environments to AVS at the networking layer.

As a migration tool, HCX abstracts both on-premises and cloud resources to present them as a single resource for VM workloads. HCX allows for bi-directional migration of virtual machines from on-premises VMware environments to AVS directly.

Since AVS deploys and configures the HCX Cloud Manager within the private cloud in Azure, there are steps to take in your on-premises VMware datacenter. To start, the HCX connector must be downloaded, activated, and configured. HCX Advanced supports up to three site connections. If you require more than three site connections, a support request needs to be submitted, which enables the VMware HCX Enterprise add-on. HCX Enterprise Edition provides up to 10 site pairs.

## HCX versions and compatibility

AVS deploys with HCX 4.0. There are vSphere version compatibility requirements that need to be met for a supported migration pattern using HCX.

| Component type | HCX connector environment requirements | HCX cloud environment requirements |
| :------| :------- | :---- |
| vSphere (includes vCenter and ESXi) | 6.0+ | 6.5.X, 6.7.X, and 7.0 |
| NSX | NSXv 6.4.4+ or NSX-T 2.4.0+. Interoperability with vSphere 7.0 requires NSX-T 3.0.1 | MSXv 6.4.5+ or NSX-T 2.5.0+. Interoperability with vSphere 7.0 requires NSX-T 3.0.1+

If you're running an older version of vSphere (5.0+), the HCX connector appliance needs to be deployed and downgraded to get support for the migration.

## Network connectivity and ports

Recall that AVS configures an ExpressRoute circuit during deployment of the resource. That ExpressRoute circuit needs to be peered directly into Azure for access to all the Azure services. Azure ExpressRoute Global Reach then should be configured between the on-premises VMware environment and AVS with a customer-provided ExpressRoute circuit. Global Reach is an add-on feature for ExpressRoute. This feature enables connectivity from on-premises environments to Azure. That connectivity routes all traffic privately within the Microsoft global backbone. Before HCX can be deployed and a site pairing established, ExpressRoute Global Reach must be configured.

When the site pairing is set up, all required network ports need to be open for communication between the on-premises VMware environment and AVS. The following chart outlines all ports, protocols used, and what components need the ports open for configuration.

| Port   | Protocol | Notes |
| :------| :------- | :---- |
| 4500 | UDP | Used for VMs in source network communicating with VMs in the HCX extended network, IX transport path carries HCX migration and disaster recovery traffic
| 443 | TCP | Configure and manage HCX services, activation and service updates, HCX initiated connections, VPXA listener, HCX vMotion control, traffic control for vMotion migration operations, ESX authentication, vCloud Director API, HCX metrics for vRealize Operations, virtual machine data transfer, HCX HTTPS communication, NSX-T API
| 9443 | TCP | HCX service appliance configuration and control, HCX internal control, activate, and register vCenter and management servers
| 45000 to 44600 | TCP | Virtual machine data transfer |
| 5672 | TCP | Advanced message queue protocol |
|31031, 44046 | TCP | HCX bulk migration, disaster recovery |
| 514 | TCP/UDP | Syslog originator to syslog collector |
| 80 | TCP | OVF import, service appliance deployment, ESX authentication |
| 22 | TCP | Secure shell connection used to launch the HCX central CLI |
| 902 | TCP | HCX cold migration (bidirectional), OVF import, service appliance deployment |

## IP addresses for network segmentation

You'll need to factor in the following network segments in the on-premises HCX environment:

- Management network
- Uplink network
- vMotion network
- Replication network

### Management network segment

Use the same management network as the on-premises VMware cluster for smaller environments. At a minimum, select two IPs on this network segment for HCX. Create a new /26 network segment for larger environments. From there, present that network segment as a port group to the on-premises VMware cluster.

### Uplink network segment

Use the same management network for the uplink network segment.

### vMotion network segment

Use the same network as vMotion by the on-premises VMware cluster. At a minimum, identify two IPs on this network segment for VMware HCX. You may need more IPs depending on the scale of the deployment. The vMotion network should be exposed a distributed virtual switch or vSwitch0. If it's not configured that way, you'll need to modify the configuration. VMware environments typically use non-routed network segments for vMotion, which doesn't cause a problem.

### Replication network segment

Use the same network segment as the management and uplink network segments. If the on-premises hosts use a dedicated replication VMkernel network, reserve two IP addresses in this network segment. Then use this replication VMkernel network for the replication network segment.

## Different migration types

HCX offers a few different ways to migrate workloads:

- Live migration
- Cold migration
- Bulk migration

### Live migration

HCX can transfer a powered on VM from an HCX-enabled vCenter to an HCX-enabled destination site. vMotion captures the VM's active memory, execution state, IP address, and MAC address. Migration duration depends on connectivity. The connectivity includes bandwidth available and the latency between both sites. In this migration scenario, the VM never powers off, there's no service disruption, and workloads remain online.

### Cold migration

Cold migration uses the same network path as VMware HCX vMotion to transfer a powered-off virtual machine. During a cold migration, the Virtual Machine IP address and MAC address are preserved.

### Bulk migration

The bulk migration option is designed for moving VMs in parallel. This migration type can be set to occur on a pre-defined schedule. The VM runs at the source site until the cutover begins. The service interruption with the bulk migration is equivalent to a reboot.

In the next unit, we'll cover how to deploy and install HCX so you can begin migrating workloads in Azure. All steps will be outlined so you can successfully deploy and install the service in your environment.