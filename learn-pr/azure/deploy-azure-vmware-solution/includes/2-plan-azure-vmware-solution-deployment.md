Azure VMware Solution delivers VMware-based private clouds in Azure. Private clouds contain clusters built with dedicated, bare-metal Azure hosts. The hosts are deployed and managed by using the Azure portal, the Azure CLI, or Azure PowerShell. Azure VMware Solution includes VMware vSphere, vCenter, vSAN, HCX, and NSX software. 

Azure VMware Solution private-cloud hardware and software deployments are fully integrated and automated in Azure. At a high level, the following diagram shows the relationship between an on-premises VMware environment, Azure VMware Solution, and all Azure services that Azure VMware Solution can connect to.

:::image type="content" source="../media/2-simple-overview.png" border="false" alt-text="Diagram that shows the relationship of an on-premises VMware environment, Azure VMware Solution, and all Azure services that Azure VMware Solution can connect to.":::

Your company can use Azure VMware Solution to run native VMware workloads on Azure. VMs can be migrated directly from the on-premises VMware environment to Azure VMware Solution. The VMs in Azure VMware Solution run like VMs do on-premises.

Before you deploy Azure VMware Solution, you need to plan the deployment:

- Evaluate required Azure components
- Review subscription-eligibility criteria
- Open a support ticket
- Register the resource provider
- Assess the migration pattern by using Azure Migrate
- Review the Azure VMware Solution assessment
- Evaluate the Azure VMware Solution solution components

## Evaluate required Azure components

Factor in the following Azure components before Azure VMware Solution deployment:

| Component   | Notes |
| :---------- | :------------------ |
| Subscription | Create a new subscription or reuse an existing one. |
| Resource group | Create a new resource group or reuse an existing one. |
| Region | Azure VMware Solution is available globally. |
| Resource name | The Azure VMware Solution resource name can't be longer than 14 characters. If it's longer than that, public IP addresses cannot be created to use with Azure VMware Solution. |
| Host size | Host instance size is AV36: 36 cores, 576 GB of RAM, 15.36 TB of raw storage capacity, and a 3.2-TB NVMe cache.
| Node count | The minimum number of hosts is three. <br>The maximum number of hosts is 16 per vSphere cluster. <br>The maximum number of clusters in an Azure private cloud instance is 12. <br>The maximum number of nodes in an Azure private cloud instance is 96. <br>Clusters can be extended or shrunk as needed. <br>Minimum and maximum nodes need to be factored in as the environment extends or shrinks.
| Azure virtual network | Create a new Azure virtual network or reuse an existing one.
| Azure Bastion | Create a platform-as-a-service (PaaS) resource that provides seamless Remote Desktop Protocol (RDP) access to a jump host.
| Jump host | Create an Azure VM (server or desktop) to use to access the vSphere environment after deployment.

## Review subscription-eligibility criteria

You need an Azure account in an Azure subscription to deploy Azure VMware Solution. The Azure subscription must meet one of these three criteria:

- A subscription under an Azure Enterprise Agreement (EA) with Microsoft
- A subscription under a Microsoft Customer Agreement (MCA) with Microsoft
- A Cloud Solution Provider (CSP)-managed subscription under an existing CSP Azure-offers contract or an Azure plan

## Open a support ticket

This step depends on the subscription type:

- **EA and MCA customers**: Open a support ticket for additional host quota. It might take up to five business days to confirm and allocate hosts for the request.

- **CSPs**: Assign an Azure plan to a customer by using the Partner Center, then use Partner Center to open a support ticket for additional host quota. It might take up to five business days to confirm and allocate hosts for the request.

## Register the resource provider

You must register the Microsoft.Azure VMware Solution resource provider before you provision hosts. Register the resource provider by using the Azure portal, PowerShell, or the Azure CLI.

## Assess the migration pattern by using Azure Migrate

Use Azure Migrate to assess the on-premises VMware environment for Azure VMware Solution readiness. First, set up the Azure Migrate appliance for VMware. The appliance will then discover on-premises VMs. The appliance sends metadata and performance information to the Azure Migrate project.

There are two types of sizing criteria to create Azure VMware Solution assessments within the Azure Migrate project:

| Assessment type   | Details | Data |
| :---------- | :------ | :--- |
| Performance-based | Assess performance data of on-premises VMs. | Recommended node size is based on CPU, memory usage, node type, storage type, and failures to tolerate (FTT). |
| As on-premises | Assess on-premises sizing. | Recommended node size is based on the on-premises VM size along with node type, storage type, and failures to tolerate (FTT).

To do the assessment:

1. Choose to **Assess** the environment from within the Azure Migrate project.
1. In the **Assessment type** dropdown list box, select **Azure VMware Solution (Azure VMware Solution)**.
1. Provide an **Assessment name** and select the **Assessment properties** you want.
1. Select the **Select machines to assess** tab.
1. Select **Review + create assessment** to build the assessment.

## Review the Azure VMware Solution assessment

You can evaluate the assessment in Azure Migrate in the Azure portal after the appliance runs within the on-premises environment. An Azure VMware Solution assessment describes readiness, number of nodes required, and usage across nodes. It also provides a monthly cost estimate.

To view the assessment:

1. Go to **Migration goals** > **Servers**.
1. Select **Assessments** in **Azure Migrate: Server Assessment**.
1. Select the Azure VMware Solution assessment to open.

The report should look something like this:

:::image type="content" source="../media/2-assessment-summary.png" alt-text="Imaging showing Azure Migrate assessment for the Azure VMware Solution migration.":::

The **Azure VMware Solution readiness** section of the report showcases the following conditions:

| Status   | Notes |
| :---------- | :------------------ |
| Ready for Azure VMware Solution | The VM can be migrated as-is and without changes. |
| Ready with conditions | The VM might have compatibility issues that need to be addressed before full functionality is achieved with Azure VMware Solution. |
| Not ready for Azure VMware Solution | The VM won't start in Azure VMware Solution and remediation is required.  |
| Readiness unknown | Azure Migrate couldn't determine readiness because of insufficient metadata collected on-premises.

The Azure Migrate assessment report will also provide:

- The suggested tool for migration.
- Overall cost details.
- A confidence score for migration.

All of this information helps to plan out the Azure VMware Solution environment before a migration of any workloads or applications takes place.

## Evaluate solution components

The last step involves an evaluation of all remaining solution components for an Azure VMware Solution private cloud. This step includes software versions, host maintenance, lifecycle management, and backup or restore.

### VMware software versions

Here are the VMware software versions used in new deployments of Azure VMware Solution private-cloud clusters:

| Software | Version |
| :------- | :------ |
| VCSA/vSphere/vCenter | 7.0 Update 3c |
| ESXi | 7.0 Update 3c |
| vSAN | 7.0 Update 3c |
| NSX-T | 3.2.2 |

Knowledge of the VMware versions gives customers an understanding of compatibility as it relates to on-premises environments.

### Host maintenance and lifecycle management

The Azure VMware Solution private-cloud platform includes specific versions of VMware vSphere, ESXi, vSAN, and NSX-T software. The private-cloud software bundle for Azure VMware Solution is validated for use. The software bundle is deployed in new private-cloud installations and for upgrades of existing private clouds.

The upgrade process for lifecycle management doesn't require downtime for private clouds. The upgrade process ensures that each Azure VMware Solution environment automatically uses the latest version of the validated Azure VMware Solution private-cloud software.

Microsoft applies upgrades and updates on a regular schedule, so private clouds are never more than one version behind the latest release of the validated software bundle. You'll be notified of planned upgrades to the private cloud. You can defer the upgrades if the private cloud is within one version of the latest release.

Critical patches and updates are applied when they're validated. You'll be notified in advance of required critical upgrades. This policy ensures that each private cloud has critical patches and updates applied immediately.

Microsoft is responsible for the lifecycle management of NSX-T appliances, such as NSX-T Manager and NSX-T Edge. Microsoft is also responsible for bootstrapping network configuration, such as creating the Tier-0 gateway and enabling North-South routing. You're responsible for NSX-T SDN configuration. These configurations include network segments, distributed firewall rules, Tier-1 gateways, and load balancers.

### NSX-T Configuration

There are two different methods for managing AVS networking and networking services such as DNS, DHCP, and others with NSX-T. You can do configurations in NSX-T Manager or Azure Resource Manager Portal.

### Backup and restoration

Microsoft backs up Private-cloud vCenter and NSX-T configurations on an hourly schedule. Backups are kept for three days. If you require restoration from a backup, open a support request in the Azure portal.

In the next unit, we'll cover all the planning considerations for network topology with Azure VMware Solution. We'll outline each aspect so you can make sure your deployment is successful.
