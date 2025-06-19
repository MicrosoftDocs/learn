Azure Lighthouse enables multitenant management with scalability, higher automation, and enhanced governance across resources.

With Azure Lighthouse, service providers can deliver managed services using comprehensive and robust tooling built into the Azure platform. Customers maintain control over who has access to their tenant, which resources they can access, and what actions can be taken. Enterprise organizations managing resources across multiple tenants can use Azure Lighthouse to streamline management tasks.

Cross-tenant management experiences let you work more efficiently with Azure services such as [Azure Policy](/azure/governance/policy/overview), [Microsoft Sentinel](/azure/sentinel/overview), [Azure Arc](/azure/azure-arc/overview), and more. Users can see what changes were made and by whom in the [Activity Log](/azure/azure-monitor/essentials/activity-log), which is stored in the customer's tenant and viewable by users in the managing tenant.

:::image type="content" source="../media/azure-lighthouse-overview.png" alt-text="Diagram showing an overview of how Azure Lighthouse works.":::

## Benefits

Azure Lighthouse helps service providers efficiently build and deliver managed services. Benefits include:

- **Management at scale**: Customer engagement and life-cycle operations to manage customer resources are easier and more scalable. Existing APIs, management tools, and workflows can be used with delegated resources, including machines hosted outside of Azure, regardless of the region.
- **Greater visibility and control for customers**: Customers have precise control over the scopes they delegate and the permissions that are allowed. They can audit service provider actions and remove access completely at any time.
- **Comprehensive and unified platform tooling**: Azure Lighthouse works with existing tools and APIs, Azure managed applications, and partner programs like the Cloud Solution Provider (CSP) program. This flexibility supports key service provider scenarios, including multiple licensing models such as EA, CSP and pay-as-you-go. You can integrate Azure Lighthouse into your existing workflows and applications, and track your impact on customer engagements by linking your partner ID.

## Capabilities

Azure Lighthouse includes multiple ways to streamline engagement and management:

- **Azure delegated resource management**: Manage your customers' Azure resources securely from within your own tenant. Customer subscriptions and resource groups can be delegated to specified users and roles in the managing tenant, with the ability to remove access as needed.
- **New Azure portal experiences**: View cross-tenant information in the *My customers* page in the Azure portal, or work directly in the context of a delegated subscription. Customers can view and manage provider access in the *Service providers* page.
- **Azure Resource Manager templates**: Use [ARM templates](/azure/lighthouse/how-to/onboard-customer) to onboard delegated customer resources and perform cross-tenant management tasks.
- **Managed Service offers in Azure Marketplace**: Offer your services to customers through [Azure Marketplace](/azure/lighthouse/how-to/publish-managed-services-offers), and automatically onboard them to Azure Lighthouse.

## Pricing and availability

There are no additional costs associated with using Azure Lighthouse to manage Azure resources. Any Azure customer or partner can use Azure Lighthouse.

## Cross-region and cloud considerations

Azure Lighthouse is a nonregional service. You can manage delegated resources located in different regions. However, you can't delegate resources across a national cloud and the Azure public cloud, or across two separate national clouds.

## Support for Azure Lighthouse

For help with Azure Lighthouse, open a [support request in the Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade). Choose **Lighthouse** (under *Monitoring & Management*) as the service if it isn't automatically selected.
