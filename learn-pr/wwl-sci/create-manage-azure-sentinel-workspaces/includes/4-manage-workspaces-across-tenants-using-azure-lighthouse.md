If you're required to manage a Microsoft Sentinel workspace not in your tenant, implementing  Azure Lighthouse will provide the option to enable your access to the tenant.  Once Azure Lighthouse is onboarded, use the directory + subscription selector on the Azure portal to select all the subscriptions containing workspaces you manage.

:::image type="content" source="../media/azure-delegated-tenant.jpg" alt-text="Diagram of multiple tenants managed by Azure Lighthouse. ":::

Azure Lighthouse allows greater flexibility to manage resources for multiple customers without having to sign in to different accounts in different tenants. For example, a service provider may have two customers with different responsibilities and access levels. By using Azure Lighthouse, authorized users can sign in to the service provider's tenant to access these resources.

