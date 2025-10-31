Notification configuration requires systematic audience analysis followed by comprehensive rule-based subscription management to ensure effective team communication and project awareness.

Azure DevOps enables notification configuration through rule-based subscriptions, default out-of-the-box (OOB) templates, and custom administrator-defined scenarios for comprehensive project activity monitoring.

Notification triggers encompass comprehensive project lifecycle events:

- **Work items:** Assignment changes, state transitions, field updates, and comment additions
- **Code reviews:** Review requests, approval status, and completion notifications
- **Pull requests:** Creation, approval, merge completion, and conflict resolution
- **Source control files:** Check-ins, branch operations, and repository changes (TFVC or Git)
- **Builds:** Completion status, failure alerts, and queue notifications
- **Releases:** Deployment success, failure conditions, and approval requirements

Event-specific scenarios include build completion notifications for continuous integration feedback and release failure alerts for immediate issue response.

Azure DevOps notification management operates across four hierarchical scopes for comprehensive organizational coverage:

- **Personal notifications:** Individual user subscriptions for relevant project activities
- **Team notifications:** Group-specific alerts for collaborative workflows and shared responsibilities
- **Project notifications:** Project-wide announcements and milestone communications
- **Global notifications:** Organization-level alerts for enterprise-wide visibility and governance

For each notification, you have a set of specific steps to configure. The following steps show how to manage global notifications:

1.  Open your Azure DevOps organization `https://dev.azure.com/**\{organization\}**/\_settings/organizationOverview`.
2.  Click on Organization settings at the bottom left side.
3.  Click on Global notifications under the General tab.

    :::image type="content" source="../media/azure-devops-global-notifications-d4ef8339.png" alt-text="Screenshot of Azure DevOps global notifications.":::

The Default subscriptions tab lists all default global subscriptions available. The globe icon on a notification subscription indicates the subscription is a default subscription. You can view all [default notification subscriptions](/azure/devops/organizations/notifications/oob-built-in-notifications).

You can view and enable options available in the context menu (...) for each subscription.

> [!NOTE]
> Only Project Collection Administrators can enable/disable any default subscription in this view. Project Collection Valid Users group can only view the details of the default subscription.

In the Subscribers tab, you can see users subscribed to each notification item. The Settings section shows the _Default delivery option_ setting. All teams and groups inherit this setting.

You can see how to manage your personal notifications following [manage your personal notifications](/azure/devops/notifications/manage-your-personal-notifications).

For more information, see:

- [Get started with notifications in Azure DevOps - Azure DevOps](/azure/devops/organizations/notifications/about-notifications).
- [Manage notifications for a team, project, organization, or collection - Azure DevOps](/azure/devops/organizations/notifications/manage-team-group-global-organization-notifications).
- [Events, subscriptions, and notifications - Azure DevOps.](/azure/devops/organizations/notifications/about-notifications)
