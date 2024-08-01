This unit presents a summary of the Well Architected Framework recommendations for securing Azure Open AI

For more information, see [Azure Well-Architected Framework perspective on Azure OpenAI Service](/azure/well-architected/service-guides/azure-openai)

The purpose of the Security pillar is to provide **confidentiality, integrity, and availability** guarantees to the workload.

The [**Security design principles**](/azure/well-architected/security/principles) provide a high-level design strategy for achieving those goals by applying approaches to the technical design around Azure OpenAI.

### Design checklist

Start your design strategy based on the [design review checklist for Security](/azure/security/fundamentals/database-security-checklist) and identify vulnerabilities and controls to improve the security posture. Then, review the [Azure security baseline for Azure OpenAI](/security/benchmark/azure/baselines/azure-openai-security-baseline). Finally, extend the strategy to include more approaches as needed.

> [!div class="checklist"]
>
> - **Protect confidentiality**: If you upload training data to Azure OpenAI, use [customer-managed keys](/azure/ai-services/openai/encrypt-data-at-rest#customer-managed-keys-with-azure-key-vault) for data encryption, implement a key-rotation strategy, and [delete training, validation, and training results data](/azure/ai-services/openai/encrypt-data-at-rest#delete-training-validation-and-training-results-data). If you use an external data store for training data, follow security best practices for that store. For example, for Azure Blob Storage, use customer-managed keys for encryption and implement a key-rotation strategy. Use managed identity-based access, implement a network perimeter by using private endpoints, and enable access logs.
>
> - **Protect confidentiality**: Guard against data exfiltration by limiting the outbound URLs that Azure OpenAI resources can access.
>
> - **Protect integrity**: Implement access controls to authenticate and authorize user access to the system by using the least-privilege principle and by using individual identities instead of keys.
>
> - **Protect integrity**: Implement [jailbreak risk detection](/azure/ai-services/content-safety/concepts/jailbreak-detection) to safeguard your language model deployments against prompt injection attacks.
>
> - **Protect availability**: Use security controls to prevent attacks that might exhaust model usage quotas. You might configure controls to isolate the service on a network. If the service must be accessible from the internet, consider using a gateway to block suspected abuse by using routing or throttling.

### Recommendations

| Recommendation | Benefit |
|--------|----|
| **Secure keys**: If your architecture requires Azure OpenAI key-based authentication, store those keys in Azure Key Vault, not in application code. | Separating secrets from code by storing them in Key Vault reduces the chance of leaking secrets. Separation also facilitates central management of secrets, easing responsibilities like key rotation. |
| **Restrict access**: [Disable public access](/azure/ai-services/openai/how-to/use-your-data-securely#disable-public-network-access) to Azure OpenAI unless your workload requires it. Create [private endpoints](/azure/ai-services/cognitive-services-virtual-networks#use-private-endpoints) if you're connecting from consumers in an Azure virtual network. | Controlling access to Azure OpenAI helps prevent attacks from unauthorized users. Using private endpoints ensures network traffic remains private between the application and the platform. |
| **Microsoft Entra ID**: Use Microsoft Entra ID for authentication and to authorize access to Azure OpenAI by using role-based access control (RBAC). [Disable local authentication in Azure AI Services](/azure/ai-services/disable-local-auth) and set `disableLocalAuth` to `true`. Grant identities that perform completions or image generation the [Cognitive Services OpenAI User](/azure/ai-services/openai/how-to/role-based-access-control#cognitive-services-openai-user) role. Grant model automation pipelines and ad-hoc data-science access a role like [Cognitive Services OpenAI Contributor](/azure/ai-services/openai/how-to/role-based-access-control#cognitive-services-openai-contributor). | Using Microsoft Entra ID centralizes the identity-management component and eliminates the use of API keys. Using RBAC with Microsoft Entra ID ensures that users or groups have exactly the permissions they need to do their job. This kind of fine-grained access control isn't possible with Azure OpenAI API keys. |
| **Use customer-managed keys**: [Use customer-managed keys](/azure/ai-services/openai/encrypt-data-at-rest) for fine-tuned models and training data that's uploaded to Azure OpenAI. | Using customer-managed keys gives you greater flexibility to create, rotate, disable, and revoke access controls. |
| **Protect against jailbreak attacks**: Use [Azure AI Content Safety Studio](https://contentsafety.cognitive.azure.com/) to detect jailbreak risks. | Detect jailbreak attempts to identify and block prompts that try to bypass the safety mechanisms of your Azure OpenAI deployments. |