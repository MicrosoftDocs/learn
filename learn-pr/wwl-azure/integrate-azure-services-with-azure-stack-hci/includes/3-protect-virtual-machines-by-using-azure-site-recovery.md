Contoso has been experiencing frequent stability and performance issues, which exposed the lack of sufficient disaster recovery provisions. It is imperative that your implementation of Azure Stack HCI includes such provisions, allowing for resiliency sufficient to maintain business continuity if there is a regional disaster. To accomplish this goal, you decide to explore the capabilities of Microsoft Azure Site Recovery and learn to use it to protect Azure Stack HCI VMs. 

## Overview of Azure Site Recovery

Azure Site Recovery is a cloud-based disaster recovery service that protects on-premises and cloud workloads by facilitating the following tasks:

- Replication of content of the operating systems and data disks of Windows and Linux servers residing in a primary site to VM disk storage in a secondary site.
- Orchestration of disaster recovery plans, including orderly failover and failback between the primary and secondary sites.

During a failover, content of disk storage in the secondary site is used to provision VMs serving as replicas of their primary site counterparts. Any additional tasks, such as provisioning of additional infrastructure services, such as load balancers, can be automated by using disaster recovery plans. Following a failover, the direction of replication is reversed to allow for lossless failback. 

Azure Site Recovery supports test failovers into an isolated Azure virtual network. This allows you to verify failover functionality without affecting your production environment at Contoso.

> [!NOTE]
> Although it is possible to use Azure Site Recovery to implement an on-premises secondary site, the primary use case in the context of Azure Stack HCI is failover to Azure, which will be the focus of this unit. 

## Azure Site Recovery components

Azure Site Recovery uses agents installed either directly on protected servers, or in case of Microsoft Hyper-V and Azure Stack HCI clusters, on servers hosting protected VMs. The agents manage replication of local virtual disk writes to storage in the remote site. You can control this storage by using Azure Recovery Services vault, which also serves as the primary configuration interface for setting up and managing replication and orchestration. During a failover, Azure Site Recovery dynamically provisions Azure VMs into a designated virtual network. 

:::image type="content" source="../media/architecture-2.png" alt-text="The diagram depicts how Azure Stack HCI integrates with Azure Site Recovery through agents installed on cluster nodes. The agents keep track of local disk writes and continuously replicate them to Azure Storage, controlled by Azure Site Recovery vault. During a failover, Azure Site Recovery dynamically provisions Azure virtual machines into a designated virtual network. Windows Admin Center streamlines the onboarding process. " border="false":::

Replication traffic and agent communication with the vault is always initiated outbound to Azure, which eliminates the need for opening any inbound ports at the edge of the internal network.

## Azure Site Recovery support for Azure Stack HCI

Azure Stack HCI offers a wide range of built-in resiliency provisions, including support for disaster recovery to another on-premises location by relying on stretched clustering. As part of your evaluation process at Contoso, you want to enhance this resiliency by onboarding Azure Stack HCI to Azure Site Recovery, which enables failover to Azure. Azure Site Recovery supports Windows and Linux server VMs running on Azure Stack HCI. Azure Site Recovery also integrates with workloads that use their own replication technologies, such as SQL Server Always On Availability Groups and Active Directory Domain Services. 

## Onboarding Azure Stack HCI to Azure Site Recovery

As the next step in your evaluation process, you decide to onboard an Azure Stack HCI cluster to Azure Site Recovery. To do this, you can use Windows Admin Center, which offers the option to automatically provision all required Azure components, including the target Azure Recovery Services vault and the storage account required for replication, and install the Site Recovery Provider on the cluster nodes. The provider manages communication with the Recovery Services vault and data replication.

:::image type="content" source="../media/wac-enable-asr-settings.png" alt-text="The screenshot depicts how Windows Admin Center offers the option to onboard an Azure Stack HCI cluster to Azure Site Recovery, which automatically provisions all required Azure components, including the target Azure Recovery Services vault and the storage account required for replication, and installs the Site Recovery Provider on the cluster nodes." border="false":::

> [!NOTE]
> As with any functionality that involves Azure-based services, you first need to register Windows Admin Center in Azure. 

After all required infrastructure components are provisioned, you can use Windows Admin Center to enable protection for individual VMs.

:::image type="content" source="../media/wac-enable-asr-virtual-machine.png" alt-text="The screenshot depicts how you can use Windows Admin Center to enable protection for individual VMs after all required infrastructure components are provisioned." border="false":::

To perform the remaining configuration and management tasks, such as creating a recovery plan, performing a test, planned, or unplanned failover, and monitoring the status of protected VMs, you can use the Recovery Services vault interface in the Azure portal or Azure PowerShell.

---


---