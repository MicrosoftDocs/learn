If you're required to manage multiple Microsoft Sentinel workspaces, or workspaces not in your tenant, you have two options:

- Microsoft Sentinel Workspace manager
- Azure Lighthouse

## Microsoft Sentinel Workspace manager

Microsoft Sentinel's Workspace manager enables users to centrally manage multiple Microsoft Sentinel workspaces within one or more Azure tenants. The Central workspace (with Workspace manager enabled) can consolidate content items to be published at scale to Member workspaces. Workspace manager is enabled in the `Configuration settings`.

:::image type="content" source="../media/microsoft-sentinel-workspace-manager-architectures.png" alt-text="Diagram of Microsoft Sentinel Workspace manager architectures. ":::

## Azure Lighthouse

Implementing  Azure Lighthouse provides the option to enable your access to the tenant.  Once Azure Lighthouse is onboarded, use the directory + subscription selector on the Azure portal to select all the subscriptions containing workspaces you manage.

:::image type="content" source="../media/azure-delegated-tenant.jpg" alt-text="Diagram of multiple tenants managed by Azure Lighthouse. ":::

Azure Lighthouse allows greater flexibility to manage resources for multiple customers without having to sign in to different accounts in different tenants. For example, a service provider may have two customers with different responsibilities and access levels. By using Azure Lighthouse, authorized users can sign in to the service provider's tenant to access these resources.
