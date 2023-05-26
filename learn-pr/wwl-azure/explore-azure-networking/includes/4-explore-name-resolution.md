

Names of resources created in Azure can be resolved by using the Azure-provided DNS service or a DNS server provided or designated by the customer. The Azure-provided DNS service is available by default and might be enough in a range of scenarios. For example, the client DNS resolver on an Azure virtual machine can use the Azure-provided DNS service to resolve the internet-based names. The same DNS service allows for automatic name resolution between virtual machines that reside on the same virtual network.

There are, however, scenarios in which you must implement a custom DNS server. For example, when implementing hybrid connectivity between an Azure virtual network and an on-premises network. Another common scenario involves deploying your own Active Directory domain environment in Azure. In both cases, you must configure an operating system of each Azure virtual machine to use your own DNS server. Typically, you accomplish this by modifying the properties of the Azure virtual network. You can also override the virtual network setting by assigning a DNS server directly to a network adapter of a VM. In either case, you must restart the operating system for the new assignment to take effect.

## Migration considerations

Some organizations might want to use their existing investments in DNS. Design recommendations for SAP implementation when a **virtual machine's DNS or virtual name doesn't change** during migration:

- Background DNS and virtual names connect many system interfaces in the SAP landscape, and customers are only sometimes aware of the interfaces that developers define over time. Connection challenges arise between various systems when virtual or DNS names change after migrations, and it's recommended to retain DNS aliases to prevent these types of difficulties.
- Use different DNS zones to distinguish each environment (sandbox, development, preproduction, and production) from each other. The exception is for SAP deployments with their own VNet; here, private DNS zones might not be necessary.

For more information, see [Network topology and connectivity for an SAP migration](/azure/cloud-adoption-framework/scenarios/sap/eslz-network-topology-and-connectivity#configure-dns-and-name-resolution-for-on-premises-and-azure-resources).
