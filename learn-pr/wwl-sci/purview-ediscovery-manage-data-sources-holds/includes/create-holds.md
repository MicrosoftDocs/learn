When an investigation is underway, you might need to preserve content that could be relevant to the case. In Microsoft Purview eDiscovery, this is done by placing content locations such as mailboxes, SharePoint sites, and OneDrive accounts on hold. This action prevents data from being permanently deleted until the hold is removed or the case is closed.

You create a hold by defining a policy in an eDiscovery case. The policy determines which content to preserve and how long it should be retained. Depending on the investigation, a hold can preserve everything in a source or only content that matches a specific query.

> [!TIP]
> Hold policies are designed for investigation and litigation. For long-term retention scenarios unrelated to legal investigations, retention policies or retention labels are a better fit.

## Step 1: Create the hold policy

Every hold begins with a policy. The policy is stored in the case and defines which data sources and filters to apply.

To create a hold policy:

1. In the [Microsoft Purview portal](https://purview.microsoft.com/), go to **eDiscovery** > **Cases** and open the case you want to work in.
1. Select the **Hold policies** tab.
1. Select **Create policy**.
1. Give the policy a name (required) and an optional description.
1. Select **Create**.

   :::image type="content" source="../media/create-hold-policy.png" alt-text="Screenshot showing the creation of a new hold policy." lightbox="../media/create-hold-policy.png":::

The hold policy is now part of the case but doesn't preserve any data yet. You'll add sources and define the scope in the next steps.

## Step 2: Add sources to the hold

To preserve content, you need to specify where it lives. This means selecting the mailboxes, OneDrive accounts, or SharePoint sites that contain the data you want to keep.

1. From the **Hold policy** tab, select the policy you created.
1. Choose **Add data sources**.
1. Use the **Manage data sources** panel to select the users, groups, or sites you want to preserve.

You can hold mailboxes, OneDrive accounts, and SharePoint sites. For Microsoft Teams or Microsoft 365 groups, you need to select the group mailbox and associated SharePoint site.

> [!NOTE]
> If you add a distribution list, it expands to show current members. However, the list doesn't stay updated. If membership changes later, you need to readd the list to reflect those updates.

At least one data source is required before you can apply the hold.

## Step 3: Define the hold scope

By default, a hold preserves all content in the selected locations. But if you're trying to limit the scope of what gets preserved, you can build a search query to target specific content types or events.

There are two ways to define a query-based hold:

- **Condition builder** lets you add filters like keywords, participants, and dates through a visual interface.
- **Keyword Query Language (KQL)** provides a freeform text field for more complex queries.

1. In the **Hold policy** tab, use the **Condition builder** to define filters that match the content you want to preserve.

1. To switch to KeyQL, select it from the **Add conditions** menu. This replaces the condition builder with a single query field for advanced query input.

1. Select **Apply hold** to finalize the scope.

   :::image type="content" source="../media/configure-hold-policy.png" alt-text="Screenshot showing a hold policy being configured with data sources and conditions in the Condition builder." lightbox="../media/configure-hold-policy.png":::

> [!NOTE]
> All content is initially preserved when you create a hold. Content that doesn't match the query is cleared from the hold within 7 to 14 days, unless it's covered by another hold or can't be indexed.

## Step 4: Confirm the hold

After applying the hold, go to the **Details** tab to confirm that the policy is active and functioning as expected.

You can view:

- The names and locations of data sources
- The hold status for each location (on hold, not on hold, or error)
- Whether the source is a person or a group
- Whether the location is a mailbox or a site

   :::image type="content" source="../media/hold-details.png" alt-text="Screenshot showing the Details tab within an eDiscovery hold." lightbox="../media/hold-details.png":::

## Create a hold from an existing search

If you've already created a search that scoped the right content, you can use that search as the starting point for a hold.

To create a hold from a search:

1. Go to the **Searches** tab.
1. Open an existing search.
1. Select **Create a hold** from the command bar.

The new hold copies the sources from the search. Keep in mind:

- Tenant-wide sources are excluded.
- Distribution lists are expanded at creation and don't stay updated automatically.

## Considerations

- When a data source is removed from a hold, a **30-day delay hold** is applied before content can be permanently deleted.
- If a user's **OneDrive URL changes** (such as from a UPN update), the existing hold still preserves the content, but you need to update the URL to reflect the new path for ongoing visibility and management.
- Teams and group content is stored in group mailboxes and SharePoint sites, while user chats and shared files are stored in individual mailboxes and OneDrive. Hold all relevant locations to ensure complete coverage.
- When you place a hold on a group, member content isn't preserved unless their mailboxes and OneDrive accounts are added separately.

## Apply a hold interactive guide

Use the **Apply a hold** interactive guide to walk through creating and applying a hold policy.

[:::image type="content" source="../media/guide-apply-hold.png" alt-text="Illustration showing the opening page to the Apply a hold interactive guide.":::](https://mslearn.cloudguides.com/guides/Apply%20a%20hold%20with%20Microsoft%20Purview%20eDiscovery?azure-portal=true)
