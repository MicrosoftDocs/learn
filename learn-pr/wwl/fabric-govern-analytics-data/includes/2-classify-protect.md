Before you can endorse assets or make data discoverable, you need to ensure that confidential information is properly classified and controlled. Microsoft Fabric integrates with Microsoft Purview Information Protection to provide sensitivity labels that classify, protect, and govern your data across the platform. You might not configure these labels yourself, but you play a critical role in identifying which data needs protection and understanding how labels should be applied.

## Understand sensitivity labels

Sensitivity labels are metadata tags from Microsoft Purview Information Protection that you apply to Fabric items. Each label represents a classification level that your organization defines, such as Public, General, Confidential, or Highly Confidential. Labels communicate the classification level to users and can enforce protection policies that control access.

When a sensitivity label is applied to a Fabric item, the label:

- Appears visually on the item in the Fabric portal, so users understand the data's classification at a glance.
- Can enforce access control through Microsoft Purview protection policies.
- Travels with data when exported through supported paths, such as Excel, PDF, PowerPoint, and Power BI Desktop (.pbix) files.

Sensitivity labels work across all Fabric item types, including lakehouses, warehouses, semantic models, reports, notebooks, and pipelines.

> [!NOTE]
> Sensitivity labels require Microsoft Purview Information Protection licensing and configuration by your organization's Purview administrator. If your organization doesn't use Purview, you can still govern data using endorsement, documentation, and the OneLake catalog features covered later in this module.

## Identify data that needs classification

As the person who discovers, transforms, and models data, you're often the first to recognize when a dataset contains sensitive information. The following example uses common classification labels as a thought exercise. When evaluating whether data needs a sensitivity label, consider these questions:

| Question | Typical classification |
|----------|------------------------|
| Does the data contain personally identifiable information (PII) such as names, addresses, or email addresses? | Confidential or higher. |
| Does the data include financial information such as salaries, revenue, or account numbers? | Confidential or higher. |
| Does the data contain health records or other regulated information? | Highly Confidential. |
| Is the data intended for public use, such as published reports or marketing metrics? | Public or General. |
| Is the data experimental or exploratory, without a defined audience? | General (apply a baseline label to prevent it from being unlabeled). |

Document your findings and share them with the team responsible for label configuration to ensure labels reflect the actual data landscape.

## Understand how labels affect your workflow

Even when someone else configures labels, they directly affect how you work with data in Fabric:

- **Visibility:** Labeled items display their classification in the Fabric portal. When you browse a workspace or the OneLake catalog, you can see which items are classified and at what level. This helps you choose the right source data for your semantic models.
- **Export behavior:** When you export labeled data through supported paths (Excel, PDF, PowerPoint, .pbix), the label and its protections travel with the exported file. Exports to CSV or TXT files don't carry label protection, and Fabric displays a warning.
- **Access restrictions:** If a label is associated with a Purview protection policy, only users in the permitted security groups can access the item. If you can't open a lakehouse or semantic model, a protection policy on its label might be the reason.

## Understand how labels propagate through lineage

In a typical analytics workflow, data flows from a lakehouse through a warehouse or SQL analytics endpoint, into a semantic model, and finally into reports. Downstream inheritance means that applying a single label at the lakehouse level can protect every item in that chain. For example, a lakehouse labeled Confidential passes that label to any SQL analytics endpoint, semantic model, or report built from it.

Fabric provides several automatic labeling capabilities that reduce the need for manual action:

- **Default labeling:** New items automatically receive a baseline label if no label is applied during creation.
- **Mandatory labeling:** When enabled, users can't save Power BI items without applying a label, preventing unlabeled content from reaching consumers. Support for non-Power BI Fabric items is limited.
- **Downstream inheritance:** Labels propagate automatically from upstream to downstream items.
- **Inheritance upon creation:** New items created from labeled parents inherit the parent's label.
- **Inheritance from data sources:** Power BI semantic models inherit labels from labeled data sources.

Because of this propagation, your labeling strategy can focus on source items. Label lakehouses and warehouses at the point of ingestion, and let inheritance protect downstream assets. Additionally, enable default labeling so new items always receive baseline classification, and use the OneLake catalog's Govern tab to track items that lack labels.

> [!TIP]
> If your organization doesn't use Microsoft Purview, you can still classify data informally by using workspace naming conventions, item descriptions, and tags. These approaches provide visibility without the enforcement that sensitivity labels offer, but they're better than no classification at all.

With classification in place, you're ready to signal which assets are trustworthy through endorsement and documentation.
