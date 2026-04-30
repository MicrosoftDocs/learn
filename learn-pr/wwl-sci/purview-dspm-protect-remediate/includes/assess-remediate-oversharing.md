A data loss prevention (DLP) policy prevents future oversharing by enforcing rules at the moment someone shares content, but it does nothing about items that are already exposed. SharePoint sites, OneDrive accounts, and Fabric workspaces accumulate overshared content over time. Data risk assessments address that gap by identifying specific sites and items where oversharing already exists and providing targeted actions to fix each instance.

## When to use data risk assessments

Data risk assessments are the right pathway when the **Prevent oversharing of sensitive data** objective reveals concentrated exposure in specific locations. Rather than applying a broad rule across all content, you investigate where oversharing is worst and remediate at the site or item level.

The two approaches work together. A one-click DLP policy stops future oversharing from occurring, and a data risk assessment remediates the oversharing that already accumulated before the policy existed.

## Default and custom assessments

Data Security Posture Management (DSPM) provides two types of data risk assessments. Which one you use depends on whether you need broad ongoing visibility or a targeted investigation.

| | Default assessment | Custom assessment |
| --- | --- | --- |
| **Scope** | Top 100 SharePoint sites by usage | Specific users, sites, or workloads you select |
| **Frequency** | Runs automatically every week | On-demand, results available for 30 days |
| **Granularity** | Site-level remediation only | Site-level or item-level remediation |
| **When to use** | Ongoing baseline visibility into your highest-traffic sites | Investigating specific oversharing concerns or remediating individual items |

### Default assessments

The default assessment runs weekly for the top 100 SharePoint sites by usage, providing a continuous baseline without manual configuration. Review the results each week to identify sites where oversharing is growing or where sensitive data is accumulating without labels. Sites with high sensitive data counts and active sharing links are strong candidates for site-level remediation.

:::image type="content" source="../media/data-risk-assessment-default.png" alt-text="Screenshot showing the default data risk assessment summary with total items, sensitive data detected, and sharing links.":::

A separate default weekly assessment covers Microsoft Fabric workspaces. Fabric items like dashboards, reports, lakehouses, notebooks, and warehouses can expose sensitive data through broad workspace membership or shared links, which makes them a distinct oversharing vector from SharePoint file sharing. Before results appear, you need to complete a one-time Microsoft Entra application registration that grants DSPM read access to Fabric metadata. After registration, the assessment runs on the same weekly cadence and surfaces results alongside SharePoint assessments in the data risk assessment view.

### Custom assessments

When oversharing risk is concentrated in locations outside the top 100, or when you need item-level visibility into what's being shared and to whom, create a custom assessment:

1. Navigate to **DSPM (preview)** > **Discover** > **Data risk assessments**.
1. Select **Create custom assessment**.
1. Configure the assessment parameters, selecting users, data sources, or specific SharePoint sites.
1. Choose the scan level. Selecting **Item-level** scanning enables remediation actions on individual overshared items rather than only at the site level.
1. Submit the assessment and wait for results, typically available within 48 hours.

After expiration at 30 days, use the duplicate option to run the same assessment again with the same parameters.

## Site-level remediation

When you select a site from the assessment results, a flyout opens with tabs for identifying sensitive content, applying protection, and reviewing sharing patterns. The **Identify** tab shows classification scan coverage for the site. If coverage is low, initiate a scan before remediating to ensure you're acting on complete data.

The **Protect** tab offers actions in two categories depending on whether the problem is AI surfacing content it shouldn't reach, or the content itself lacking protection.

:::image type="content" source="../media/data-risk-assessment-protect-tab.png" alt-text="Screenshot showing the Protect tab for a site with options to restrict Copilot access or create labeling policies.":::

If AI interactions are the concern, **Restrict access by label** blocks Copilot from summarizing labeled content, and **Restrict all items** removes the entire site from Copilot results. Use Restrict all items sparingly because it affects all Copilot interactions with that site.

If the content needs protection regardless of AI, **Create an auto-labeling policy** applies sensitivity labels to unlabeled sensitive files, and **Create retention policies** deletes stale content that hasn't been accessed in three years.

Each action creates a policy through a guided workflow. You review the configuration before submission.

## Item-level remediation

Item-level scanning, available in custom assessments, identifies individual files flagged as potentially overshared because they have a sharing link for external or anonymous users. For each item, you choose one of four actions based on the sensitivity and sharing context:

| Scenario | Recommended action | Reasoning |
| --- | --- | --- |
| Item intentionally shared broadly for a valid business purpose | Resolve | The oversharing is acceptable given the item's content and context |
| Unlabeled item containing sensitive data | Apply sensitivity label | Labeling ensures ongoing protection through label-based DLP policies |
| Items in a site where the owner should evaluate access patterns | Notify | The site owner has the best context to determine appropriate access |
| Highly sensitive item with anonymous external link and no business justification | Remove sharing link + Apply sensitivity label | Address immediate exposure and prevent future unprotected sharing |

> [!IMPORTANT]
> Removing a sharing link is irreversible from the assessment workflow. If legitimate users need access, the site or item owner must create a new sharing link with more restrictive permissions.

## Feeding results back to the objective

Data risk assessment remediation feeds directly into the **Prevent oversharing of sensitive data** objective's outcome metrics. As you remediate overshared items or create site-level policies from assessment results, the objective's coverage and risk indicators update. If the gap remains after item-level remediation, complement it with a broader one-click policy from the objective workflow.
