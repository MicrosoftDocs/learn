As a leader in the healthcare industry, Contoso must operate in a strict regulatory compliance environment. Take a look at some of the key considerations for network communication in such an environment.

## Protecting digital assets

You must protect every virtual machine (VM) that gets deployed in Azure and Azure VMware Solution private cloud. Network traffic in and out of Azure VMware Solution private cloud must be inspected for malicious activity in real time. Contoso wants to allow their IT administrators to allow or deny access to potentially risky websites such as certain types of social media websites. 

## Controlling network traffic

Contoso has multiple Azure Virtual Networks (VNets). Each VNet has multiple subnets. Contoso needs clearly defined rules established that permit well-defined network traffic across subnets. Such rules enable Contoso to control how each subnet initiates network traffic. It also gives them the ability to override Azure's default network policy of allowing network flow across subnets.

## Firewall Internet Route

After Contoso evaluated the requirements around protection and controlling of network traffic, they chose to use Azure Firewall. It's a stateful, managed firewall as a service. Azure Firewall provides traffic filtering through hybrid network connectivity using ExpressRoute and VPN gateways – which is relevant for Azure VMware Solution private cloud. While Azure Firewall can be used for traffic filtering, it needs direct access to the internet itself which is achieved by configuring the appropriate rules on the subnet in which Azure Firewall is deployed.

Use instructions in the following unit for technical implementation of Azure Firewall and network traffic controls. This implementation helps to meet key network security requirements discussed in this unit.
