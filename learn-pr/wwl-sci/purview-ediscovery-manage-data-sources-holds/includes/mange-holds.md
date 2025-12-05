After placing content on hold in an eDiscovery case, you might need to return to that hold to verify, edit, or manage it as the case progresses. Microsoft Purview provides tools to help you maintain these holds over time and ensure the right content remains preserved.

## View and filter existing holds

The **Hold policies** tab in each case provides a centralized view of all existing holds. From this dashboard, you can:

- View the name, creator, and last modified time for each policy
- Check the status of each hold (such as Draft, On, or Off)
- Filter or search for specific policies
- Customize the columns that appear
- Download the list of holds as a .csv file

Select a hold from the list to view its details, including the data sources and any conditions that scope the hold.

## Understand hold policy states

Each hold policy has a status that reflects its current state:

- **Draft**: The policy has been created but not applied. Navigating away before applying it discards the draft.
- **On**: The hold is active and content is being preserved.
- **Off**: The hold is no longer active, but the policy still exists.
- **In progress**: The policy is still applying or updating.
- **Pending deletion**: The policy is being deleted and is no longer preserving content.

## Edit an existing hold

You can update the description or change the scope of a hold after it's been created. The policy name is fixed once the hold is applied.

To edit the description:

1. In the [Microsoft Purview portal](https://purview.microsoft.com/), go to **eDiscovery** > **Cases** and open the case you want to work in.
1. Go to the **Hold policies** tab and open the hold you want to edit.
1. Select the pencil icon next to the name.
1. Make your updates and select **Continue**.

   :::image type="content" source="../media/edit-hold-policy-description.png" alt-text="Screenshot showing where the pencil icon to edit the description of an eDiscovery hold." lightbox="../media/edit-hold-policy-description.png":::

To change the data sources or query:

1. Open the hold from the **Hold policies** tab.
1. In the **Hold policy** tab, edit the data sources, keywords, date ranges, or participants.
1. Select **Apply hold** to save your changes.

## Policy actions

The **Policy actions** menu includes tools to manage an existing hold. These actions let you reapply, pause, or remove a hold depending on the needs of the investigation.

:::image type="content" source="../media/hold-policy-actions.png" alt-text="Screenshot showing the Policy actions dropdown menu in an eDiscovery hold." lightbox="../media/hold-policy-actions.png":::

### Retry a hold

If a hold fails to apply to one or more locations, you might see an error in the **Details** tab. This can happen if:

- A site or mailbox doesn't exist
- A SharePoint site is read-only
- A distribution list is too large to expand
- A URL or email address is invalid

To retry the hold after fixing the issue:

1. Open the hold.
1. Select **Policy actions** > **Retry policy**.

Purview attempts to reapply the hold to all selected locations. This ensures content in fixed or updated sources is preserved.

### Turn a hold off or on

You can disable a hold without deleting it. This might be useful if you need to pause preservation temporarily.

To turn a hold off:

1. Open the hold.
1. Select **Policy actions** > **Turn off**.

To turn it back on later, use the **Policy actions** menu again and select **Turn on**.

Turning a hold off might allow preserved content to be deleted unless it's protected by another hold.

### Delete a hold policy

When a hold is no longer needed, you can delete it. This removes the hold and releases all associated content.

To delete a hold:

1. Open the hold.
1. Select **Policy actions** > **Delete policy**.
1. Confirm the deletion.

> [!CAUTION]
> Content that was only protected by this hold might become eligible for deletion once it's removed.

## Hold considerations for Microsoft Teams and groups

Microsoft Teams and Microsoft 365 Groups store content across multiple services. To ensure full preservation, you might need to hold both group resources and individual user content.

To preserve group or Teams content:

- Add the group mailbox and SharePoint site as data sources
- For private chats and shared files, hold the users' mailboxes and OneDrive accounts
- Use PowerShell (`Get-UnifiedGroup`) to find group site URLs
- Remember that placing a group on hold doesn't preserve member content unless added separately

## Hold error reference

If a hold status shows an error in the **Details** tab, use this reference to diagnose and resolve common issues:

| Error | Description  | Resolution |
|-----|-----| -----|
| **Site not found** | SharePoint URL is incorrect or deleted  | Confirm the site and update the source |
| **Mailbox not found** | Email address isn't valid | Verify and correct the address |
| **Too many members** | Distribution list exceeds 1,000 members | Split the list or add members individually |
| **Read-only site** | SharePoint location can't be modified | Make the site writable, then retry |
| **Deployment interrupted** | System failed to apply the hold | Use **Retry policy** |
