Organizations with Azure-hosted resources want to secure access to those resources. Typically, they implement security technologies, such as firewalls, to create security perimeters. These perimeters can control traffic flow to and from hosted apps and other resources. However, as your organization's security requirements grow, it might become difficult to manage these security technologies. How can you simplify the management of your cloud-based security? Use Azure Firewall Manager to centralize your firewall-security policies and route management for your cloud-based security perimeters. 

:::image type="content" source="../media/firewall-manager-overview.png" alt-text="Hierarchy of Firewall Manager. A global admin is managing Firewall Manager, which centralizes management of firewall policies.":::

## Example scenario

Suppose your company has resources distributed across multiple Azure virtual networks. You might decide to configure Azure Firewall, a managed cloud-based security service. A firewall can help protect each resource-holding virtual network, as the following graphic depicts.

:::image type="content" source="../media/single-firewall.png" alt-text="A simple firewall configuration supporting one workload subnet and one firewall subnet, which is connected to the internet.":::

As your needs evolve, you can implement more Azure Firewall instances. Each should have similar rules governing traffic flow. Management becomes more difficult when you have a more complex virtual network, virtual WAN, and firewall settings. However, Firewall Manager enables you to centrally manage these components and more easily control your cloud-based security perimeters.

## What will we be doing?

Analyzing the capabilities and benefits of using Firewall Manager so that you can answer the following questions:

- Why should you use Firewall Manager?
- How can Firewall Manager help you manage your cloud-based security perimeters?
- When should you use Firewall Manager to centralize your firewall policies and route management?

## What is the main goal?

That by the end of this module, your evaluation of Firewall Manager has shown you how to use it to help improve security management.
