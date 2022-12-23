Massively parallel compute applications are often used in security-conscious industries, like banking or insurance. Consider using the following features to enhance the security of your Azure Batch account. 

## Private endpoints for a Batch account

Azure Private Link enables access to the Azure platform as a service (PaaS) services and Azure-hosted, customer-owned services over a private endpoint in your virtual network. Private Link restricts access to a Batch account from within the virtual network or from any peered virtual network. Resources mapped to Private Link are also accessible on-premises over private peering through VPN or Azure ExpressRoute.

To use private endpoints, you need to create a Batch account and configure it appropriately. Public network access configuration must be disabled. After you create the Batch account, you can create private endpoints and associate them with the account.

By default, a private endpoint is an Azure Resource Manager resource. An Azure Resource Manager template (ARM template) defines the infrastructure and configuration that are required for deployment, without writing a sequence of programming commands. ARM template deployment helps to create the virtual network, the web app, the private endpoint, and the private DNS zone.

## Pools without public IP addresses

By default, all the compute nodes in a Batch pool are assigned a public IP address. The Batch service uses this address to schedule tasks and for communication with compute nodes, including outbound access to the internet.

To restrict access to these nodes and reduce the discoverability of these nodes from the internet, you can provision the pool without public IP addresses. This feature is most often used with private endpoints.

## Disk encryption

With a Batch pool, you can access and store data on the OS and temporary disks of the compute node. Encrypting the server-side disk with a platform-managed key will safeguard this data with low overhead and convenience.
