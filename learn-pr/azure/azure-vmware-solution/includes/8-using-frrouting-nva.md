You will continue to use NVAs for generating the default route just like in your on-premises environment. Discussed below are key considerations for this continuity.

## Operational Processes

NVAs are part of Contoso's Standard Operating Process (SOP). Contoso's monitoring and management processes rely on certain feature sets (like traffic rules and network segmentation) being available in NVAs. Using the same processes and features makes it easy for Contoso to migrate from an on-premises environment to Azure.

## Skills
As part of Contoso's IT team, you have developed deep knowledge of the NVA over the years. It's a good thing that those NVAs can be deployed and operated in Azure. You can carry forward your NVA skills in Azure instead of learning a corresponding Azure service.  

## Open-source
NVAs can either be proprietary or open source. Open source NVAs are developed by the technical community as opposed to a commercial vendor. Proprietary NVAs incur additional costs but provide guaranteed support. With open source NVAs, you have access to source code and rely upon the technical community for any support. At Contoso, you'll use an open-source implementation for the NVA. Such an implementation gives you flexibility to use open protocols such as BGP. You can use NVA capability to generate a default route. NVAs offers simple integration with VMs and networks running in Azure.

The considerations discussed above are the key reasons why Contoso uses FRRouting (FRR) – an open source and free implementation for network routing.

In the next unit, you'll practice how to configure FRR in Azure and generate the default route.
