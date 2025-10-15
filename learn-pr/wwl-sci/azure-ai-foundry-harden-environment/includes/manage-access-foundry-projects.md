Configuring role-based access control (RBAC) in Microsoft Entra ID defines who can manage your Azure AI Foundry environment, but project access requires a more granular approach. Each Foundry project includes its own set of roles and permissions that govern who can view data, deploy models, and modify guardrails. Managing these roles independently ensures that access remains aligned with responsibility across teams.

In the **Azure AI Foundry portal**, you'll find **Users** listed twice in the **Management center**, once under the Resource section for workspace access and again under each Project for project-level access.

- The **Resource-level Users** view reflects role assignments managed through Azure role-based access control (RBAC), which determine who can access or manage the Foundry workspace itself.

- The **Project-level Users** view defines who can work inside a specific project and which in-portal permissions they have.

   :::image type="content" source="../media/foundry-user-locations.png" alt-text="Screenshot showing two Users sections in Azure AI Foundry, one under Resource for workspace access and one under Project for project access." lightbox="../media/foundry-user-locations.png":::

To manage project-level access, open **Management center** > **Project** > **Users**, then select **New user**. You can add users or groups and assign roles like **Azure AI User**, **Project Contributor**, or **Reader**. Each role grants progressively broader access, from basic read-only permissions to full modification of project resources.

Apply the same least-privilege approach you used at the Azure layer:

- Grant project access only to active contributors.
- Match roles to actual responsibilities, not job titles.
- Review access under **Inherited access (view only)** to identify users with permissions inherited from higher scopes.

The **Inherited access** list shows identities and service accounts that already have permissions from Azure RBAC assignments at higher levels, like the subscription or resource group. These permissions flow down automatically and can't be changed within the Foundry portal because they're managed in Microsoft Entra ID or the Azure portal.

:::image type="content" source="../media/foundry-inherited-access.png" alt-text="Screenshot showing the Inherited access tab in Azure AI Foundry listing system-assigned roles with read and scanner permissions." lightbox="../media/foundry-inherited-access.png":::

A common setup might give developers Contributor access within a specific Foundry project while reserving project ownership for a smaller operations group that manages guardrails, diagnostics, and integrations with Defender for Cloud. This separation of duties keeps administrative control aligned with accountability.

## Extend access control across connected services

Foundry projects often rely on other Azure services. Consistent access boundaries across these dependencies prevent privilege drift and unintended data exposure.

- **Azure Storage**: restrict write access to only the containers used for model training or logs.
- **Azure Key Vault**: grant access to the **managed identity** used by inference or deployment services instead of individual users.
- **Networking**: use **managed virtual networks** and **private links** to isolate access paths between compute, storage, and model endpoints.
- **Defender for Cloud**: review security recommendations tied to identity and network exposure across these services.

Each supporting service should reflect the same least-privilege principle applied to Foundry itself. When access and network isolation are consistent, your AI workloads operate in a predictable and auditable security boundary.

When these access layers work together, Azure AI Foundry environments stay controlled and auditable. Entra ID defines who can manage the infrastructure, while project roles govern who can work within each workspace. Extending the same principles to connected services like Storage, Key Vault, and networks creates consistent boundaries that protect data and keep operations accountable.

After setting clear access boundaries for Foundry projects, you can turn to protecting the keys and connection information that power them with **Azure Key Vault**.
