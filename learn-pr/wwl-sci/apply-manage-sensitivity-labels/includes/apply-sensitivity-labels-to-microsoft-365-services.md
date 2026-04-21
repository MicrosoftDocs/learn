Sensitivity labels for containers (Teams, SharePoint sites, Microsoft 365 Groups) protect the workspace itself, not just the files inside it. A label on a SharePoint site can enforce who's allowed external sharing. A label on a team can control guest access and privacy. These are different decisions from labeling a document, and they happen in different places.

The challenge is knowing _where_ to apply a label and _who_ should be responsible for applying it. Microsoft 365 offers several surfaces for applying container labels:

- Outlook on the web
- SharePoint admin center
- SharePoint document library settings
- Teams admin center
- Teams desktop or web client

Each surface serves a different audience and scope. The following table maps common scenarios to the surface that fits best:

| Scenario | Best surface |
| --- | --- |
| Group owner classifies their own group | Outlook on the web |
| Admin standardizes labels across many sites | SharePoint admin center |
| Specific library needs a consistent file classification | SharePoint library settings |
| Admin reclassifies an existing team | Teams admin center |
| End user creates a new team with a label | Teams desktop or web client |
| Automated provisioning or scripted label assignment | [Microsoft Entra ID](/entra/identity/users/groups-assign-sensitivity-labels?azure-portal=true) |

## Apply sensitivity labels to groups in Outlook on the web

Microsoft 365 Groups connect Teams, SharePoint, and shared mailboxes into a single membership boundary. Labeling a group from Outlook on the web is the most direct way for group owners to set or change sensitivity. This approach works well when the group owner is the person closest to understanding the sensitivity of the content the group handles.

1. Navigate to [Outlook on the web](https://outlook.office.com/?azure-portal=true).
1. From the left navigation pane, go to **Groups**.
1. To edit the sensitivity of an existing group:
   1. Select the group, then select **...** > **Settings**.
   1. In the flyout, select **Edit group**.
   1. Under **Sensitivity**, select the desired label, then select **Save**.
    :::image type="content" source="../media/outlook-web-edit-group.png" alt-text="Screenshot showing more options within an Outlook on the web group." lightbox="../media/outlook-web-edit-group.png":::
1. To assign a label to a new group:
   1. Select **New group**.
   1. In the dialogue, select **Edit** to the right of **Default settings**.
   1. Under **Edit settings**, select the desired sensitivity label.

## Apply sensitivity labels to SharePoint sites

Site-level labels control privacy, external sharing, and Conditional Access settings for the entire site. This is where administrators standardize protection across the organization. Applying labels from the SharePoint admin center makes sense when you need to label or relabel sites at scale, or when site owners shouldn't be making the classification decision themselves.

To apply a label to an existing SharePoint site:

1. Navigate to the [Microsoft 365 admin center](https://admin.microsoft.com/?azure-portal=true), then select **… Show all** > **SharePoint**.
1. In the **SharePoint admin center**, navigate to **Sites** > **Active Sites**.
1. Select the site you want to modify.
1. On the site's properties page, select **Settings**.
1. Under the Settings tab, select the desired sensitivity label, then select **Save**.
:::image type="content" source="../media/sharepoint-settings-site.png" alt-text="Screenshot showing where to set sensitivity labels for SharePoint sites." lightbox="../media/sharepoint-settings-site.png":::

You can also apply a label when creating a new site:

1. In the **SharePoint admin center**, navigate to **Sites** > **Active Sites** > **+ Create**.
1. Select the site type and template.
1. Enter your site settings (name, description, address, owner).
1. On the **Set language and other options** page, under **Sensitivity**, select the desired label, then select **Create site**.
:::image type="content" source="../media/sharepoint-sensitivity-label-new-site.png" alt-text="Screenshot showing where to set sensitivity labels when creating a new SharePoint site." lightbox="../media/sharepoint-sensitivity-label-new-site.png":::

## Apply default sensitivity labels to SharePoint document libraries

Site labels and library default labels serve different purposes. A site label controls who can access and share from the site, but it doesn't classify or encrypt the files inside it. A library default label fills that gap by classifying the _files_ themselves. When someone uploads or creates a new file in the library, the library automatically applies its default label, unless the file already has a higher-priority label.

A library default label is useful when a specific library holds content that consistently needs the same classification. For example, a library storing client contracts might default to **Confidential**, ensuring new documents are labeled even if the user forgets.

1. Navigate to the SharePoint site that contains the document library.
1. Select **Documents** from the left navigation pane.
1. Select the gear icon to open the **Settings** menu, then select **Library settings**.
1. On the Library settings flyout page, under **Default sensitivity labels**, select the desired label.

    :::image type="content" source="../media/sharepoint-settings-sensitivity-label.png" alt-text="Screenshot showing where to set sensitivity labels within a SharePoint library." lightbox="../media/sharepoint-settings-sensitivity-label.png":::

Keep in mind that library default labels only apply to newly created or edited files. Existing files at rest aren't relabeled automatically.

## Apply sensitivity labels to Teams from the admin center

The Teams admin center gives IT administrators a central view of all teams in the organization. Apply labels from this surface when you need to reclassify an existing team or enforce labels that team owners haven't applied. It's an administrative action, and team owners and members won't typically use this path.

1. Navigate to the [Microsoft Teams admin center](https://admin.teams.microsoft.com/?azure-portal=true), then select **Teams** > **Manage teams** from the left navigation pane.
1. On the **Manage teams** page, select the check box to the left of the team you want to modify, then select **Edit**.
1. On the **Edit team** flyout page, under **Sensitivity**, select the desired label.

   :::image type="content" source="../media/teams-edit-team.png" alt-text="Screenshot showing the Manage teams page in the Microsoft Teams admin center." lightbox="../media/teams-edit-team.png":::

## Apply sensitivity labels when creating teams from the desktop or web client

When sensitivity labels are configured with a **Groups & sites** scope and your organization has Microsoft Entra ID P1 (or higher) licensing, users see a sensitivity label picker when they create a new team. This is the path most end users follow, and it's where label policies are most visible. If your label policy requires a label, users can't skip this step.

1. In the Teams desktop or web client, select **Teams** from the left navigation pane.
1. Select **+** in the top right, then select **Create team**.
1. Enter a **Team name**, then select the bar under **Description** to open label and privacy options.

   :::image type="content" source="../media/teams-create-team-menu.png" alt-text="Screenshot showing the Create a team options." lightbox="../media/teams-create-team-menu.png":::

1. Select the desired sensitivity label and sublabel if applicable.

   :::image type="content" source="../media/teams-create-team-type.png" alt-text="Screenshot showing the What kind of team will this be? menu options." lightbox="../media/teams-create-team-type.png":::

> [!TIP]
> The sensitivity label applies to the team, its SharePoint site, and any private channel SharePoint sites.

In practice, most organizations use a combination of these surfaces. Administrators handle bulk site labeling and enforce policies from admin centers, while team and group owners apply labels from the apps they use every day. Organizations that manage group creation centrally can also apply labels through Microsoft Entra ID, which is useful for scripted provisioning workflows.
