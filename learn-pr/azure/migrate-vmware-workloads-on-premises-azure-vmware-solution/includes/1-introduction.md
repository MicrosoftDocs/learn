Azure VMware Solution delivers an in-depth VMware environment as a service. Azure VMware Solution deploys on dedicated, bare-metal infrastructure in Azure. After you deploy it, you gain access to common native VMware tools:

| Product | What does the product do? |
| :------ | :------------------------ |
| ESXi | Bare-metal servers with virtualization software. |
| vCenter Server | Advanced server management software that centralizes the vSphere ESXi environment. |
| vSAN | Software-defined storage solution embedded in ESXi. |
| NSX | Software-defined networking and security solution that extends across datacenters, clouds, and application frameworks.
| VMware HCX | Software-defined hybrid cloud platform between on-premises vSphere and Azure VMware Solution for VM migrations. |

VMware HCX provides infrastructure abstraction for virtual machine (VM) migrations. You can migrate native VMware workloads to Azure by using VMware HCX vMotion technology. VMware HCX vMotion enables live migration of running VMs from one vSphere environment to another with minimal downtime. VMware HCX simplifies migration efforts and enables faster adoption of cloud resources.

The following diagram shows VMware HCX deployed on-premises. VMware HCX then replicates VMs in the on-premises datacenter to Azure VMware Solution. After the VMs are in Azure, they're closer to the rich APIs of Azure for ongoing administration and maintenance.

:::image type="icon" source="../media/1-hcx-diagram.png" border="false" alt-text="Diagram that shows a high-level overview of a VMware datacenter on-premises, with VMware HCX migrating VMs to Azure VMware Solution.":::

## Example scenario

Imagine you work for a healthcare company that runs production workloads on a VMware vSphere platform. Your company decided to migrate existing VMware vSphere workloads to Azure VMware Solution. Your company doesn't have to change virtualization platforms or alter existing operational patterns by using Azure VMware Solution. You planned for and deployed Azure VMware Solution, now you need to migrate VMware workloads on-premises to Azure. In this module, you'll learn how to migrate existing VMware vSphere workloads on-premises into Azure VMware Solution.

## What will we be doing?

First, you'll learn how to plan for the VMware HCX Connector deployment on-premises. From there, you'll learn how to deploy VMware HCX Connector on-premises and connect the appliance to Azure VMware Solution. Additionally, you'll learn about the steps required to ensure the service is configured correctly. After VMware HCX is deployed and configured, you'll learn how to migrate VMware vSphere workloads from on-premises to Azure VMware Solution.

## What is the main goal?

The main goal is to quickly migrate VMware vSphere VMs on-premises into Azure VMware Solution which helps your company deal with aging hardware and new hardware requests.
