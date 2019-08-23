You can use Azure Site Recovery as part of your organization's disaster recovery process.

Your organization has multiple workloads, some running in the cloud and some remaining on-premises. To protect these workloads, you'll need to understand how to use Azure Site Recovery as part of your business continuity and disaster recovery plan, and how it can be used with other Azure solutions.

In this unit, you'll see how Azure Site Recovery simplifies your business continuity and disaster recovery process. You'll see the different types of machines and scenarios that are supported with Azure Site Recovery. And you'll learn how to integrate your existing network with Azure Site Recovery.

## Simplify your BCDR with Azure Site Recovery

Azure Site Recovery helps you simplify your BCDR – you can configure and manage your replication, failovers, and failbacks, all through the Azure portal.
Use Azure Site Recovery to replicate different types of targets. For example, Azure Site Recovery can help you configure disaster recovery for Azure virtual machines. You can replicate Azure virtual machines from a primary to a secondary region. Your on-premises virtual machines can be replicated too, along with workloads.

When you replicate over to Azure, the associated data goes into Azure storage and is kept resilient as a result. If a failover is triggered, Azure virtual machines are created for you, using this data that's replicated and stored in Azure storage.
Azure Site Recovery helps you meet your recovery time objective because it can perform continuous replication for your virtual machines. Replication can occur as often as every 30 seconds for any Hyper-V virtual machine – this means reduced recovery time objective. You can make recovery time objectives even shorter if you use Azure Traffic Manager with your Azure Site Recovery service.
Site Recovery can recover to application-consistent snapshots. Site Recovery takes snapshots of all data that's in memory, all data on disk, and all transactions in process.

Use Azure Site Recovery's recovery plans to group your virtual machines, add scripts, manual actions, and failover – and recover multi-tier applications that are spread across different virtual machines. You can set up Azure automation runbooks to work with your recovery plans.

Always test your disaster recovery plan. Azure Site Recovery lets you run disaster recovery tests with no disruption to your running replication.

If you're using other BCDR technologies, you may be able to integrate those too. For example, if you're using SQL Server Always On to protect databases, you can use Azure Site Recovery to help manage failovers of your availability groups.

## Implement a solution using Site Recovery and Azure Backup

![alt text](../media/3-asr-backup-diagram.png)

<!---Feel free to format this diagram according to your own standards-->

The example solution shown above incorporates Azure Backup and Azure Site Recovery.

There's an on-premises environment that has a Hyper-V host server for hosting virtual machines. You want to back up all the files and folders in this virtual machine to Azure. You also want to protect any workloads running on the virtual machine, and keep running them even if the virtual machine fails. Azure Backup and Azure Site Recovery can be used together as part of a single solution.

You can configure both backup and site recovery for your infrastructure from a Recovery Services vault. For Azure Backup, identify where workloads are running, and what you want to back up – here, workloads are running on-premises, and you would be backing up files and folders. You then install any necessary agents before initiating or scheduling a backup into Azure.

For Azure Site Recovery, set your protection goal to define where machines are located and where you want to replicate them. You then run a deployment planner to help Azure Site Recovery estimate whether you'll meet network bandwidth, storage capacity, and other requirements. You then prepare your source and target environments by, for example, installing a configuration server if necessary. Finally, you'll enable replication and protect your virtual machines.

In this scenario, Azure Backup periodically backs up the files and folders on the Windows machine to Azure. This process ensures they are secure and retrievable even if the whole on-premises environment stops functioning. Separately, Azure Site Recovery will be used to protect running workloads and keep them running. Because Azure Site Recovery can replicate frequently, the recovery time objective for your workloads can be reduced.

To configure the backup portion of your solution in this scenario – and to protect files and folders – you download and install the Microsoft Azure Recovery Services agent. You can then create backup policies and automatically back up your data on a scheduled basis. The Microsoft Azure Recovery Services agent also lets you restore all your data to either the same source machine, or to an entirely different machine. With Azure Backup, your data is also encrypted before it's backed up.

To set up Azure Site Recovery, you install an Azure Site Recovery Services agent and a Site Recovery Provider on the Hyper-V server. These tools are used for replication and orchestration of failover to Azure. Your data is encrypted when it's in transit. Data also remains encrypted when it's at rest and stored in Azure. When a failover is triggered, new virtual machines can be created for you based on the machines that have been protected by Azure Site Recovery.

## Protect different scenarios with Site Recovery

Azure Site Recovery allows replication of different types of machines in different scenarios.

You can protect Azure virtual machines and replicate them from a source region to an entirely different target region. You can replicate:
 - on-premises virtual machines to Azure, whether they're Hyper-V or VMware based.
 - physical servers – both can be Linux and Windows based.
 - machines hosted on other cloud providers such as Amazon Web Services.

You can also replicate both Hyper-V and VMware-based machines (managed by System Center), and your physical servers to your own secondary site. Azure Site Recovery replicates any of your workloads that are running on the machines that are supported.

There are some replication requirements and restrictions, depending on your scenario. For example, your physical servers should be 64-bit, and BitLocker must be turned off.

## Integrate your network with Azure Site Recovery

You might have a multi-tier application, made up of a web tier and an app tier, consisting of two machines each. You can use Azure Site Recovery to protect the whole structure and replicate it to Azure.

Your web tier and application tier will likely also have an internal load balancer and external load balancer attached to them. Azure Site Recovery can protect these load balancers too. To achieve this outcome, you first protect your virtual machines using the Recovery Services vault. Once protection is in place, you create an availability set for your protected application tier machines, and an availability set for the protected web tier machines. When you then create a recovery plan in the Recovery Services vault, you'll need to add the machines in two separate groups.

Groups help you separate virtual machines, and dictate the actions that should take place for each group. With the help of Azure Automation, Azure Site Recovery can then your scripts to attach the appropriate load balancers to the virtual network interfaces of your virtual machines during a failover.

You can keep your IP addresses from on-premises machines and use them for target Azure machines. You create a virtual network in Azure where your virtual machines will be provisioned when failover is triggered. This network acts as an extension of your on-premises network. You'll need to at least establish a VPN-based site-to-site connection between your virtual and on-premises networks.

Your workloads will now fail over smoothly. Before the failover is triggered, you also need to assign the same IP addresses you have on-premises for each machine in its properties in Azure Site Recovery. When failover is complete, Azure Site Recovery creates virtual machines with the same IP addresses.

## Integrate Azure Site Recovery with Azure Traffic Manager

Azure Site Recovery works with Azure Traffic Manager to protect your infrastructure.
Consider a case where your organization has applications with public endpoints running on-premises. The organization wants to ensure these applications are protected in Azure if there's a disaster. If a disaster occurs, your organization wants to direct all traffic to Azure.
You can achieve this by configuring a Traffic Manager profile. You use Azure Traffic Manager's priority routing to create two external endpoints. You'll need to create one primary endpoint for your on-premises, and set it as priority 1. You'll also need a failover endpoint for Azure, and set it as priority 2. Traffic Manager directs your traffic to the on-premises endpoint for as long as the endpoint is healthy.

If there's a disaster, Azure Site Recovery performs a failover. Traffic Manager can probe your endpoints based on values you set – as frequent as every 10 seconds if necessary. When Traffic Manager sees the endpoint isn't healthy, traffic is directed to the failover endpoint. When you're ready to fail back to your on-premises environment, Azure Site Recovery can perform a failback for you. Traffic Manager then can confirm that the primary endpoint is healthy. Traffic is then automatically routed back to your primary endpoint.