# Network encryption

## Considerations  
  
        -When using ExpressRoute with private peering, traffic isn't currently encrypted. Traffic on MIcrosoft's backbone is always encrypted with MACSec.
        -MACSec can be used with ExpressRoute private peering only with ExpressRoute Direct
        -With Virtual WAN, private peering ExpressRoute traffic can be encrypted with an IPSec tunnel of private (RFC1918) IP space.
        -Third party VPN appliances are available in the marketplace and OS based encryption for Virtual Machines are also viable options for network encryption.
        -MACSec with ExpressRoute direct will encrypt all traffic on the ExpressRoute connection including BGP data at Layer 2.

## Recommendations

        -If ExpressRoute encryption is needed and ExpressRoute Direct isn't an option, use an IPSec tunnel over ExpressRoute
        -To enable ExpressRoute direct with MACSec, follow the guidance here: <https://docs.microsoft.com/en-us/azure/expressroute/expressroute-howto-macsec>
        -There is no performance degradation on the Microsoft hardware for MACSec, but check with your hardware vendor to understand performance implications of MACSec on your devices.
![Diagram that illustrates encryption flows.](./media/enc-flows.png)