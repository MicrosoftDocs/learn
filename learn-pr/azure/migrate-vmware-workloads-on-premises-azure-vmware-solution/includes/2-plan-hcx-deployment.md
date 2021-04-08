VMware's Hybrid Cloud Exchange (HCX) Advanced Connector is deployed by default in Azure VMware Solution (AVS). After AVS deployment, the next step involves planning to deploy HCX on-premises. 

## HCX overview

VMware's HCX is a workload mobility platform that provides set of network features to simplify VM migrations. These features ease all challenges with connecting on-premises data centers to Azure. The appliance links on-premises environments to AVS on the networking layer.

As a migration tool, HCX abstracts both on-premises and cloud resources to present them as a single resource for VM workloads. HCX allows for bi-directional migration of virtual machines from one location to another.

Since AVS deploys and configures the HCX Cloud Manager within the private cloud in Azure, there are steps to take in your on-premises VMware datacenter. The HCX connector must be downloaded, activated, and configured. HCX Advanced supports up to three site connections. If you require more than three site connections, a support request needs to be submitted, which enables the VMware HCX Enterprise add-on. HCX Enterprise Edition provides up to 10 site pairs.

## HCX versions and compatibility

AVS deploys with HCX 4.0.

## Network and ports

When the site pairing is set up, all required network ports need to be open for communication between the on-premises VMware environment and AVS.

| Port   | Protocol | Notes |
| :------| :------- | :---- |
| 4500 | UDP | Used for VMs in source network communicating with VMs in the HCX extended network, IX transport path carries HCX migration and disaster recovery traffic
| 443 | TCP | Configure and manage HCX services, activation and service updates, HCX initiated connections, VPXA listener, HCX vMotion control, traffic control for vMotino migration operations, ESX authentication, vCloud Director API, HCX metrics for vRealize Operations, virtual machine data transfer, HCX HTTPS communication, NSX-T API
| 9443 | TCP | HCX service appliance configuration and control, HCX internal control, activate, and register vCenter and management servers
| 45000 to 44600 | TCP | Virtual machine data transfer |
| 5672 | TCP | Advanced message queue protocol |
|31031, 44046 | TCP | HCX bulk migration, disaster recovery |
| 514 | TCP/UDP | Syslog originator to syslog collector |
| 80 | TCP | OVF import, service appliance deployment, ESX authentication |
| 22 | TCP | Secure shell connection used to launch the HCX central CLI |
| 902 | TCP | HCX cold migration (bidirectional), OVF import, service appliance deployment |

## IP addresses

## Different migration types