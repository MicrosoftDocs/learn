:::image type="content" source="../media/create-public-ip-address-f07bd67c.png" alt-text="Screenshot of creating a public IP address.":::


**IP Version**. Select IPv4 or IPv6 or Both. Selecting Both will result in two Public IP addresses being created- one IPv4 address and one IPv6 address.

**SKU**. A standalone virtual machine, virtual machines within an availability set, or virtual machine scale sets can use Basic or Standard SKUs. Mixing SKUs between virtual machines within availability sets or scale sets or standalone VMs is not allowed.

**Name**. The name must be unique within the resource group you select.

**IP address assignment.** There are two types of IP address assignments.

 -  **Dynamic**. Dynamic addresses are assigned only after a public IP address is associated to an Azure resource, and the resource is started for the first time. Dynamic addresses can change if they're assigned to a resource, such as a virtual machine, and the virtual machine is stopped (deallocated), and then restarted. The address remains the same if a virtual machine is rebooted or stopped (but not deallocated). Dynamic addresses are released when a public IP address resource is dissociated from a resource.
 -  **Static**. Static addresses are assigned when a public IP address is created. Static addresses aren't released until a public IP address resource is deleted. If the address isn't associated to a resource, you can change the assignment method after the address is created. If the address is associated to a resource, you may not be able to change the assignment method. If you select IPv6 for the IP version, the assignment method must be Dynamic for Basic SKU. Standard SKU addresses are Static for both IPv4 and IPv6.
