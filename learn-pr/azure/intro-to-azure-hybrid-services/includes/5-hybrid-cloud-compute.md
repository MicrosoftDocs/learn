
Tailwind Traders has a mix of compute workloads running as physical servers, virtual machines (VMs), or containers across datacenters in Sydney, Melbourne, and Auckland. These workloads are running a mix of Windows Server and Linux, with Hyper-V configured as the primary virtualization platform. 

Managing this diverse set of operating systems is already a challenge for Tailwind Traders. The company is concerned that migrating into a hybrid posture where workloads are running both on-premises and in the cloud will make it even more difficult to keep track of server operating system workloads and their compliance state.

For the last few years, Tailwind Traders has been using a Microsoft high-performance computing (HPC) pack to manage a 16-node compute cluster that resides in the Sydney datacenter for a series of engineering-related design tasks. These calculations occur for only short periods during the year. But as calculations have become more complicated, the time required for these calculations has increased.

Tailwind Traders is planning to use containers as the primary platform for new applications instead of having them hosted on virtual machines. The company is interested in a platform that allows it to orchestrate containers in its hybrid environment.

In this unit, you'll learn about various methods of supporting compute workloads in hybrid environments.

## What are Azure Arc enabled servers?

Azure Arc enabled servers allow organizations to manage Windows and Linux servers on networks outside Azure. This capability includes servers hosted on internal organizational networks and those hosted on third-party cloud IaaS infrastructure.

When you hybrid connect a computer to Azure by using Azure Arc to install the Azure Arc enabled servers agent, the server can be treated as an Azure resource. You can then manage the server as part of a resource group within a subscription. You can also apply Azure Policy for configuration and management, along with applying tags. 

The Azure Arc enabled servers agent supports the following Windows and Linux operating systems:

- Windows Server 2008 R2 SP1, 2012 R2, 2016, 2019, and 2022
  - Both Desktop and Server Core experiences are supported
  - Azure Editions are supported on Azure Stack HCI
- Windows 10, 11 (see client operating system guidance)
- Windows IoT Enterprise
- Azure Stack HCI
- Ubuntu 16.04, 18.04, 20.04, and 22.04 LTS
- Debian 10 and 11
- CentOS Linux 7 and 8
- Rocky Linux 8
- SUSE Linux Enterprise Server (SLES) 12 SP3-SP5 and 15
- Red Hat Enterprise Linux (RHEL) 7, 8 and 9
- Amazon Linux 2
- Oracle Linux 7 and 8

Only x86-64 (64-bit) architectures are supported.

Azure Arc enabled servers agent supports the following functionality:

- The Azure Policy guest configuration functionality allows you to validate operating system configuration.
- Resource context for Azure Monitor Log Analytics data allows you to limit the scope of who can access server telemetry by using Azure role-based access control (RBAC).

The functionality included when the Azure Arc enabled servers agent is deployed on computers in hybrid environments is evolving. For the latest information refer to [Azure Arc supported cloud operations](/azure/azure-arc/servers/overview#supported-cloud-operations?azure-portal=true) and [what's new with Azure arc enabled servers](/azure/azure-arc/servers/agent-release-notes?azure-portal=true).

For Tailwind Traders, having a single location to manage Windows Server and Linux workloads across the entire hybrid environment will address some of the operations team's concerns about the hybrid environment's complexity.

## What is Azure Stack HCI?

Azure Stack HCI is a hyperconverged infrastructure operating system that you can use to host Hyper-V virtual machines running Windows and Linux operating systems. Unlike running on a hyperconverged Windows Server Hyper-V cluster, Azure Stack HCI is designed to give you the option of deploying and managing virtual machines through the Azure portal or Windows Admin Center.

Unlike a traditional Windows Server virtualization deployment in which the local operations team maintains responsibility for managing the host operating system, Azure Stack HCI is an Azure service. A customer acquires a validated hardware configuration from an approved vendor and connects the system to an internet-connected network, and an Azure service manages the infrastructure. Hybrid Azure services like Azure Automation Update Management, Azure Site Recovery, and Azure Backup are automatically integrated.

For Tailwind Traders, Azure Stack HCI provides a future platform to which it can eventually migrate its on-premises virtual machines. The migration will enable a consistent set of management tools for all VMs in the hybrid environment.

## What is hybrid high-performance computing?

High-performance computing uses large numbers of CPUs or GPUs to perform complex mathematical tasks, such as certain scientific and engineering calculations. Instead of having these CPUs or GPUs attached to the same computer, HPC uses an arrangement in which a controlling computer allocates tasks to separate computers running Windows and Linux operating systems as nodes to perform discrete segments of a large and repetitive compute calculation. The more nodes an HPC cluster has, the faster the HPC cluster performs the calculation.

Organizations that have an existing on-premises HPC solution can connect that solution to Azure. This structure allows them to burst into the cloud. Bursting to the cloud involves adding cloud-based HPC nodes to an existing on-premises HPC node deployment. When you use this approach, HPC compute nodes can be instantiated in Azure as necessary to perform calculation tasks and then discarded when the tasks are complete. 

The following image illustrates bursting into the cloud.

:::image type="content" source="../media/5-burst-cloud.png" alt-text="Diagram that shows on premises HPC deployment with job queue using worker nodes on-premises and as required in Azure." border="false" lightbox="../media/5-burst-cloud.png":::

Being able to burst HPC calculations into the cloud allows organizations to maintain a minimum amount of hardware for common HPC tasks on-premises. Organizations can then deploy extra nodes as necessary if the benefit of the calculation justifies the expense.

Tailwind Traders already has an HPC deployment. But the company's capacity to perform complex calculations is limited by the amount of compute resources in its physical and virtual environment that it can allocate to HPC tasks. By adopting a hybrid HPC approach, Tailwind Traders can scale its HPC capacity as needed without having to purchase the hardware for additional on-premises nodes.

## What is Azure Arc enabled Kubernetes?

Azure Arc enabled Kubernetes allows you to attach and configure Kubernetes clusters so that they can be managed through the Azure portal. When you use Azure Arc enabled Kubernetes, you can:

- Connect Kubernetes clusters running outside Azure and perform inventory, grouping, and tagging tasks.
- Deploy applications and apply configuration to Azure Arc enabled Kubernetes clusters by using GitOps–based configuration management.
- Use Azure Monitor for containers to review and monitor your Kubernetes clusters in a hybrid environment.
- Apply Azure Policy for Kubernetes policies to Kubernetes clusters in a hybrid environment.

Azure Arc enabled Kubernetes will work with any Cloud Native Computing Foundation (CNCF) certified Kubernetes cluster. Azure Arc enabled Kubernetes allows your organization to manage Kubernetes clusters both on-premises and in the cloud in a hybrid environment, as shown in the following image.

:::image type="content" source="../media/5-manage-clusters-hybrid.png" alt-text="Diagram that shows hybrid Kubernetes clusters managed through Azure Monitor, Azure Policy, and Azure Arc enabled Kubernetes clusters." border="false" lightbox="../media/5-manage-clusters-hybrid.png":::

The benefit for Tailwind Traders of using Azure Arc for Kubernetes is that it allows the company to manage Kubernetes clusters by using a single set of tools. It also allows those Kubernetes clusters to be configured and secured in a consistent manner across the hybrid environment.

## What are Azure Arc enabled data services?

Azure Arc enabled data services allow organizations to manage supported databases running in Azure and on-premises by using one set of tools. Organizations can use Azure Arc enabled data services to run Azure Database for PostgreSQL servers and SQL managed instances on-premises while managing those instances through Azure Data Studio, the Azure portal, or the Azure CLI.

When enabled, Azure Arc enabled data services allow you to automate the patching and update processes for these on-premises database instances in the same way that Microsoft manages these processes when you deploy PostgreSQL and SQL managed instances in Azure. Azure Arc enabled data services also allow organizations to apply the advanced threat protection functionality available in Microsoft Defender for Cloud for Azure SQL databases to database server instances running on-premises.

Azure Arc enabled data services use container and Kubernetes infrastructure for the on-premises services. Azure Arc enabled data services also allow integration between these on-premises data services and Azure services such as Azure Backup.

From Tailwind Traders' perspective, Azure Arc enabled data services provide an alternative way of running some of its current database workloads. The company can migrate some of its on-premises databases to Azure Arc enabled data services. This migration will relieve the operations team's concerns about the management and security of those instances.

## What is Azure Site Recovery?

Azure Site Recovery allows organizations to replace disaster recovery sites by replicating physical and virtual operating systems and the workloads they host into the Azure cloud platform. Azure Site Recovery allows failover to Azure. Azure Site Recovery can also perform failback of workloads to an on-premises datacenter from Azure. 

The following image shows a basic Azure Site Recovery configuration.

:::image type="content" source="../media/5-recovery-configuration.png" alt-text="Diagram that shows Azure Site Recovery configuration with on-premises VMs replicated to a recovery vault in Azure." border="false" lightbox="../media/5-recovery-configuration.png":::

Azure Site Recovery allows Tailwind Traders to move from using the Melbourne and Sydney datacenters as disaster recovery sites in its on-premises-only implementation, to using Azure as a disaster recovery site for a large number of workloads as the deployment becomes hybrid. The challenge for Tailwind Traders is that some workloads have physical or other dependencies that have blocked them from being migrated to Azure. The company won't be able to use Azure as a disaster-recovery site for the same reasons.
