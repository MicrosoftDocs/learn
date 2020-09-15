Enterprise cloud deployments may have different encryption requirements for different deployments. For instance, a PCI compliant application will have different requirements than an internal application for requesting time off. Below are the considerations and design recommendations for network encryption.

# Considerations  
  
Expressroute private peering traffic isn't currently encrypted. Traffic on MIcrosoft's backbone is always encrypted with MACSec and MACSec can be used with ExpressRoute private peering with ExpressRoute Direct. With Virtual WAN, private peering ExpressRoute traffic can be encrypted with an IPSec tunnel of private (RFC1918) IP space.

Third-party VPN appliances are available in the marketplace and OS based encryption for Virtual Machines are also viable options for network encryption.

![Diagram that illustrates encryption flows.](../media/enc-flows.png)

# Recommendations

Sometimes requirements dictate ExpressRoute encryption is needed and ExpressRoute Direct isn't an option. Use an IPSec tunnel over ExpressRoute. If MACSec is in use, there is no performance degradation on the Microsoft hardware for MACSec, but check with your hardware vendor to understand performance implications of MACSec on your devices.
