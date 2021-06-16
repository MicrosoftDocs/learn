Azure VMware Solution (AVS) delivers an in-depth VMware environment as a service. AVS deploys on dedicated bare-metal infrastructure in Azure. After deployment, customers gain access to common native VMware tools:

| Product | What does the product do? |
| :------ | :------------------------ |
| vSphere ESXi | Server hypervisor software for bare-metal servers. |
| vCenter | Advanced server management software that centralizes the vSphere ESXi environment. |
| vSAN | Software-defined storage solution embedded with vSphere ESXi. |
| NSX-T | Software-defined networking solution that extends across datacenters, clouds, and application frameworks.
| HCX | Software-defined abstraction layer between on-premises and AVS for VM migrations. |

VMware's Hybrid Cloud Extension (HCX) provides infrastructure abstraction for VM migrations. Customers can migrate native VMware workloads to Azure by using HCX vMotion technology. HCX vMotion enables live migration of running VMs from one vSphere environment to another with minimal downtime. HCX simplifies migration efforts and enables faster adoption of cloud resources. The following diagram shows HCX deployed on-premises. HCX then replicates VMs in the on-premises datacenter to AVS in Azure. Once the VMs are in Azure, they are closer to the rich APIs of Azure for administration and maintenance.

:::image type="icon" source="../media/1-hcx-diagram.png" border="false" alt-text="High-level overview of the datacenter on-premises with HCX migrating VMs to AVS.":::

## Example scenario

Imagine you work for a healthcare company that runs production workloads on a VMware platform. Your company decided to migrate existing VMware workloads to Azure VMware Solution (AVS). Your company doesn't have to change virtualization platforms or alter existing operational patterns by using AVS. You've planned for and deployed AVS. Now you need to migrate VMware workloads on-premises to Azure. In this module, you'll learn how to migrate existing VMware workloads on-premises into Azure VMware Solution.

## What will we be doing?

First, you'll learn how to plan for the Hybrid Cloud Extension (HCX) Connector deployment on-premises. From there, you'll learn how to deploy the HCX Connector on-premises and connect the appliance to Azure VMware Solution. Additionally, you'll learn about the steps required to ensure the service is configured correctly. After HCX is deployed and configured, you'll learn how to migrate VMware workloads from on-premises to AVS.

## What is the main goal?

The main goal is to quickly migrate VMware VMs on-premises into Azure VMware Solution to help out your company with aging hardware and new hardware requests.