As our firm begins the project to launch a new service powered by data analysis and AI, we're faced with the critical task of managing sensitive information. This includes everything from our clients' financial details to strategic plans. Your role in ensuring the safety of this data is crucial. Equipped with Microsoft 365 sensitivity labels, you're prepared to protect our project at every stage.

This unit guides you on how to:

- **Secure email communication**: Apply sensitivity labels in Outlook on the web to determine who can view project-related emails.
- **Safeguard shared spaces**: Protect documents and discussions during the service launch by applying sensitivity labels in SharePoint and Teams.
- **Extend protection**: Broaden the application of sensitivity labels to Microsoft 365 Groups, aligning security measures across Teams, SharePoint, and group-related activities.

## Apply sensitivity labels to groups in Outlook on the web

When creating or updating a group in Outlook on the web, you can select or modify the available sensitivity label.

1. Navigate to [Outlook on the web](https://outlook.office.com/?azure-portal=true).
1. From the left navigation pane, go to **Groups**.
1. To edit the sensitivity of an existing group:
   1. Select the group you'd like to modify.
   1. In the group, select the **...** to expand extra settings, then select **Settings**.
   1. In the right flyout page, select **Edit group**.
   1. In the **Edit group** dialogue under **Sensitivity**, select the desired sensitivity label, then select **Save**.
    :::image type="content" source="../media/outlook-web-edit-group.png" alt-text="Screenshot showing more options within an Outlook on the web group." lightbox="../media/outlook-web-edit-group.png":::
1. To assign sensitivity labels to a new group:
   1. Select **New group**.
   1. In the **New group** dialogue, select **Edit** to the right of **Default settings**.
   1. Under **Edit settings** select the desired sensitivity label.

## Apply sensitivity labels to SharePoint sites

You can apply sensitivity labels to SharePoint sites to manage access and protect sensitive content according to your organization's policies. To apply a sensitivity label to an existing SharePoint site:

1. Navigate to the [Microsoft 365 admin center](https://admin.microsoft.com/?azure-portal=true), then select **… Show all** to show all admin center options, then select  **SharePoint**.
1. In the **SharePoint admin center**, navigate to **Sites** > **Active Sites**.
1. On the Active sites page, select the site you'd like to modify.
1. On the site's properties page, select **Settings**.
1. Under the Settings tab, select the desired sensitivity label then select **Save**.
:::image type="content" source="../media/sharepoint-settings-site.png" alt-text="Screenshot showing where to set sensitivity labels for SharePoint sites." lightbox="../media/sharepoint-settings-site.png":::

You can also apply sensitivity labels to new sites upon creation. To do this:

1. Navigate to the [Microsoft 365 admin center](https://admin.microsoft.com/?azure-portal=true), then select **… Show all** to show all admin center options, then select  **SharePoint**.
1. In the **SharePoint admin center**, navigate to **Sites** > **Active Sites**.
1. Select **+ Create** to create a new SharePoint site.
1. Select the desired site type and template if necessary.
1. Enter your SharePoint site settings for name, description, site address, and site owner.
1. On the **Set language and other options** page under **Sensitivity** select the desire sensitivity label, then select **Create site**.
:::image type="content" source="../media/sharepoint-sensitivity-label-new-site.png" alt-text="Screenshot showing where to set sensitivity labels when creating a new SharePoint site." lightbox="../media/sharepoint-sensitivity-label-new-site.png":::

## Apply sensitivity labels to SharePoint document libraries

You can also use sensitivity labels on SharePoint document libraries to control and restrict access based on the classification of the information contained within.

1. Navigate to [Office 365](https://portal.office.com?azure-portal=true), then select the hamburger navigation in the top left.
1. Select **SharePoint** to navigate to your organization's SharePoint page.
1. To modify the sensitivity settings of your SharePoint library:
   1. Navigate to the site you'd like to modify.
   1. Select **Documents** from the left navigation pane.
   1. Select the gear on the top left to open the **Settings** menu, then select **Library settings**.
   1. On the Library settings flyout page under Default sensitivity labels,** select the desired sensitivity label.

    :::image type="content" source="../media/sharepoint-settings-sensitivity-label.png" alt-text="Screenshot showing where to set sensitivity labels within a SharePoint library." lightbox="../media/sharepoint-settings-sensitivity-label.png":::

## Apply sensitivity labels to Teams from the admin center

1. Navigate to the [Microsoft Teams admin center](https://admin.teams.microsoft.com/?azure-portal=true), then select **Teams** > **Manage teams** from the left navigation pane.
1. On the **Manage teams** page, select the check box to the left of the team you'd like to modify then select **Edit**.
1. On the **Edit team** fly out page, under **Sensitivity** select the desired sensitivity label.

   :::image type="content" source="../media/teams-edit-team.png" alt-text="Screenshot showing the Manage teams page in the Microsoft Teams admin center." lightbox="../media/teams-edit-team.png":::

## Apply sensitivity labels to new Teams channels from the desktop or web client

If sensitivity labels are created with a Group & site setting and the user has a Microsoft Entra ID P1 license, then it's possible to control the creation of Microsoft Teams with sensitivity labeling.

1. Navigate to either the Microsoft Teams desktop or web client.
1. Select **Teams** from the left navigation pane.
1. Select **+** (plus sign) in the top right of the **Teams** menu, then select **Create team**.
1. Give your team a meaningful **Team name** in the **Create a team** menu, then select the bar under the **Description (optional)** field to open label and privacy options.

   :::image type="content" source="../media/teams-create-team-menu.png" alt-text="Screenshot showing the Create a team options." lightbox="../media/teams-create-team-menu.png":::

1. On the **What kind of team will this be?** menu, select the desired Sensitivity label and Sensitivity sublabel if applicable.

   :::image type="content" source="../media/teams-create-team-type.png" alt-text="Screenshot showing the What kind of team will this be? menu options." lightbox="../media/teams-create-team-type.png":::

> [!TIP]
> The sensitivity label applies to the Microsoft Team, SharePoint Site and to the private channel SharePoint Site.

## Apply sensitivity labels to Microsoft 365 groups

Microsoft Entra ID supports applying sensitivity labels published by the Microsoft Purview compliance portal to Microsoft 365 groups. To learn more about applying sensitivity labels to Microsoft 365 groups, see [Assign sensitivity labels to Microsoft 365 groups in Microsoft Entra ID](/entra/identity/users/groups-assign-sensitivity-labels?azure-portal=true).

Now that we've applied sensitivity labels to Microsoft 365 services, we've improved how we protect our project's data. Next, we focus on securing our meetings in Microsoft Teams and Outlook. By using sensitivity labels for meetings, we make sure that only the authorized individuals can join these discussions, keeping our information secure and private. This is our next step in keeping our firm's data safe and compliant.

## Knowledge check

Select the best response to the question, then select **Check your answers**.
