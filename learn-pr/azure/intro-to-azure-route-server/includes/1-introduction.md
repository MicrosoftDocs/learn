Azure Route Server is a fully managed service that simplifies dynamic routing between your network virtual appliance (NVA) and Azure virtual network.

## Example scenario

Imagine that you work for an online retail company that has several applications and databases deployed on servers both on-premises and in the cloud on Azure virtual machines (VMs). Your local on-premises network is configured with several subnets. It also has network appliances to provide firewall and routing functionalities in addition to a connection to Azure. Your resources in Azure consist of several VMs deployed in a virtual network. You also consider deploying Azure ExpressRoute to provide a faster connection between your local resources and Azure resources.

In your Azure network, you have a Software-Defined Wide Area Network (SD-WAN) Network Virtual Appliance (NVA) that connects you to your partner company’s network. The applications and resources deployed on-premises communicate intensively with the resources deployed on Azure VMs. You’ve noticed that changes to either the local or Azure network configuration are accompanied by delays or outages in network communication. Sometimes you need to manually configure static routes to enable proper communication. You need to ensure that the communication is optimized as much as possible, and that changes in network configuration or network routing locally or in Azure are propagated as fast as possible to all network appliances and gateways. To address this requirement, you consider deploying Azure Route Server.

After completing this module, you’ll know more about the Azure Route Server service, how it works, and how to recognize scenarios where you should deploy and use it. You’ll also learn about the high-level steps for its deployment and configuration.

## What will we be doing?

In this module, you’ll be introduced to the Azure Route Server service. You’ll also discuss usage scenarios, learn how it works, and explore the steps you should take to deploy and configure it.

## What is the main goal?

By the end of this module, you’ll be able to describe Azure Route Server, recognize scenarios where it would be of benefit, and know how to deploy it in basic scenarios.
