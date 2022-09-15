
Perimeter-based networks operate on the assumption that all systems
within a network can be trusted. But today's employees access their
organization's resources from anywhere on a variety of devices and
apps, which makes perimeter security controls irrelevant. Access control
policies that focus only on who can access a resource are not enough. To
master the balance between security and productivity, security admins
also need to factor in how a resource is being accessed.

Networks need to evolve from traditional defenses because networks might
be vulnerable to breaches: an attacker can compromise a single endpoint
within the trusted boundary and then quickly expand a foothold across
the entire network. Zero Trust networks eliminate the concept of trust
based on network location within a perimeter. Instead, Zero Trust
architectures use the device, and user trust claims to gate access to
organizational data and resources. For new initiatives, adopt Zero Trust
approaches that validate trust at the time of access.

## Logically segment subnets

Azure virtual networks are similar to Local Area Networks (LANs) on an on-premises network. The idea behind an Azure virtual network is to create a network based on a single private IP address space, on which all Azure virtual machines can be placed. The private IP address spaces available are in the Class A (10.0.0.0/8), Class B (172.16.0.0/12), and Class C (192.168.0.0/16) ranges.


## Deploy perimeter networks for security zones

A [perimeter network](/azure/architecture/vdc/networking-virtual-datacenter) (also known as a DMZ) is a physical or logical network segment that provides another layer of security between  assets and the internet. Specialized network access control devices on the edge of a perimeter network allow only desired traffic into a virtual network.
Perimeter networks are useful to help focus network access control management, monitoring, logging, and reporting on the devices at the edge of an Azure virtual network. A perimeter network is where distributed denial of service (DDoS) prevention, intrusion detection/intrusion prevention systems (IDS/IPS), firewall rules and policies, web filtering, network antimalware, and more are typically enabled. The network security devices sit between the internet and an Azure virtual network and have an interface on both networks.

Based on the Zero Trust concept, consider using a perimeter network for all high security deployments in order to enhance the level of network security and access control for Azure resources. Azure or a third party solution can be used to provide another layer of security between assets and the internet.

## Avoid exposure to the internet with dedicated WAN links

Many organizations have chosen the hybrid IT route. With hybrid IT, some of the company's information assets are in Azure, and others remain on-premises. In many cases, some components of a service are running in Azure while other components remain on-premises.
In a hybrid IT scenario, there's usually some type of cross-premises connectivity. Cross-premises connectivity allows the company to connect its on-premises networks to Azure virtual networks. 

## Use virtual network appliances

Network security groups and user-defined routing can provide a certain measure of network security at the network and transport layers of the OSI model. But in some situations, security needs to be enabled at high levels of the stack. In such situations, it is recommended to deploy virtual network security appliances provided by Azure partners. Azure network security appliances can deliver better security than what network-level controls provide. 