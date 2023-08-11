Lamna Healthcare has seen great results with Azure Lighthouse so far. Your company already uses multiple service providers and Relecloud to manage their subscriptions and resources. You’ll explore how Lamna Healthcare can manage and view information on all their service providers. You’ll also explore how they'll view service providers' activities, delegate specific resources through Azure delegated resource management, and browse for the newest service-provider offers.

## How Azure Lighthouse benefits Lamna Healthcare

Lamna Healthcare uses Azure Lighthouse to provision and manage role-based access control (RBAC) so Relecloud users can access their Azure environments. The company prefers Azure Lighthouse to Azure Active Directory B2B. By using Azure delegated resource management, managed service providers (MSPs) like Relecloud no longer need to create administrator accounts (including contributor, security administrator, backup administrator, and more) in your company's tenants. This enables MSPs like Relecloud to manage the lifecycle of delegated administrators within their own Microsoft Azure Active Directory (Azure AD) tenant. MSPs can also add user accounts to the user group in their Azure AD tenant while, at Lamna Healthcare, you make sure those groups have the required access to manage their resources. To revoke access when an employee leaves the MSP’s organization, you remove the user from the specific group access they'd been delegated.

You can manage and view information on Relecloud and other service providers managing your subscriptions and resources. You can also can delegate specific resources and browse for the newest service provider offers, all within a single pane.

You use controls within Azure Lighthouse to understand if your service providers are using Azure Active Directory Privileged Identity Management (Azure AD PIM) or Multi-Factor Authentication (MFA) for their users.

## View and manage service providers  

To consolidate the management experience, you can view all of the service providers that have access to your subscriptions or resource groups through Azure delegated resource management. You do this in the Azure portal by searching for **Azure Lighthouse** and selecting **View service provider offers**.

:::image type="content" source="../media/2-search-azure-lighthouse.png" alt-text="Screenshot of searching for Azure Lighthouse .":::

The Service providers pane in the Azure portal is where you’ll view information about your company's service providers. From the same location, you can also shop for new service provider offers and delegate specific resources to service providers.

:::image type="content" source="../media/2-service-provider-overview.png" alt-text="Screenshot of the View service providers page.":::

To find information about service providers, select **Service provider offers**. You can add new public or private offers from service providers here:

Public offers:

:::image type="content" source="../media/2-public-offers.png" alt-text="Screenshot of the Public offers tab.":::

Private offers:

:::image type="content" source="../media/2-private-offers.png" alt-text="Screenshot of the Private offers tab.":::

For each service provider offer, you'll see the service provider's name and the offer associated with it, along with the name that Lamna Healthcare entered during the onboarding process.

When you’ve added service provider offers, you’ll see a list of all the offers for which your company has signed up, and details of the service provider that delivered each one.

### View update offers from service providers

Sometimes, service providers might want to update an offer. In your case, Relecloud say they might want to make changes to include a new role definition for the offer. Azure Lighthouse lets you know when this happens because, whenever an offer is updated by the service provider, the **Service provider offers** pane shows an icon next to the offer in the list.

:::image type="content" source="../media/2-offer-updated.png" alt-text="Screenshot of an updated offer.":::

You then select the notification to review the changes and decide whether you want to update to the new version.

### Delegate resources

By selecting the **Delegations** pane on the left, you can see which resource groups and subscriptions have been made accessible and delegated to the service provider.

Relecloud must be delegated for resource management before users can access and manage your company’s resources and subscriptions. If you've accepted an offer from a service provider but not yet delegated anything to them, you’ll see a notification in the **Service provider offers** pane. This helps you understand what you need to do before a service provider can access your company’s resources or subscriptions. You'll have to either select **Delegate subscriptions** or **Delegate resource groups** to specify which resources or subscriptions you want to configure for delegation.

In the following video, you’ll see how you do these steps to delegate subscriptions and resource groups to Relecloud, your managed service provider.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4B1Uq]

> [!NOTE]
> This is a silent video. You'll find additional information, where applicable, in captions.

### Audit delegations

Your company has many different subscriptions and resources, so it's especially useful to help keep track of delegations. You can use *Azure Policy built-in policy definition* for Azure Lighthouse to audit delegation of scopes to service providers. Then, you can check for compliance of delegated subscriptions or resources against the policy, and stay alert for any unexpected delegations.

Your company must have at least one user who has the Owner built-in role in Azure. This user can add and remove offers, and delegate resources.

## View service-provider activity

If you have delegated subscriptions for Azure delegated resource management, you can use Azure activity log data to monitor any actions taken. This way, you'll gain wider visibility into the work the service providers are doing through delegated resource management.

### View activity log data

You can use the activity log to see a list of activities, the status, and the date and time an activity occurred. It also shows which user performed a particular action, and whether the user is from a service provider or from inside Lamna Healthcare. To keep users secure, Azure will only show the user’s role or tenant, and won’t reveal further user information.

You can view the activity login Azure Monitor under the **Monitor** pane in the Azure portal.

You can also limit the view to show specific subscriptions and fetch Azure activity log events in an automated way by connecting your own tools to the REST API for further analysis.

In the following video, you’ll learn how to use the activity log to monitor for activities across your managed services:

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4B4vs]

> [!NOTE]
> This is a silent video. You'll find additional information in captions.

### Set alerts to monitor critical operations

You can use activity log alerts to monitor critical operations done by service providers. You can set alerts to trigger if a virtual machine is removed in a certain resource group, or if any administrative actions are done on a subscription.

:::image type="content" source="../media/2-set-alerts.png" alt-text="Screenshot of Monitor Alert rules.":::

### Query logs for analysis

You create log queries to analyze and audit activity. You can query all administrative actions done on subscriptions, or a particular subscription, for an audit. You use Log Analytics to create and run queries. You choose to run a query to find out which devices have sent heartbeats within the last hour. Write your query using the Kusto Query Language (KQL), as follows.

```kql
//List all computer heartbeats from the last hour.

Heartbeat
| where TimeGenerated > ago(1h)

```

Write the query into the Log Analytic query editor, then select **Run**.

:::image type="content" source="../media/2-query-log-analytics.png" alt-text="Screenshot of a query running in Monitor.":::

When the query stops running, you see the results of it in the table underneath your query. The results include details like the IP addresses of each computer, the computer name, and more.
