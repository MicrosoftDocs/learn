Azure VMware Solution (AVS) delivers VMware-based private clouds in Azure. Private clouds contain clusters built with dedicated, bare-metal Azure hosts. The hosts are deployed and managed through the Azure portal, CLI, or PowerShell. AVS includes VMware vSphere, vCenter, vSAN, and NSX software. AVS private cloud hardware and software deployments are fully integrated and automated in Azure. At a high level, the following diagram shows the relationship between an on-premises VMware environment, AVS, and all Azure Services that AVS can connect to.

:::image type="icon" source="../media/2-avs-simple-overview.png" border="false" alt-text="Illustration that shows the relationship of an on-premises VMware environment, AVS, and all Azure Services that AVS can connect to like Azure Machine Learning, PowerApps, and so on.":::

AVS will allow your company to run native VMware workloads on Azure. VMs can be migrated directly from the on-premises VMware environment to AVS. The VMs in AVS run like VMs do on-premises.

To deploy AVS, you need to first plan the deployment. You'll need to:

- Evaluate required Azure components
- Review eligibility criteria
- Assess the migration pattern
- Plan the network topology
- Evaluate the AVS solution components

## Evaluate Azure components

The following Azure components need to be factored in before AVS deployment:

| Component   | Notes |
| :---------- | :------------------ |
| Subscription | Create a new or reuse an existing subscription. |
| Resource group | Create a new or reuse an existing resource group. |
| Region | AVS is deployable in: Canada Central, East US, North Central US, West US, Australia East, West Europe, Japan East, and UK South. |
| Resource name | The AVS resource name can't be longer than 14 characters. If the name is longer than 14 characters, public IP addresses cannot be created to use with AVS. |
| Host size | Host instance size is AV36: 36 cores, 576-GB RAM, 15.36-TB raw storage capacity, 3.2-TB NVMe cache.
| Node count | The minimum number of hosts is 3. The maximum number of hosts is 16 per vSphere cluster. The maximum number of nodes in an Azure Private Cloud instance is 64. Clusters can be extended or shrunk as needed. Minimum and maximum nodes need to be factored in as the environment extends or shrinks.
| vCenter administrator password  | Create a vCenter admin password during deployment. This password is used for the cloudadmin@vsphere.local admin account. You'll use it to sign into vCenter.              |
| NSX-T administrator password  | Create an NSX-T admin password during deployment. This password is assigned to the admin user in the NSX account during the build. You'll use it to log into NSX-T Manager. |

## Review subscription eligibility criteria

Use an Azure account in an Azure subscription to deploy AVS. The Azure subscription must meet one of the three criteria listed below:

- A subscription under an Azure Enterprise Agreement (EA) with Microsoft.
- A subscription under a Microsoft Customer Agreement (MCA) with Microsoft.
- A Cloud Solution Provider (CSP) managed subscription under an existing CSP Azure offers contract or an Azure plan.

## Open a support ticket

For EA and MCA customers, a support ticket needs to be opened for additional host quota. It may take up to five business days to confirm and allocate hosts for the request.

For CSPs, assign an Azure Plan to a customer using the Partner Center. Then use Partner Center to open up a support ticket for additional host quota. It may take up to five business days to confirm and allocate hosts for the request.

## Register resource provider

The Microsoft.AVS resource provider must be registered before provisioning hosts. Register the resource provider by using the Azure portal, PowerShell, or the AZ-CLI.

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
| Not ready for AVS | The VM won't start in AVS and remediation is required.  |
| Readiness unknown | Azure Migrate couldn't determine readiness because of insufficient metadata collected on-premises.

The Azure Migrate assessment report will also highlight:

- The suggested tool for migration
- Provide overall cost details
- Produce a confidence score for migration

All of this information helps to plan out the AVS environment before a migration of any workloads or applications.

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

The AVS private cloud platform includes specific versions of VMware vSphere, ESXi, vSAN, and NSX-T software. The private cloud software bundle for AVS is validated for use. The software bundle is deployed in new private cloud installations and for upgrades of existing private clouds.

The lifecycle management upgrade process doesn't require downtime for private clouds. The upgrade process ensures each AVS environment automatically uses the latest version of the validated AVS private cloud software.

Upgrades are applied on a regular cadence so private clouds are never more than one version behind the latest release of the validated software bundle. You'll be notified of planned upgrades to the private cloud. The upgrades can be deferred if the private cloud is within one version of the latest release.

Critical patches and updates are applied when they're validated. You'll be notified in advance of required critical upgrades. This policy ensures each private cloud has critical patches and updates applied immediately.

Microsoft is responsible for the lifecycle management of NSX-T appliances, such as NSX-T Manager and NSX-T Edge. Microsoft is also responsible for bootstrapping network configuration, such as creating the Tier-0 gateway and enabling North-South routing. You're responsible for NSX-T SDN configuration. These configurations include network segments, distributed firewall rules, Tier 1 gateways, and load balancers.

### NSX-T Configuration

There are two different methods of configuring NSX-T Manager for AVS.

### Backup and restoration

Private cloud vCenter and NSX-T configurations are backed up on an hourly schedule. Backups are kept for three days. If restoration from a backup is required, a support request needs to be opened in the Azure portal.

In the next unit, we'll go through the deployment of AVS. All steps will be outlined so you can deploy the service in your environment.