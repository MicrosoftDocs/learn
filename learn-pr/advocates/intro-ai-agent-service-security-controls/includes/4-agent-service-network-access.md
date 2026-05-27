Network isolation for current Foundry Agent Service is configured for a Foundry resource and its projects, not for a classic hub. Separate inbound private endpoint access to the Foundry resource from outbound private isolation for agent runtime traffic. Basic setup can use inbound private access, but outbound private network isolation for agents requires **Standard Setup with private networking**.

Standard Setup with private networking helps keep agent traffic private by using:

- **Public network access disabled** on the Foundry resource and on the supporting resources that store agent data.
- **Private endpoints and private DNS** so clients and services resolve Foundry, Azure Storage, Azure AI Search, and Azure Cosmos DB endpoints to private IP addresses.
- **Virtual network injection** so the agent runtime connects to your virtual network through a dedicated subnet.
- **Bring your own (BYO) resources** for Azure Storage, Azure AI Search, and Azure Cosmos DB. Standard setups require these resources so agent files, vector data, and conversation state stay in your Azure tenant.

Before you configure a network-secured environment, validate these prerequisites:

- The person creating the Foundry account and project has the **Foundry Account Owner** role at subscription scope.
- For Standard Setup with private networking, the same person can assign roles on the required Azure Cosmos DB, Azure AI Search, and Azure Storage resources. **Role Based Access Control Administrator**, or **Owner at the subscription level**, satisfies this requirement because it includes `Microsoft.Authorization/roleAssignments/write`.
- Required resource providers are registered: `Microsoft.KeyVault`, `Microsoft.CognitiveServices`, `Microsoft.Storage`, `Microsoft.MachineLearningServices`, `Microsoft.Search`, `Microsoft.Network`, `Microsoft.App`, and `Microsoft.ContainerService`. Register `Microsoft.Bing` only if the solution uses Grounding with Bing Search.
- Team members who create or edit agents after deployment have the **Foundry User** role on the project.
- Azure AI Search tool connections that use a private virtual network use keyless Microsoft Entra authentication with the project managed identity. Key-based authentication isn't supported for that private networking path.
- Hosted agents have extra network limitations: virtual network injection must be included when the Foundry account is first created, and you can't add it later to an existing account. An Azure Container Registry used for hosted agent images also must remain reachable over its public endpoint; a private endpoint with public network access disabled isn't supported for that registry.

To configure a network-secured environment:

1. Create or select the Azure Storage account, Azure AI Search service, and Azure Cosmos DB account that the Foundry project will use.
1. Disable public network access on the Foundry resource and on each BYO resource.
1. Create private endpoints for the Foundry resource and for each BYO resource. Private endpoints to Azure Storage, Azure AI Search, and Azure Cosmos DB aren't autocreated when you deploy the Foundry resource. Configure and link the required private DNS zones to the virtual network so resource names resolve to private IP addresses.
1. Enable virtual network injection for Foundry Agent Service. Select a dedicated agent subnet in the same region as the Foundry resource and virtual network. The subnet must be delegated to `Microsoft.App/environments` and must be `/27` or larger; `/24` is recommended for production capacity.
1. Assign least-privilege roles to the users and managed identities that create agents and access BYO data sources.
1. Verify the deployment from a machine connected to the virtual network by confirming the agent subnet is delegated to `Microsoft.App/environments`, checking private DNS resolution for the Foundry resource and each BYO resource, confirming public network access is disabled on all of them, and creating or running an agent in the Foundry project.

You can create the setup in the Azure portal or deploy it by using Bicep or Terraform. If users need to work with secured agents from outside the virtual network, provide private connectivity such as VPN Gateway, ExpressRoute, or a jump box accessed through Azure Bastion.

> [!NOTE]
> Earlier hub-based projects (Azure AI Agent Service (classic)) used managed virtual network outbound modes and Application Gateway patterns for some on-premises access scenarios. Treat that guidance as migration context only. Use Standard Setup with private networking for current Foundry Agent Service deployments.
