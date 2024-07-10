Applying sensitivity labels in Microsoft 365 is essential for securing sensitive information, enabling organizations to protect critical data like financial details and strategic plans. These labels ensure that only authorized individuals have access, maintaining high data security standards while allowing seamless collaboration.

In our global consultancy firm, the marketing team is preparing to launch a new service that uses data analysis and AI to offer unique insights to our clients. This initiative involves handling sensitive information, including financial details and strategic plans. Sensitivity labels in Microsoft 365 are essential tools at your disposal to ensure this data remains secure.

As part of this effort, you're tasked with deploying sensitivity labels throughout our Microsoft 365 environment for the new service launch. This project requires teamwork from around the world, including remote workers. Your main goals are to keep client information safe and make sure teams can work together smoothly.

Here you learn to:

- **Identify the function of sensitivity labels**: Describe how sensitivity labels secure critical data in Microsoft 365 environments like Teams, Groups, and SharePoint Sites.
- **Apply sensitivity labels for your organization**: Demonstrate the process to enable and implement sensitivity labels across Microsoft 365 services for data protection.
- **Configure settings in the Microsoft Purview compliance portal**: Modify protection settings for groups and sites to enhance data security within your organization.

## Understand sensitivity labels in Microsoft 365

Sensitivity labels in Microsoft 365 provide a powerful way to manage data protection and compliance across various workloads. Organizations can categorize and protect sensitive information within Microsoft Teams, Microsoft 365 Groups, and SharePoint Sites by using these labels. This functionality enhances the security of data as it travels and is saved across the digital workspace, enabling a controlled and compliant collaboration environment. With sensitivity labels, businesses can find a balance between safeguarding sensitive information and promoting productivity and collaboration among their teams.

When you use a sensitivity label for containers like Teams, Microsoft 365 Groups, and SharePoint sites, you apply defined security and compliance settings automatically. Keep in mind:

- Sensitivity labels, once applied, enforce predefined settings on the container.
- Site owners can change some settings that are usually handled by administrators by applying labels. Be careful with settings that you might not want site owners to change.
- Settings for content markings and encryption based on labels aren’t automatically applied to documents in these containers. So that users can label their documents in SharePoint sites or team sites, make sure you enabled sensitivity labels for Office files in SharePoint and OneDrive.
- Container labels don't support displaying other languages and display the original language only for the label name and description.

## Implement sensitivity labels across Microsoft 365 workloads

Before you enable and configure sensitivity labels for containers, users can see and apply sensitivity labels in their apps. For example, from Word:

:::image type="content" source="../media/sensitivity-label-word.png" alt-text="Screenshot showing a sensitivity label displayed in the Word desktop app." lightbox="../media/sensitivity-label-word.png":::

After you enable and configure sensitivity labels for containers, users can also see and apply sensitivity labels to Microsoft team sites, Microsoft 365 groups, and SharePoint sites. For example, when you create a new team site from SharePoint:

:::image type="content" source="../media/sensitivity-labels-new-team-site.png" alt-text="Screenshot showing a sensitivity label when creating a team site from SharePoint." lightbox="../media/sensitivity-labels-new-team-site.png":::

After a sensitivity label is applied to a site, you must have the following role to change that label in SharePoint or Teams:

- For a group-connect site: Microsoft 365 group [Owners](/microsoft-365/admin/create-groups/office-365-groups?azure-portal=true)
- For a site that isn't group-connected: SharePoint [site admin](/sharepoint/site-permissions?azure-portal=true#site-admins)

### Enable sensitivity labels for containers and synchronize labels

To use Microsoft Purview's data protection and compliance capabilities for Microsoft Teams, Microsoft 365 Groups, and SharePoint sites, follow these steps to enable sensitivity labels for containers in your environment.:

1. **Enable labels**: Follow the [Microsoft Entra documentation to enable sensitivity labels for Microsoft 365 Groups](/entra/identity/users/groups-assign-sensitivity-labels?azure-portal=true).
1. **Synchronize labels**: Connect to [Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell?azure-portal=true) as an administrator, and run the `Execute-AzureAdLabelSync` command to sync labels with Microsoft Entra ID.

### Configure groups and site settings

After sensitivity labels are enabled for containers, you can then configure protection settings for groups and sites in the sensitivity labeling configuration. Until sensitivity labels are enabled for containers, the settings are visible but you can't configure them.

1. Navigate to the Microsoft Purview compliance portal to create or edit a sensitivity label. Select **Groups & sites** for the label's scope:
:::image type="content" source="../media/groups-and-sites-scope-options-sensitivity-label.png" alt-text="Screenshot showing sensitivity label scope option for Groups & sites." lightbox="../media/groups-and-sites-scope-options-sensitivity-label.png":::
1. On the **Define protection settings for groups and sites** page, choose the settings to configure:
   - **Privacy and external user access settings** for privacy and external users access.
   - **External sharing and Conditional Access settings** for controlling external sharing from SharePoint sites and using Conditional Access to protect labeled sites.
   - **Private teams discoverability and shared channel controls** for managing how private teams and shared channels are discovered and accessed.
   - If applicable, select a default label for channel meetings and chats.
1. If **Privacy and external user access settings** was selected:
   1. Set the **Privacy** setting for the group or site to **Public**, **Private**, or **None** for user-defined privacy settings. Specify **External user access** rules to control whether the group owner can add guests to the group.
1. If **External sharing and Conditional Access settings** was selected, then:
   1. Configure **Control external sharing from labeled SharePoint sites** by selecting appropriate external sharing options for SharePoint sites.
   1. For Microsoft Entra Conditional Access, select settings to control access from unmanaged devices or choose an existing authentication context to enforce stricter access conditions based on your organization's Conditional Access policies.
1. **If Private teams discoverability and shared channel controls** was selected:
   1. Use the checkbox to allow or restrict users from discovering private teams that have the sensitivity label applied.
   1. Configure shared channel controls to manage how teams can invite other teams to shared channels, with options like **Internal only**, **Same label only**, and **Private team only**.

Now that we've covered the basics of using sensitivity labels in our Microsoft 365 tools, it's clear these steps are just the beginning of ensuring our firm's information is well protected and compliant.

Next, we explore how to effectively manage sensitivity labels in Office applications, ensuring documents and emails are protected.
