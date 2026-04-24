Power Platform lets users build apps and automations that connect to dozens of data sources through connectors. Without governance, a user could create a flow that sends customer records from Dynamics 365 to a personal social media account. Data loss prevention (DLP) policies in Power Platform prevent this by controlling which connectors can communicate with each other.

## Understand connector groups

A connector is a wrapper around an API that provides predefined triggers and actions to access the data behind it. DLP policies classify connectors into groups that determine which ones can be used together:

| Category | Actions |
| :--- | :--- |
| Business | Allows connections only to other connectors in the business group |
| Non-Business | Allows connections only to other connectors in the nonbusiness group |
| Blocked | Blocks any connection attempts to these connectors |

DLP policies control which connectors can work together, not what data flows through them. For example, if the SharePoint Online connector is in the Business group, a user can still access any content in a SharePoint library. The policy only prevents that connector from being combined with connectors in other groups.

Connectors can reside in only one group at a time. If you move SharePoint Online and a non-Microsoft connector into the Business group, users can't create flows or apps that combine those connectors with anything in the Non-Business or Blocked groups. Existing flows that already comply with the new grouping continue to run, but a background enforcement process suspends flows that now cross group boundaries.

> [!TIP]
> In addition to connector group classification, Power Platform DLP policies now support more granular controls such as connector action control and endpoint filtering. These options let you restrict specific actions or endpoints within a connector rather than blocking the entire connector. For more information, see [Connector action control](/power-platform/admin/connector-action-control) and [Endpoint filtering](/power-platform/admin/dlp-endpoint-filtering).

## Decide how to classify connectors

Before creating a policy, decide which connectors handle sensitive business data and which don't. Start with connectors that access core business systems, such as Dynamics 365, SharePoint Online, and SQL Server, and place those in the Business group. Connectors that access personal or uncontrolled destinations, such as social media or personal email services, should stay in Non-Business or be moved to Blocked. Keeping those connectors in Non-Business or moving them to Blocked prevents users from building flows that bridge business data into unmanaged channels.

If you aren't sure how your organization uses a connector, keep it in Non-Business. You can reclassify it later without disrupting flows that don't cross group boundaries.

While the blocked group exists, not all connectors can be added to it. When a connector can't be blocked, the Block action is greyed out and a warning appears.

> [!NOTE]
> If you select the blocked group as default, all new blockable connectors default to Blocked, and unblockable connectors default to the Non-Business group.

## Choose between tenant-level and environment-level policies

An environment is a space to store, manage, and share your organization's business data, apps, and flows. It also serves as a container to separate apps that have different roles, security requirements, or target audiences.

DLP policies can be scoped to the entire tenant or to specific environments. The decision to use tenant-level or environment-level policies has real consequences:

- **Tenant-level policies** apply across all environments or a selected subset. They're appropriate when you need consistent connector governance everywhere, such as blocking social media connectors organization-wide.
- **Environment-level policies** apply only to a single environment. They're appropriate when different environments have different requirements. For example, a development environment where citizen developers need broader connector access than production.

> [!CAUTION]
> A tenant-level policy takes effect immediately against all existing flows and apps in scope. Existing flows that cross the connector groups you define are suspended. Before applying a tenant-wide policy, audit existing flows to understand which flows and apps the policy affects. Consider starting with a single environment to validate behavior, then expanding scope.

When multiple policies apply to the same environment, the most restrictive combination of connector classifications takes effect.

## Create a DLP policy in Power Platform admin center

To follow these steps for tenant-level policies, you need one of the following permissions:

- Power Platform admin permissions

- Microsoft 365 Global admin permissions

To create environment-level policies, you need to have Power Apps Environment Admin permissions.

To create a DLP policy that denies connectivity between SharePoint Online and non-business apps, follow these steps. Every connector starts in the Non-Business group by default, so the key decisions are which connectors to promote to Business (protecting them from being combined with unmanaged destinations), what URL patterns to allow or deny for custom connectors, and which environments to include in scope.

1. In Power Platform admin center, select **Policies**, select **Data policies**, and then select **+** **New policy**.

1. Enter a policy name, and then select **Next**.

1. On the **Assign Connectors** page, review the default connector classifications.

1. Select the **SharePoint** connector, then select **Move to Business**. You can also use the ellipsis (three dots) to the right of the connector name.

1. After you complete the connector assignment across the **Business**, **Non-Business**, and **Blocked** groups, select **Next**.

1. On the **Custom connectors patterns** page, define **Allow** or **Deny** URL patterns for custom connectors. Select **Add connector pattern**, configure the pattern, select **Save**, then select **Next**.

1. On the **Define scope** page, select **Add multiple environments**, choose the environments to include, and select **Add to policy**. Select **Next**.

1. On the Review and create policy page, review all settings. Select **Create Policy**.

> [!TIP]
> You can also use the PowerApps PowerShell module with the [New-DlpPolicy](/powershell/module/microsoft.powerapps.administration.powershell/new-dlppolicy?azure-portal=true) cmdlet to create a DLP policy for Power Platform.
