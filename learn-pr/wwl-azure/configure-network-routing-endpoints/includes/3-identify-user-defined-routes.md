Azure automatically handles all network traffic routing. But, what if you want to do something different? For example, you may have a VM that performs a network function, such as routing, firewalling, or WAN optimization. You may want certain subnet traffic to be directed to this virtual appliance. For example, you might place an appliance between subnets or a subnet and the internet.

:::image type="content" source="../media/user-defined-routes-2417e693.png" alt-text="Diagram of a subnet using a UDR to access an NVA and then the internet. The subnet is using another UDR and NVA to access the backend subnet.":::


In these situations, you can configure user-defined routes (UDRs). UDRs control network traffic by defining routes that specify the next hop of the traffic flow. The hop can be a virtual network gateway, virtual network, internet, or virtual appliance.

Each route table can be associated to multiple subnets, but a subnet can only be associated to a single route table.

There are no charges for creating route tables in Microsoft Azure.

> [!NOTE]
> Will you need to create custom routes?
