The OneLake catalog Govern tab brings governance insights from across your Fabric tenant into one place — sensitivity label coverage, DLP policy status, endorsement data, and recommended actions. Fabric admins see a tenant-wide view; data owners see insights scoped to their own items.

In this unit, you'll explore what the Govern tab shows and how to use it to assess and improve your organization's governance posture.

## Access the OneLake catalog Govern tab

The OneLake catalog Govern tab is the central place in Fabric for monitoring and improving your data estate's governance posture. To access it:

1. Select the **OneLake catalog** icon in the Fabric navigation pane, then select the **Govern** tab.
1. Alternatively, select the **settings gear** icon → **OneLake Catalog | Govern**.

:::image type="content" source="../media/onelake-catalog-govern-tab.png" alt-text="Screenshot of the OneLake catalog Govern tab, showing the overview tiles, charts, and recommended actions." lightbox="../media/onelake-catalog-govern-tab.png":::

The tab opens to an overview of your data estate — summary tiles showing total capacities, workspaces, domains, and items, alongside charts that break down your items by type, workspace, and recent operations. Fabric administrators see tenant-wide data across all workspaces and domains. Data owners see governance insights scoped to their own items — use the **My items** filter to focus on items you own or manage.

## Identify recommended actions

Below the overview, the **Recommended actions** panel surfaces specific governance issues as action cards. Each card describes a problem and links directly to the items or settings you need to fix it.

For example, if a large proportion of items are unlabeled, you'll see an **Increase sensitivity label coverage** action card. If items lack endorsement, you'll see **Establish sources of truth with endorsements**. Recommended actions help you prioritize the most impactful governance work first — especially useful in environments where labeling gaps or DLP violations require prompt attention.

## Explore governance insights

Selecting **View more** on the Govern tab opens a detailed governance report. The report has four navigation tabs, each focused on a different aspect of your data estate.

:::image type="content" source="../media/govern-tab-insights.png" alt-text="Screenshot showing the four navigation tabs in the detailed governance report: Manage your data estate, Protect secure and comply, Discover trust and reuse, and Item Explorer." lightbox="../media/govern-tab-insights.png":::

### Manage your data estate

This tab provides an inventory view of your entire Fabric data estate. You can see the number of items across your tenant, organized by capacities and domains. Use this tab to understand the scope and structure of your data landscape — for example, to identify workspaces not associated with any domain, or to track how items are distributed across business areas.

### Protect, secure, and comply

This tab focuses on data protection and regulatory compliance. It contains two key selectors:

- **Sensitivity labels**: Shows which sensitivity labels are most frequently applied across your tenant, the percentage of items that are unlabeled, and a breakdown by item type, user, domain, or workspace. Use this view to identify labeling gaps — for example, to find which workspaces have the most unlabeled items that might contain sensitive records.

- **DLP policies**: Shows which workspaces and items have been evaluated by your Data Loss Prevention policies. Use this selector to identify policy violations, review items flagged by DLP rules, and trigger new scans on demand.

### Discover, trust, and reuse

This tab helps you assess the quality and trustworthiness of your data assets. It surfaces insights about:

- **Endorsement**: Which items are promoted, certified, or marked as master data — and which high-visibility items have no endorsement yet.
- **Data freshness**: How recently items have been updated, helping you identify stale or out-of-date datasets.
- **Curation state**: Whether items have complete metadata, descriptions, and other curation details that make them easier to discover and reuse.

With the Govern tab, you have a single place inside Fabric to assess your governance posture, identify gaps, and act on them — backed by the full power of Microsoft Purview.