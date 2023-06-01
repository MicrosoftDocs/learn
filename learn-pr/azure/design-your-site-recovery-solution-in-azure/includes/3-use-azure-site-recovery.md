Your organization has multiple workloads, some running in the cloud and some remaining on-premises. To protect these workloads, you need to understand how to use Azure Site Recovery as part of your BCDR plan and how to use it with other Azure solutions.

In this unit, you learn about the types of machines and scenarios that Site Recovery supports for BDCR. You also learn how to integrate your existing network with Site Recovery.

## Simplify your BCDR by using Site Recovery

Site Recovery helps you simplify your BCDR. You can configure and manage your replication, failover, and failback through the Azure portal, the Azure CLI, or Azure PowerShell.

Use Site Recovery to replicate different types of targets. For example, Site Recovery can help you configure disaster recovery for Azure virtual machines. You can replicate Azure virtual machines from a primary region to a secondary region. Your on-premises virtual machines can be replicated too, along with workloads such as SQL Server.

When you replicate to Azure, the replicated virtual machine disks go into Azure Storage and are kept resilient as a result. If a failover is triggered, Azure virtual machines are created for you via the disks replicated from the source.

Site Recovery helps you meet your RTO because it can perform continuous replication for your virtual machines. Replication can occur as often as every 30 seconds for your virtual machines. This frequency means reduced RTO.

Site Recovery can recover to application-consistent snapshots. Site Recovery takes snapshots of all data in memory and on disk, and all transactions in process.

Use recovery plans in Site Recovery to:

- Group your virtual machines.
- Add scripts, manual actions, and failover.
- Recover multiple-tier applications that are spread across virtual machines.

You can set up Azure Automation runbooks to work with your recovery plans and automate the necessary steps to recover systems.

Always test your disaster recovery plan. Site Recovery lets you run disaster recovery tests with no disruption to your running replication.

If you're using other BCDR technologies, you might be able to integrate them too. For example, if you're using SQL Server Always On to help protect databases, you can use Site Recovery to manage failover of your availability groups.

## Implement a solution by using Site Recovery and Azure Backup

Let's look at a solution that incorporates Azure Backup and Site Recovery.

:::image type="content" source="../media/3-asr-backup-diagram.png" alt-text="Diagram that shows Site Recovery and Azure Backup.":::

In this example, an on-premises environment has a Hyper-V host server for hosting virtual machines. You want to back up all the files and folders in this virtual machine to Azure. You also want to protect any workloads running on the virtual machine, and keep running them even if the virtual machine fails. You can use Azure Backup and Site Recovery together as part of a single solution.

You can configure both Azure Backup and Site Recovery for your infrastructure from a Recovery Services vault. 

For Azure Backup:

1. Identify where workloads are running and what you want to back up. In this example, workloads are running on-premises, and you would back up files and folders.
1. Install any necessary agents before starting or scheduling a backup in Azure.

For Site Recovery:

1. Set your protection goal to define where machines are located and where you want to replicate them.
1. Run a deployment planner to help Site Recovery estimate whether you meet network bandwidth, storage capacity, and other requirements.
1. Prepare your source and target environments by installing a configuration server, if necessary.
1. Enable replication and help protect your virtual machines.

In this scenario, Azure Backup periodically backs up the files and folders on the Windows machine to Azure. This process helps ensure that the files and folders are secure and retrievable even if the whole on-premises environment stops functioning. Separately, Site Recovery helps protect running workloads and keep them running. Because Site Recovery can replicate frequently, you can reduce the RTO for your workloads.

To configure the backup portion of your solution in this scenario, and to help protect files and folders, you download and install the Microsoft Azure Recovery Services (MARS) agent. You can then create backup policies and automatically back up your data on a scheduled basis. The MARS agent also lets you restore all your data to either the same source machine or a different machine. With Azure Backup, your data is also encrypted before it's backed up.

To set up Site Recovery, you install the Site Recovery Services agent and a Site Recovery Provider agent on the Hyper-V server. These tools are used for replication and orchestration of failover to Azure. When a failover is triggered, new virtual machines can be created for you based on the machines that Site Recovery has helped protect.

## Integrate your on-premises network with Site Recovery

You can keep your private IP addresses from on-premises machines and use them for target Azure machines. You create a virtual network in Azure where your virtual machines are provisioned when failover is triggered. This network acts as an extension of your on-premises network.

As part of your failover, you need establish or configure a site-to-site VPN connection or use Azure ExpressRoute for connectivity between Azure and on-premises networks.

## Help protect different scenarios by using Site Recovery

Site Recovery allows replication of different types of machines in different scenarios. You can use Site Recovery to help protect:

- Azure virtual machines and replicate them from a source region to a different target region.
- On-premises virtual machines to Azure, whether they're Hyper-V or VMware based.
- Physical servers running Linux or Windows.
- Virtual machines hosted on other cloud providers.

You can also replicate both Hyper-V and VMware-based machines (managed by System Center), and your physical servers, to your own secondary site. Site Recovery replicates any of your workloads that are running on supported machines.
