Before you create a virtual network gateway for your virtual network, you first need to create the gateway subnet. The gateway subnet is part of the virtual network IP address range that you specify when you configure your virtual network. There are a few requirements for creating the gateway subnet, including identifying your virtual network gateway IP addresses before you start the creation process.

### Things to know about the gateway subnet

Take a few minutes to review the following important details about the gateway subnet.

- You deploy a gateway in your virtual network by adding a gateway subnet.

- Your gateway subnet must be named *GatewaySubnet*.

- The gateway subnet contains the IP addresses that are used by your virtual network gateway resources and services.

- When you create your gateway subnet, gateway virtual machines are deployed to the gateway subnet and configured with the required VPN gateway settings.

### Things to consider when creating the gateway subnet

When you create the gateway subnet in the Azure portal, there are several configuration parameters. There are a few items to consider when planning your parameter values.

:::image type="content" source="../media/create-gateway-subnet-c668ade2.png" alt-text="Screenshot that shows how to configure the gateway subnet for a virtual network in the Azure portal.":::

- **Consider gateway subnet size**. Some configurations require a larger gateway subnet than others. For the recommended sizes, refer to the documentation for the configuration that you're planning to create. If possible, it's best to create a gateway subnet by using a classless inter-domain routing (CIDR) block of /28 or /27. This approach should provide enough IP addresses to accommodate future configuration requirements.

- **Consider no extra resources**. Identify your required virtual network gateway resources, including virtual machines. When you create your gateway subnet, gateway virtual machines are deployed to the gateway subnet. Never deploy other resources to the gateway subnet, such as extra virtual machines.

- **Consider network security groups**. Network security groups (NSGs) can't be used to create the gateway subnet. If you try to create your gateway subnet with NSGs, the configuration will be blocked. 

   > [!Important]
   > Avoid associating a network security group (NSG) to your gateway subnet. Associating an NSG to the gateway subnet can cause your virtual network gateway to stop functioning as expected, which can affect your VPN and Azure ExpressRoute gateways.