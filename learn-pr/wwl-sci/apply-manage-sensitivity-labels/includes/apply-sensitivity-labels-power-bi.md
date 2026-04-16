Sensitivity labels in Power BI extend your organization's data protection strategy into business intelligence. Reports, dashboards, semantic models, and dataflows often contain the same sensitive data that lives in your documents and emails. Without labels, that data loses its classification the moment someone builds a report from it. Applying sensitivity labels in Power BI keeps the protection consistent from the source data through to the final exported file.

## Requirements for applying labels in Power BI

Before you can apply sensitivity labels in Power BI, several prerequisites must be in place:

- You need a Power BI Pro or Premium Per User (PPU) license, along with Edit permission on the content you want to label. Users with a Free license can only apply labels to items in their own **My workspace**.
- Sensitivity labels must be enabled for your organization through the Fabric admin portal. The tenant setting **Allow users to apply sensitivity labels for content** controls this capability.
- You must belong to a security group with permissions to apply sensitivity labels, as configured in the Fabric admin portal under **Information protection**.
- Your labels and label policies must already be published from the Microsoft Purview portal.

## Apply sensitivity labels in the Power BI service

In the Power BI service, sensitivity labels appear in a **Sensitivity** column in the workspace list view for dashboards, reports, semantic models, and dataflows. This column gives you a quick overview of how content is classified across the workspace.

To apply or change a label on a report or dashboard:

1. Select the **More options (...)** menu for the item, then select **Settings**.
1. In the **Settings** side pane, go to the **Sensitivity label** section.
1. Select the appropriate sensitivity label from the list.

The process is similar for semantic models and dataflows. Open **Settings** for the item, expand the **Sensitivity label** section, and select the label.

If the **Sensitivity label** setting isn't available, you might not have the required usage rights to change it. In that case, contact the person who originally applied the label or your security administrator.

## Apply sensitivity labels in Power BI Desktop

You can also apply sensitivity labels to .pbix files directly in Power BI Desktop. This protects the file before it's ever published to the Power BI service, which matters when files are shared via email, stored on local drives, or uploaded to locations outside of Power BI.

To apply a label in Desktop:

1. Select the **Sensitivity** option on the toolbar.
1. Select the appropriate sensitivity label from the dropdown list.

After you apply the label, it's visible in the status bar at the bottom of the Desktop window.

When you publish a labeled .pbix file to the Power BI service, Power BI applies the label to both the report and the semantic model it creates. If the file replaces existing assets, you're prompted to choose whether to keep the existing labels or apply the .pbix file's label.

## How labels flow through Power BI

One of the most valuable aspects of sensitivity labels in Power BI is how they propagate automatically through the content lifecycle. Understanding these inheritance behaviors helps you apply labels strategically rather than manually labeling every item. The most effective starting point is your semantic models: label them first, and every report and dashboard built from them inherits that classification automatically.

### Inheritance when creating new content

When you create a new report from a labeled semantic model, the report automatically inherits the semantic model's sensitivity label. The same applies when you create a dashboard from a labeled report. This inheritance means labeling your upstream semantic models has a cascading effect on everything built from them.

### Downstream inheritance

When you apply or change a sensitivity label on a semantic model or report, Power BI can automatically propagate that label to all dependent content downstream. For example, labeling a semantic model as **Highly Confidential** can push that label to every report and dashboard built from it.

Downstream inheritance operates in two modes, controlled by a tenant setting:

- **User consent mode** (default): When you apply a label, a checkbox asks whether to also apply it downstream. Users can opt out.
- **Fully automated mode**: Labels propagate automatically without user input.

In both modes, downstream inheritance never overwrites a label that was manually applied, and it never replaces a label with a less restrictive one.

### Inheritance from data sources

Power BI semantic models that connect to labeled data in supported sources can inherit those labels automatically. Currently supported data sources include Azure Synapse Analytics, Azure SQL Database, and Excel files stored in OneDrive or SharePoint Online. This capability must be enabled through the tenant setting **Apply sensitivity labels from data sources to their data in Power BI**.

## What happens when you export labeled data

When you export data from Power BI to Excel, PowerPoint, PDF, or .pbix files, the sensitivity label travels with the exported file. If the label includes encryption settings, Power BI encrypts the exported file automatically. For example, if someone exports a financial projections dashboard labeled **Confidential** to a PDF for a client presentation, the PDF inherits the label and its encryption. The recipient still needs the right permissions to open it.

A few things to keep in mind about exports:

- Export to unsupported formats like .csv or .png doesn't carry the sensitivity label or protection.
- When you download a .pbix file and the report and semantic model have different labels, Power BI applies the more restrictive label to the downloaded file.
- Content markings configured on the label (such as headers and footers) aren't applied to exported files automatically. They appear when the file is opened in an Office desktop app.

## Considerations for Power BI label management

As you roll out sensitivity labels in Power BI, consider these operational factors:

- **Mandatory labeling**: Label policies can require users to apply a sensitivity label before saving Power BI content. Mandatory labeling is fully supported for Power BI items.
- **Workspace admin overrides**: Automated labeling scenarios can sometimes result in labels that no user has permission to change. The tenant setting **Allow workspace admins to override automatically applied sensitivity labels** addresses this limitation by giving workspace admins the ability to change automatically applied labels.
- **Embedded reports**: Sensitivity labels persist in embedded reports and dashboards, including when embedded in Teams, SharePoint, or organizational apps. The label remains visible in the embedded view.
- **Mobile apps**: Sensitivity labels are visible on reports and dashboards in the Power BI mobile apps for iOS and Android.

For more information on applying sensitivity labels in Power BI, see [How to apply sensitivity labels in Power BI](/fabric/enterprise/powerbi/service-security-apply-data-sensitivity-labels?azure-portal=true). For the full overview of sensitivity label capabilities in Power BI, see [Sensitivity labels in Power BI](/fabric/enterprise/powerbi/service-security-sensitivity-label-overview?azure-portal=true).
