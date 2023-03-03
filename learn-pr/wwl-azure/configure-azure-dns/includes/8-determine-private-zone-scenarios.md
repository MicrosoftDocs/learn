Let's review some common scenarios for implementing Azure Private DNS zone records.

## Scenario 1: Name resolution scoped to a single virtual network

The first scenario consists of virtual networks and resources in Azure that include virtual machines. The resources need to be resolved from within the virtual network by using a specific domain name (or DNS zone). The name resolution needs to be private and not accessible from the internet. The scenario requires that Azure should automatically register the virtual machines within the virtual network into the DNS zone.

:::image type="content" source="../media/resolution-single-zonesv2-56c8d638.png" alt-text="Diagram of a virtual network with virtual machines querying Azure Private DNS zone records. Private IP addresses are resolved by another virtual network." border="false":::

Let's examine the details of this scenario:

- Virtual network 1 contains two virtual machines: VM1 and VM2. VM1 and VM2 each have a private IP address.

- When an Azure Private DNS zone address is created (such as `contoso.lab`) and linked to Virtual network 1, Azure DNS automatically creates two `A` records in the DNS zone if **Auto registration** is enabled in the link configuration.

- In this scenario, Azure DNS uses only Virtual network 2 to resolve domain name (or DNS zone) queries.

   Azure DNS queries from VM1 in Virtual network 1 to resolve the `VM2.contoso.lab` address receive an Azure DNS response that contains the private IP address of VM2 (10.0.0.5).
   
- A reverse DNS query (PTR) for the private IP address of VM1 (10.0.0.4) issued from VM2 receive an Azure DNS response that contains the FQDN of VM1, as expected.

## Scenario 2: Name resolution for multiple networks

The second scenario involves name resolution across multiple virtual networks, which is probably the most common usage for Azure Private DNS zones. This scenario consists of two virtual networks. One network is focused on registration for Azure Private DNS zone records and the other supports name resolution. 

:::image type="content" source="../media/resolution-multiple-zones-c3e11b8d.png" alt-text="Diagram that shows two virtual networks querying Azure Private DNS zone records. One virtual network provides registration, and the other provides name resolution." border="false":::

Here are the details of this configuration:

- Virtual network 1 is designated for _registration_. Virtual network 2 is designated for _name resolution_.

- The design strategy is for both virtual networks to share the common DNS zone address, `contoso.lab`.

- The resolution and registration virtual networks are linked to the common DNS zone.

- Azure Private DNS zone records for virtual machines in Virtual network 1 (registration) are created automatically.

- For virtual machines in Virtual network 2 (resolution), Azure Private DNS zone records can be created manually.

- In this scenario, Azure DNS uses both virtual networks to resolve domain name queries.

   An Azure DNS query from a virtual machine in Virtual network 2 (resolution) for a virtual machine in Virtual network 1 (registration) receives an Azure DNS response containing the private IP address of the virtual machine.

- Reverse DNS queries are scoped to the same virtual network.

   - A reverse DNS (PTR) query from a virtual machine in Virtual network 2 (resolution) for a virtual machine in Virtual network 1 (registration) receives an Azure DNS response containing the `NXDOMAIN` of the virtual machine. `NXDOMAIN` is an error message that indicates the queried domain doesn't exist.
   
   - A reverse DNS (PTR) query from a virtual machine in Virtual network 1 (registration) for a virtual machine also in Virtual network 1 receives the FQDN for the virtual machine.