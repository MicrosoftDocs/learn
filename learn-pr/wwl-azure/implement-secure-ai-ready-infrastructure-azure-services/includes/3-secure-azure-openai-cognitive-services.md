
## Authentication: Eliminating credential sprawl

A Foundry hub connection doesn't automatically configure authentication for every application that calls an AI service. Configure the calling identity and its permissions on the target resource. Traditional API key authentication creates security challenges that compound as your AI portfolio grows. Each service requires unique keys that developers embed in configuration files, environment variables, or—worse—source code. When a developer leaves your organization, your security team must rotate keys across dozens of applications. With 15 AI services deployed, that's 15 credential updates, each risking service disruptions if applications aren't updated simultaneously.

Managed identities eliminate this entire problem by allowing applications to authenticate to Azure services using tokens from Microsoft Entra ID. When your fraud detection application needs to call Azure OpenAI Service, it requests a token using its managed identity. Azure OpenAI validates the token against Entra ID and grants access based on assigned RBAC roles—no API keys involved. This becomes especially valuable when your compliance team audits authentication methods: managed identities provide automatic token rotation, detailed access logs, and centralized permission management that API keys can't match.

:::image type="content" source="../media/validate-token-grants-access-based.png" alt-text="Diagram showing how managed identities provide automatic token rotation and detailed access logs.":::

At the same time, some legacy applications or third-party integrations still require API keys. For these scenarios, store keys in Azure Key Vault and configure your applications to retrieve them at runtime using Key Vault references. Your application code never contains the actual key—only the Key Vault URI. When you need to rotate keys for compliance reasons, you update the key in Key Vault once, and all applications automatically receive the new value on their next retrieval. This hybrid approach satisfies both modern passwordless authentication and backward compatibility requirements.

## Network isolation: Blocking public internet access

With authentication secured through managed identities, your next security boundary is network connectivity. By default, Azure OpenAI Service and Cognitive Services accept connections from the public internet, creating potential exposure to brute-force attacks, data exfiltration attempts, and unauthorized access probes. Your security team requires that all AI service traffic flows through your corporate network, never touching the public internet.

Private endpoints provide private connectivity to an Azure OpenAI resource through a network interface with a private IP address in your virtual network. Configure private DNS so that applications on the permitted network resolve the service hostname to that address. The private endpoint connection must be approved, and the calling application needs a network path to it. For a hub-based workload, verify the required managed-network connections rather than assuming that adding a service connection creates all network access.

To require private access, disable public network access on the Azure OpenAI resource as well. Creating a private endpoint alone doesn't establish that public access is disabled. Test both permitted private access and denied public access. For callers in on-premises data centers, configure a private network path, such as VPN Gateway or ExpressRoute, with the required routing and DNS. These controls govern connectivity, not the service's inference-processing location.

## Content governance: Filtering harmful AI outputs

Now that you understand network and identity controls, let's examine how Azure OpenAI Service prevents your applications from generating or processing harmful content. Unlike traditional APIs that simply return data, generative AI models can produce outputs that violate content policies, expose bias, or create legal liability. Your customer service automation can't risk generating responses that contain hate speech, violence, or discriminatory language—even if customer prompts attempt to elicit such content.

Azure OpenAI Service provides built-in content filtering that analyzes both input prompts and generated responses across four harm categories: hate, sexual, violence, and self-harm. Each category uses severity thresholds (low, medium, high) that you configure based on your organization's risk tolerance. For instance, your customer service application might block all violence content regardless of severity, while your fraud detection system—which analyzes crime reports—allows high-severity violence text in prompts but blocks it in responses to analysts. These filters operate in real-time, rejecting harmful requests before model processing and sanitizing outputs before delivery to applications.

Building on this concept, you can create custom content filters when standard categories don't address your specific compliance requirements. Financial services regulations prohibit providing investment advice without proper disclosures. You'd configure a custom filter that detects phrases like "I recommend buying" or "You should invest" and either blocks the response or injects required disclaimers. This layered content governance—combining platform filters with custom policies—ensures your AI applications stay within regulatory boundaries while serving legitimate business needs.

## Data residency and compliance boundaries

Your European fraud detection team needs to match its model deployment to the organization's approved processing boundary. Selecting an Azure region for the resource is only part of that decision. Review resource location, model deployment type, stored data, and logging destinations separately.

The deployment type determines the inference-processing boundary:

- **Global deployments** can process prompts and responses across global locations where the model is available.
- **Data Zone deployments** process prompts and responses within the Microsoft-defined data zone selected for the deployment, such as the EU data zone.
- **Standard and Regional Provisioned deployments** process prompts and responses within the designated Azure geography. Processing can occur across regions in that geography for operational purposes.

For example, a resource in West Europe with a Global Standard model deployment doesn't constrain inference to West Europe or the EU. If the approved requirement is processing within the Microsoft-defined EU data zone, choose an EU Data Zone deployment where the required model and capacity are available. If the requirement specifies an Azure geography, evaluate the supported geography-based deployment types. Neither option is a blanket guarantee that every operation stays in one Azure region.

For service features that store customer data, the documented storage boundary is generally the resource's designated Azure geography, including for Global and Data Zone deployments. Review feature-specific processing and storage commitments, including any fine-tuning workflow, rather than extending an inference-deployment rule to all training and storage operations. See [Deployment types](/azure/ai-foundry/openai/how-to/deployment-types) and [Data, privacy, and security](/azure/foundry/responsible-ai/openai/data-privacy).

Resource-location policies help restrict where resources are created. They don't substitute for deployment-type controls or determine the processing boundary by themselves. A private endpoint changes the network path to the service, not the documented processing location.

Configure diagnostic settings on the resources you need to monitor, and select log destinations that meet your retention and location requirements. Sending logs to a West Europe Log Analytics workspace doesn't change a Global deployment's processing boundary. Verify the supported log categories and exported fields. If an audit requires prompt or response content, assess its collection, access controls, and retention separately instead of assuming that every diagnostic log contains it.

## Putting it all together: Layered security in practice

Your fraud detection application runs in a separately managed Azure Kubernetes Service cluster and calls an Azure OpenAI model deployment. Configure its workload identity and the required role on Azure OpenAI, private connectivity and DNS, and disabled public access on the service. Select the deployment type that matches the approved processing boundary. Configure content filters and diagnostic settings for the application requirements.

Validate each layer independently: the calling identity has the intended permissions, private access works, public access is denied, the deployment has the approved processing boundary, and the required logs reach the approved destination. Supported hub settings provide a shared baseline, while connected services and applications retain their own configuration requirements. The next unit covers security for the container images that package your AI applications.

## Additional resources

- [Configure managed identities for Azure OpenAI](/azure/ai-services/openai/how-to/managed-identity) - Implementation guide for passwordless authentication
- [Azure OpenAI Service content filtering](/azure/ai-services/openai/concepts/content-filter) - Documentation on harm categories and custom filters
- [Configure private endpoints for Azure AI services](/azure/ai-services/cognitive-services-virtual-networks) - Network isolation configuration steps
