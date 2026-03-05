As your organization moves to Azure, you must design a secure virtual networking environment that provides connectivity and name resolution for both virtual and on-premises resources. Users must be able to access the resources they need smoothly and securely, regardless of where they're accessing the network from. This module provided an overview of some of the most crucial aspects of designing and planning an Azure virtual network. 

**The main takeaways from this module are:**
- Azure virtual networks enable resources in Azure to securely communicate with each other, the internet, and on-premises networks.
- A subnet is a range of IP address in a virtual network. Each subnet must have a unique address range.
- Public networks like the Internet communicate by using public IP addresses. Private networks like your Azure Virtual Network use private IP addresses.
- A dynamic public IP address can change over the lifespan of the Azure resource. A static public IP address doesn't change over the lifespan of the Azure resource.
- Azure provides both public and private DNS resolution.
- Virtual network peering enables you to seamlessly connect two Azure virtual networks. Peering can be either global or regional.
- Azure automatically creates system routes and assigns the routes to each subnet in a virtual network. Each route contains an address prefix and next hop type.
- You can create custom, or user-defined(static), routes. To troubleshoot routing issues, you can view the effective routes for each network interface.
- NAT enables you to share a single public IPv4 address among multiple internal resources.

## Learn more with Copilot
Copilot can assist you in configuring Azure infrastructure solutions. Copilot can compare, recommend, explain, and research products and services where you need more information. Open a Microsoft Edge browser and choose Copilot (top right) or navigate to copilot.microsoft.com. Take a few minutes to try these prompts and extend your learning with Copilot.

- What are the basic steps to configure a virtual network with subnets? What are the most important considerations for the design?
- What is the difference between Azure public and private DNS resolution? Provide usage examples. 
- What is Azure virtual network peering? What usage cases are appropriate for this feature?
- What is the difference between Azure system routes and user-defined routes? Provide usage cases for each route type. 

## Learn more with self-paced training

- [Configure virtual networks](/training/modules/configure-virtual-networks/). Learn to configure virtual networks and subnets, including IP addressing.
- [Manage and control traffic flow in your Azure deployment with routes](/training/modules/control-network-traffic-flow-with-routes/). Learn how to control Azure virtual network traffic by implementing custom routes.
- [Configure Azure Virtual Network peering](/training/modules/configure-vnet-peering/). Learn to configure an Azure Virtual Network peering connection and address transit and connectivity concerns.
