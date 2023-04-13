
Azure offers several options for ensuring the availability of the virtual machines, and applications, you have deployed.

## Availability zones

[Availability zones](/azure/availability-zones/az-overview?context=/azure/virtual-machines/context/context) expand the level of control you have to maintain the availability of the applications and data on your VMs. An Availability Zone is a physically separate zone, within an Azure region. There are three Availability Zones per supported Azure region.

An Availability Zone in an Azure region is a combination of a fault domain and an update domain. For example, if you create three or more VMs across three zones in an Azure region, your VMs are effectively distributed across three Fault domain and three update domains. The Azure platform recognizes this distribution across update domains to make sure that VMs in different zones are not scheduled to be updated at the same time.

Build high-availability into your application architecture by co-locating your compute, storage, networking, and data resources within a zone and replicating in other zones. Azure services that support Availability Zones fall into two categories:

* **Zonal services**: Where a resource is pinned to a specific zone (for example, virtual machines, managed disks, Standard IP addresses), or
* **Zone-redundant services**: When the Azure platform replicates automatically across zones (for example, zone-redundant storage, SQL Database).

## Availability sets

An [availability set](/azure/virtual-machines/availability-set-overview) is a logical grouping of VMs that allows Azure to understand how your application is built to provide for redundancy and availability. An availability set is composed of two additional groupings that protect against hardware failures and allow updates to be safely applied - Fault domain (FDs) and update domains (UDs).

### Fault domain

A fault domain is a logical group of underlying hardware that share a common power source and network switch, similar to a rack within an on-premises datacenter. As you create VMs within an availability set, the Azure platform automatically distributes your VMs across these Fault domain. This approach limits the impact of potential physical hardware failures, network outages, or power interruptions.

:::image type="content" source="../media/virtual-machine-fault-domains.png" alt-text="Image showing a representation of a Fault domain. Two separate hardware racks are shown with VMs and databases distributed across each.":::

### Update domains

An update domain is a logical group of underlying hardware that can undergo maintenance or be rebooted at the same time. As you create VMs within an availability set, the Azure platform automatically distributes your VMs across these update domains. This approach ensures that at least one instance of your application always remains running as the Azure platform undergoes periodic maintenance. The order of update domains being rebooted may not proceed sequentially during planned maintenance, but only one update domain is rebooted at a time.

:::image type="content" source="../media/virtual-machine-update-domains.png" alt-text="Conceptual drawing of the update domain and fault domain configuration. Image shows groups of hardware that can be maintained or rebooted at the same time.":::


## Virtual Machine Scale Sets

[Azure Virtual Machine Scale Sets](/azure/virtual-machine-scale-sets/overview?context=/azure/virtual-machines/context/context) let you create and manage a group of load balanced VMs. The number of VM instances can automatically increase or decrease in response to demand or a defined schedule.

## Load balancer

Combine the [Azure Load Balancer](/azure/load-balancer/load-balancer-overview) with an availability zone or availability set to get the most application resiliency. An Azure load balancer is a Layer-4 (TCP, UDP) load balancer that provides high availability by distributing incoming traffic among healthy VMs. A load balancer health probe monitors a given port on each VM and only distributes traffic to an operational VM.

You define a front-end IP configuration that contains one or more public IP addresses. This front-end IP configuration allows your load balancer and applications to be accessible over the Internet.

Virtual machines connect to a load balancer using their virtual network interface card (NIC). To distribute traffic to the VMs, a back-end address pool contains the IP addresses of the virtual (NICs) connected to the load balancer.

To control the flow of traffic, you define load balancer rules for specific ports and protocols that map to your VMs.
