Azure Firewall Manager enables you to centralize firewall security policies and route management for your cloud-based security perimeters. 

:::image type="content" source="../media/firewall-manager-overview.png" alt-text="A graphic depicting a simple firewall configuration supporting one workload subnet and one firewall subnet, which is connected to the internet.":::

## Example scenario

Organizations with Azure-hosted resources will seek to secure access to those resources. Typically, they will implement security technologies, such as firewalls, to create security perimeters. These perimeters can be used to control the flow of traffic to and from hosted apps and other resources. 

Let's consider an example. Suppose you have resources distributed across multiple Azure virtual networks. You might decide to configure Azure Firewall, a managed cloud-based security service. Each resource holding virtual network might be protected by a firewall, as displayed in the following graphic.

:::image type="content" source="../media/single-firewall.png" alt-text="A graphic depicting a simple firewall configuration supporting one workload subnet and one firewall subnet, which is connected to the internet.":::

As your needs grow and change, you might implement additional instances of Azure Firewall, each with similar rules that govern traffic flow. With more complex virtual network, virtual WAN, and firewall settings, things can get harder to manage. With Azure Firewall Manager, you can centrally manage these components, making it easier to keep control of your cloud-based security perimeters.

## What will we be doing?

In this module, you'll learn what Azure Firewall Manager can do to help you manage your cloud-based security perimeters. You'll also learn how Azure Firewall Manager works, and when you should consider using it to help centralize firewall policies and route management. 

## What is the main goal?

By the end of this module, you'll have evaluated Azure Firewall Manager, and learned how you can use Azure Firewall Manager to improve security management.

