Virtual network peering is a secure, efficient method for connecting two virtual networks, allowing applications in different networks, subscriptions, Azure tenants, or regions to communicate directly.

## Virtual network peering with SAP RISE/ECS

Virtual network peering is the most performant way to connect securely between two virtual networks, all in a private network address space. The peered networks appear as one for connectivity purposes, allowing applications running in different virtual networks, subscriptions, Azure tenants, or regions to communicate directly. Like network traffic on a single virtual network, peering traffic remains in a private address space and doesn't traverse the internet.

For SAP RISE/ECS deployments, virtual network peering is the preferred way to establish connectivity with the customer’s existing Azure environment. The primary benefits are:

- Minimized network latency and maximized throughput between the SAP RISE landscape and your own applications and services running in Azure.
- No extra complexity or cost that would be associated with using different on-premises communication paths for SAP RISE, instead using existing Azure network hubs.

Virtual network peering can be set up within the same region as your SAP managed environment, but also through [global virtual network peering](/azure/virtual-network/virtual-network-peering-overview) between any two Azure regions. With SAP RISE/ECS available in many [Azure regions](https://azure.microsoft.com/global-infrastructure/geographies/), the region should match with the workload running in the customer's virtual networks, due to latency and peering cost considerations. However, some scenarios (such as central S/4HANA deployment for a globally present company) also require peering networks globally. For globally distributed SAP landscapes, the recommendation is to use multi-region network architecture within your own Azure environment, with SAP RISE peering locally in each geography to your network hubs.

:::image type="complex" source="../media/sap-rise-peering.png" alt-text="Diagram of Customer peering with S A P RISE / E C S.":::
   This diagram shows a typical S A P customer's hub and spoke virtual networks. Cross-tenant virtual network peering connects S A P RISE and customer's hub virtual networks.
:::image-end:::

Both the SAP and customer virtual networks are protected with network security groups (NSG), permitting communication on SAP and database ports through the peering. Communication between the peered virtual networks is secured through these NSGs, limiting communication to and from customer’s SAP environment.

Since SAP RISE/ECS runs in SAP’s Azure tenant and subscriptions, set up the virtual network peering between [different tenants](/azure/virtual-network/create-peering-different-subscriptions). You accomplish this configuration by setting up the peering with the SAP provided network’s Azure resource ID, and having SAP approve the peering. Add a user from the opposite Microsoft Entra tenant as a guest user, accept the guest user invitation, and follow the process documented in [Create a virtual network peering - different subscriptions](/azure/virtual-network/create-peering-different-subscriptions). Contact your SAP representative for the exact steps required. Engage the respective teams within your organization that deal with network, user administration, and architecture to enable this process to be completed swiftly.
