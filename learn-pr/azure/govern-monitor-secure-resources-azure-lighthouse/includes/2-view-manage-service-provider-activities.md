Lamna Healthcare has seen great results with Azure Lighthouse so far. Lamna Healthcare already uses multiple service providers, in addition to Relecloud, to manage their subscriptions and resources. You’ll explore how Lamna Healthcare can manage and view information on all their service providers. You’ll also explore how they can view service providers’ activities, delegate specific resources through Azure delegated resource management, and browse for the newest service provider offers.

## How Azure Lighthouse benefits Lamna Healthcare

Lamna Healthcare, takes advantage of   Azure Lighthouse to provision and manage role-based access control (RBAC) for Relecloud's users' access to their Azure environments.  You understand that Lamna Healthcare prefers it to Azure Active Directory B2B because by using Azure delegated resource management, managed service providers (MSPs) like Relecloud no longer need to create administrator accounts (including contributor, security administrator, backup administrator, and more) in Lamna Healthcare’s tenants. This allows MSPs to manage the lifecycle of delegated administrators right within their own Microsoft Azure Active Directory (Azure AD) tenant. Moreover, MSPs can add user accounts to the user group in their Azure Active Directory (AD) tenant, while at Lamna Healthcare, you make sure those groups have the required access to manage their resources. To revoke access when an employee leaves the MSP’s organization, the user can simply be removed from the specific group the access has been delegated to.

You can manage and view information on Relecloud and other service providers managing your subscriptions and resources, you can delegate specific resources and browse for the newest service provider offers all in with a single pane..

## View and manage service providers  

You view all of the service providers that have access to your subscriptions or resource groups through Azure delegated resource management, so that you can consolidate  the management experience. You do this  in the Azure portal, by searching for  "Azure Lighthouse", and selecting "Manage service provider offers":

:::image type="content" source="../media/2-search-azure-lighthouse.png" alt-text="Search for Azure Lighthouse ":::

The Service providers pane in the Azure portal, is where you’ll view information about your company’s service providers. From the same location, you're also able to shop for new service provider offers, and delegate specific resources to service providers:

:::image type="content" source="../media/2-service-provider-overview.png" alt-text="View service providers":::

To find information about service providers,  you select **Service provider offers**.  You’re able to add new public or private offers from Service providers.

Public offers:

:::image type="content" source="../media/2-public-offers.png" alt-text="Public offers":::

Private offers:

:::image type="content" source="../media/2-private-offers.png" alt-text="Private offers":::

### View update offers from service providers

Sometimes, service providers might want to update an offer. In your case, Relecloud have stated they might want to make changes to include a new role definition for the offer. Azure Lighthouse will let you know when this happens, because whenever an offer has been updated by the service provider, the **Service provider offers** pane will show an icon next to the offer in the list to notify  you.

:::image type="content" source="../media/2-offer-updated.png" alt-text="Offer updated":::

You can then select the notification to review the changes and decide whether you want to update to the new version.

### Delegate resources

By selecting the **Delegations** pane on the left,  you can see which resource groups and subscriptions have been made accessible and delegated to the service provider.

Relecloud must be delegated for resource management before Relecloud users can access and manage  your company’s resources and subscriptions. If you've accepted an offer from a service provider, but not yet delegated anything to them, you’ll see a notification in the **Service provider offers** pane. This will help you understand what you need to do before a service provider can access your company’s resources or subscriptions. You'll have to either select **Delegate subscriptions** or **Delegate resource groups**, to specify which resources or subscriptions you want to configure for delegation.

Link to video demo: https://microsoft-my.sharepoint.com/personal/prukulka_microsoft_com/_layouts/15/Lightbox.aspx?url=https%3A%2F%2Fmicrosoft%2Dmy%2Esharepoint%2Ecom%2Fpersonal%2Fprukulka%5Fmicrosoft%5Fcom%2FDocuments%2FDesktop%2FLearn%5FModule200%2FDelegate%20Resources%2Emp4

### Audit delegations

You can gain more visibility into its delegations to service providers. Your company has many different subscriptions and resources would find it especially useful to help keep track of the delegations.   . You can take advantage of **Azure Policy built-in policy definition** for Azure Lighthouse to audit delegation of scopes to service providers. You are able to check for compliance of delegated subscriptions or resources against the policy and stay alert for any unexpected delegations.

Your company must have at least one user who has the Owner built-in role in Azure for the subscription to add offers, remove offers, and delegate resources.

## View service provider activity

If you have delegated subscriptions for Azure delegated resource management,  you  can use Azure Activity log data to monitor any actions that have been taken. This way, you can gain wider visibility into the work the service providers are doing through delegated resource management. 

### View activity log data

With the help of the activity log, you can see a list of activities, the status, along with the date and time an activity occurred. It also shows which user performed a particular action, and whether this is a user from a service provider or from inside Lamna Healthcare. To keep users secure, Azure will only show the user’s role or tenant, and won’t reveal further user information.

You can view the activity login Azure Monitor under the **Monitor** pane in the Azure portal.

Additionally, you can limit the view to show specific subscriptions. You are also able to fetch Azure Activity log events in an automated way by connecting your  own tools to the REST API for further analysis.

Link to video demo: https://microsoft-my.sharepoint.com/personal/prukulka_microsoft_com/_layouts/15/Lightbox.aspx?url=https%3A%2F%2Fmicrosoft%2Dmy%2Esharepoint%2Ecom%2Fpersonal%2Fprukulka%5Fmicrosoft%5Fcom%2FDocuments%2FDesktop%2FLearn%5FModule200%2FViewActivityLogData%2Emp4

### Set alerts to monitor critical operations

You can take advantage of activity log alerts to keep an eye on critical operations performed by its service providers. You set alerts to be triggered in the event that a virtual machine is removed in a certain resource group, or if any administrative actions are performed on a subscription.

### Query logs for analysis

You can create log queries to analyze and audit activity. You're able to query all administrative actions performed on subscriptions, or a particular subscription for an audit. You use Log Analytics to create and run queries. You run a query like the one below to find out who deleted a resource and when they deleted the resource:

:::image type="content" source="../media/2-log-analytics.png" alt-text="Log Analytics queries":::

### Elevation process for users [This section might be removed]

Relecloud users can create eligible authorizations that use Azure AD Privileged Identity Management (PIM) to let users in their tenant temporarily elevate their role.  This way, they can take advantage of additional permissions on a just-in-time basis. After Relecloud users have onboarded your company for Azure delegated resource management, any eligible authorizations created will be available to the specified user (or to users in any specified groups). Each user can elevate their access by visiting Azure AD Privileged Identity Management in the Azure portal (for the managing tenant).

Users in your tenant can review all role assignments, including eligible authorizations, before the onboarding process. They can see which identities in the service provider have standing or 'permanent' authorizations vs which ones need to elevate and for how long they can elevate RBAC to. They aren't notified and don’t need to provide any consent when a user in the managing tenant elevates their access.

For more details, see Activate my Azure AD roles in PIM . <!--- needs to be a link I think. Waiting for Prutha! --> [This should be a link. But link not yet received]