In this module, you learned about service endpoints, private endpoints, private links, private link services, and DNS integration. 

**The main takeaways from this module are:**
- **Service Endpoints** limit the Azure service's access to the allowed virtual network and subnet. Service endpoints provide network-level security and isolation of the Azure service traffic.
- **Service Endpoint policies** allow you to filter egress virtual network traffic to Azure Storage accounts over Service Endpoint, and allow data exfiltration to only specific Azure Storage accounts.
- **Azure Private Link** enables you to access Azure PaaS Services and Azure hosted customer-owned/partner services over a Private Endpoint in your virtual network. Private Link is designed to eliminate security risks by removing the public part of the connection.
- **Azure private endpoint** is the key technology behind private link. Private endpoint is a network interface that enables a private and secure connection between your virtual network and an Azure service. 
- **Azure Private Link service** lets you offer Private Link connections to your custom Azure services. Consumers of your custom services can then access those services privately—that is, without using the internet—from their own Azure virtual networks.
- **Azure DNS Private Resolver** that enables you to query Azure DNS private zones from an on-premises environment and vice versa without deploying VM based DNS servers. When you use DNS Private Resolver, you don't need a DNS forwarder, and Azure DNS is able to resolve on-premises domain names.

### Learn more with Copilot

Copilot can assist you in configuring Azure infrastructure solutions. Copilot can compare, recommend, explain, and research products and services where you need more information. Open a Microsoft Edge browser and choose Copilot (top right) or navigate to copilot.microsoft.com. Take a few minutes to try these prompts and extend your learning with Copilot.

- What is an Azure Service Endpoint and when would you use it?
- What is an Azure private endpoint and how is it accessed using Azure private link?



## Learn more with self-paced training

Use these resources to discover more.

 -  [Secure and isolate access to Azure resources by using network security groups and service endpoints](/training/modules/secure-and-isolate-with-nsg-and-service-endpoints/). Learn how network security groups and service endpoints help you secure your virtual machines and Azure services from unauthorized network access.
 - [Introduction to Azure Private Link](/training/modules/introduction-azure-private-link/). Learn how  Azure Private Link enables private connectivity to Azure services, including its features, how it works, and its use cases.
 - [Introduction to Azure DNS](/training/modules/intro-to-azure-dns/). This module explains what Azure DNS does, how it works, and when you should choose to use Azure DNS as a solution to meet your organization’s needs.
 - [Design and implement private access to Azure Services](/training/modules/design-implement-private-access-to-azure-services/). Learn to design and implement private access to Azure Services with Azure Private Link, and virtual network service endpoints.
 - [Intro to Azure DNS Private Resolver](/training/modules/intro-to-azure-dns-private-resolver/). This module introduces you to Azure DNS Private Resolver and describes its characteristics, capabilities, and use cases.