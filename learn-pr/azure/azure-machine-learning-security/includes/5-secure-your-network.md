Before you begin training models, it’s essential to secure your Azure ML network from outside intrusion. Without first securing your network, you can leave your data and models exposed to potential malicious actors and lead to data theft or attacks that change model behavior. These alterations can often be difficult to spot due to the often-large nature of datasets or parameters influencing model behavior. To avoid these problems, we'll begin by separating your model training from the wider net to its own virtual network.

To secure the Azure ML workspace and compute resources, we'll use a **virtual network (VNet).** An Azure VNet is the fundamental building block for your private network in Azure. VNet enables many types of Azure resources, such as *Azure Virtual Machines (VM)* and *Azure Container Registry*, to securely communicate with each other, the internet, and on-premises networks. VNet is similar to a traditional network that you'd operate in your own data center, but brings with it extra benefits of Azure's infrastructure such as scale, availability, and isolation. With a VNet, you can safely communicate between Azure resources and filter network traffic to ensure only trusted users have access to the network.

The main two paths to establishing a VNet for your Azure ML are either through private endpoints or service endpoints. Both can be used to connect resources like Azure storage, Azure Key Vault, and Azure Container Services. Integrating Azure services to an Azure virtual network enables private access to the service from virtual machines or compute resources in the virtual network. You can integrate Azure services in your virtual network with the following options:

* **Service endpoints** provide the identity of your virtual network to the Azure service. Once you enable service endpoints in your virtual network, you can add a virtual network rule to secure the Azure service resources to your virtual network. Service endpoints use public IP addresses.
* **Private endpoints** are network interfaces that securely connect you to a service powered by *Azure Private Link*. Private endpoint uses a private IP address from your VNet, effectively bringing the service into your VNet.

All resources in a VNet can communicate outbound to the internet, by default. You can communicate inbound to a resource by assigning a public IP address or a public Load Balancer. You may also use a public IP or public Load Balancer to manage your outbound connections. Further, you can connect your on-premises computers and networks to a virtual network using any combination of the following options:

* **Point-to-site virtual private network (VPN):** Established between a virtual network and a single computer in your network. Each computer that wants to establish connectivity with a virtual network must configure its connection. This connection type is great if you're just getting started with Azure, or for developers, because it requires little or no changes to your existing network. The communication between your computer and a virtual network is sent through an encrypted tunnel over the internet.
* **Site-to-site VPN:** Established between your on-premises VPN device and an Azure VPN Gateway that is deployed in a virtual network. This connection type enables any on-premises resource that you authorize to access a virtual network. The communication between your on-premises VPN device and an Azure VPN gateway is sent through an encrypted tunnel over the internet.
* **Azure ExpressRoute:** Established between your network and Azure, through an ExpressRoute partner. This connection is private. Traffic does not go over the internet.

![Diagram of the azure machine learning security architecture.](../media/5-workspace.png)

### Securing the workspace and resources

To begin securing your network, you will need to connect to your workspace via a private endpoint (private IP).

You can then limit access to your workspace to only occur over the private IP addresses. The private endpoint can be added to a workspace through the Azure ML Python SDK, Azure CLI, or within the Networking tab of the Azure portal. Since communication to the workspace is then only allowed from the virtual network, any development environments that use the workspace then must be members of the VNet unless you've configured the network to allow public IP connections.

![Diagram showing azure machine learning on a private network.](../media/5-workflow.png)

### Security groups and routing?

Application security groups enable you to configure network security as a natural extension of an application's structure, allowing you to group virtual machines, and define network security policies based on those groups. You can reuse your security policy at scale without manual maintenance of explicit IP addresses. The platform handles the complexity of explicit IP addresses and multiple rule sets, allowing you to focus on building models.

Once you've connected your workspace to a private endpoint, you may connect other Azure tools and services. If you plan on securing the network traffic to/from the public internet, then we must allow inbound communications from the Azure Batch service. The Batch service adds Network security groups (NSGs) which are attached to the VMs. These NSGs automatically configure inbound and outbound rules to allow the following traffic:

### ExpressRoute?

ExpressRoute can be used if you wish to speed up the creation of private connections to Azure services. The service allows to you create private connections between Microsoft datacenters and infrastructure that’s on your premises or in another facility. ExpressRoute connections are separate from the public internet and offer high security, reliability, and speeds with lower latency that typical connections over the internet. ExpressRoute has a range of pricing options depending on your estimated bandwidth requirements.

## Private endpoints & Private Link

The Azure ML workspace can use Azure Private Link to create a private endpoint behind the VNet. This provides a set of private IP addresses that you can use to access the workspace from within the VNet. Some of the services that Azure ML relies on can also use Azure Private Link, but some rely on network security groups or user-defined routing.

You can use private endpoints to allow ingress of events directly from your virtual network to Azure resource securely over a private link without going through the public internet. A private endpoint is a special network interface for an Azure service in your virtual network. When you create a private endpoint for your Azure resource, it provides secure connectivity between clients on your virtual network and your Azure resource. The private endpoint is assigned an IP address from the IP address range of your virtual network. The connection between the private endpoint and the Azure service uses a secure private link.