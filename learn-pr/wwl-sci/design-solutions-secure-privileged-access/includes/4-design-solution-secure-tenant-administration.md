This unit will look at the following perspectives on secure tenant administration:

- Azure tenant administration with Azure Lighthouse
- Principles for Microsoft 365 tenant administration

## Azure tenant management with Azure Lighthouse

Azure Lighthouse enables multi-tenant management with scalability, higher automation, and enhanced governance across resources.

With Azure Lighthouse, service providers can deliver managed services using [comprehensive and robust tooling built into the Azure platform](https://learn.microsoft.com/azure/lighthouse/concepts/architecture). Customers maintain control over who has access to their tenant, which resources they can access, and what actions can be taken. [Enterprise organizations](https://learn.microsoft.com/azure/lighthouse/concepts/enterprise) managing resources across multiple tenants can use Azure Lighthouse to streamline management tasks.

[Cross-tenant management experiences](https://learn.microsoft.com/azure/lighthouse/concepts/cross-tenant-management-experience) let you work more efficiently with Azure services such as [Azure Policy](https://learn.microsoft.com/azure/lighthouse/how-to/policy-at-scale), [Microsoft Sentinel](https://learn.microsoft.com/azure/lighthouse/how-to/manage-sentinel-workspaces), [Azure Arc](https://learn.microsoft.com/azure/lighthouse/how-to/manage-hybrid-infrastructure-arc), and many more. Users can see what changes were made and by whom [in the activity log](https://learn.microsoft.com/azure/lighthouse/how-to/view-service-provider-activity), which is stored in the customer's tenant and can be viewed by users in the managing tenant.

![Diagram that shows an overview of Azure Lighthouse](https://learn.microsoft.com/azure/lighthouse/media/azure-lighthouse-overview.jpg)
<!-- 
[](https://learn.microsoft.com/azure/lighthouse/overview#benefits)
-->
## Benefits

Azure Lighthouse helps service providers efficiently build and deliver managed services. Benefits include:

-   **Management at scale**: Customer engagement and life-cycle operations to manage customer resources are easier and more scalable. Existing APIs, management tools, and workflows can be used with delegated resources, including machines hosted outside of Azure, regardless of the regions in which they're located.
-   **Greater visibility and control for customers**: Customers have precise control over the scopes they delegate and the permissions that are allowed. They can [audit service provider actions](https://learn.microsoft.com/azure/lighthouse/how-to/view-service-provider-activity) and remove access completely at any time.
-   **Comprehensive and unified platform tooling**: Azure Lighthouse works with existing tools and APIs, [Azure managed applications](https://learn.microsoft.com/azure/lighthouse/concepts/managed-applications), and partner programs like the [Cloud Solution Provider program (CSP)](https://learn.microsoft.com/azure/lighthouse/concepts/cloud-solution-provider). This flexibility supports key service provider scenarios, including multiple licensing models such as EA, CSP and pay-as-you-go. You can integrate Azure Lighthouse into your existing workflows and applications, and track your impact on customer engagements by [linking your partner ID](https://learn.microsoft.com/azure/lighthouse/how-to/partner-earned-credit).
<!-- 
[](https://learn.microsoft.com/azure/lighthouse/overview#capabilities)
-->
## Capabilities

Azure Lighthouse includes multiple ways to help streamline engagement and management:

-   **Azure delegated resource management**: [Manage your customers' Azure resources securely from within your own tenant](https://learn.microsoft.com/azure/lighthouse/concepts/architecture), without having to switch context and control planes. Customer subscriptions and resource groups can be delegated to specified users and roles in the managing tenant, with the ability to remove access as needed.
-   **New Azure portal experiences**: View cross-tenant information in the [**My customers** page](https://learn.microsoft.com/azure/lighthouse/how-to/view-manage-customers) in the Azure portal. A corresponding [**Service providers** page](https://learn.microsoft.com/azure/lighthouse/how-to/view-manage-service-providers) lets customers view and manage their service provider access.
-   **Azure Resource Manager templates**: Use ARM templates to [onboard delegated customer resources](https://learn.microsoft.com/azure/lighthouse/how-to/onboard-customer) and [perform cross-tenant management tasks](https://learn.microsoft.com/azure/lighthouse/samples/).
-   **Managed Service offers in Azure Marketplace**: [Offer your services to customers](https://learn.microsoft.com/azure/lighthouse/concepts/managed-services-offers) through private or public offers, and automatically onboard them to Azure Lighthouse.

## Microsoft 365 tenant management

A Microsoft 365 tenant is a dedicated instance of the services of Microsoft 365 and your organization data stored within a specific default location, such as Europe or North America. This location is specified when you create the tenant for your organization. Each Microsoft 365 tenant is distinct, unique, and separate from all other Microsoft 365 tenants. You create a Microsoft 365 tenant when you purchase one or more products from Microsoft, such as Microsoft 365 E3 or E5, and a set of licenses for each.

Your Microsoft 365 tenant also includes an Azure Active Directory (Azure AD) tenant, which is a dedicated instance of Azure AD for user accounts, groups, and other objects. Each Azure AD tenant is distinct, unique, and separate from all other Azure AD tenants. While your organization can have multiple Azure AD tenants that you can set up with Azure subscriptions, Microsoft 365 tenants can only use a single Azure AD tenant, the one that was created when you created the tenant.

Here is an example:

![Diagram that shows an example Microsoft 365 tenant with its Azure AD tenant.](../media/tenant-management-example-tenant.png)

_Tenant management_ is the planning, deployment, and ongoing operation of your Microsoft 365 tenants.
<!-- 
[](https://learn.microsoft.com/microsoft-365/solutions/tenant-management-overview?view=o365-worldwide#attributes-of-a-well-designed-and-operating-tenant)
-->
### Attributes of a well-designed and operating tenant

Beyond the correct name and location for your tenant, there are additional elements to plan, deploy, and manage to ensure that your user experiences with cloud productivity apps—such as Microsoft Teams and Exchange Online—are effective, secure, and performant.

Here are the elements:

-   You have the correct set of products (subscriptions) and licenses.
    -   The set of products match your business, IT, and security needs.
    -   There is an adequate number of licenses for your workers and anticipated changes in staffing.
-   For networking:
    -   You have configured the correct DNS domain names.
    -   For enterprise networks, you have optimized network traffic to the Microsoft network for onsite workers.
    -   You have optimized network traffic for remote workers who are using a VPN client.
-   You have synchronized your Active Directory Domain Services (AD DS) accounts, groups, and other objects.
    -   Your Azure AD tenant accounts are mapped to Exchange Online mailboxes with the correct DNS domains for email addresses.
    -   Your user accounts have been assigned the correct licenses from the correct purchased products (such as Microsoft 365 E3 or E5).
-   You have configured strong identity and access management.
    -   You are requiring secure user sign-in with passwordless or multi-factor authentication (MFA).
    -   You have Conditional Access policies that enforce sign-in requirements and restrictions for higher levels of security.
-   On-premises Office servers and their data have been migrated to cloud apps or are being used in a hybrid configuration.
-   You are doing device management with Intune or Basic Mobility and Security built into Microsoft 365.
    -   Your organization-owned devices are enrolled and managed.
    -   The apps for personal devices are managed.

Here is an example of a Microsoft 365 tenant with all these elements in place.

![Diagram that shows an example Microsoft 365 tenant.](../media/tenant-management-tenant-config.png)

In this illustration, the Microsoft 365 tenant includes:

-   Products and licenses for Microsoft 365 E3 and E5.
-   Microsoft 365 productivity apps.
-   Intune with enrolled devices and device and application policies.
-   An Azure AD tenant that has synchronized user account (groups and other directory objects are not shown), domains, and Conditional Access policies.
