
## Authentication: Eliminating credential sprawl

Remember that Foundry Hubs enforce identity controls through Microsoft Entra ID. Now let's see how this translates to securing your AI service connections. Traditional API key authentication creates security challenges that compound as your AI portfolio grows. Each service requires unique keys that developers embed in configuration files, environment variables, or—worse—source code. When a developer leaves your organization, your security team must rotate keys across dozens of applications. With 15 AI services deployed, that's 15 credential updates, each risking service disruptions if applications aren't updated simultaneously.

Managed identities eliminate this entire problem by allowing applications to authenticate to Azure services using tokens from Microsoft Entra ID. When your fraud detection application needs to call Azure OpenAI Service, it requests a token using its managed identity. Azure OpenAI validates the token against Entra ID and grants access based on assigned RBAC roles—no API keys involved. This becomes especially valuable when your compliance team audits authentication methods: managed identities provide automatic token rotation, detailed access logs, and centralized permission management that API keys can't match.

:::image type="content" source="../media/validate-token-grants-access-based.png" alt-text="Diagram showing how managed identities provide automatic token rotation and detailed access logs.":::

At the same time, some legacy applications or third-party integrations still require API keys. For these scenarios, store keys in Azure Key Vault and configure your applications to retrieve them at runtime using Key Vault references. Your application code never contains the actual key—only the Key Vault URI. When you need to rotate keys for compliance reasons, you update the key in Key Vault once, and all applications automatically receive the new value on their next retrieval. This hybrid approach satisfies both modern passwordless authentication and backward compatibility requirements.

## Network isolation: Blocking public internet access

With authentication secured through managed identities, your next security boundary is network connectivity. By default, Azure OpenAI Service and Cognitive Services accept connections from the public internet, creating potential exposure to brute-force attacks, data exfiltration attempts, and unauthorized access probes. Your security team requires that all AI service traffic flows through your corporate network, never touching the public internet.

Private endpoints transform this requirement into reality by creating a network interface within your Azure Virtual Network that maps to your AI service. When you deploy a private endpoint for Azure OpenAI Service, Azure assigns a private IP address from your VNet subnet to the service. Applications within your VNet—including Foundry Projects connected through the hub's network configuration—access the service using this private IP. All traffic stays within the Azure backbone network, completely bypassing public internet routing. For example, when your fraud detection model queries GPT-4, the request flows from your project workspace through the private endpoint to Azure OpenAI Service without ever becoming visible to external networks.

This network boundary provides measurable security benefits beyond regulatory compliance. Organizations implementing private endpoints report 100% reduction in internet-based attack attempts against AI services and eliminate data exfiltration risks from misconfigured public endpoints. However, this changes when you need to access AI services from on-premises data centers or remote developer workstations. In these scenarios, configure Azure VPN Gateway or ExpressRoute to extend your private network connectivity to external locations, maintaining the security boundary while supporting distributed teams.

## Content governance: Filtering harmful AI outputs

Now that you understand network and identity controls, let's examine how Azure OpenAI Service prevents your applications from generating or processing harmful content. Unlike traditional APIs that simply return data, generative AI models can produce outputs that violate content policies, expose bias, or create legal liability. Your customer service automation can't risk generating responses that contain hate speech, violence, or discriminatory language—even if customer prompts attempt to elicit such content.

Azure OpenAI Service provides built-in content filtering that analyzes both input prompts and generated responses across four harm categories: hate, sexual, violence, and self-harm. Each category uses severity thresholds (low, medium, high) that you configure based on your organization's risk tolerance. For instance, your customer service application might block all violence content regardless of severity, while your fraud detection system—which analyzes crime reports—allows high-severity violence text in prompts but blocks it in responses to analysts. These filters operate in real-time, rejecting harmful requests before model processing and sanitizing outputs before delivery to applications.

Building on this concept, you can create custom content filters when standard categories don't address your specific compliance requirements. Financial services regulations prohibit providing investment advice without proper disclosures. You'd configure a custom filter that detects phrases like "I recommend buying" or "You should invest" and either blocks the response or injects required disclaimers. This layered content governance—combining platform filters with custom policies—ensures your AI applications stay within regulatory boundaries while serving legitimate business needs.

## Data residency and compliance boundaries

Consider what happens when your European fraud detection team needs Azure OpenAI Service for analyzing transactions. Regulatory requires that EU customer data stays within European Economic Area borders, but Azure OpenAI's default deployment might process requests in any global region. This creates compliance risk that could result in regulatory fines and damage customer trust.

Azure OpenAI Service supports regional deployments that guarantee data processing stays within specific geographies. When you create an OpenAI resource, you select an Azure region like West Europe or North Europe. All model training, inference processing, and data storage for that resource occurs within your chosen region. Your Foundry Hub configuration can enforce this requirement by restricting project creation to approved regions. The fraud detection project deploys its OpenAI instance in West Europe, ensuring regulatory compliance, while the US-based customer service project uses East US for lower latency to American call centers.

:::image type="content" source="../media/azure-service-support-regional-deployments.png" alt-text="Diagram showing how Azure OpenAI Service supports regional deployments that guarantee data processing.":::

At the same time, diagnostic logging for audit trails might store data in Log Analytics workspaces. Configure these workspaces in the same region as your AI services to maintain consistent data residency. Enable diagnostic settings to send API request logs, content filter decisions, and access events to your workspace. These logs provide the audit trail your compliance team needs during regulatory reviews, showing which identities accessed services, what prompts were submitted, and which responses were filtered. Organizations that implement comprehensive diagnostic logging reduce audit preparation time by 60% and gain visibility into AI usage patterns that inform capacity planning.

## Putting it all together: Layered security in practice

Now that you've seen each security control individually, let's examine how they work together in a production deployment. Your fraud detection application runs in an Azure Kubernetes Service cluster within your Foundry Project workspace. The application uses a managed identity assigned to its pod to authenticate to Azure OpenAI Service—no credentials stored in container images or Kubernetes secrets. All API requests flow through a private endpoint connected to your project's virtual network, ensuring traffic never leaves Azure's private backbone. Content filters reject any prompts that might expose customer personal information and block responses containing harmful content. Diagnostic logs capture every API call with request metadata, enabling your security team to audit AI service usage and detect anomalies.

This architecture delivers measurable outcomes: 100% elimination of credential-based authentication vulnerabilities, zero public internet exposure for AI services, real-time content policy enforcement on every request, and complete audit trails for compliance reporting. Your security team approves the deployment because every control is verifiable and enforceable through Azure Policy. Your development team maintains velocity because Foundry Projects inherit security automatically—no manual configuration of networking, identity, or logging per application. With this foundation in place, you're ready to add the final security layer: securing the container images that package your AI applications for deployment.

:::image type="content" source="../media/secure-authentication-network-access-flow.png" alt-text="Diagram showing secure authentication and network access flow for Azure AI services.":::

*Secure authentication and network access flow for Azure AI services showing managed identity as primary authentication path with private endpoint connectivity and content filtering*

## Additional resources

- [Configure managed identities for Azure OpenAI](/azure/ai-services/openai/how-to/managed-identity) - Implementation guide for passwordless authentication
- [Azure OpenAI Service content filtering](/azure/ai-services/openai/concepts/content-filter) - Documentation on harm categories and custom filters
- [Configure private endpoints for Azure AI services](/azure/ai-services/cognitive-services-virtual-networks) - Network isolation configuration steps
