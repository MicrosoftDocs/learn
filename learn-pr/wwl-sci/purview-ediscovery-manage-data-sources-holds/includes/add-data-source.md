Once a case has been created, eDiscovery allows you to define which content sources should be included in a search. Adding data sources ensures that you're querying the right locations tied to the individuals or groups involved in your investigation.

In the new eDiscovery experience, data sources are added directly from within a search. This streamlines the workflow and provides a clear view of what locations are included. Sources can be added manually or using broader organization-wide options, depending on the scope of your investigation.

## Add sources to a search

To add data sources in the new experience:

1. Go to the Microsoft Purview portal and navigate to **Solutions** > **eDiscovery** > **Cases**.

1. Select a case, then select the **Searches** tab to open an existing search or create a new one.

1. Select **Add sources** or **Add tenant-wide sources**.

1. Use the **Search for sources** panel to look up people, groups, or locations.

   :::image type="content" source="../media/add-data-sources.png" alt-text="Screenshot showing where to add data sources in an eDiscovery search." lightbox="../media/add-data-sources.png":::

1. Apply filters to narrow your selection. You can:

   - Limit the results to people or groups only
   - Show or hide inactive users
   - Focus only on sources already connected to the case

1. Select the users or groups to include.

   After selecting users or groups as sources, use the **Manage** button to review and adjust which data locations are included for each source. For users, you can choose their mailbox and OneDrive site. For groups, you can choose the group mailbox and any associated SharePoint site.

    :::image type="content" source="../media/manage-data-sources.png" alt-text="Screenshot of the Manage sources panel showing users and groups with mailboxes and sites selected." lightbox="../media/manage-data-sources.png":::

1. Save your selections.

Once saved, your chosen sources appear in the **Data sources** list for the search. Each source displays icons to indicate which content types are included, such as mailboxes or SharePoint sites.

If your case requires broader coverage, you can use the **Add tenant-wide sources** option. This includes:

- **All people and groups**, which covers all mailboxes, OneDrive sites, and group content across the organization
- **All public folders**, which includes all content in Exchange public folder mailboxes

> [!NOTE]
> The list of available users and groups in the **Search for sources** panel depends on the case's data source settings. These settings are configured when creating or editing a case and include options like departed users, guest users, and shared Teams channels. You can review or update these settings in the **Settings** tab of the case. For more information, see [Learn about data sources settings in eDiscovery cases](/purview/edisc-settings-data-sources).

## Review or modify data sources

After saving your selections, you can return to the search at any time to update the data sources. From the **Searches** tab within the case, open the relevant search, and select the **Manage sources** icon in the data sources section. This allows you to:

- Add or remove users and groups
- Change which content types are included (mailbox, OneDrive, SharePoint)
- Review location mappings for each source

   :::image type="content" source="../media/manage-sources.png" alt-text="Screenshot showing the options to Manage sources after data sources are added." lightbox="../media/manage-sources.png":::

Any changes you make affect the scope of the search results and can be saved immediately.

You can also select the **Sync** (⟳) button to check whether any of the data sources have changed, such as new Teams channels being added. This ensures your search includes the most current content locations. Sync doesn't reflect changes to group membership. If new users are added to a group after it's selected, their mailboxes and OneDrive sites won't be included automatically.

## Considerations

You can include distribution lists in your search. eDiscovery automatically resolves these lists into individual mailboxes, helping you quickly target a defined group of users without manually adding each one.

Defining data sources early helps ensure that search results are accurate and makes it easier to apply holds without needing to reselect sources later.
