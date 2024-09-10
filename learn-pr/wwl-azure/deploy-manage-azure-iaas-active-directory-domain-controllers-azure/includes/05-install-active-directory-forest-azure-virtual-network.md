Having completed the planning process, you must perform one of the following procedures:

- Deploy an additional AD DS domain controller to an Azure VM.
- Deploy a separate AD forest or domain to Azure that is trusted by domains in your on-premises AD forest.

In this unit, you'll learn how to implement a new Active Directory forest in Azure.

## Create a new Active Directory forest in Azure

The requirements to implement a new Active Directory forest in Azure are similar to that needed to create a replica domain controller. The main difference is that you need to create an Azure virtual network, but there are no requirements for cross-premises connectivity. Furthermore, the new Active Directory forest most likely will be the single Active Directory site, and in that case, all domain controllers should be global catalogs.

To implement a new Active Directory forest in Azure, perform the following procedure:

1. Create an Azure VNet by specifying:
   - The name of the virtual network.
   - The DNS server addresses that point to the IP address of your new domain controller.
   - Virtual Network Address Spaces that define the IP address range for the VMs that run in Azure.
1. Create the VMs to run both the domain controller and DNS server roles, using the procedure outlined in the preceding unit.
1. Install the AD DS and DNS server roles, using the procedure outlined in the preceding unit.

At the end of both processes, to increase security, you can implement access control on the endpoints, or you can design network security groups to limit and control access on domain controllers.
