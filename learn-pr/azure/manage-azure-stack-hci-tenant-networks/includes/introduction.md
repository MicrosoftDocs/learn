Azure Stack HCI provides a highly flexible and more secure multitenant networking environment.

## Example scenario

Suppose you work as a systems engineer at a large, US-based financial services company. Your company develops highly specialized, proprietary commercial applications for its customers, and hosts those applications in its own datacenters.

As part of modernizing its technology, the company started deploying Azure Stack HCI across its on-premises locations. This has significantly accelerated datacenter consolidation, enhanced the agility of compute workloads, and helped minimize the dependency on expensive storage-area networks (SANs) that are complex to manage.

However, your company continues to struggle with maintaining sufficient levels of isolation between its customers and guaranteeing acceptable levels of protection for their workloads. It’s especially challenging to accommodate the customers' need for their own frequently overlapping IP-address spaces. Another increasingly difficult task is ensuring that network connections to customers' datacenters provide a degree of security and resiliency that’s sufficient to satisfy regulatory requirements.

To address these challenges, you decide to use the SDN capabilities in Azure Stack HCI. Your goal is to determine how you could provide the required network isolation and connectivity by using virtualized networking.

You deployed an Azure Stack HCI unit (including Network Controller) into your proof-of-concept environment. Now it’s time to research and evaluate the relevant SDN functionality to determine the extent to which it could help you improve security and resiliency for your customers.

## What will we be doing?

In this module, you’ll explore the isolated and virtual local area network (VLAN)-based tenant VM networking and Gateway connectivity functionality of SDN in Azure Stack HCI. You’ll also review a couple of demonstrations illustrating a sample implementation and use of these capabilities.

## What's the main goal?

By the end of this module, you’ll be able to describe how to use isolated VM networks, VLAN-based VM networks, and Gateway connections to the Enterprise (Layer-3), Site-to-Site, and/or Generic Routing Encapsulation (GRE) on Azure Stack HCI.
