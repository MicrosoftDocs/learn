Azure VMware Solution delivers VMware vSphere clusters built on dedicated Azure hardware. These clusters are deployed and managed through the Azure portal, the Azure CLI, or PowerShell. Microsoft manages the supported VMware platform, while you manage workloads and the supported customer-controlled configuration.

Azure VMware Solution private cloud hardware and software deployments are fully integrated and automated in Azure. At a high level, the following diagram shows the relationship between an on-premises VMware environment, Azure VMware Solution, and all Azure services that Azure VMware Solution can connect to.

:::image type="content" source="../media/2-azure-vmware-relationship-on-premises-azure-native.png" border="false" alt-text="Diagram that shows connections between on-premises VMware, Azure VMware Solution, and Azure services." lightbox="../media/2-azure-vmware-relationship-on-premises-azure-native.png":::

Your company can use Azure VMware Solution to run native VMware workloads on Azure. Virtual machines (VMs) can be migrated directly from the on-premises VMware environment to Azure VMware Solution. The VMs in Azure VMware Solution run like VMs do on-premises.

Before you deploy Azure VMware Solution, you need to plan the deployment:

- Choose the deployment generation, region, and supported host configuration
- Evaluate required Azure components
- Review subscription-eligibility criteria
- Confirm portable VMware Cloud Foundation (VCF) eligibility and registration details
- Open a support ticket to request quota
- Register the resource provider
- Reserve management, workload, and expansion address space
- Assess the migration pattern by using Azure Migrate
- Review the Azure VMware Solution assessment
- Evaluate the Azure VMware Solution components
- Decide on the host type and size of deployment

## Evaluate required Azure components

### Choose the deployment generation

This module's walkthrough deploys a standard, single-zone Generation 1 private cloud and uses its Microsoft-managed ExpressRoute circuit. It connects that circuit to a customer virtual network and uses ExpressRoute Global Reach for the demonstrated on-premises connection. Generation 1 remains supported; Generation 2 uses a different deployment and connectivity model. Don't apply the walkthrough's Generation 1 circuit and Global Reach steps to Generation 2.

Use the following comparison to choose a generation before requesting capacity or preparing networks:

| Planning decision | Generation 1 walkthrough | Generation 2 alternative |
| :--- | :--- | :--- |
| Initial hosts | Choose a supported base-cluster host type available in the region. AV64 expansion adds a separate cluster and requires an existing supported base cluster. | AV64 can form the initial private cloud. Select the AV64 SKU; there isn't a separate SKU with a Gen2 suffix. |
| Azure connectivity | Connect the AVS-managed ExpressRoute circuit to the customer virtual network through an ExpressRoute gateway. | Connect the private cloud directly to its hosting virtual network during deployment. |
| On-premises connectivity | This walkthrough uses a customer ExpressRoute circuit and Global Reach. | Use the supported ExpressRoute-gateway or site-to-site VPN design for the hosting or connected virtual network. |
| Resource providers | Register `Microsoft.AVS`. | Register `Microsoft.AVS` and `Microsoft.BareMetal`. |
| Network preparation | Reserve a management /22 separate from the connected customer virtual network. | Reserve a management /22 in the hosting-virtual-network design. Follow the Generation 2 address layout, not the Generation 1 subnet table. |
| Availability-zone design | Use standard placement for this walkthrough. A separately planned stretched alternative is available where supported. | The Generation 1 stretched-cluster option isn't supported. |

For Generation 2, confirm regional AV64 capacity and quota, use a hosting virtual network in the same resource group as the private cloud, and check the required deployment permissions. Both first-party applications, **Avs Fleet Rp** and **AzS VIS Prod App**, must be enabled. Azure creates and manages the AVS delegated subnets during deployment. Don't manually create a single delegated /22 subnet or modify service-managed subnet configuration. Reserve separate space for customer workloads and any required HCX management and uplink networks. Detailed Generation 2 provisioning is outside this walkthrough.

### Select Azure resources and host capacity

Factor in the following Azure components before Azure VMware Solution deployment:

| Component   | Notes |
| :---------- | :------------------ |
| Subscription | For the standard deployment in this walkthrough, create a new subscription or reuse an eligible existing one. The stretched-cluster alternative requires a new, separate subscription and additional enablement. |
| Resource group | Create a new resource group or reuse an existing one. |
| Region | Choose a region that supports the selected generation, host type, and availability-zone design, and confirm capacity. |
| Host location (availability-zone deployment) | Select one availability zone for the standard walkthrough. The stretched alternative uses supported placement across two zones. |
| Resource name | Provide the name of your Azure VMware Solution private cloud. |
| Host size | Select a supported host configuration from the hardware comparison that follows. |
| Host count | A standard cluster supports 3-16 hosts. A stretched cluster supports 6-16 hosts in total. Each private cloud is subject to both the 12-cluster and 96-host limits. |
| Address block for private cloud | Reserve a /22 for management services such as vCenter Server and NSX Manager, for example `10.175.0.0/22`. Complete the address-plan checkpoint before deployment. |
| Customer virtual network | Create or reuse a virtual network for the Generation 1 gateway and jumpbox. Generation 2 instead requires its hosting virtual network. |
| Azure Bastion (optional) | Create a platform-as-a-service (PaaS) resource that provides Remote Desktop Protocol (RDP) access to a jump host. |
| Jumpbox VM (optional) | Create an Azure VM to access the vSphere environment after deployment. |

Stretched clusters require equal host counts across two availability zones, with at least three hosts in each zone, and scale in pairs. Microsoft manages the witness in a third zone. Select this design only when the region and host type support it: AV64 and Generation 2 don't support this stretched-cluster deployment. Standard and stretched clusters can't be mixed in one private cloud, and you can't convert between standard and stretched placement after deployment.

For this alternative, plan two zone-specific ExpressRoute Global Reach connections. Connect each availability zone's AVS ExpressRoute circuit to the on-premises customer circuit, using a distinct customer-circuit authorization key for each connection. The standard walkthrough's single connection doesn't provide the intended zone-resilient hybrid path. Validate that both connections are successfully provisioned and connected, and test the recovery behavior required by your design before production use.

The documented stretched-cluster availability commitment also requires a workload storage policy with **Dual-Site Mirroring** and **Secondary Failures To Tolerate (SFTT) of 1**, together with the other applicable SLA requirements. The standard-cluster policy table that follows doesn't replace these site-protection requirements.

Scale clusters within their supported limits, but don't treat a minimum host count as a sizing recommendation. Stretched-cluster sizing depends on the storage policy and capacity required after a zone failure. A zone failure can require VM restarts. Stretched placement isn't a replacement for workload backup or a multi-region recovery design.

The following hardware comparison distinguishes raw storage capacity from a separate cache tier. The storage figures use decimal TB:

| Host configuration | Physical cores | RAM | Raw capacity tier | Separate cache tier |
| :--- | :--- | :--- | :--- | :--- |
| AV36P | 36 | 768 GB | 19.20 TB | 1.5 TB Intel cache |
| AV48 with Express Storage Architecture (ESA) | 48 | 1,024 GB | 25.60 TB | None |
| AV52 | 52 | 1,536 GB | 38.40 TB | 1.5 TB Intel cache |
| AV64 with Original Storage Architecture (OSA), Generation 1 expansion | 64 | 1,024 GB | 15.36 TB | 3.84 TB NVMe cache |
| AV64 with ESA, Generation 2 | 64 | 1,024 GB | 19.25 TB | None |

In Generation 1, AV64 expansion requires an existing private cloud with a supported AV36, AV36P, AV48, or AV52 base cluster. The hardware table above lists this module's new-deployment choices. AV36 is included here only for existing-cloud eligibility, and its retirement is scheduled for 30 August 2027. Plan the transition of those existing hosts with Microsoft before that date.

Request AV64 quota and add a separate AV64 cluster with at least three hosts. Don't insert AV64 hosts into the existing base-SKU cluster. Adding an AV64 cluster doesn't itself replace or retire the existing base cluster. For a new Generation 1 design that includes both a base cluster and an AV64 expansion cluster, allow for at least three hosts in each cluster, then increase those counts as required by workload capacity, storage policy, and resilience.

In Generation 2, AV64 can form the initial private cloud. Confirm the selected host configuration and regional capacity before requesting quota. For AV64, Microsoft recommends four hosts for improved operational behavior during a host failure, even though the supported standard-cluster minimum is three.

> [!IMPORTANT]
> Check CPU and Enhanced vMotion Compatibility (EVC) requirements in both migration directions when planning moves between clusters with different host SKUs. In the documented AV36P/AV52-to-AV64 scenario, a VM created or power-cycled on AV64 can expose CPU features that prevent live vMotion back to the older-CPU base cluster. Plan a supported compatible per-VM EVC baseline or a powered-off (cold) migration where necessary, accounting for potential downtime with either approach. Don't assume the same migration direction or compatibility result for AV48, and don't change Microsoft-managed host or cluster configuration.

Raw storage isn't usable VM capacity. Account for the management resource pool, hypervisor overhead, high-availability (HA) admission-control reserve, and the selected vSAN storage policy, including failures to tolerate (FTT) and RAID overhead. Keep at least 25% of usable vSAN capacity available to meet the service requirement, and allow additional operating and growth headroom where needed.

For standard, nonstretched clusters, the selected storage policy can require more hosts than the three-host service minimum. Validate the policy before requesting capacity. The following examples show the minimum supported host counts for common policies:

| Storage policy | OSA minimum hosts | ESA minimum hosts |
| --- | ---: | ---: |
| RAID-1, FTT 1 | 3 | 3 |
| RAID-5, FTT 1 | 4 | 3 |
| RAID-1, FTT 2 | 5 | 5 |
| RAID-6, FTT 2 | 6 | 6 |

A supported policy minimum isn't a complete sizing or availability plan. Check maintenance readiness and the applicable SLA separately, and account for failures and recovery capacity. Microsoft's maintenance-readiness guidance specifies FTT 1 for clusters with up to five hosts and FTT 2 for six or more. Scaling a cluster doesn't automatically update workload storage policies.

### Complete the address-plan checkpoint

> [!IMPORTANT]
> The private-cloud management CIDR can't be changed after deployment. Reserve a non-overlapping /22 from RFC1918 private space, excluding `172.17.0.0/16`, before submitting the deployment.

Check the proposed ranges against connected Azure virtual networks, on-premises networks, other private clouds, and planned expansion. Keep workload segments outside the management /22. Avoid the NSX-reserved ranges `169.254.0.0/24`, `169.254.2.0/23`, and `100.64.0.0/16`; these service/internal ranges aren't workload address pools.

For Generation 1 AV64 expansion, reserve an additional /23 or three /25 management blocks. This reservation doesn't replace the initial management /22. For Generation 2, follow its distinct hosting-virtual-network layout and reserve any required HCX management and uplink networks. If you plan to enable Azure Arc, check the Arc resource bridge's reserved-address constraints before finalizing the permanent address plan.

## Review subscription-eligibility criteria

You need an Azure account in an Azure subscription to deploy Azure VMware Solution. The Azure subscription must meet one of these three criteria:

- A subscription under an Azure Enterprise Agreement (EA) with Microsoft
- A subscription under a Microsoft Customer Agreement (MCA) with Microsoft
- A Cloud Solution Provider (CSP)-managed subscription under an existing CSP Azure-offers contract or an Azure plan

### Confirm portable VCF eligibility and registration details

New Azure VMware Solution deployments and added hosts require an eligible portable VCF subscription purchased from Broadcom. An Azure subscription and allocated host quota don't provide this entitlement. Gather the following details before deployment:

- **License/subscription key**: The 25-character key for the eligible portable VCF subscription.
- **Subscription identifiers**: The Broadcom site ID and serial number.
- **Expiration date**: The subscription's expiration date.
- **Deployed BYOL cores**: The physical cores covered by bring-your-own-license (BYOL) hosts deployed on this private cloud, not automatically the full purchased entitlement.

Register the subscription separately on each private cloud through **Portable VCF (BYOL)** in the Azure portal. Update the registration when you add or remove BYOL hosts or change or renew the subscription. For example, three AV64 BYOL hosts represent 192 physical cores. The sum registered across private clouds must stay within the purchased entitlement.

> [!IMPORTANT]
> When assessing an existing private cloud for expansion, verify licensing for its existing hosts as well as added capacity. As of 13 November 2026, the required 31 October 2026 transition to portable VCF for license-included pay-as-you-go hosts has passed. If an existing deployment hasn't completed that transition, contact Microsoft support and resolve its entitlement and registration status rather than assuming it remains covered. For hosts still covered by eligible license-included reservations, plan the transition before the reservation expires or the 30 August 2027 cutoff, whichever occurs first. Obtain the required Broadcom entitlement before exchanging a reservation for its VCF BYOL equivalent, then register the VCF details on the private cloud within 60 minutes after the exchange. Confirm that registration is successful and covers the deployed BYOL cores. Azure VMware Solution itself isn't retiring. This licensing transition is separate from the VCF 9.1 platform transition.

Protect license keys and keep them out of screenshots and shared example files. Features that require a separate vDefend entitlement need that licensing in addition to VCF. License registration, deployment generation, and the managed platform's software version are separate planning decisions.

## Open a support ticket

For EA and MCA subscriptions, create the host-quota request in **Azure portal > Help + Support**. For a CSP subscription, assign an Azure plan to the customer in Partner Center. The partner then opens the customer's **Microsoft Azure Management Portal** from Partner Center by using **Admin On Behalf Of (AOBO)** and creates the request in **Help + Support**.

Select **Service and subscription limits (quotas)**, the target subscription, and **Azure VMware Solution**. Provide the region, host SKU, and required total number of hosts for that SKU. Enter the new absolute total, not just the additional hosts. For example, increasing from three hosts to six requires a requested total of six. Allocation can take up to five business days.

For the stretched-cluster alternative, request quota against a new, separate subscription. Explicitly identify the private-cloud type as **Stretched Cluster** and provide the supported region, required even host count, contact details, and expansion plan. Wait for confirmation that the subscription is enabled for stretched deployment before selecting **Hosts in two availability zones**.

> [!IMPORTANT]
> Unused or undeployed quota normally expires after 30 days. Quota equivalent to the number of Azure VMware Solution reserved instances is exempt from this expiration. Confirm that the quota needed for your deployment remains available, and submit another request if it has expired.

If your design requires specific availability-zone alignment, such as for an Azure NetApp Files integration, submit a technical support request after quota allocation and before provisioning. This is a conditional placement requirement, not an extra prerequisite for every deployment. A request doesn't guarantee the requested placement.

## Register the resource provider

Register the `Microsoft.AVS` resource provider in the subscription where you plan to deploy the Generation 1 private cloud. You can use the Azure portal, PowerShell, or the Azure CLI. Confirm the intended subscription context and wait for the registration state to become `Registered` before provisioning hosts. For a Generation 2 deployment, also register `Microsoft.BareMetal`.

## Assess the migration pattern by using Azure Migrate

Use Azure Migrate to assess the on-premises VMware vSphere environment for Azure VMware Solution readiness. Create an Azure Migrate project and discover the VMware inventory by using the Azure Migrate appliance, an RVTools XLSX import, or a supported CSV import.

The appliance collects metadata and performance samples. File imports don't supply the same time-series CPU and memory history, and performance-history and percentile settings aren't applied to RVTools or CSV imports. For appliance discovery, collect at least a day of data and preferably the full representative period selected for the assessment.

Choose sizing criteria that match the available data and your planning assumptions:

| Sizing criterion | Data basis | Planning use |
| :--- | :--- | :--- |
| Performance-based | Appliance discovery provides CPU and memory utilization samples. File-based assessments can use utilized storage without equivalent CPU and memory history. | Review available measurements and assumptions together with host type, storage type, and FTT/RAID policy. |
| As on-premises | The VM's allocated on-premises resources. | Size from allocated CPU, memory, and storage together with the selected host and storage configuration. |

The following procedure describes the current Azure Migrate experience. Navigation can differ for existing projects using another experience.

1. In the Azure Migrate project's **Infrastructure** view, select the discovered workloads you want to assess.
1. Select **Create assessment > For Azure VMware Solution (AVS)**.
1. Enter an **Assessment name**, select **Add workloads** if you need additional workloads, and select **Next**.
1. Under **General** settings, review the target location, currency, program/offer, savings option, sizing criteria, and comfort factor. For appliance-based performance sizing, select the performance history and percentile utilization.
1. In **Advanced** settings, select **Edit defaults**, confirm **Azure VMware Solution (AVS)** as the target service, and open its defaults. Select **New SDDC** for this new private cloud. Use **AVS SDDC expansion** only when assessing an existing private cloud.
1. Review the node types for the chosen generation and region, storage options, FTT/RAID policy, and deduplication and compression assumptions. If you include external storage, review its IOPS and throughput assumptions instead of accepting unverified defaults.
1. Review CPU oversubscription, CPU headroom, and memory overcommit against the workload requirements and the capacity reserved for management operations.
1. Save any changed settings and select **Review + Create assessment**. Review the details, then select **Create** to run the assessment.

An expansion assessment doesn't measure available capacity in the existing private cloud. It considers the capacity requirements for management appliances, so you must check the existing cloud's actual capacity separately.

## Review the Azure VMware Solution assessment

After the assessment completes, open it in your Azure Migrate project. The assessment describes readiness, recommended node counts, resource usage, and estimated monthly cost for the discovered or imported workloads.

Review the results before using them to request hosts:

1. Open the completed Azure VMware Solution assessment and review its readiness and cost summary.
1. Inspect the workload-level readiness results and the reasons for any conditions, incompatibilities, or unknown results.
1. Compare recommended host counts and storage with your selected generation, region, storage policy, and standard or stretched design. Check management overhead, HA reserve, and the vSAN free-space requirement.
1. Review the available performance-data coverage and confidence indicators. For imported data, validate the resource and storage assumptions rather than treating an import as measured performance history.
1. Update assumptions and rerun the assessment when the discovered inventory, collected data, or deployment design changes.

Interpret workload readiness using the following categories:

| Status   | Notes |
| :---------- | :------------------ |
| Ready for Azure VMware Solution | The assessment identifies no compatibility changes required for migration. |
| Ready with conditions | The VM might have compatibility issues that need to be addressed before full functionality is achieved with Azure VMware Solution. |
| Not ready for Azure VMware Solution | The identified compatibility requirements need remediation before migration. |
| Readiness unknown | Azure Migrate couldn't determine readiness because of insufficient metadata. |

Use any migration-tool recommendations and confidence indicators in the report alongside the workload requirements. An assessment doesn't configure the migration tool or guarantee application readiness.

The Azure Migrate node estimate assumes that portable VCF is purchased separately from Broadcom and ported to the private cloud. It isn't a complete operating-cost estimate. Review VCF costs separately and account for connectivity, egress, the gateway, Bastion and the jumpbox, workload licensing, backup, and any external storage.

Published Azure VMware Solution node prices are per node, not per private cloud. Budget for at least three hosts in the standard cluster, or the larger count required by your assessment, and purchase the portable VCF subscription separately. The Basic Bastion used in this walkthrough incurs hourly charges while deployed, even when nobody is connected. Agree who owns the exercise costs, how long the resources will be retained, and when any disposable resources will be removed.

Validate the estimate against the selected region, host configuration, commercial terms, and measured workload behavior before committing to a deployment size.

## Evaluate solution components

The last step involves evaluating the remaining solution components for an Azure VMware Solution private cloud. This step includes software compatibility, host maintenance, lifecycle management, administrative access, and backup and recovery.

### VMware software versions

Azure VMware Solution provides a Microsoft-managed VMware platform. Microsoft validates the software deployed in new private clouds and manages updates to existing private clouds. Confirm the current Microsoft-documented vCenter Server, ESXi, vSAN, NSX, and HCX versions and the compatibility requirements of your source environment and migration tools.

The documented new-deployment baseline can differ from an existing private cloud's running version. An added cluster follows the existing private cloud's supported software configuration. Don't assume that an upstream product release or a static version table establishes the version available in your private cloud.

As of 13 November 2026, Microsoft documents a required VCF 9.1 platform transition by 11 October 2027. The transition documentation is still evolving toward general availability. Plan for the published deadline and service communications, but don't treat the announced platform as already deployed in every private cloud. This platform transition is separate from portable VCF license registration and from the choice of deployment generation.

### Host maintenance and lifecycle management

Microsoft manages updates to the platform and communicates planned maintenance and expected impact through Azure Service Health. Maintenance is designed to preserve workload availability, but its impact depends on the component and the private cloud's configuration.

During vCenter Server maintenance, running VMs can continue while vCenter management operations are unavailable. NSX maintenance can interrupt management access and cause transient packet loss. Maintenance-blocking VM configurations can require a brief workload interruption to remediate. Maintain sufficient capacity and review the maintenance prerequisites before the event.

Eligible maintenance can be rescheduled within the event's permitted window. Each event has a deadline. Rescheduling is normally available until 24 hours before the scheduled start, subject to the feature's restrictions. Critical security work and other restrictions can limit rescheduling, and exceptions require a support request.

Assign an operational owner for capacity and health alerts before handing over the private cloud. Plan Azure Monitor alerts for vSAN utilization and resource health, and Service Health notifications for relevant incidents and planned maintenance. Platform maintenance notifications don't replace workload monitoring or your responsibility to resolve maintenance-blocking configurations.

Microsoft is responsible for the lifecycle management of NSX appliances, such as NSX Manager and NSX Edge, and for bootstrapping networking, including the Tier-0 gateway and North-South routing. You're responsible for supported NSX software-defined networking configuration, including workload segments, distributed firewall rules, Tier-1 gateways, and load balancers.

### Administrative access and responsibilities

Azure role-based access control (RBAC) permissions to deploy and manage the AVS resource are separate from vCenter Server and NSX permissions. Azure Contributor doesn't grant unrestricted VMware administration. The AVS CloudAdmin role is restricted and doesn't provide unrestricted vCenter administrator or ESXi root access. Don't attempt to upgrade platform components or alter Microsoft-managed networking.

Use initial credentials for approved setup, then configure supported external identity integration and least-privilege access. Protect the local vCenter CloudAdmin account as an emergency-access account rather than using it for routine administration or service integration. Keep passwords out of screenshots and shared learning materials. Use supported Run Command and identity workflows when an operation exceeds the customer role's direct permissions.

### NSX configuration

You can configure supported workload networking features in NSX Manager or through the Azure portal's AVS networking controls. Available controls depend on the feature and deployment generation. DNS forwarding is documented for both generations; don't assume that every portal workflow is identical.

### Backup and restoration

Microsoft backs up vCenter Server and enabled HCX Manager configurations daily, and NSX configuration hourly. These configuration backups are retained for at least three days. Support-assisted restoration is intended for catastrophic recovery; open a support request in the Azure portal if restoration is required.

> [!IMPORTANT]
> Platform configuration backups don't protect your workload VMs or application data. You remain responsible for workload backup and recovery.

Before migrating production workloads, select a supported backup solution, define recovery point and recovery time objectives, configure retention, and test restoration. Snapshots and stretched-cluster placement don't replace workload and application backups.

In the next unit, we'll cover all the planning considerations for network topology with Azure VMware Solution. We'll outline each aspect so you can make sure your deployment is successful.
