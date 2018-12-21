Azure offers three primary ways to set up virtual networking:

- Azure virtual networks
- Azure VPN gateways
- Azure ExpressRoute

Azure virtual networks can connect resources such as virtual machines and virtual machine scale sets within the same region, enabling them to communicate. Azure virtual networks can also connect to specified Azure service endpoints, such as Azure Storage, databases, and web apps.

Azure VPN gateways can enable communication with on-premises clients or networks over the public Internet, or connect virtual networks in different Azure regions. When you need a highly secure, dedicated route, you can use Azure ExpressRoute. It creates private, high-bandwidth connections to Azure datacenters that achieve the highest levels of reliability and security.

## Cleanup

The interactive exercises in this module created two resource groups, `VpnGatewayDemo` and `vm-networks`. Delete these resource groups to clean up the resources created during the exercises.