Organizations have very prescriptive network traffic security requirements. Noncompliance with network traffic security requirements can potentially result in costly penalties – especially in heavily regulated industries such as healthcare or finance. This module demonstrates how to meet these network security requirements by securing outbound network traffic from Azure VMware Solution.

## Example Scenario

You work for a healthcare industry customer – Contoso. Contoso has recently moved their applications from an on-premises VMware environment to Azure VMware Solution.

Contoso's network security team wants to implement the same network traffic inspection and control process in Azure VMware Solution as they had in their on-premises environment. Carrying forward these same processes helps Contoso to remain compliant with rigorous healthcare industry regulations while accelerating their digital transformation initiatives further.

Contoso's network security team wants to control outbound network traffic using their choice of Network Virtual Appliance (NVA). They need to route all outbound traffic through a firewall where rules can be configured to allow or deny traffic based upon protocol, port and IP addresses.

:::image type="content" source="../media/1-azure-vmware-solution-network-connectivity.png" alt-text="Diagram that shows high level architecture of how Contoso wants to implement network traffic inspection.":::

### What will we be doing?

You'll establish connectivity between Azure VMware Solution private cloud and Azure. You'll deploy a custom NVA, which will generate the default route with Azure Firewall as the next hop. Azure Route Server will then propagate the default route to the Azure VMware Solution private cloud. Finally, Azure Firewall controls the traffic via network rule creation.

### What is the main goal?

By the end of this module, you learn how to manage outbound internet connectivity more securely from the Azure VMware Solution private cloud using a custom NVA, Azure Route Server and Azure Firewall.
