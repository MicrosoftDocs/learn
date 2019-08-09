You can use Azure Site Recovery as part of the disaster recovery process for your organization.

Your organization has multiple workloads, some running in the cloud and some remaining on-premises. You will need to understand how you can use Azure Site Recovery with other Azure tools in Azure to protect your workloads.

In this unit, you will understand how Azure Site Recovery can simplify your business continuity and disaster recovery process. You will learn what different types of machines and scenarios are supported with Azure Site Recovery. And you will learn how you can integrate your existing network with Azure Site Recovery.

## Simplify your BCDR with Azure Site Recovery

Azure Site Recovery helps you simplify your BCDR. Azure Site Recovery lets you configure and manage your replication, failovers and failbacks, all through the Azure portal.
Azure Site Recovery can replicate different types of targets. As an example, Azure Site Recovery makes it possible for you to configure disaster recovery for your Azure virtual machines. You can replicate your Azure virtual machines from a primary to a secondary region. Your on-premises virtual machines can be replicated too, along with workloads.

Every time you replicate over to Azure, the associated data is put into Azure storage. This means your data is kept resilient as a result. If a failover is triggered, Azure virtual machines are created for you using this data that is replicated and stored in Azure storage.
Azure Site Recovery helps you meet your recovery time objective. This is because Azure Site Recovery can perform continuous replication for your Azure virtual machines and VMware virtual machines. Replication can be as often as very 30 seconds for any Hyper-V virtual machines. This reduces your recovery time objective. You can make you recovery time objective even shorter if you use Azure Traffic Manager with your Azure Site Recovery service.
Azure Site Recovery can recover to application-consistent snapshots. Azure Site Recovery takes snapshots of all data that is in memory, all data that is on disk, and all of the transactions that are in process.

You can use Azure Site Recovery's recovery plans to group your virtual machines, add scripts, manual actions, and failover and recover your multi-tier applications that are spread across different virtual machines. You can set up Azure automation runbooks to work with your recovery plans.

You should always test your disaster recovery plan. Azure Site Recovery let's you run disaster recovery tests with no disruption to your running replication.

If you are using other BCDR technologies, you may be able to integrate those as well. For example, if you are using SQL Server Always On to protect your databases, you can use Azure Site Recovery to help manage failovers of your availability groups.

## Implement a solution using Azure Site Recovery and Azure Backup

![alt text](../media/3-asr-backup-diagram.png)

<!--Please feel free to style this diagram-->

Above is an example solution incorporating both Azure Backup and Azure Site Recovery.

You can see an on-premises environment that has a Hyper-V host server for hosting virtual machines. We want to back up all the files and folders in this virtual machine in to Azure. We want to also protect any workloads running on the virtual machine, and be able to keep running them even if the virtual machine fails. The Azure Backup and Azure Site Recovery services can be used together as part of a single solution.

You can configure both backup and site recovery for your infrastructure from a Recovery Services vault. For Azure Backup, you identify where your workloads are running, and what you want to back up. In this scenario your workloads are running on-premises, and you would be backing up files and folders. You would then install any necessary agents before initiating or scheduling a backup into Azure. For Azure Site Recovery, you set your protection goal defining where your machines are located and where you want to replicate your machines. You then run a deployment planner to help Azure Site Recovery estimate whether you can meet network bandwidth, storage capacity and other requirements. Then you go on to prepare your source and target environments, by for example installing a configuration server if it's required. You will then finally enable replication and protect your virtual machines.

Azure Backup here periodically backs up the files and folders on the Windows machine in to Azure. This ensures our data is secure and retrievable even if the whole on-premises environment ceases to function. Separately, Azure Site Recovery is being used to protect your running workloads and keep them running. Because Azure Site Recovery can replicate on a frequent basis, the recovery time objective for your workloads can be very short.

In order to configure the backup portion of your solution in this scenario to protect your files and folders, you will need download and install the Microsoft Azure Recovery Services agent. You will then be able to create backup policies and automatically back up your data on a scheduled basis. The Microsoft Azure Recovery Services agent will also let you restore all of your data to either the same source machine, or to an entirely different machine. With Azure Backup, your data is encrypted before it is backed up, and stays encrypted when it has been backed up.

In order to set up Azure Site Recovery, you would need to install an Azure Site Recovery Services agent and a Site Recovery Provider on the Hyper-V server. They are used for replication and orchestration of failover to Azure respectively. Your data is encrypted when it is in-transit. It also remains encrypted when it is at-rest and stored in Azure. Once a failover is triggered, new virtual machines are created for you based on the machines that have been protected for you with Azure Site Recovery.

## Protect different scenarios with Azure Site Recovery

Azure Site Recovery allows replication of different types of machines in different scenarios.

You can protect your Azure virtual machines and replicate them from a source region to an entirely different target region. You can replicate on-premises virtual machines to Azure, whether they are Hyper-V or VMware based. You are also able to replicate physical servers, both can be Linux and Windows based. If you have machines hosted on Amazon Web Services, you can replicate those machines into Azure too.

You can also replicate to your own secondary site. You can replicate both Hyper-V and VMware based machines (managed by System Center), and your physical services. Azure Site recovery can replicate any of your workloads that are running on any of the machines that are supported.

You should always check regions that are supported for use of Azure Site Recovery. You can find more details about support with [this tool](https://azure.microsoft.com/global-infrastructure/services/?products=&regions=). You must also check whether your individual scenario supports replication to a region. For example, Brazil South [can't be used](https://docs.microsoft.com/en-us/azure/site-recovery/azure-to-azure-support-matrix#region-support) as a target region for replication when replicating between Azure regions.

There are some replication requirements and restrictions, and these depend on your scenario. As an example, your physical servers must be 64-bit, and BitLocker must be turned off.

## Integrate your network with Azure Site Recovery

You could find yourself in situation where you are dealing with a multi-tier application, made up of a web tier and an app tier consisting of two machines each. Azure Site Recovery can be used to protect the whole structure and replicate it to Azure.

Your web tier and your application tier will likely also have an internal load balancer and an external load balancer respectively. Azure Site Recovery can protect these load balancers too. To achieve this, you must first protect your virtual machines using the recovery services vault. Once protection is in place, you can then create an availability set for your protected application tier machines, and an availability set for the protected web tier machines respectively. Then when you create a recovery plan, you'll need to add the machines in two separate groups of your recovery plan. Groups help you separate your virtual machines, and dictate what actions should be performed on each group. With the help of Azure Automation, Azure Site Recovery can then run your scripts to attach the appropriate load balancers to the virtual network interfaces of your virtual machines during a failover.

 You can keep your IP addresses from your on-premises machines and use them for your target Azure machines. You will need to create a virtual network in Azure where your virtual machines will be provisioned once your failover is triggered. This network will act as an extension of your on-premises network, so you will need to at least establish a VPN based site-to-site connection between your virtual network and your on-premises one. This will make it possible for your workloads to failover smoothly. You need to also assign the exact same IP addresses you have on-premises for each machine in its properties in Azure Site Recovery before the failover is triggered. After a failover is completed, Azure Site Recovery will create virtual machines for you with the exact same IP addresses.

## Integrate Azure Site Recovery with Azure Traffic Manager

Azure Site Recovery can work with Azure Traffic Manager to protect your infrastructure.
Consider the case that your organization has applications with public endpoints running on-premises, and wants to ensure these are protected in Azure in case of a disaster. Your organization wants to direct all traffic to Azure if a disaster does occur.
You can achieve this by configuring a Traffic Manager profile. You use Azure Traffic Manager's priority routing to create two external endpoints. You'll need to create one endpoint for your on-premises, the primary endpoint, and set it as priority 1. You also need to have a failover endpoint for Azure, and set it as priority 2. Azure Traffic Manager directs your traffic to the on-premises endpoint for as long as the endpoint is healthy.

If a disaster occurs, Azure Site Recovery preforms a failover. Azure Traffic Manager can probe your endpoints based on values you set. Traffic Manager can probe your endpoints as frequent as every 10 seconds. Once Azure Traffic Manager sees the endpoint is not healthy, your traffic is directed to the failover endpoint. Then once you are ready to failback to your on-premises environment, Azure Site Recovery can perform a failback for you, and Azure Traffic Manager will confirm the primary endpoint is healthy. Traffic is then automatically routed back again to your primary endpoint.
