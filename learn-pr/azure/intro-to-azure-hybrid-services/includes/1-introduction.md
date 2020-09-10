Many organizations that use Azure have some workloads that run on-premises in traditional datacenters or server rooms and other workloads that run completely in the cloud. And increasing number of organizations migrate the all their workloads to the cloud, while some start as cloud native, Many organizations, however, are either on a slower migration journey toward the cloud or are seeking a balance between having some workloads remain on-premises and others in the cloud. Instead of being an all-or-nothing proposition, a properly architected hybrid Azure deployment allows organizations to find a balance between cloud and on-premises deployments that best fits their needs.

In this module, you’ll get an introductory overview of various hybrid-cloud technologies and how you can connect an on-premises environment to Azure in a way that works best for your organization.

## Scenario

Tailwind Traders is a conglomerate business that manufactures and sells everything from hardware and outdoor maintenance equipment, to electrical appliances and furniture. Tailwind Traders is based in Australia and New Zealand. The head office is in Sydney and branch offices are in Melbourne, Perth, Brisbane, and Auckland. There are important datacenters in Sydney and Melbourne and a minor datacenter in Auckland. In addition, 100 retail sites are scattered across both Australia and New Zealand. These sites have registers and other computers that use VPN connections to interact with applications running in these datacenters.

Tailwind Traders’ IT infrastructure has grown piecemeal since the 1990s. Approximately 25 percent of business-critical applications are still running on physical servers, 60 percent run on virtual machines, and the remaining 15 percent have been migrated to containers. Many of the noncontainerized applications rely heavily on on-premises Active Directory Domain Services for identity and security configuration through Group Policy. The Melbourne datacenter functions as a disaster-recovery site for the Sydney and Auckland datacenters. The Sydney datacenter functions as a disaster-recovery site for the Melbourne datacenter.

Tailwind Traders primarily uses site-to-site VPNs to connect the retail and Auckland sites to the Sydney office. There is a dedicated leased connection between the Sydney and Melbourne datacenters. Internal network traffic between branch offices is all routed through Sydney in a hub-and-spoke architecture.

Tailwind Traders wants to rationalize its datacenter footprint, by migrating workloads to Azure where it makes sense and keeping on-premises the workloads that can’t be easily migrated for technical or cost reasons. The chief information officer (CIO) at Tailwind Traders has named the company’s hybrid cloud strategy Best of Both Worlds.

## Learning objectives

After completing this module, you’ll be able to:

- Describe the elements of an Azure hybrid-cloud deployment.
- Explain methods of connecting on-premises networks to workloads in Azure.
- Understand how to use the same set of identities in hybrid environments.
- List the types of Azure hybrid-cloud compute workloads.
- Explain hybrid cloud application infrastructure.
- Describe the services that support files and data in hybrid clouds.
- Explain technologies that support hybrid-cloud security.

## Prerequisites

To get the best learning experience from this module, you should have knowledge of:

- Azure networking fundamentals
- Azure compute fundamentals
- Azure security fundamentals
- On-premises workload fundamentals
