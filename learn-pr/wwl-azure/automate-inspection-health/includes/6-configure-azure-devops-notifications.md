
After defining your target audience, you need to configure your notifications. Using Azure DevOps, you can help your team stay informed about your projects' activities.

You can configure notifications to be sent based on rules or subscriptions by default, out-of-the-box (OOB), created by you or the team or group administrator.

You can get a notification when the following items change:

 -  Work items.
 -  Code reviews.
 -  Pull requests.
 -  Source control files (TFVC or Git).
 -  Builds.
 -  Release.

For example, you can get notified whenever your build completes, or your release fails.

There are four notification types that you can manage in Azure DevOps:

 -  Personal notifications.
 -  Team notifications.
 -  Project notifications.
 -  Global notifications.

For each notification, you have a set of specific steps to configure. The following steps show how to manage global notifications:

1.  Open your Azure DevOps organization ```https://dev.azure.com/**\{organization\}**/\_settings/organizationOverview```.
2.  Click on Organization settings at the bottom left side.
3.  Click on Global notifications under the General tab.
    
    :::image type="content" source="../media/azure-devops-global-notifications-d4ef8339.png" alt-text="Screenshot of Azure DevOps global notifications.":::
    

The Default subscriptions tab lists all default global subscriptions available. The globe icon on a notification subscription indicates the subscription is a default subscription. You can view all [default notification subscriptions](/azure/devops/notifications/oob-built-in-notifications?view=azure-devops).

You can view and enable options available in the context menu (...) for each subscription.

> [!NOTE]
> Only Project Collection Administrators can enable/disable any default subscription in this view. Project Collection Valid Users group can only view the details of the default subscription.

In the Subscribers tab, you can see users subscribed to each notification item. The Settings section shows the *Default delivery option* setting. All teams and groups inherit this setting.

You can see how to manage your personal notifications following [manage your personal notifications](/azure/devops/notifications/manage-your-personal-notifications).

For more information, see:

 -  [Get started with notifications in Azure DevOps - Azure DevOps](/azure/devops/notifications/about-notifications).
 -  [Manage notifications for a team, project, organization, or collection - Azure DevOps](/azure/devops/notifications/manage-team-group-global-organization-notifications).
 -  [Events, subscriptions, and notifications - Azure DevOps.](/azure/devops/notifications/concepts-events-and-notifications)
