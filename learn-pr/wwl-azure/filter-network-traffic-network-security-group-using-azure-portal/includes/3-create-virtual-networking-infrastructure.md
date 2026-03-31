Azure **Virtual Network** is the fundamental building block for your private network in Azure. A virtual network enables many types of **Azure resources**, such as **Azure Virtual Machines (VM)**, to securely communicate with each other, the internet, and on-premises networks. A virtual network is similar to a traditional network that you'd operate in your own data center. An Azure Virtual Network brings with it extra benefits of Azure's infrastructure such as scale, availability, and isolation.

**Example: Azure virtual network**

:::image type="content" source="../media/virtual-network-qs-resources-292872a9.png" alt-text="Diagram showing an example of an Azure virtual network topology.":::


## Why use an Azure Virtual network?

Azure virtual network enables Azure resources to securely communicate with each other, the internet, and on-premises networks.

Key scenarios that you can accomplish with a virtual network include:<br>

 -  Communication of Azure resources with the internet
 -  Communication between Azure resources
 -  Communication with on-premises resources
 -  Filtering network traffic
 -  Routing network traffic
 -  Integration with Azure services.

Based on the principle of “never trust, always verify,” Zero Trust helps secure corporate resources by eliminating unknown and unmanaged devices and limiting lateral movement. Implementing a true Zero Trust model requires that all components—user identity, device, network, and applications—be validated and proven trustworthy. Zero Trust verifies identity and device health before granting access to corporate resources. When access is granted, applying the principle of least privilege limits user access to only those resources that are explicitly authorized for each user. Least privilege reduces the risk of lateral movement within the environment. In an ideal Zero Trust environment, the following four elements are necessary:

- Strong identity authentication everywhere (user verification via authentication)
- Devices are enrolled in device management, and their health is validated
- Least-privilege user rights (access is limited to only what is needed)
- The health of services is verified (future goal)

## Network communication behavior

By default, Azure virtual networks allow:

- All outbound traffic to the internet
- All traffic between resources in the same virtual network
- Traffic between peered virtual networks

Network security groups override these defaults by explicitly allowing or denying traffic based on your security requirements. When you create NSG rules, you define exactly which traffic is permitted, implementing a defense-in-depth security strategy.

## Filtering network traffic

Network security groups (NSGs) are the primary tool for filtering network traffic within virtual networks. Understanding how NSG's work with virtual networks is essential:

- **Network security groups**: Contain multiple inbound and outbound security rules that filter traffic to and from resources by source and destination IP address, port, and protocol
- **Subnet-level protection**: Apply NSGs to subnets to control all traffic entering or leaving that subnet
- **Network interface-level protection**: Apply NSGs to individual network interfaces for granular control
- **Network virtual appliances**: Deploy specialized virtual machines (VMs) that perform advanced network functions such as firewalls or WAN optimization

## Virtual networks and availability zones

Virtual networks and subnets span all availability zones in a region. When you deploy resources across availability zones for high availability, the same network security rules apply consistently, simplifying security management while maintaining resilience.
