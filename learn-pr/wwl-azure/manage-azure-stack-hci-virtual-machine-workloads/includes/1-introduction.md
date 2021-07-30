Microsoft Azure Stack HCI offers a straightforward approach to manage a wide range of virtualized workloads by integrating with Windows Admin Center. Supported workloads include standard virtual desktops, compute-intensive software dependent on GPU acceleration, and highly sensitive applications that require virtualization-based security.

## Optimizing VM operational model

Contoso Ltd. is a medium-sized financial-services company located in New York. Until recently, Contoso has been operating almost entirely on-premises, with the majority of its compute environment running on either Windows Server 2012 R2 or older versions of Linux distributions. Virtualization was used sparingly, primarily by relying on Windows Server 2012 R2 Hyper-V, hosting a small-scale virtual desktop infrastructure (VDI) deployment. Operational overhead was a significant challenge, primarily because of limited use of automation and limited opportunities for integration across out-of-date, disparate technologies. Legacy hardware and software contributed to an increased rate of stability and performance issues, affecting some of the business-critical workloads, including financial modeling applications and resource-intensive Microsoft SQL Server instances. 

As part of datacenter consolidation and modernization initiatives, Contoso IT staff started exploring Microsoft software-defined datacenter technologies. The objective was to identify the optimal approach to retire aging hardware, increase the agility of on-premises workloads, and minimize dependencies on third-party network and storage vendors. 

Following a request from the Contoso's Chief Information Officer (CIO), you, the lead system engineer, are now actively evaluating Azure Stack HCI as the technology that would help change Contoso's IT landscape. 

In the first stage of your evaluation, you focused on the cluster management tasks. Next, you investigated the methods of integrating Azure Stack HCI with Azure. Now you want to explore methods of managing Azure Stack HCI virtual machines (VMs) and determine to what extent they differ from the traditional management of Windows and Linux physical and virtual servers. You also intend to identify the viability of using Azure Stack HCI for hosting Contoso's most critical business workloads.

## Learning objectives

At the end of this module, you'll be able to:

- Manage Azure Stack HCI VMs.
- Configure affinity of Azure Stack HCI VMs.
- Configure load balancing of Azure Stack HCI VMs.
- Configure GPU support for Azure Stack HCI VMs.
- Implement VDI in Azure Stack HCI.
- Implement trusted enterprise virtualization in Azure Stack HCI.


## Prerequisites

Familiarity with:

- The key features of Windows Server
- The concept of virtualization
- The architecture, core capabilities, and primary use cases of Azure Stack HCI