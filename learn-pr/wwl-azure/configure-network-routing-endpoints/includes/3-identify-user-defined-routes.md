
Azure automatically handles all network traffic routing, but in some cases, a custom configuration is preferable. In these situations, you can configure _user-defined routes_ (UDRs) and _next hop_ targets.

### Things to know about user-defined routes

Let's examine the characteristics of user-defined routes.

- UDRs control network traffic by defining routes that specify the _next hop_ of the traffic flow.

- The next hop can be one of the following targets:

   - Virtual network gateway
   - Virtual network
   - Internet
   - Network virtual appliance (NVA)

- Similar to system routes, UDRs also access route tables.

- Each route table can be associated to multiple subnets.

- Each subnet can be associated to one route table only.

- There are no charges for creating route tables in Microsoft Azure.

#### Business scenario

Suppose you have a virtual machine that performs a network function like routing, firewalling, or WAN optimization. You want to direct certain subnet traffic to the NVA. To accomplish this configuration, you can place an NVA between subnets or between one subnet and the internet. The subnet can use a UDR to access the NVA and then the internet. The subnet can use another UDR and NVA to access the back-end subnet. The following illustration highlights this scenario:

:::image type="content" source="../media/user-defined-routes-2417e693.png" alt-text="Diagram that shows two subnets that use a UDR to access an NVA as described in the text." border="false":::