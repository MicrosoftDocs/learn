Organizations with Azure-hosted resources will seek to secure access to those resources. Typically, they'll implement security technologies, such as firewalls, to create security perimeters. These perimeters can control the flow of traffic to and from hosted apps and other resources. If your organization has growing security requirements, it can become difficult to manage these security technologies. How can you simplify the management of your cloud-based security? You can centralize firewall security policies and route management for your cloud-based security perimeters by using Firewall Manager. 

:::image type="content" source="../media/firewall-manager-overview.png" alt-text="Hierarchy of Firewall Manager. A global admin is managing Firewall Manager, which provides centralized management of firewall policies.":::

## Example scenario

Suppose you work for a company that has resources distributed across multiple Azure virtual networks. You might decide to configure Azure Firewall, a managed cloud-based security service. A firewall might protect each resource-holding virtual network, as the following graphic depicts.

:::image type="content" source="../media/single-firewall.png" alt-text="A graphic depicting a simple firewall configuration supporting one workload subnet and one firewall subnet, which is connected to the internet.":::

As your needs grow and change, you need to implement additional instances of Azure Firewall, each with similar rules that govern traffic flow. With a more complex virtual network, virtual WAN, and firewall settings, things can get more difficult to manage. With Firewall Manager, you can centrally manage these components and more easily control your cloud-based security perimeters.

## What will we be doing?

We'll analyze the capabilities and benefits of using Firewall Manager. You'll know when to:

- **Launch**: When should you consider using Firewall Manager?
- **Manage**: How can Firewall Manager help you manage your cloud-based security perimeters?
- **Centralize**: When should you consider using Firewall Manager to centralize your firewall policies and route management?

## What is the main goal?

By the end of this module, you'll have evaluated Firewall Manager and learned how to use it to improve security management.
