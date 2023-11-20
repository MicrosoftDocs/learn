You can create a public IP address for your resource in the Azure portal.

:::image type="content" source="../media/create-public-ip-address-f07bd67c.png" alt-text="Screenshot that shows how to create a public IP address in the Azure portal.":::

### Things to consider when creating a public IP address

To create a public IP address, configure the following settings:

- **IP Version**: Select to create an **IPv4** or **IPv6** address, or **Both** addresses. The **Both** option creates two public IP addresses: an IPv4 address and an IPv6 address.

- **SKU**: Select the SKU for the public IP address, including **Basic** or **Standard**. The value must match the SKU of the Azure load balancer with which the address is used.

- **Name**: Enter a name to identify the IP address. The name must be unique within the resource group you select.

- **IP address assignment**: Identify the type of IP address assignment to use. 

   - **Dynamic** addresses are assigned after a public IP address is associated to an Azure resource and is started for the first time. Dynamic addresses can change if a resource such as a virtual machine is stopped (deallocated) and then restarted through Azure. The address remains the same if a virtual machine is rebooted or stopped from within the guest OS. When a public IP address resource is removed from a resource, the dynamic address is released.

   - **Static** addresses are assigned when a public IP address is created. Static addresses aren't released until a public IP address resource is deleted. If the address isn't associated to a resource, you can change the assignment method after the address is created. If the address is associated to a resource, you might not be able to change the assignment method. 
   
> [!NOTE]
>  If you select **IPv6** for the IP version, the assignment method must be **Dynamic** for the Basic SKU. Standard SKU addresses are **Static** for both IPv4 and IPv6 addresses.