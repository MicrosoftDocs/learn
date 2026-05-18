Contoso's AI document processing pipeline relies on Azure Storage accounts that are currently accessible from any network. AI agents running in Azure Functions upload and retrieve documents. The on-premises document scanning systems need read access to push scanned files, and Azure AI Foundry processes documents for classification. The cloud security team must restrict network access to only these legitimate sources—while ensuring all other traffic is denied by default.

Azure Storage accounts provide several network security controls that let you create a layered defense strategy. Configure firewall rules to deny traffic from all networks except explicitly allowed sources, and grant access to specific virtual networks, public IP addresses, Azure resource instances, and trusted Azure services. For scenarios requiring fully private connectivity, deploy private endpoints to eliminate public endpoint exposure entirely.

Throughout this module, you work alongside Contoso's cloud security team as they lock down the storage accounts that power the AI document processing pipeline. The team starts by establishing a deny-all firewall baseline, then works through each type of network rule needed to restore access for authorized clients only—the Azure Functions workload, the on-premises scanning systems, and the Azure AI Foundry project. By the end, they eliminate the public endpoint entirely using private endpoints.

## Learning objectives

After completing this module, you'll be able to:

- Describe how Azure Storage firewall rules restrict access through the public endpoint
- Create virtual network rules and IP network rules for approved sources
- Configure resource instance rules for Azure AI and PaaS services
- Add trusted service exceptions for Azure platform services
- Implement private endpoints for fully private storage connectivity
