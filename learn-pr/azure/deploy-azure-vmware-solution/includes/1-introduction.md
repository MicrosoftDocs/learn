Imagine you work for a healthcare company that runs production workloads on a VMware vSphere platform. IT operations are spread among different offices. Several trends have surfaced in recent months:

- Some locations have equipment nearing end-of-life, so hardware-refresh decisions need to be made soon.
- Your company isn't able to get new infrastructure quickly enough to meet requests for hardware refreshes and new applications. The requisition process, approvals, and logistics can take four to six months or longer.

Your company has decided to migrate existing VMware workloads to Azure VMware Solution. The service provides vSphere clusters built on dedicated Azure hardware and preserves familiar VMware workload-management tools. Some responsibilities differ from an on-premises deployment: Microsoft manages the platform, while you manage workloads and the supported customer-controlled configuration.

In this module, you'll plan and deploy a standard, single-zone Azure VMware Solution Generation 1 private cloud, connect it to an Azure virtual network, and use ExpressRoute Global Reach to connect your existing on-premises VMware infrastructure.

> [!IMPORTANT]
> This walkthrough uses Generation 1 and its Microsoft-managed ExpressRoute circuit. Generation 2 connects AV64 hosts directly to an Azure virtual network and uses different deployment and connectivity steps. Choose the generation, region, host type, quota, and portable VMware Cloud Foundation entitlement before starting. Don't apply the Generation 1 circuit and Global Reach steps to Generation 2.

## Learning objectives

By the end of this module, you'll be able to:

- Plan an Azure VMware Solution deployment, including the generation and licensing prerequisites.
- Connect a standard Generation 1 private cloud to an on-premises VMware environment by using ExpressRoute Global Reach.
