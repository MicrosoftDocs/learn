Enterprise cloud deployments might have varying encryption requirements. For instance, a PCI-compliant application has different requirements than an internal application for requesting time off. This unit covers the considerations and design recommendations for network encryption.

## Considerations  
  
Traffic for Azure ExpressRoute private peering isn't currently encrypted. Whenever Azure customer traffic moves between Azure datacenters, it's encrypted through the IEEE 802.1AE MAC Security standard (also known as MACsec). MACsec encryption is also possible when you're using ExpressRoute Direct. With Azure Virtual WAN, you can encrypt traffic for ExpressRoute private peering by using an IPSec tunnel of private (RFC1918) IP space.

Partner VPN appliances are available in Azure Marketplace. OS-based encryption for virtual machines is also a viable option for network encryption.

The following diagram illustrates the encryption flow with: (A) IPSec VPN, (B) MACSec, and (C) VPN over ExpressRoute with Virtual WAN.

:::image type="content" source="../media/7-encryption-flows.png" alt-text="Diagram that illustrates encryption flows." lightbox="../media/7-encryption-flows-large.png":::

## Recommendations

When you're using ExpressRoute Direct, encrypt traffic by using MACSec. If you need end-to-end encryption, use IPSec tunnels on top of ExpressRoute. There's no performance degradation on the Microsoft hardware when you're using MACSec, but check with your hardware vendor to understand performance implications of MACSec on your devices.