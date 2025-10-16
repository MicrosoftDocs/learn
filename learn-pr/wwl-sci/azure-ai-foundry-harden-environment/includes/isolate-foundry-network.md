AI workloads in Azure often depend on multiple connected services: storage accounts, compute clusters, data sources, and model endpoints. Without clear network boundaries, these services can be exposed to the public internet, increasing the risk of unauthorized access or data exfiltration. Network isolation ensures that traffic between components stays private and controlled.

**Azure AI Foundry** supports network isolation through **managed virtual networks** and **Private Link**. Together, these features keep data and model communication paths secure while maintaining connectivity to essential Azure services.

Azure AI Foundry runs in a Microsoft-managed network, so its ingress controls limit who can access the Foundry workspace but don't isolate it within your own virtual network. Most organizations focus first on isolating dependent resources like **Key Vault** and **Storage**, where model and data access actually occur.

## Why network isolation matters

When AI workloads process sensitive data or operate in production environments, network configuration plays a central role in security. Public endpoints or open subnets create potential entry points that attackers can exploit, even if authentication and encryption are in place.

Using managed virtual networks and Private Link provides several security and operational benefits:

- **Private traffic paths** that prevent data from crossing the public internet
- **Tighter access control** using network security groups and route tables
- **Consistent integration** with Azure services like Key Vault and Storage through private endpoints
- **Simplified compliance** by ensuring data stays within defined network boundaries

These controls align with zero-trust principles by verifying every connection and minimizing exposure.

## Use managed virtual networks in Azure AI Foundry

Use the **Networking** settings on your Azure AI services resource to restrict which virtual networks can call the Foundry service. The workspace itself remains in a Microsoft-managed virtual network that can't be joined to your own. These controls define who can reach the Foundry workspace and which networks can call it. Isolation of data paths happens on the resources that Foundry connects to, like Storage and Key Vault, by using private endpoints.

When you secure access with virtual network rules and private endpoints:

- Traffic to protected resources uses **Azure Private Link** and stays on the Azure backbone once a private endpoint and DNS are in place.
- Network rules and security groups on your virtual networks can restrict access to approved services.
- Data movement to or from your workloads should use **Private Link** or **ExpressRoute**, not public endpoints. **Service endpoints** are supported but less secure because traffic might still traverse public IP space.

Managed virtual networks and private endpoints reduce exposure without requiring you to build custom networking inside the Foundry service. You can integrate with existing enterprise virtual networks if your organization uses a hub-and-spoke architecture, connecting through private endpoints rather than direct peering with Foundry's managed network.

For detailed setup guidance, see [Configure Azure AI services virtual networks](/azure/ai-services/cognitive-services-virtual-networks).

## Connect services securely with Private Link

**Azure Private Link** allows Foundry to access Azure resources privately by mapping them to private endpoints within your virtual network. This replaces public endpoints with internal addresses that are only accessible from within your network.

You can use Private Link to connect Azure AI Foundry securely to services like:

- **Azure Storage** for datasets and training outputs
- **Azure Key Vault** for credentials and keys
- **Azure Machine Learning** or **OpenAI endpoints** for model hosting
- **Custom APIs** hosted in App Service or Azure Kubernetes Service (AKS)

Private Link reduces data exposure by ensuring that service calls never traverse the public internet. It also integrates with **Defender for Cloud**, which provides recommendations for missing or misconfigured private endpoints.

To configure a private endpoint for a connected service:

1. In the **Azure portal**, open the Azure resource that Foundry connects to, like a Storage account or Key Vault.
1. Go to **Networking** > **Private endpoint connections**, then select **+ Private endpoint**.
1. Select the target resource details, then choose the subscription, resource group, and the **virtual network and subnet** that Foundry uses.
1. Approve the connection request if required by the target resource.

Once configured, Foundry communicates with that resource privately through the virtual network rather than over the internet.

For the full procedure, see [Create a private endpoint using the Azure portal](/azure/private-link/create-private-endpoint-portal?azure-portal=true).

## Combine managed virtual networks and Private Link for layered protection

Managed virtual networks and Private Link work best when used together. The managed virtual network limits who can reach the service, while Private Link creates controlled access points to dependent Azure services. This combination prevents lateral movement and ensures that only trusted components exchange data.

A secure configuration might include:

- A managed virtual network for each Foundry workspace to contain data and compute
- Private endpoints to Azure Storage, Key Vault, and external APIs
- Security groups that limit outbound traffic to approved Azure service tags
- Enable diagnostic settings on private endpoints and connected resources to audit traffic and track usage

These layers create a closed, observable network environment that supports both operational needs and compliance requirements.

Network isolation builds on your earlier configurations for access control and secret management. With managed virtual networks and Private Link in place, your AI workloads run within controlled network boundaries where communication stays private and auditable. Next, you'll configure diagnostic settings and log routing to maintain visibility across your Azure AI Foundry environment.
