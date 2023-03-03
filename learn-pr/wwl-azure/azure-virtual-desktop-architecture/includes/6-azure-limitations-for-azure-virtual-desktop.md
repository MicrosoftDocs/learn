The Azure Virtual Desktop service scales to more than 10,000 session hosts per workspace. You can address some Azure platform and Azure Virtual Desktop control plane limitations in the design phase to avoid changes in the scaling phase.

Numbers in the following sections are approximate. The following numbers are based on various large customer deployments, and they might change over time.

 -  You **can't create more than 500 application groups** per single Azure Active Directory tenant.
 -  We recommend that you **don't publish more than 50 applications** per application group.
 -  We recommend deploying **not more than 5,000 virtual machines per Azure subscription per region**, this recommendation applies to both personal and pooled host pools based on Windows 10 Enterprise single and multi-session. Most customers use Windows 10 Enterprise multi-session, which allows multiple users to log on to each VM. You can increase the resources of individual session host VMs to accommodate more user sessions.
 -  For **automated session host-scaling tools, the limits are around 2,500 virtual machines per Azure subscription per region**, because VM status interaction consumes more resources.
 -  To manage enterprise environments with **more than 5,000 virtual machines per Azure subscription in the same region**, you can create multiple Azure subscriptions in a hub-spoke architecture and connect them via virtual network peering, as in the preceding example architecture. You could also deploy VMs in a different region in the same subscription to increase the number of VMs.
 -  Azure Resource Manager subscription **API throttling limits don't allow more than 600 Azure virtual machine reboots per hour** via the Azure portal. You can reboot all your machines at once via the operating system, which doesn't consume any Azure Resource Manager subscription API calls.
 -  You **can currently deploy 399 VMs per Azure Virtual Desktop Azure Resource Manager template deployment without Availability Sets**, or 200 virtual machines per Availability Set. You can increase the number of VMs per deployment by switching off Availability Sets in either the Azure Resource Manager template or the Azure portal host pool enrollment.
 -  Azure **virtual machine session host name prefixes can't exceed 11 characters**, due to auto-assigning of instance names and the NetBIOS limit of 15 characters per computer account.
 -  By default, **you can deploy up to 800 instances of most resource types in a resource group**. Azure Compute doesn't have this limit.
