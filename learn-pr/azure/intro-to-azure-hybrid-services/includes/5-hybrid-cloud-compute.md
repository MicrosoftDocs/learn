# Hybrid-cloud compute workloads

Tailwind Traders has a mix of compute workloads running as physical servers, virtual machines, or containers across datacenters in Sydney, Melbourne, and Auckland. These workloads are running a mix of Windows Server and Linux, with Hyper-V configured as the primary virtualization platform. Managing this diverse set of operating systems is already a challenge for Tailwind Traders. As such, the company is concerned that migrating into a hybrid posture where workloads are running both on-premises and in the cloud will make it even more difficult to keep track of server operating system workloads and their compliance state.

For the last few years, Tailwind Traders has been using Microsoft high-performance computing (HPC) pack to manage a 16-node compute cluster that resides in the Sydney datacenter for a series of engineering-related design tasks. These calculations only occur for short periods during the year, but as calculations have become more complicated, the time required for these calculations to complete has increased.

Tailwind Traders is planning to use containers as the primary platform for new applications instead of having them hosted on virtual machines. They’re interested in a platform that allows them to orchestrate containers in their hybrid environment.

In this unit, you’ll learn about various methods of supporting compute workloads in hybrid environments.

## What are Azure Arc enabled servers?

[Azure Arc–enabled servers](https://docs.microsoft.com/azure/azure-arc/servers/overview) allows organizations to manage Windows and Linux servers on networks outside Azure. This capability includes servers hosted on internal organizational networks and those hosted on third-party cloud IaaS infrastructure.

When you hybrid connect a computer to Azure by using Azure Arc to install the Azure Arc for servers agent, the server can be treated as an Azure resource. This allows you to manage it as part of a resource group within a subscription. It also allows you to apply Azure Policy for configuration and management gives you the ability to apply tags. The Azure Arc for servers agent supports the following Windows and Linux operating systems:

- Windows Server 2012 R2 and newer (including Windows Server Core)
- Ubuntu 16.04 and 18.04 (x64)
- CentOS Linux 7 (x64)
- SUSE Linux Enterprise Server (SLES) 15 (x64)
- Red Hat Enterprise Linux (RHEL) 7 (x64)
- Amazon Linux 2 (x64)

Azure Arc enabled servers supports the following functionality:

- The Azure Policy guest configuration functionality allows you to validate operating-system configuration.
- Resource context for Azure Monitor Log Analytics data allows you to limit the scope of who can access server telemetry by using Azure role-based access control (RBAC).

The functionality included when the Azure Arc for servers agent is deployed on computers in hybrid environments is evolving. Eventually, other functionality that’s presently available when managing Windows and Linux VMs in Azure, such as the ability to remotely run automation, track ,and limit application execution, and remote shell access will likely be enabled for Azure Arc enabled servers.

For Tailwind Traders, having a single location to manage Windows Server and Linux workloads across the entirety of the hybrid environment will address some of the operations teams’ concerns about the hybrid environment’s complexity.

## What is Azure Stack HCI?

[Azure Stack HCI](https://docs.microsoft.com/azure-stack/hci/overview) is a hyper-converged infrastructure operating system that allows you to host Hyper-V virtual machines running Windows and Linux operating systems. Unlike running on a hyperconverged Windows Server Hyper-V cluster, Azure Stack HCI is designed to provide you the option of deploying and managing virtual machines through the Azure Portal or Windows Admin Center.

Unlike a traditional Windows Server virtualization deployment in which the local operations team maintain responsibility for managing the host operating system, Azure Stack HCI is an Azure service. A customer acquires a validated hardware configuration from an approved vendor, connects the system to an internet-connected network, and an Azure service manages the infrastructure. Because they’re fully connected to Azure, all hybrid Azure services, such as Azure Update Management, Azure Site Recovery, and Azure Backup are automatically integrated.

For Tailwind Traders, Azure Stack HCI provides a future platform to which they can eventually migrate their on-premises virtual machines, thereby enabling a consistent set of management tools for all VMs in their hybrid environment.

## What is hybrid high-performance computing?

[High-performance computing (HPC)](https://docs.microsoft.com/azure/architecture/topics/high-performance-computing) uses large numbers of CPUs or GPUs to perform complex mathematical tasks, such as certain scientific and engineering calculations. Instead of having these CPUs or GPUs attached to the same computer, HPC uses an arrangement in which a controlling computer allocates tasks to separate computers running Windows and Linux operating systems as nodes to perform discrete segments of a large and repetitive compute calculation. The more nodes in an HPC cluster, the faster the HPC cluster performs the calculation.

Organizations that have an existing on-premises HPC solution can connect that solution to Azure. This structure allows them to burst into the cloud. Bursting to the cloud involves adding cloud-based HPC nodes to an existing on-premises HPC node deployment. When you use this approach, depicted in Figure 7, HPC compute nodes can be instantiated in Azure as necessary to perform calculation tasks and then discarded when the task is complete. Being able to burst HPC calculations into the cloud allows organizations to maintain a minimum amount of hardware for common HPC tasks on-premises. Organizations can then deploy extra nodes as necessary if the benefit of the calculation justifies the expense.

:::image type="content" source="../media/image9.png" alt-text="On premises HPC deployment with job queue using worker nodes on-premises and as required in Azure." border="false":::

Figure 9. HPC with burst to Azure.

Tailwind Traders already has an HPC deployment. However, their capacity to perform complex calculations is limited by the amount of compute resources in their physical and virtual environment that they can allocate to HPC tasks. By adopting a hybrid HPC approach, Tailwind Traders can scale their HPC capacity as needed without having to purchase the hardware for additional on-premises nodes.

## What is Azure Arc enabled Kubernetes?

[Azure Arc enabled Kubernetes](https://docs.microsoft.com/azure/azure-arc/kubernetes/overview) allows you to attach and configure Kubernetes clusters so that they can be managed through the Azure Portal. When you use Azure Arc enabled Kubernetes, you can:

- Connect Kubernetes clusters running outside of Azure and perform inventory, grouping, and tagging tasks.
- Deploy applications and apply configuration to Azure Arc enabled Kubernetes clusters by using GitOps–based configuration management.
- Use Azure Monitor for containers to review and monitor your hybrid-environment Kubernetes clusters.
- Apply Azure Policy for Kubernetes policies to hybrid-environment Kubernetes clusters.

Azure Arc enabled Kubernetes will work with any Cloud Native Computing Foundation (CNCF) certified Kubernetes cluster. Azure Arc enabled Kubernetes allows your organization to manage Kubernetes clusters both on-premises and in the cloud in a hybrid environment as depicted in Figure 10.

:::image type="content" source="../media/image10.png" alt-text=" Hybrid Kubernetes clusters managed through Azure Monitor, Azure Policy and Azure Arc-enabled Kubernetes clusters." border="false":::

Figure 10. Hybrid Kubernetes cluster management.

The benefit for Tailwind Traders of using Azure Arc for Kubernetes is that it allows the company to manage Kubernetes clusters by using a single set of tools. It also allows those Kubernetes clusters to be configured and secured in a consistent manner across the hybrid environment.

## What is Azure Arc enabled data services?

[Azure Arc enabled data services](https://azure.microsoft.com/en-au/blog/bring-azure-data-services-to-your-infrastructure-with-azure-arc/) allows organizations to manage supported databases running in Azure and on-premises by using one set of tools. Azure Arc enabled data services allows organizations to run Azure Database for PostgreSQL Servers and SQL Managed Instances on-premises while managing those instances through Azure Data Studio, the Azure Portal, or Azure CLI.

When enabled, Azure Arc enabled data services allows you to automate the patching and update processes for these on-premises database instances in the same way that Microsoft manages these processes when you deploy PostgreSQL and SQL managed instances in Azure. Azure Arc enabled data services also allows organizations to apply the database advanced threat protection functionality available in Azure Security Center for Azure SQL databases to database server instances running on-premises.

Azure Arc enabled data services leverages container and Kubernetes infrastructure for the on-premises services. Azure Arc enabled data services also allows integration between these on-premises data services and Azure services such as Azure Backup.

From Tailwind Traders’ perspective, Azure Arc enabled data services provides an alternative way of running some of their current database workloads. They can migrate some of their on-premises databases across to the Azure Arc for data services instances, which will relieve the operations team’s concerns about the management and security of those instances.

## What is Azure Site Recovery?

[Azure Site Recovery](https://docs.microsoft.com/azure/site-recovery/site-recovery-overview) allows organizations to replace disaster-recovery sites by replicating physical and virtual operating systems and the workloads they host into the Azure cloud. Azure Site Recovery allows failover to Azure. Importantly, Azure Site Recovery can also perform failback of workloads to an on-premises datacenter from Azure. Figure 11 depicts a basic Azure Site Recovery configuration.

:::image type="content" source="../media/image11.png" alt-text="Azure Site Recovery configuration with on-premises VMs replicated to recovery vault in Azure." border="false":::

Figure 11. Azure Site Recovery.

Azure Site Recovery allows Tailwind Traders to move from using the Melbourne and Sydney datacenters as disaster-recovery sites in their on-premises only implementation, to using Azure as a disaster-recovery site for a large number of workloads as their deployment becomes hybrid. The challenge for Tailwind Traders is that some workloads have physical or other dependencies that have blocked them from being migrated to Azure. This means that they won’t be able to use Azure as a disaster-recovery site for the same reasons.

## Knowledge check

As a part of their hybrid strategy, Tailwind Traders wants to manage container orchestration through the Azure Portal instead of using on-premises tools. Which of the following hybrid-cloud compute technologies allows Tailwind Traders to accomplish this goal?

1\. Azure Arc enabled Kubernetes. \[Correct. Azure Arc enabled Kubernetes is a container orchestration service that allows you to manage container orchestration through the Azure Portal.\]

2\. Azure Stack HCI. \[Incorrect. Azure Stack HCI is an on-premises hyperconverged virtualization host solution. While it’s possible to host a container orchestration solution on those virtual machines, Azure Stack HCI isn’t a container orchestration solution.\]

3\. Azure Arc enabled servers. \[Incorrect. Azure Arc enabled servers are servers that exist outside the Azure IaaS environment and are connected to Azure, and for which Azure can provide some limited management functionality.\]