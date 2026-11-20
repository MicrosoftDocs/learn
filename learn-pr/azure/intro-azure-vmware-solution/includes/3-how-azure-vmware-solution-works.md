Moving the healthcare company's application to Azure VMware Solution (AVS) changes who maintains the hosts. Your team still operates the application and protects its data.

## Shared support

Compared with running VMware in your own datacenter, here's how the [responsibilities are shared](/azure/azure-vmware/introduction#azure-vmware-solution-responsibility-matrix---microsoft-vs-customer):

| Area | Microsoft's responsibility | Your team's responsibility |
|---|---|---|
| Physical infrastructure | Secure the datacenter, maintain hardware, and replace failed hosts. | Not applicable: customers don't configure physical hardware. |
| VMware software and workloads | Deploy, patch, and upgrade ESXi, vCenter Server, vSAN, and NSX. | Choose capacity, deploy workload virtual machines (VMs), and patch guest operating systems and applications. |
| Networking | Provision the NSX Tier-0 gateway for routing into and out of the private cloud and the default Tier-1 gateway for workload networks. | Create workload segments and configure firewall policies and load balancers. Create additional Tier-1 gateways in NSX Manager if needed. |
| Backup and recovery | Back up management components, including vCenter Server and NSX Manager. | Back up workload VMs, test restores, and plan workload recovery. |
| Customer-installed partner products | Support the AVS platform. | Deploy and maintain the product. Contact its vendor for product support. |

For disaster recovery, vSphere Replication copies selected VMs to a recovery site. For [VMware Live Site Recovery from on-premises vSphere to AVS](/azure/azure-vmware/disaster-recovery-using-vmware-site-recovery-manager#scenario-on-premises-to-azure-vmware-solution), verify that you have a 2-Gbps ExpressRoute connection between the sites and that AVS can resolve the DNS names of the on-premises recovery appliances.

If you use the AVS add-on to orchestrate failover between supported sites, [install VMware Live Site Recovery first, then its vSphere Replication appliances](/azure/azure-vmware/disaster-recovery-using-vmware-site-recovery-manager#install-the-vsphere-replication-appliance). Pair the sites, configure protection for the VMs, and test the recovery plan. Live Site Recovery installs with an evaluation license; for production, [obtain a license from Broadcom](/azure/azure-vmware/disaster-recovery-using-vmware-site-recovery-manager#vmware-live-site-recovery-licensing-in-azure-vmware-solution).

Microsoft [supports installation and removal](/azure/azure-vmware/disaster-recovery-using-vmware-site-recovery-manager#support) of both Live Site Recovery and vSphere Replication Manager on AVS, as well as scaling the replication appliances. For those operations, use your [AVS support channel](/azure/azure-vmware/faq#who-supports-azure-vmware-solution): if you have a Cloud Solution Provider subscription, contact your provider first. Contact Broadcom directly for licensing, pairing, replication, or recovery-site configuration issues.

A workload segment doesn't require a firewall add-on. For new bring-your-own-license (BYOL) deployments, purchase and register the [VMware vDefend Firewall add-on](/azure/azure-vmware/portable-vcf-licensing-reference#vmware-vdefend-firewall-licensing) before enabling features such as nondefault distributed firewall policies.

## Monitoring and remediation

AVS monitors VMware components and hardware. Disk errors or loss of host connectivity, for example, can trigger remediation. AVS adds a healthy host and, when possible, uses vMotion to move running VMs off the faulty host so it can enter maintenance mode. AVS removes the faulty host even if it can't enter maintenance mode.

If a host fails before its VMs can move, vMotion can't evacuate it. Instead, vSphere HA restarts the affected VMs on surviving hosts with available capacity. Applications on those VMs can be unavailable while they restart. Host redundancy isn't a workload backup or a guarantee against application downtime or regional outages.

For planned maintenance, check Azure Service Health and keep VMs [ready for vMotion](/azure/azure-vmware/azure-vmware-solution-private-cloud-maintenance#actions-to-ensure-private-cloud-is-maintenance-ready). For example, detach a VM's mounted ISO image if other hosts can't access it.

## Private clouds, clusters, and hosts in Azure

A private cloud runs VMware Cloud Foundation (VCF) on dedicated Azure hosts. It starts with one vSphere cluster; additional clusters share its vCenter Server and NSX Manager. Use vSphere Client for workloads, NSX Manager for networks, and the Azure portal or API to scale within your approved regional host quota. A subscription starts with a limit of one private cloud. Use these host and cluster limits to size your private cloud:

- **Standard (non-stretched) cluster:** 3–16 hosts. Microsoft [recommends at least four for production](/azure/cloud-adoption-framework/azure-vmware-solution/operations-health-management#41-cluster-sizing-standard) to help keep data protected during maintenance on one host.
- **Gen 1 stretched cluster:** Where supported, split 6–16 hosts evenly across two availability zones, with at least three hosts per zone. Add or remove hosts in pairs, one per zone. Choose standard or [stretched clusters](/azure/azure-vmware/architecture-stretched-clusters) when you create the private cloud. You can't mix them in one private cloud or convert from one type to the other in place.

  With the [dual-site mirroring storage policy](/azure/azure-vmware/architecture-stretched-clusters#storage-policies-supported), vSAN keeps a copy of the VM's data in each data zone. A Microsoft-managed witness in a third zone helps maintain quorum (enough votes to serve the data). If a data zone fails, [vSphere HA can restart affected VMs in the surviving zone](/azure/reliability/reliability-vmware-solution#behavior-during-a-zone-failure). Clients can lose their connections while applications restart.

- **Gen 2 zonal private cloud:** A [zonal deployment](/azure/reliability/reliability-vmware-solution) runs in **one** zone. If you need an AVS recovery site for loss of that zone, plan a separate deployment in another zone or region and configure and test workload recovery.
- **Private cloud:** Up to 12 clusters and 96 hosts in total. Allow for management VMs in the first cluster, reserve capacity for high availability if a host fails, and leave free space on vSAN.

> [!CAUTION]
> Removing a host requires enough remaining capacity and compatible storage policies for all objects. [Deleting a cluster](/azure/azure-vmware/tutorial-scale-private-cloud#delete-an-existing-cluster) permanently destroys workloads and data left in it. Migrate them or verify recoverable backups first.

Normally, use one host type throughout a private cloud. In an eligible Gen 1 private cloud with standard clusters, you can add AV64 as a **separate expansion cluster**. For that expansion, reserve an [extended management address block](/azure/azure-vmware/tutorial-scale-private-cloud#prerequisites): one `/23` or three `/25` networks. A Gen 2 private cloud can start with AV64.

Compare [host specifications](/azure/azure-vmware/architecture-private-clouds#hosts) for CPU, memory, storage, and regional availability. Microsoft lists 100 Gbps of network interface throughput per host. The adapter layout varies by host type; this isn't a bandwidth guarantee for one VM, one storage connection, or ExpressRoute. Even for AV64, the generation matters:

| AV64 deployment | Where AV64 fits | Cache per host | Raw storage capacity per host |
|---|---|---|---|
| Gen 1 | Add a **separate AV64 cluster** after an eligible seed cluster of at least three AV36, AV36P, AV48, or AV52 hosts of one type. | 3.84 TB | 15.36 TB |
| Gen 2 | AV64 can be the first cluster; no other host type is needed. | No separate cache tier | 19.25 TB |

If you run an [AV36 private cloud](https://azure.microsoft.com/updates/?id=503883), move its workloads to a supported destination by **August 30, 2027**. The private cloud becomes inaccessible on August 31, 2027, even if its reservation runs longer. A new AV64 Gen 2 private cloud is one possible destination if its capacity and features meet your needs. You can't convert the AV36 private cloud in place.

AV36P and AV52 [retire on June 30, 2029](https://azure.microsoft.com/updates/?id=557094). The last day to buy a three-year BYOL reservation for those two host types was June 30, 2026.

Microsoft tests and updates the VMware stack. For new deployments, see the [AVS software version matrix](/azure/azure-vmware/architecture-private-clouds#vmware-software-versions), including the supported version of the optional VMware HCX migration add-on. An added cluster uses the running version **if the existing vCenter Server supports it**. Check [platform updates](/azure/azure-vmware/azure-vmware-solution-platform-updates) and Azure Service Health for your cloud's rollout.

## Interconnectivity in Azure

Azure-only workloads need no on-premises link. The connection to an Azure virtual network (VNet) depends on the generation:

- **Gen 1:** To [connect the AVS-managed ExpressRoute circuit to the VNet](/azure/azure-vmware/tutorial-configure-networking#connect-expressroute-to-the-virtual-network-gateway), redeem **the AVS circuit's authorization key** using its circuit ID on the ExpressRoute virtual network gateway. Reuse an existing gateway if it has capacity. A VNet can connect to at most four circuits from one peering location; the [gateway SKU](/azure/expressroute/expressroute-about-virtual-network-gateways#feature-support-by-gateway-sku) limits the total across locations.
- **Gen 2:** AV64 hosts attach directly to your VNet without an AVS-managed circuit or Global Reach. Use [supported peering or hub connections](/azure/azure-vmware/native-network-design-consideration) to reach other VNets, and ExpressRoute or a site-to-site VPN for optional on-premises access.

  When you add, change, or remove an advertised NSX workload prefix, synchronize each affected VNet peering and test reachability from the peer. [Automatic peering sync](/azure/azure-vmware/native-auto-peering-sync) is an opt-in preview for eligible peers in the same subscription and tenant. You still need to set up the peering.

For **Gen 1 hybrid access** with [ExpressRoute Global Reach](/azure/azure-vmware/tutorial-expressroute-global-reach-private-cloud), supply **your on-premises circuit's resource ID and authorization key** to AVS. This links your functioning, privately peered circuit directly to the AVS circuit, not through the VNet gateway.

For Global Reach, confirm that your gateways and ExpressRoute provider support four-byte autonomous system numbers (ASNs). Advertise a route that covers your on-premises management clients and is more specific than `0.0.0.0/0`. The AVS management network won't use a default route alone for return traffic.

**Gen 1 example: on-premises ExpressRoute Global Reach**

:::image type="content" source="../media/3-networking-overview.png" border="false" alt-text="Diagram that shows how a Gen 1 AVS private cloud uses Global Reach for on-premises access and a separate gateway for VNet access.":::

If Global Reach isn't available, one Gen 1 option is to [route traffic through a network virtual appliance (NVA) in Azure](/azure/azure-vmware/architecture-network-design-considerations#connectivity-between-azure-vmware-solution-and-an-on-premises-network). Connecting both ExpressRoute circuits to the same VNet gateway doesn't, by itself, route traffic between them.

## Private cloud storage

vSAN pools local flash storage into a datastore for the cluster's VM files. Gen 1 AV64 uses Original Storage Architecture (OSA): each disk group has a cache device and capacity devices. AV48 and Gen 2 AV64 use Express Storage Architecture (ESA): one storage pool per host, no separate cache tier. After accounting for data protection and free space, usable VM capacity is less than raw capacity.

> [!IMPORTANT]
> Keep at least **25% of the vSAN datastore free**. For the [standard-cluster availability service-level agreement (SLA)](/azure/azure-vmware/faq#storage), VM storage policies must tolerate one failure (FTT-1) for 3–5 hosts and two (FTT-2) for 6–16. At the sixth host, check and update policies on **existing VM storage objects**, including virtual disks. Neither adding a host nor changing the datastore default updates them. Stretched clusters have separate site-mirroring and local fault-tolerance requirements.

If you need more storage, match the option to the kind of data you're storing:

| Need | Storage option |
|---|---|
| More space for VM disks, but no more compute | Local vSAN is included. In supported configurations, you can add an [Azure NetApp Files NFSv3 datastore](/azure/azure-vmware/attach-azure-netapp-files-to-azure-vmware-solution-hosts) or an [iSCSI-backed VMFS datastore on Azure Elastic SAN](/azure/azure-vmware/configure-azure-elastic-san). Datastore support doesn't guarantee recovery-tool support. Before placing protected VMs, check the [AVS recovery compatibility matrix](/azure/azure-vmware/ecosystem-disaster-recovery-vms): VMware Live Site Recovery on AVS supports vSAN, but external datastores are still under testing. |
| Application files | A guest VM can mount an Azure Files share or an Azure NetApp Files SMB or NFS share. A guest mount isn't an ESXi datastore. |
| Objects or file synchronization | Applications can write objects to Azure Blob Storage. Windows file servers can use Azure File Sync to sync files with Azure Files. Neither is an ESXi datastore. |

## Security and compliance

> [!NOTE]
> [AVS audit reports](/azure/azure-vmware/vulnerability-management) are available to active Microsoft customers. Sign in to the [Service Trust Portal](/compliance/assurance/stp-get-started) with your organization's Microsoft cloud account and accept the nondisclosure agreement if prompted. For the healthcare company, verify that AVS and the controls you need are in the report's scope.

The report is evidence for the platform, not the application. Your team must configure and demonstrate its own controls, such as which users can read patient records.

Azure role-based access control (RBAC) authorizes changes to the Azure resource. Assigning someone the Azure subscription Owner role doesn't give their identity a vCenter role or ESXi root access. For daily work, use named external identities and assign only the required vCenter roles. Follow the [AVS Run command procedure](/azure/azure-vmware/configure-identity-source-vcenter) for Microsoft Entra ID federation or Windows Server Active Directory over LDAPS. The identity provider authenticates users; vCenter roles authorize workload actions.

Reserve the built-in local **CloudAdmin account** for emergency (break-glass) access. Restrict [Azure role assignments](/azure/role-based-access-control/permissions/compute#microsoftavs) that let someone [retrieve the private cloud's shared VMware administrator credentials](/azure/azure-vmware/tutorial-access-private-cloud#connect-to-the-vcenter-server-of-your-private-cloud). That permission lets them use the shared account even if their own identity has no vCenter role.

The **CloudAdmin role** can manage workload VMs, browse datastores, and allocate space. It can't change Microsoft-managed host or distributed-switch configuration or grant unrestricted vCenter privileges.

**vSAN encrypts data at rest by default.** That protects patient records on disk, not traffic between sites. [ExpressRoute provides a private path but doesn't encrypt traffic by default](/azure/expressroute/expressroute-about-encryption). For example, use [Transport Layer Security (TLS) between application endpoints](/azure/security/fundamentals/data-encryption-best-practices#protect-data-in-transit) to protect patient records in transit.

The AVS key-management system supplies the key-encryption keys for vSAN:

| Key protection | How the keys protect disk data |
|---|---|
| Default: Microsoft-managed keys | Microsoft manages the keys. The vSAN key-encryption keys wrap the data-encryption keys that ESXi uses to encrypt disk data. You don't need your own key vault. |
| Optional: customer-managed key | The private cloud's system-assigned managed identity accesses your key in Azure Key Vault. Your key wraps the vSAN key-encryption keys, which wrap the data-encryption keys. ESXi still uses the data-encryption keys for disk data, not your vault key. |

For [customer-managed keys](/azure/azure-vmware/configure-customer-managed-keys), use a vault in the same region as the private cloud with soft delete and purge protection. Enable the private cloud's system-assigned managed identity and grant it `get`, `wrapKey`, and `unwrapKey` permissions on the key. If the vault firewall restricts access, [allow trusted Microsoft services through it](/azure/azure-vmware/configure-customer-managed-keys#prerequisites) so AVS can use the key.

When AVS removes a host, it immediately invalidates its SSD data.

## Deployment milestones

Use these checkpoints to plan a move; you don't need to deploy a private cloud for this module.

1. **Plan capacity and licensing.** Assess workload dependencies and choose a supported generation, region, host type, and count. Confirm an eligible Enterprise Agreement, Microsoft Customer Agreement, or Cloud Solution Provider subscription. Obtain [regional host quota](/azure/azure-vmware/request-host-quota-azure-vmware-solution) for that SKU. For new hosts, confirm your portable VCF entitlement and register the physical cores on this private cloud's BYOL hosts during provisioning.
1. **Reserve addresses.** Set aside an unused RFC 1918 private `/22` block outside `172.17.0.0/16` for management and vMotion. Check for overlaps with on-premises networks, other Azure VNets, and guest segments. If you plan to use Azure Arc-enabled VMware vSphere, confirm that neither the management `/22` nor any workload network overlaps the [pod or service ranges reserved by the Arc resource bridge](/azure/azure-arc/resource-bridge/network-requirements#designated-ip-ranges-for-arc-resource-bridge). You can't change the management block after deployment. Plan routes, DNS, and required ports for both management and guest networks.

   For [Gen 2](/azure/azure-vmware/native-create-azure-vmware-virtual-network-private-cloud), the management `/22` can be unused address space within the host VNet itself. Reserve [two additional `/24` networks](/azure/azure-vmware/native-network-design-consideration#routing-and-subnet-considerations) outside that block: one for cloud-side HCX management and one for its uplink. Reserve them even if you don't enable HCX. If you choose Azure DNS Private Resolver, reserve a dedicated subnet in the host VNet outside the management `/22` and delegate it to the resolver for its inbound endpoint. The [AVS private DNS example](/azure/azure-vmware/native-dns-forward-lookup-zone#configure-private-dns-for-your-azure-vmware-solution-generation-2-private-cloud) uses two `/28` subnets because it also creates an outbound endpoint. You don't need the outbound endpoint for on-premises queries about AVS management names.

1. **Provision the private cloud.** Follow the instructions for the generation you've selected:

   - **[Gen 1](/azure/azure-vmware/tutorial-create-private-cloud):** Confirm that the deployment identity has at least [Contributor-level access on the subscription](/azure/azure-vmware/tutorial-create-private-cloud#prerequisites). Register the `Microsoft.AVS` resource provider and create the private cloud. For VNet access, connect its managed circuit to the ExpressRoute gateway.
   - **[Gen 2](/azure/azure-vmware/native-create-azure-vmware-virtual-network-private-cloud):** Confirm that the deployment identity can create resources and assign roles at the subscription level. A subscription Owner can do both; User Access Administrator grants role-assignment permission, not resource creation. The Gen 2 deployment role assignments must be unconditional.

     In Microsoft Entra ID, verify that both [first-party applications](/azure/azure-vmware/native-first-party-principle-security), **Avs Fleet Rp** and **AzS VIS Prod App**, are enabled. If either is disabled, ask someone with [permission to edit enterprise applications](/azure/azure-vmware/native-first-party-principle-security#prerequisite), such as a Microsoft Entra Cloud Application Administrator, to enable it. Being an Azure subscription Owner doesn't grant this directory permission.

     Before deploying, review local and inherited Azure Policy assignments on the host VNet and its resource group. If a rule would [block AVS from creating a required network security group or route table](/azure/azure-vmware/native-network-design-consideration#limitations), work with your governance team on an exception limited to that rule and deployment. Remove the exception after provisioning to restore enforcement.

     Register `Microsoft.AVS` and `Microsoft.BareMetal`. Deploy AV64 into a host VNet with room for the management block. The host VNet, the private cloud, and any network security groups associated with that VNet must share a resource group. Only one private cloud is supported per host VNet and per resource group. If the host VNet links to a route table or DDoS Protection plan in another resource group or subscription, AVS doesn't support that link by default and NSX segment routes might not propagate. Remove the link or [assign the AVS on Fleet VIS Role](/azure/azure-vmware/native-network-design-consideration#limitations) to **AzS VIS Prod App** at the referenced resource group or subscription.

1. **Validate access.** After provisioning shows **Succeeded**, verify DNS and HTTPS access to vCenter Server and VMware NSX Manager from a privately connected management client.

   If you use Gen 2 private DNS, keep Azure-provided DNS on the **host VNet**. Custom DNS on that VNet breaks platform operations such as scaling. To resolve management names from on-premises, [forward queries for the private cloud's zone](/azure/azure-vmware/native-dns-forward-lookup-zone) to an Azure DNS Private Resolver inbound endpoint in the host VNet, or to a DNS server there that forwards them to Azure DNS.

   For a workload test, create an [NSX workload segment](/azure/azure-vmware/tutorial-nsx-t-network-segment), attach a test VM, and check that an intended client can reach its application.

1. **Add on-premises access only if needed.** Establish the path for the chosen generation. Check routes at the on-premises edge and test DNS and application access from an on-premises client.
1. **If migrating with VMware HCX, test a move.** Enable the HCX add-on on each participating AVS private cloud. Reachability alone isn't enough: check [AVS network ports](/azure/azure-vmware/tutorial-network-checklist#required-network-ports) and [Broadcom's HCX port requirements](https://ports.broadcom.com/home/VMware-HCX) for the version installed at each site. For HCX 4.11 or later, the older HCX license-validation endpoint entry in the AVS checklist no longer applies. Check that the path meets the bandwidth and latency requirements for your migration method. Pair the sites according to the source:

   - **On-premises vSphere:** The [pairing tutorial](/azure/azure-vmware/configure-vmware-hcx#prerequisites) uses Gen 1 ExpressRoute Global Reach. For Gen 2, [connect to the host VNet](/azure/azure-vmware/native-connect-on-premises), for example over ExpressRoute.

     Download the [HCX Connector virtual appliance (OVA)](/azure/azure-vmware/install-vmware-hcx#vmware-hcx-connector-on-premises) from `AVS_Official_HCX_Connector_Binaries` on the destination private cloud's vSAN datastore. Deploy and power it on in your on-premises vSphere cluster. Activate it with the HCX activation key from AVS and configure it to use the source vCenter Server and single sign-on service. Pair the Connector with the destination HCX Cloud Manager.
   - **Another AVS private cloud:** Establish supported connectivity between the clouds, such as the [Gen 1 to Gen 2 ExpressRoute connection](/azure/azure-vmware/native-connect-private-cloud-previous-edition). [Pair the source and destination HCX Cloud Managers](/azure/azure-vmware/migrate-between-private-clouds#configure-site-pairing-between-the-private-clouds). Don't deploy a Connector in the source private cloud.

   For either source, configure the network and compute profiles, create the service mesh, and verify that the interconnect tunnel is **UP**.

   Use a routed destination network if the VM can change IP addresses. If it must keep its address while the source network is still in use, consider a [temporary HCX Layer 2 extension](/azure/cloud-adoption-framework/azure-vmware-solution/migration#162-network-extension-governance). To extend an on-premises network, [check the source network type](/azure/azure-vmware/configure-vmware-hcx#prerequisites): HCX can extend a supported distributed port group or NSX segment, but not a network on a vSphere Standard Switch.

   While the extended network's default gateway remains at the source site, either on-premises or in the source AVS private cloud, the migrated VM can still depend on that site for routed traffic.

   Map the test VM to the chosen network, migrate it, and test the application and its dependencies from a client. Define when to roll back and [test the rollback path for the chosen migration method](/azure/cloud-adoption-framework/azure-vmware-solution/migration#3-migration-execution) before moving production VMs.

   After the last workload on an extended segment moves, coordinate the gateway handoff and removal of the temporary extension. Confirm the AVS gateway routes traffic correctly before retiring the source network.

> [!NOTE]
> For each host type and region, [request the new total](/azure/azure-vmware/request-host-quota-azure-vmware-solution), not just the extra hosts. If you have three hosts and need two more, request five. Allow up to five business days for allocation.
>
> Unused quota normally expires after 30 days, except for quota up to the number of reserved instances. A reservation doesn't replace quota approval, and provisioning the private cloud still takes several hours.
