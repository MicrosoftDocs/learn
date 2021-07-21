Before creating a virtual network gateway for your virtual network, you first need to create the gateway subnet. The gateway subnet contains the IP addresses that are used by the virtual network gateway. If possible, it's best to create a gateway subnet by using a CIDR block of /28 or /27 to provide enough IP addresses to accommodate future configuration requirements.

When you create your gateway subnet, gateway VMs are deployed to the gateway subnet and configured with the required VPN gateway settings. Never deploy other resources (for example, additional VMs) to the gateway subnet. The gateway subnet must be named *GatewaySubnet*.

Deploy a gateway in your virtual network by adding a gateway subnet.

:::image type="content" source="../media/create-gateway-subnet-c668ade2.png" alt-text="Screenshot of the Subnets blade of the Virtual Networking Azure portal . The add Gateway subnet link is highlighted.":::
