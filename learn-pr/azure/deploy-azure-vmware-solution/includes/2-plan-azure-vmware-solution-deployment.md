Azure VMware Solution (AVS) delivers VMware-based private clouds in Azure. Private clouds contain clusters built with dedicated, bare-metal Azure hosts. The hosts are deployed and managed through the Azure portal, CLI, or PowerShell. AVS includes VMware vSphere, vCenter, vSAN, and NSX software. AVS private cloud hardware and software deployments are fully integrated and automated in Azure. At a high level, the following diagram depicts the adjacency of an on-premises VMware environment, AVS, and all Azure Services that AVS can connect to.

:::image type="content" source="../media/2-avs-simple-overview.png" alt-text="Simple overview of Azure VMware Solution":::

AVS will allow your company to run native VMware workloads on Azure. VMs can be to migrateds directly from the on-premises VMware environment to AVS. The VMs in AVS will run like VMs do on-premises. In order to deploy AVS, some planning steps need to occur. You'll need to evaluate required Azure components, review eligibility criteria, assess the migration pattern, plan the network topology, and evaluate the AVS solution components.

## Evaluate Azure components

The following Azure components need to be factored in prior to AVS deployment:

| Component   | Notes |
| :---------- | :------------------ |
| Subscription | Create a new or reuse an existing subscription. |
| Resource group | Create a new or reuse an existing resource group. |
| Region | AVS is deployable in: Canada Central, East US, North Central US, West US, Australia East, West Europe, Japan East, and UK South. |
| Resource name | The AVS resource name can't be longer than 14 characters. If the name is longer than 14 characters, public IP addresses cannot be created to use with AVS. |
| Host size | Host instance size is AV36: 36 cores, 576-GB RAM, 15.36-TB raw storage capacity, 3.2-TB NVMe cache.
| Node count | The minimum number of hosts is 3. The maximum number of hosts is 16 per vSphere cluster. The maximum number of nodes in an Azure Private Cloud instance is 64. Clusters can be extended or shrunk as needed. Minimum and maximum nodes need to be factored in as the environment is extends or shrinks.
| vCenter administrator password  | Create a vCenter admin password during deployment. This password is used for the cloudadmin@vsphere.local admin account. You'll use it to sign into vCenter.              |
| NSX-T administrator password  | Create an NSX-T admin password during deployment. This password is assigned to the admin user in the NSX account during the build. You'll use it to log into NSX-T Manager. |

## Review eligibility criteria

Use an Azure account in an Azure subscription to deploy AVS. The Azure subscription must meet one of the two criteria listed below:

1. A subscription under an Azure Enterprise Agreement (EA) with Microsoft.
1. A Cloud Solution Provider (CSP) managed subscription under an existing CSP Azure offers contract or an Azure plan.

For EA customers, a support ticket needs to be open for host allocation. It may take up to five business days to confirm the request.

For CSPs, assign an Azure Plan to a customer using the Partner Center. Then use Partner Center to open up a support ticket for host allocation. It may take up to five business days to confirm the request.

The Microsoft.AVS resource provider needs to be registered before provisioning hosts. Register the resource provider by using the Azure portal, PowerShell, or the AZ-CLI.

## Assess migration pattern using Azure Migrate

Azure Migrate can be used to assess the on-premises VMware environment for AVS readiness. The Azure Migrate appliance for VMware needs to be set up. The appliance will then discover on-premises VMs. The appliance sends metadata and performance information to the Azure Migrate project. 

There are two types of sizing criteria to create AVS assessments within the Azure Migrate project:

| Assessment   | Details | Data |
| :---------- | :------ | :--- |
| Performance-based | Assess performance data of on-premises VMs. | Recommended node size: based on CPU, memory usage, node type, storage type, and failures to tolerate (FTT). |
| As on-premises | Assess on-premises sizing. | Recommended node size: based on the on-premises VM size along with node type, storage type, and failures to tolerate (FTT).

First choose to **Assess** the environment from within the Azure Migrate project. Select **Azure VMware Solution (AVS)** to build out the assessment. Provide an **Assessment name** and select the right **Assessment properties**. Then select the **Select machines to assess** tab. From there,  select **Review + create** to build the assessment.

:::image type="content" source="../media/2-assess-servers-avs.png" alt-text="Image showing Azure VMware Solution being selected for assessment type, along with setting up the Assessment name and providing Assessment properties.":::

## Evaluate AVS assessment

The assessment can be evaluated once the appliance runs within the environment. An AVS assessment describes readiness, number of nodes required, usage across nodes, and provides a monthly cost estimation.

An assessment can be viewed by going to **Migration goals > Servers**. Select **Assessments** in **Azure Migrate: Server Assessment**. Then select the AVS assessment to open. The report should be similar to what is shown below:

:::image type="content" source="../media/2-avs-assessment-summary.png" alt-text="Imaging showing Azure Migrate assessment for AVS migration.":::

The AVS readiness section of the report showcases the following conditions:

| Status   | Notes |
| :---------- | :------------------ |
| Ready for AVS | VM can be migrated as is without changes. |
| Ready with conditions | The VM may have compatibility issues that need to be addressed before full functionality is achieved with AVS. |
| Not ready for AVS | The VM will not start in AVS and remediation is required.  |
| Readiness unknown | Azure Migrate couldn't determine readiness because of insufficient metadata collected on-premises.

The Azure Migrate assessment report will also showcase the suggested tool for migration, provide overall cost details, and produce a confidence score for the migration. All of this information helps to plan out the AVS environment before a migration of any workloads or applications.

## Plan network topology

A plan for network topology with AVS is an important next step. The AVS environment in Azure needs to pass network traffic to Azure services and on-premises VMware environments. 

### IP segments

IP addressing needs to be planned out before AVS deployment. At a minimum, the service ingests a /22 CIDR network address block you provide. The address space can be carved up into smaller network segments within NSX-T Manager. Those IP segments are used for vCenter, VMware HCX, NSX-T, and vMotion. AVS, your existing Azure environment, and your on-premises environment will all need to exchange routes to migrate VMs into Azure. The /22 CIDR network address block defined shouldn't overlap with network address blocks already configured on-premises or in Azure.

A VM IP segment will need to be built to create the first NSX segment in the AVS private cloud. The VM IP segment allows for deployment of VMs onto AVS. Optionally, network segments can be extended from an on-premises VMware environment to AVS. Networks on-premises need to connect to a vSphere Distributed Switch (vDS), as vSphere Standard Switches can't be extended.

### Example subnet breakdown

The following chart is an example of how to carve up the /22 CIDR network address block into different IP segments:

| Network usage | Subnet | Example |
| :------------ | :------| :------ |
| Private cloud management |/26 | 10.5.0.0/26 |
| HCX migrations | /26 | 10.5.0.64/26 |
| Global Reach reserved | /26 |	10.5.0.128/26 |
| ExpressRoute reserved | /27 |	10.5.0.192/27 |
| ExpressRoute peering | /27 | 10.5.0.224/27 |
| ESXi management | /25 | 10.5.1.0/25 |
| vMotion network | /25 | 10.5.1.128/25 |
| Replication network | /25 | 10.5.2.0/25 |
| vSAN | /25 | 10.5.2.128/25 |
| HCX uplink | /26 | 10.5.3.0/26 |
| Reserved | 3 /26 blocks| 10.5.3.64/26, 10.5.3.128/26, 10.5.3.192/26 |

### ExpressRoute and routing requirements

AVS connects to an Azure virtual network using an ExpressRoute connection that deploys with the service. The AVS provided ExpressRoute facilitates connectivity to and from the AVS private cloud to other Azure services. AVS will then connect to the on-premises data center through a provided ExpressRoute circuit. Use an existing circuit or purchase a new one.

ExpressRoute Global Reach should be enabled in order to route traffic to and from on-premises to AVS. The provided ExpressRoute circuit is not a part of the AVS private cloud deployment. All gateways involved with the deployment need to support 4-byte Autonomous System Number (ASN). An ASN is a unique identifier that is globally available and allows its autonomous system to exchange routing information with other systems. All routes between on-premises and Azure are advertised via the industry standard Border Gateway Protocol (BGP).

### Required network ports

If the networking infrastructure on-premises is restrictive, the following ports will need to be allowed:

| Source | Destination | Protocol | Port |
| :------------ | :------| :------ | :------ |
| AVS private cloud DNS server | On-premises DNS server | UDP | 53 |
| On-premises DNS server | AVS DNS server | UDP | 53 |
| On-premises network | AVS vCenter | TCP (HTTP/HTTPS) | 80, 443 |
| AVS private cloud management network | On-premises Active Directory | TCP | 389 |
| On-premises vCenter | AVS management network | TCP | 8000 |
| Web browser | Hybrid Cloud Manager (HCM) | TCP (HTTPS) | 9443 |
| Admin network | HCM | SSH | 22 |
| HCM | Cloud Gateway | TCP (HTTPS) | 8123, 9443 |
| Cloud Gateway | Layer 2 connectivity | TCP (HTTPS) | 443
| Cloud Gateway | ESXi Hosts | TCP | 80, 902 |
| Cloud Gateway (local) | Cloud Gateway (remote) | UDP | 4500, 500 |

### DHCP and DNS resolution considerations

VMs running in AVS require name resolution and DHCP services for lookup and IP address assignments. A VM on-premises can be configured or a VM in Azure to facilitate name resolution. The DHCP service built-in to NSX can be used or choose to use a local DHCP server in the AVS private cloud. Configuring DHCP in AVS won't require routing broadcasts of DHCP traffic over the WAN back to on-premises.

## Evaluate solution components

The last step involves an evaluation of all remaining solution components for an AVS private cloud. This step includes software versions, host maintenance, lifecycle management, and backup or restore.

### VMware software versions

The current software versions of AVS are as follows:

| Software | Version |
| :------- | :------ |
| VCSA/vSphere/vCenter | 6.7 Update 3 |
| ESXi | 6.7 Update 3 |
| vSAN | 6.7 Update 3 |
| NSX-T | 2.5 |

### Host maintenance and lifecycle management

The AVS private cloud platform includes specific versions of VMware vSphere, ESXi, vSAN, and NSX-T software. The private cloud software bundle for AVS is validated for use in new private cloud installations and for upgrades of existing private clouds.

The lifecycle management upgrade process doesn't require downtime for private clouds. The upgrade process ensures each AVS environment automatically uses the latest version of the validated AVS private cloud software.

Upgrades are applied on a regular cadence so private clouds are never more than one version behind the latest release of the validated software bundle. You'll be notified of planned upgrades to the private cloud. The upgrades can be deferred if the private cloud is within one version of the latest release.

Critical patches and updates are applied when they're validated. You'll be notified in advance of required critical upgrades. This policy ensures each private cloud has critical patches and updates applied immediately.

Microsoft is responsible for the lifecycle management of NSX-T appliances, such as NSX-T Manager and NSX-T Edge. Microsoft is also responsible for bootstrapping network configuration, such as creating the Tier-0 gateway and enabling North-South routing. You're responsible for NSX-T SDN configuration. This includes network segments, distributed firewall rules, Tier 1 gateways, and load balancers.

### Backup and restoration

Private cloud vCenter and NSX-T configurations are backed up on an hourly schedule. Backups are kept for three days. If restoration from a backup is required, a support request needs to be opened in the Azure portal.

In the next unit, we'll go through the deployment of AVS. All steps will be outlined so you can deploy the service in your environment.