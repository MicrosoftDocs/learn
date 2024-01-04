You can create new virtual networks at any time. You can also add virtual networks when you create a virtual machine.

### Things to know about creating virtual networks

Review the following requirements for creating a virtual network.

- When you create a virtual network, you need to define the IP address space for the network.

- Plan to use an IP address space that's not already in use in your organization.

   - The address space for the network can be either on-premises or in the cloud, but not both.

   - Once you create the IP address space, it can't be changed. If you plan your address space for cloud-only virtual networks, you might later decide to connect an on-premises site. 

- To create a virtual network, you need to define at least one subnet.

   - Each subnet contains a range of IP addresses that fall within the virtual network address space.
   
   - The address range for each subnet must be unique within the address space for the virtual network.

   - The range for one subnet can't overlap with other subnet IP address ranges in the same virtual network.

- You can create a virtual network in the Azure portal. Provide the Azure subscription, resource group, virtual network name, and service region for the network.

   :::image type="content" source="../media/create-virtual-networks-b4f1fd40.png" alt-text="Screenshot that shows how to create a virtual network in the Azure portal.":::

> [!Note]
> Default limits on Azure networking resources can change periodically. Be sure to consult the [Azure networking documentation](/azure/networking/) for the latest information.