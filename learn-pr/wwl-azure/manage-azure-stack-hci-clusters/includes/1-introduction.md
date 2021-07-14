Microsoft Azure Stack HCI offers streamlined management, closely integrated with Windows Admin Center. This integration simplifies the most common operational tasks, which traditionally required using multiple administrative tools.

## Scenario: Optimize the operational model

Contoso Ltd. is a medium-size financial-services company located in New York. Contoso operates almost entirely on-premises, with most of its compute environment running on either Windows Server 2012 R2 or older versions of Linux distributions. Contoso uses virtualization sparingly, primarily by using Windows Server 2012 R2 Hyper-V. Operational overhead has become a significant challenge, primarily because of limited use of automation and limited opportunities for integration across out-of-date, disparate technologies. Legacy hardware and software contribute to an increased rate of stability and performance issues, affecting the ability to meet the service-level objectives expected by internal business stakeholders. Recent hardware failures and power outages exposed flaws in the way some of the more critical internally developed applications were implemented. The flaws include insufficient high availability and disaster recovery provisions and the lack of a reliable, centralized monitoring solution. 

To address these problems, Contoso has recently launched various datacenter consolidation and modernization initiatives. As part of the overall solution, Contoso IT staff have begun to explore Microsoft software-defined datacenter technologies. The goal is to identify the optimal approach to reduce the presence of aging hardware, increase the agility of on-premises workloads, and minimize dependencies on third-party network and storage vendors.

Contoso's Chief Information Officer (CIO) realizes that many regulatory and compliance constraints preclude the ability of migrating some of the on-premises workloads to a public cloud. However, at the same time, Contoso wants to replace legacy infrastructure with a modern, cutting-edge hardware and software platform. The CIO has asked you, as lead system engineer, to evaluate whether Microsoft Azure Stack HCI might serve as the technology that would help to deliver the much-needed change to Contoso's IT landscape. To start, you've purchased an Azure Stack HCI unit and deployed it into your proof-of-concept environment. Now, it is time to test some of the most common configuration, management, and maintenance tasks to check how much they would help improve resiliency, stability, and performance of the existing infrastructure.

## Learning objectives

At the end of this module, you'll be able to:

- Describe the basic Azure Stack HCI management tasks.
- Apply operating system updates to an Azure Stack HCI cluster.
- Monitor the status of an Azure Stack HCI cluster.
- Configure the quorum of an Azure Stack HCI cluster.
- Describe the primary characteristics of an Azure Stack HCI stretched cluster and implement the stretched cluster.
- Add and remove the nodes of an Azure Stack HCI cluster.
- Perform the basic maintenance tasks on an Azure Stack HCI cluster.
- Manage and troubleshoot the CredSSP configuration of an Azure Stack HCI cluster.

## Prerequisites

Familiarity with:

- The key features of Windows Server
- The concept of virtualization
- The architecture, core capabilities, and primary use cases of Azure Stack HCI