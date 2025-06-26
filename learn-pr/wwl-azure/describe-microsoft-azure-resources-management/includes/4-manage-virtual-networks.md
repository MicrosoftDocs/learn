Recall that Azure provides the ability to create and manage your own virtual networks (VNets) and subnets for the virtual networks.

##Virtual Networks
In Azure, a VNet is the foundational building block for private networking. It enables Azure resources like virtual machines, app services, and databases to securely communicate with each other, the internet, and on-premises networks. 

VNets can quickly be created and managed form the Virtual Network blade within Azure. You can create new virtual networks, manage and modify existing VNets, and configure additional settings and resources.

:::image type="content" source="../media/virtual-network-blade.png" alt-text="Screenshot of the virtual network blade within Azure.":::

VNets are logically isolated from one another, providing a secure and customizable environment for deploying cloud resources. They also support advanced networking features such as peering, service endpoints, and private links, making them essential for scalable and secure cloud architectures.

Some things that VNETs are great for include:
* Environment isolation: Separate dev, test, and production environments.
* Security boundaries: Enforce strict access controls between workloads.
* Multi-region deployment: Host VNets in different Azure regions for redundancy and performance.
* Organizational separation: Allow different teams or business units to manage their own networks.
* Subscription limits: Distribute resources across subscriptions to avoid hitting quotas.

##Subnets
Subnets are subdivisions within a VNet that allow you to segment the network into smaller, more manageable sections. Each subnet can host a specific group of resources and apply its own security and routing rules. This segmentation helps improve security, performance, and operational clarity by grouping similar resources together and controlling traffic flow between them.

Common reasons to use multiple subnets include:
* Tiered architecture: Separate web, application, and database layers.
* Custom security policies: Apply different Network Security Groups (NSGs) to control access.
* Service-specific needs: Some Azure services, such as Azure Bastion, require dedicated subnets.
* Traffic routing: Use custom route tables to direct traffic differently per subnet.

:::image type="content" source="../media/virtual-network-overview.png" alt-text="Screenshot of the virtual network overview blade within Azure.":::

Similarly, once a VNet is selected, managing most of the settings is straight forward. For example, you can quickly add additional subnets, or change the subnet configuration .