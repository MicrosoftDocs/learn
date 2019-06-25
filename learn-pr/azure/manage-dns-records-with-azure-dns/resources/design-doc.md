# Module design

## Title

Manage DNS records with Azure DNS

## Role(s)

Administrator

## Level

Beginner

## Product(s)

Azure DNS

## Prerequisites

None

## Summary

Evaluate Azure DNS. Create a DNS zone for the domain name. Create DNS records inside the DNS zone. Test the name resolution for the domain.

## Learning objectives

- Decide whether to host your domain with Azure DNS
- Create DNS zone and records for your domain

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    You recently bought the custom domain name wideworldimporters.com from a domain name registrar. The domain name is for a new website your organization plans to launch. You need a hosting service for DNS domains. This hosting service would resolve the wideworldimporters.com domain to the IP address of your web server. You decide to evaluate Azure DNS.

1. **Learning-content unit title**

    List the content that will enable the learner to *subtask*:

    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective

1. **Knowledge check**

    What types of questions will test *learning objective*?

    - Question type
    - Question type

1. **Exercise - exercise unit title**

    List the steps which apply the learning content from previous unit:

    1. Step
    1. Step
    1. Step

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

## Resources

- [What is Azure DNS?](https://docs.microsoft.com/azure/dns/dns-overview)
- [Tutorial: Configure an alias record to refer to an Azure public IP address](https://docs.microsoft.com/en-us/azure/dns/tutorial-alias-pip)
- [Quickstart: Create an Azure DNS zone and record using the Azure portal](https://docs.microsoft.com/azure/dns/dns-getstarted-portal#test-the-name-resolution)
- [Tutorial: Host your domain in Azure DNS](https://docs.microsoft.com/azure/dns/dns-delegate-domain-azure-dns)
- [Tutorial: Create DNS records in a custom domain for a web app](https://docs.microsoft.com/en-us/azure/dns/dns-web-sites-custom-domain)
- [Tutorial: Create an Azure DNS private zone using the Azure portal](https://docs.microsoft.com/azure/dns/private-dns-portal)
- [Overview of DNS zones and records](https://docs.microsoft.com/azure/dns/dns-zones-records)