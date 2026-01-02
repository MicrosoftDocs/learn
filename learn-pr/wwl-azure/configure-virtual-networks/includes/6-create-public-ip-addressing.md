You can create a public IP address for your resource in the Azure portal. For example, you could create a public IP address for a virtual machine.

:::image type="content" source="../media/create-public-ip-address-f07bd67d.png" alt-text="Screenshot that shows how to create a public IP address in the Azure portal.":::

### Things to consider when creating a public IP address

To create a public IP address, configure these settings. Notice that public IP addresses are often used with load balancers. 

- **IP Version**: Public IPv4 addresses can be attached to a load balancer or to a network interface. Public IPv6 addresses can only be attached to load balancers. IPv4 and IPv6 addresses are charged at the same rate.

- **SKU**: Select the SKU for the public IP address. A Public IP's SKU must match the SKU of the Load Balancer with which it is used.

- **Tier**: Must match the load balancer tier. A cross-region load balancer distributes traffic across regional backends. Regional distributes traffic within a virtual network.
  
- **IP address assignment**: Static addresses are assigned when a public IP address is created. Static addresses aren't released until a public IP address resource is deleted. 
   

