# Module design

## Title

Host your domain on Azure DNS

## Role(s)

Administrator

## Level

Beginner

## Product(s)

Azure DNS

## Prerequisites

Basic knowledge of networking concepts like name resolution and IP addresses

## Summary

Create a DNS zone for your domain name. Create DNS records to map the URL to an IP address. Test that the domain name resolves to your web server. 

## Learning objectives

- Configure Azure DNS to host your domain

## Chunk your content into subtasks

Identify the subtasks of *Manage DNS records with Azure DNS*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Understand Azure DNS |You need a hosting service for DNS domains |Knowledge check|Enabling objective for "Configure Azure DNS"|
| Create DNS records in Azure | You decide to use Azure DNS | Exercise | Configure Azure DNS to host your domain| Yes |
| Create Private and Public DNS zones |  You decide to use Azure DNS | Exercise | Configure Azure DNS to host your domain | Yes |
| Create Alias records for Azure DNS  |  You decide to use Azure DNS| Exercise | Configure Azure DNS to host your domain | Yes |

## Outline the units

1. **Introduction**

    You recently bought the custom domain name wideworldimporters.com from a domain name registrar. The domain name is for a new website your organization plans to launch. You need a hosting service for DNS domains. This hosting service would resolve the wideworldimporters.com domain to the IP address of your web server. You're already using Azure to build your website. To manage your domain, you decide to use Azure DNS. With Azure DNS, you can keep things simple and use the same credentials, APIs, tools, and billing as your other Azure services. 

1. **What is Azure DNS?**
    - What does Azure DNS do?
       Azure DNS is a hosting service for DNS domains that provides name resolution by using Microsoft Azure infrastructure.
    - Why use Azure DNS?
       - Security features - mention RBAC roles
       - Support for private domains 
       - Integrated with Azure so ease of use: Azure tools to manage, same credentials, support contract, and billing
       - Support for alias records
    - Describe how DNS works 
        - Domains mapped to IP addresses
        - IPv4 and IPv6 can both be mapped if applicable
        - Different types of records, MX, A, CNAME, what do they do?

    See [Azure DNS overview](https://docs.microsoft.com/azure/dns/dns-overview)

    Knowledge check:
    1. Azure DNS allows you to ____?
    1. What security features does Azure DNS provide?
    1. What kind of DNS record would you need to create for ...?

1. **Configure Azure DNS to host your domain**

    - Create a DNS zone
        - How do you point your external domain at azure DNS zone
        - use nslookup to query the SOA record of the zone to prove. (nslookup -type=SOA contoso.net)
        - Configure custom DNS settings
    - Private v Public DNS Zones (Private DNS zones are in preview, expected live end of July)
        - Differences between the two,
        - describe how you link a VNET to create private zone
       - How to configure private DNS zones must be included to cover the information required for the Administrator certification.
    - Explain the DNS records and configuration that are required to address the scenario in unit 1

1. **Exercise - Create DNS Zone and A record using Azure DNS**

    1. Create DNS Zone
    1. Setup Recordset
    1. Create an A record
    1. Demonstrate it working

    See: [Quickstart: Create an Azure DNS zone and record using the Azure portal](https://docs.microsoft.com/azure/dns/dns-getstarted-portal#test-the-name-resolution)

1. **Dynamically resolve resource name by using alias record**


      - Alias Records
        - What problems do they solve, IP changes, load balanced environment
        - How are they created, through the public IP, through the zone


1. **Exercise - Create Alias records for Azure  DNS**

    1. Run a shell script to setup the environment of a load balancer with two VMs and a public IP (See Notes for script info)
    1. Add an alias record to the public IP by creating a DNS zone 
    1. Verify name resolves.
    1. Change the public IP address
    1. Verify name resolves.

    See: [Announcing Alias records for Azure DNS](https://azure.microsoft.com/blog/announcing-alias-records-for-azure-dns/)

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

## Notes

- Cover tasks for AZ-103 certification:
  - Configure Azure DNS
  - Configure custom DNS settings​
  - Configure private and public DNS zones
- For exercises, use this as the model: [Quickstart: Create an Azure DNS zone and record using the Azure portal](https://docs.microsoft.com/azure/dns/dns-getstarted-portal#test-the-name-resolution). E.g. Get as far as you can go without requiring a real domain name. 
- In conceptual learning units, include info about:
  - Creating public vs. private DNS zones - private is in preview as of 6/25 but expected to be public by the end of July.
  - Custom DNS settings
  - Different record types and we'd you need them (E.g. MX records for email). Cover alias records as that's differentiator from other DNS hosting services. Relate alias records to the scenario where they're hosting their website on Azure and using Load Balancer. 
  - Tie configurations back to scenario - what settings/records would they pick to fit the scenario.
  - The following creates a load balanced environment with a public IP, so can be used to setup the final exercise
git clone https://github.com/GeekEffect/load-balancer-setup.git
cd load-balancer-setup
bash setup.sh

## Sandbox requirements

- Microsoft.Compute/availabilitySets X
- Microsoft.Compute/disks X
- Microsoft.Compute/virtualMachines X
- Microsoft.Network/dnszones 
- Microsoft.Network/loadBalancers X
- Microsoft.Network/networkInterfaces X
- Microsoft.Network/networkSecurityGroups NO
- Microsoft.Network/publicIPAddresses X
- Microsoft.Network/virtualNetworks X


## Resources

- [What is Azure DNS?](https://docs.microsoft.com/azure/dns/dns-overview)
- [Tutorial: Configure an alias record to refer to an Azure public IP address](https://docs.microsoft.com/en-us/azure/dns/tutorial-alias-pip)
- [Quickstart: Create an Azure DNS zone and record using the Azure portal](https://docs.microsoft.com/azure/dns/dns-getstarted-portal#test-the-name-resolution)
- [Tutorial: Host your domain in Azure DNS](https://docs.microsoft.com/azure/dns/dns-delegate-domain-azure-dns)
- [Tutorial: Create DNS records in a custom domain for a web app](https://docs.microsoft.com/azure/dns/dns-web-sites-custom-domain)
- [Tutorial: Create an Azure DNS private zone using the Azure portal](https://docs.microsoft.com/azure/dns/private-dns-portal)
- [Overview of DNS zones and records](https://docs.microsoft.com/azure/dns/dns-zones-records)

