Azure Local is a hyperconverged infrastructure (HCI) platform that runs virtualized workloads on-premises. It integrates with Microsoft cloud services, allowing organizations to manage both local and cloud resources through a single environment. This approach can help simplify IT operations and support hybrid infrastructure strategies.

## Hyperconverged infrastructure (HCI) stack

A hyperconverged infrastructure (HCI) stack is an integrated system that combines compute, storage, and networking into a single platform—usually running on standard, off-the-shelf servers—and managed through a unified software layer.

*In simple terms:*

Instead of using separate physical systems for servers (compute), storage (SAN/NAS), and networking, HCI brings everything together into one tightly integrated system that is virtualized and software-defined.

## Azure Local as an HCI stack

**Azure Local** is a Microsoft offering that:

- Runs on-premises using local servers  
- Consolidates compute, storage, and networking into a single virtualized environment  
- Uses software-defined infrastructure to manage and provision workloads  
- Integrates with Azure cloud services for hybrid scenarios  

It fits the definition of an HCI stack because it provides:

| Component      | Azure Local equivalent                               |
|----------------|-----------------------------------------------------|
| **Compute**    | Virtual machines (VMs) running on local hosts       |
| **Storage**    | Software-defined storage pooled from local disks   |
| **Networking** | Virtual networking managed within the HCI environment |
| **Management** | Azure Arc + Azure portal + Windows Admin Center     |

## Hybrid cloud capabilities

Azure Local stands out from traditional HCI systems because of its deep integration with Azure. This integration enables:

- Centralized management of both local and cloud resources

- Access to cloud services such as monitoring, policy management, and security updates

- Use of Azure Arc to extend Azure management and control to on-premises systems

By using Azure Arc, Azure Local consolidates virtualized workloads while delivering cloud efficiencies—especially when data must remain on-premises due to company policies, legal, or privacy requirements.

Additionally, to support legacy workloads approaching end-of-life, Windows Server extended security updates are available at no extra cost when migrating those workloads to Azure Local.

## Azure hybrid service

Azure Local extends infrastructure management to the cloud and allows management of Azure Local hosts, virtual machines (VMs), and Azure resources within the Azure portal.

It supports:

- Monitoring of clusters

- Management of extensions and policies

- Self-service VM provisioning

The service includes regular feature and security updates along with unified billing.

## Integration with existing tools

Azure Local integrates with existing IT environments and non-Microsoft solutions using familiar management tools.

- Windows Admin Center provides a graphical interface for managing infrastructure

- Windows PowerShell allows automation through scripts for routine management tasks

![A photograph of a customer using a point of sales terminal to pay at a café counter.](../media/coffee.png)