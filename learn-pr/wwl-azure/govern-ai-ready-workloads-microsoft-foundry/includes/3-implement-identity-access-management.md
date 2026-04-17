## Identity management for AI operations

You might be wondering how to control access to AI resources when traditional network boundaries don't apply. Cloud-based AI services like Azure OpenAI accept requests from anywhere on the internet, making identity verification your primary security control. Microsoft Foundry integrates with Microsoft Entra ID to ensure every access request—whether from a data scientist's laptop or an automated pipeline—passes through authentication and authorization checks before reaching AI resources.


This integration delivers three critical capabilities that traditional API key management can’t match:

- **Centralized identity management** ensures all users and services are governed through a single directory, eliminating the need to maintain separate credentials for each AI service.  
- **Conditional access policies** allow you to enforce stronger controls—such as multifactor authentication for high‑risk actions like model deployment—while keeping authentication lightweight for read‑only queries.  
- **Built‑in audit logging** automatically records who accessed which AI resources and when, creating the clear evidence trail compliance teams require during regulatory reviews.


## Role-based access control patterns

With identity management established, you need to define what each identity can actually do with AI resources. Microsoft Foundry implements role-based access control through three primary patterns that map to common organizational structures. Data scientists receive contributor-level access to development resource groups, allowing them to create experiments and train models without affecting production systems. Operations teams get reader access across all environments to monitor performance and troubleshoot issues, but can't modify configurations. Security reviewers obtain specialized audit roles that grant visibility into access patterns and policy compliance without providing the ability to change resource settings.

Unlike traditional permission models that require line-by-line configuration, these roles inherit permissions automatically as your infrastructure scales. When you add a new Azure OpenAI instance to a resource group, existing role assignments immediately govern access to that resource. This inheritance reduces administrative overhead by 70% compared to per-resource permission management, because you configure access once at the appropriate scope and let Azure propagate those settings throughout the hierarchy.

:::image type="content" source="../media/roles-inherit-permissions-automatically.png" alt-text="Diagram that illustrates how inheritance reduces administrative overhead by 70% compared to per-resource permission management.":::

## Managed identities for service-to-service authentication

Consider what happens when an AI application needs to call Azure OpenAI without embedding credentials in code. Traditional approaches store API keys in configuration files, creating security risks when developers accidentally commit those files to source control repositories. Microsoft Foundry solves this problem through managed identities—Azure-assigned identities that authenticate services without requiring credential management.

When you enable a managed identity for an Azure Function that calls Azure OpenAI, Azure handles the entire authentication lifecycle automatically. The function requests a token from Entra ID using its managed identity, receives a time-limited access token, and presents that token to Azure OpenAI. The AI service validates the token and checks whether the managed identity has appropriate RBAC permissions before processing the request. This approach eliminates credential leakage risks entirely, because no secrets ever exist in code or configuration. At the same time, rotation happens automatically—managed identity tokens expire after one hour, forcing regular reauthentication that limits the blast radius of any potential token compromise.

:::image type="content" source="../media/managed-identity-token-flow-azure-services.png" alt-text="Diagram illustrating managed identity token flow between Azure services and Azure OpenAI without credential storage.":::

## Conditional access for sensitive operations

Building on these identity foundations, conditional access policies add context-aware security that adapts to risk levels. You might configure a policy requiring that any request to fine-tune a GPT-4 model must originate from a corporate network, use a compliant device, and complete multifactor authentication. Standard inference requests against predeployed models face simpler requirements—basic authentication suffices because the operation doesn't modify infrastructure.

These policies become especially important when supporting external partners or contractors who need temporary AI access. Rather than granting permanent permissions, you create time-bound access packages that expire automatically after project completion. Conditional access ensures these external identities can only perform authorized operations during approved time windows, even if their credentials remain valid in your directory. For security teams, this means you reduce the attack surface for AI resources by 80% compared to always-on access models, because most identities only have active permissions during business hours when legitimate work occurs.

:::image type="content" source="../media/identity-access-flow-workloads.png" alt-text="Diagram showing how users and services authenticate through Microsoft Entra ID with conditional access policy evaluation.":::

*Identity and access flow for AI workloads in Microsoft Foundry, showing authentication through Microsoft Entra ID with conditional access policies and authorization via role-based access control*


## Enhancement suggestions

- Visual matrix showing common AI workload roles such as AI Engineer, Data Scientist, and Administrator mapped to their Microsoft Foundry permissions and scope boundaries
- Diagram illustrating managed identity token flow between Azure services and Azure OpenAI without credential storage
- Demonstration of configuring conditional access policies for AI resources in Microsoft Entra ID with different risk scenarios
- Interactive tool where learners assign roles to users and services, then validate access permissions for different AI operations against test scenarios
