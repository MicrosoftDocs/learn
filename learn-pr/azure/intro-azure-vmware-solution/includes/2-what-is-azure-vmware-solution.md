Azure VMware Solution (AVS) gives you a private cloud: a VMware environment on dedicated Azure hosts. You can move compatible applications without redesigning them, deploy new virtual machines (VMs), and connect applications to Azure services over time. Microsoft operates the hosts and patches the VMware platform. You manage your guest operating systems, applications, and data.

## How the private cloud connects

The following table shows a **Gen 1 hybrid example**: a private cloud with connections to an Azure virtual network (VNet) and an on-premises datacenter.

| Part of the deployment | Role in this example |
| --- | --- |
| AVS private cloud | VMware vSphere runs VMs on ESXi hosts. vCenter Server manages the VMs, vSAN provides the cluster's built-in datastore, and VMware NSX connects workload networks. VMware Hybrid Cloud Extension (HCX) is an optional migration add-on. |
| Azure VNet | An ExpressRoute virtual network gateway connects the VNet to the AVS-managed ExpressRoute circuit. |
| On-premises VMware datacenter | Where available, ExpressRoute Global Reach links your on-premises ExpressRoute circuit directly to the AVS circuit at Microsoft's network edge, not through the VNet gateway. |
| Azure identity and services | Microsoft Entra ID authenticates users in Azure. An AVS application can use Azure SQL Database. For a Windows desktop lab, Azure Virtual Desktop runs session hosts on Azure VMs alongside AVS, not on the VMware hosts. |

In [Gen 2](/azure/azure-vmware/native-introduction), AV64 hosts attach directly to your Azure VNet. This attachment needs neither an AVS-managed circuit nor Global Reach. For on-premises access, choose a supported route to the VNet, such as ExpressRoute or a site-to-site VPN.

For a new private cloud, [start with Gen 2](/azure/cloud-adoption-framework/azure-vmware-solution/strategy#what-azure-vmware-solution-generation-to-use) if it meets your regional, capacity, and feature requirements. For example, if you need a stretched cluster, choose Gen 1 in a region that supports it. To change generations later, you must deploy a new private cloud and migrate the workloads.

## Manage and move workloads

Use these tools to manage the private cloud and prepare workloads for migration:

- **Provision and scale the private cloud** through Azure Resource Manager using the Azure portal, Azure CLI, or PowerShell. A subscription is initially limited to one private cloud. To add compute and local vSAN storage, check host availability and obtain [host quota for the host type and region](/azure/azure-vmware/request-host-quota-azure-vmware-solution). Allow for management VMs, host failures, and vSAN free space.
- **Manage VMware workloads** with vSphere Client connected to vCenter Server. Use NSX Manager for workload networks. Your team can reuse VMware skills but still needs to understand Azure networking and permissions. Check whether existing automation needs privileges that Microsoft reserves for platform management.
- **Manage selected VM tasks from Azure.** Connecting vCenter Server to [Azure Arc for AVS](/azure/azure-vmware/deploy-arc-for-azure-vmware-solution) discovers VMware resources. To start or stop a VM from Azure, onboard that VM for virtual hardware management. To install guest extensions, also enable [guest management](/azure/azure-vmware/arc-onboard-vms). The VM needs a supported guest OS and connectivity to the required endpoints. With the VM powered on and VMware Tools running, the portal can use authorized guest credentials to install the Azure Connected Machine agent.
- **Plan the cutover.** Use Azure Migrate to assess VMs and their dependencies, then check application compatibility. HCX Enterprise replication-assisted vMotion can synchronize several eligible VMs at once, but the interconnect appliance pair on a given service mesh performs [one final switchover at a time](https://knowledge.broadcom.com/external/article/373010/hcx-bulk-migration-replication-assiste.html). Allow for that sequence when scheduling dependent VMs. HCX bulk migration restarts the VM at the destination; cold migration requires it to be off. Choose a [migration method](/azure/azure-vmware/architecture-migrate) that fits your downtime window.

Microsoft supports the AVS platform. Open an [Azure support request](/azure/azure-vmware/faq#who-supports-azure-vmware-solution), or contact your Cloud Solution Provider (CSP) first if it manages your subscription.

Microsoft's [audit reports](/azure/azure-vmware/vulnerability-management) cover specified platform controls. Your team still needs to demonstrate that its own applications meet the requirements that apply to them.

## Use Azure services alongside AVS

You can use the following services and tools with applications running on AVS. They're optional and aren't installed with the private cloud.

Internet access is off by default for a new private cloud. For services that an application calls from an AVS guest, check that the guest can resolve and reach the required endpoints through supported private connectivity or controlled outbound access. An outbound connection doesn't require exposing the guest to inbound internet traffic.

| Application goal | Examples and their roles |
| --- | --- |
| Connect services and automate work | Azure Relay connects services across network boundaries. Azure Logic Apps and Power Automate can run workflows. |
| Build and deliver apps | Use the [Microsoft 365 Agents SDK](/microsoft-365/agents-sdk/bf-migration-guidance) to develop conversational apps. Azure Pipelines in Azure DevOps can deploy code to Azure App Service or Azure Functions. |
| Analyze business records | Use [Link to Data lake (Azure Synapse Link for Dataverse)](/power-apps/maker/data-platform/azure-synapse-link-data-lake) to export Dynamics 365 or Power Apps records from Dataverse. Use an Azure Data Lake Storage Gen2 account in the same Microsoft Entra tenant as Power Apps. Enable hierarchical namespace on the account and change tracking on the selected tables. Restricting storage access to selected networks requires [configuring the link with a managed identity](/power-apps/maker/data-platform/azure-synapse-link-msi). Check that your cloud supports this option. The link service, not the AVS guest, writes and updates the files. It doesn't create a SQL database replica. |
| Analyze and report on data | Azure Data Factory moves data to Azure Databricks or Azure Synapse Analytics for processing. Azure Analysis Services models data for reports in the Power BI service. |
| Process events | Azure Event Hubs receives application events that Azure Stream Analytics can process. |
| Add AI and search | Use Foundry Tools for tasks such as speech recognition, Azure Machine Learning to train models, and [Foundry IQ (Azure AI Search)](/azure/search/search-what-is-azure-search) to retrieve relevant information. |

### Monitor, protect, and deliver workloads

Choose integrations for the task. For example, collecting VMware platform logs is different from collecting events inside a guest VM.

| Task | Service and configuration |
| --- | --- |
| Monitor the private cloud | Azure Monitor platform metrics and Azure Activity Log events are available without a workspace. To query [VMware syslog](/azure/azure-vmware/configure-vmware-syslogs) in Log Analytics, configure a diagnostic setting on the private cloud, select `vmwaresyslog`, and choose the destination workspace. |
| Monitor a guest VM | Enable guest management on the Arc-enabled VM and install [Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-overview). Associate a data collection rule (DCR) that selects the guest events or performance counters to collect and where to send them. |
| Protect guest servers | Onboard eligible machines to Microsoft Defender for Cloud and enable the appropriate Defender for Servers plan. Creating the private cloud doesn't enable guest protection. For endpoint detection and response, check the Defender for Endpoint integration and verify that the sensor is onboarded and reporting. A machine can appear in [device inventory](/azure/defender-for-cloud/integration-defender-for-endpoint#resource-discovery-and-onboarding-status) before either happens. |
| Investigate security events | Enable Microsoft Sentinel on the Log Analytics workspace and [connect the workspace to the Microsoft Defender portal](/azure/sentinel/microsoft-sentinel-onboard) if it wasn't connected automatically. Configure connectors for your data sources. Some connectors bring in existing alerts; to generate alerts from raw events, enable or create the appropriate analytics rules. Investigate the results in the Defender portal. |
| Store application files | A guest VM can mount an [Azure NetApp Files](/azure/azure-vmware/netapp-files-with-azure-vmware-solution) share over Server Message Block (SMB) or Network File System (NFS). The mount gives the guest access to files; it doesn't expand the ESXi datastore that holds the VM's disks. |
| Back up workload VMs | For this design, run [Microsoft Azure Backup Server](/azure/azure-vmware/set-up-backup-server-for-azure-vmware-solution) on a dedicated, domain-joined Windows Server VM in Azure. Check that Backup Server can reach both destinations on the [required ports](/azure/backup/backup-azure-backup-server-vmware#prerequisites): vCenter Server on TCP 443 and the ESXi hosts on TCP 443 and 902. Choose a Recovery Services vault in the AVS private cloud's region. Check its storage redundancy before configuring backups. Register Backup Server with the vault **even for disk-only backups**. Attach data disks to the VM and add their empty volumes to Backup Server's disk storage for local recovery points. In Backup Server, add vCenter Server over trusted HTTPS using an account with backup permissions. To protect discovered VMs, [create a protection group](/azure/azure-vmware/backup-azure-vmware-solution-virtual-machines#configure-a-protection-group), select the workload VMs, and set the disk backup schedule and retention. Enable and schedule online protection if you also want recovery points in the vault. Store the encryption passphrase securely outside Backup Server, for example in Azure Key Vault. If the server fails, you'll need the passphrase to [recover the online backups](/azure/backup/backup-azure-alternate-dpm-server#recover-the-data) using another Backup Server registered to the same Recovery Services vault. Test a restore from the recovery points you intend to use. |
| Route web requests | Azure Application Gateway routes HTTP and HTTPS requests to reachable AVS application backends at layer 7. For web application firewall (WAF) protection, associate an enabled [WAF policy](/azure/web-application-firewall/ag/create-waf-policy-ag) with the WAF_v2 gateway, listener, or path that handles these requests. Detection mode logs rule matches without blocking. Use Prevention mode to enforce blocking rules. |
| Direct clients across sites | [Azure Traffic Manager](/azure/traffic-manager/traffic-manager-overview) uses DNS to select among public-facing endpoints, such as one serving an AVS app. Clients connect directly to that endpoint, not through Traffic Manager. |

> [!IMPORTANT]
> Keep the Azure subscription active and maintain [Backup Server's required Azure connectivity](/azure/backup/backup-support-matrix-mabs-dpm#networking-and-access-support), even for disk-only backups. If Backup Server is disconnected from Azure Backup for more than 15 days, [backups to disk and Azure stop](/azure/backup/backup-support-matrix-mabs-dpm#dpmmabs-connectivity-to-azure-backup).

## Plan for recovery

A standard cluster helps protect against host failure. It isn't a backup or a recovery plan for a zone or regional outage. Microsoft backs up private-cloud management components. For catastrophic loss of a management component, [request a restore through Azure Support](/azure/azure-vmware/architecture-private-clouds#backup-and-restore). Those backups aren't recovery points for your workload VMs; you protect those VMs yourself.

> [!NOTE]
> Even with a geo-redundant vault, [Azure Backup Cross Region Restore](/azure/backup/backup-support-matrix#cross-region-restore) doesn't support backups made with Microsoft Azure Backup Server. If your workload must recover in another region, choose and test a recovery solution that supports that region.

To use AVS as a recovery site for on-premises VMs, decide how much data loss and downtime you can tolerate. Configure replication to AVS or use a backup solution that can restore those VMs there. To [test recovery](/azure/reliability/reliability-vmware-solution) against your targets without moving production, run a test failover for a replica or a test restore from a backup.

Plan how you'll protect changes made in AVS after a real failover. If you use VMware Live Site Recovery and intend to return on-premises, include [reprotection and failback](/azure/azure-vmware/disaster-recovery-using-vmware-site-recovery-manager#vmware-srm-protection-reprotection-and-failback) in your recovery plan. Once the original site is ready, reverse replication to copy changes from AVS back to that site. After the changes are synchronized, move production back and resume replication from the on-premises site to AVS.

## Estimate host, network, VMware, and guest costs separately

**Azure hosts.** Azure bills per provisioned host, not per guest VM. Pay as you go for variable usage. For steady usage, check [host pricing and available reservation terms](https://azure.microsoft.com/pricing/details/azure-vmware/) for your host type and region. A one- or three-year reservation is a commitment that discounts usage on matching running hosts within its scope. It doesn't deploy a host, guarantee capacity, or replace quota approval. Check the exchange and cancellation terms before buying.

**Network path.** In the Gen 1 example, the AVS-managed ExpressRoute circuit isn't metered, but Azure charges for the VNet gateway. For hybrid access over ExpressRoute, include your own circuit and any outbound data charges under its plan. Gen 2 doesn't need the AVS-managed circuit or gateway just to attach to the host VNet. See the [AVS billing examples](/azure/azure-vmware/faq#billing).

**VMware subscription.** New hosts require a [portable VMware Cloud Foundation (VCF) subscription](/azure/azure-vmware/portable-vcf-licensing-reference), separate from Azure host charges. Use eligible portable cores you already hold; if you need more, obtain them from Broadcom or a reseller partner. In the Azure portal, [register the physical cores on the bring-your-own-license (BYOL) hosts in each private cloud](/azure/azure-vmware/vmware-cloud-foundations-license-portability). For example, three BYOL AV64 hosts with 64 physical cores each need **192 portable VCF cores**. Update the count when you add or remove BYOL hosts. If you share a key across private clouds, the total registered can't exceed your entitlement.

> [!NOTE]
> Pay-as-you-go hosts need portable VCF. Don't count cores still covered by a license-included reservation as BYOL. To stay on AVS, transition those hosts to portable VCF by the earlier of reservation expiry or **August 30, 2027**. If you won't transition, move the workloads before coverage ends.

Before [exchanging an active license-included reservation](/azure/azure-vmware/faq#can-i-exchange-my-azure-vmware-solution-ri-for-another-eligible-azure-compute-reservation), check that a BYOL reservation is still on sale for your host type and region. The [new purchase must cover the remaining value](/azure/cost-management-billing/reservations/exchange-and-refund-azure-reservations) of the reservation you return. If you [exchange it for the equivalent AVS BYOL reservation](/azure/azure-vmware/vmware-cloud-foundations-license-portability#exchange-a-license-included-reservation), register the portable VCF license on the private cloud within 60 minutes after the exchange completes. If there's no matching offer, review other billing or migration options with Microsoft or your provider. An exchange doesn't move your workloads or extend access to retiring hardware.

**Guest licenses.** Azure Hybrid Benefit is separate from VCF. If your Windows Server or SQL Server licenses don't qualify for Azure Hybrid Benefit, you still need rights to run that software in the guest. Don't assume an on-premises perpetual license covers dedicated cloud hardware. Check your agreement, the date you acquired the licenses, and the product version against [Microsoft's dedicated cloud licensing guidance](https://www.microsoft.com/licensing/news/updated-licensing-rights-for-dedicated-cloud). If your rights don't cover this deployment, obtain the appropriate licenses before the move.

If you have eligible licenses with active Software Assurance or qualifying subscription licenses, compare the two [guest licensing models](/azure/azure-vmware/license-sql-windows-in-avs#type-of-licenses) below. An eligible Windows Server Standard or Datacenter processor license counts as 16 core licenses; SQL Server uses eligible core licenses.

- **Per VM:** License the virtual cores, subject to each product's minimum. For a VM with four virtual CPUs (vCPUs), that means at least eight Windows Server core licenses if it runs Windows Server. SQL Server has a separate minimum of four core licenses per VM.
- **Per host:** On a host running many VMs, covering all physical cores with eligible Windows Server Datacenter or SQL Server Enterprise licenses gives unlimited virtualization rights for that product on that host. Standard edition doesn't grant those host-wide rights.

For SQL Server Enterprise host licensing, apply Azure Hybrid Benefit through an [AVS VM-host affinity placement policy](/azure/azure-vmware/enable-sql-azure-hybrid-benefit) for the covered hosts and VMs. For per-VM SQL Server licensing, you can register the license type through Arc guest management and the Azure extension for SQL Server. Neither step registers portable VCF. AVS has no corresponding Windows Server guest-license registration screen; keep records of your allocations.

Check the [Microsoft Azure Product Terms for your agreement](https://www.microsoft.com/licensing/terms/productoffering/MicrosoftAzure) before scheduling parallel use. For example, under the Enterprise Agreement, eligible licenses can cover both the source and Azure for up to **180 days** from allocation to Azure when you license Windows Server Standard per VM, Windows Server Datacenter per dedicated host, or SQL Server. If you allocate eligible Windows Server Datacenter licenses **per VM**, you can continue using the licensed software on-premises without that 180-day limit while you remain eligible.
