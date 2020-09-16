Enterprise cloud deployments may have different encryption requirements for different deployments. For instance, a PCI compliant application will have different requirements than an internal application for requesting time off. Below are the considerations and design recommendations for network encryption.

## Considerations  
  
ExpressRoute private peering traffic isn't currently encrypted.Whenever Azure Customer traffic moves between Azure datacenters, it is encrypted using IEEE 802.1AE MAC Security Standards (also known as MACsec). MACsec encryption is also possible when using ExpressRoute Direct. With Virtual WAN, private peering ExpressRoute traffic can be encrypted with an IPSec tunnel of private (RFC1918) IP space.

Third-party VPN appliances are available in the marketplace and OS based encryption for Virtual Machines are also viable options for network encryption.

The diagram below illustrates the encryption flow with: A. IPSec VPN, B. MACSec and C. VPN over ExpressRoute with Virtual WAN.

:::image type="content" source="../media/enc-flows.png" alt-text="Diagram that illustrates encryption flows.":::

## Recommendations

When using ExpressRoute Direct, encrypt traffic using MACSec. If end-to-end encryption is required, use IPSec tunnels on top of ExpressRoute. If MACSec is in use, there is no performance degradation on the Microsoft hardware for MACSec, but check with your hardware vendor to understand performance implications of MACSec on your devices.
