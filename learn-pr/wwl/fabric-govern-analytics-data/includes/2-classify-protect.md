Without classification, nothing prevents someone from using sensitive data they shouldn't have access to. A lakehouse containing employee salary data might sit in a workspace where anyone with viewer access can export it to Excel and share it in a meeting deck. **Classification makes the sensitivity visible** before someone opens or exports the data.

## What sensitivity labels do

Sensitivity labels are metadata tags that classify Fabric items by sensitivity level. Common levels include Public, General, Confidential, and Highly Confidential. Your organization defines these levels and the policies behind them.

Sensitivity labels are visible in the Fabric portal for all item types, so users can make informed decisions. Labels can enforce access restrictions through protection policies that control who opens the item.

In a typical workflow, data moves from a lakehouse through a warehouse or SQL analytics endpoint, into a semantic model, and into reports. Labels flow with that data automatically through inheritance. Labels also travel with the data when exported through supported paths like Excel, PDF, PowerPoint, and Power BI Desktop files.

:::image type="content" source="../media/label-inheritance-flow.png" alt-text="Diagram of a sensitivity label applied at the lakehouse flowing downstream through warehouse, semantic model, and report.":::

This means **classification can start at the source**. Labeling a lakehouse at ingestion time can protect every item built from it.

## When to classify data

Classification matters most when data contains information that could cause harm if misused. Personally identifiable information like names and addresses, financial data like salaries or account numbers, health records, and internal business data not meant for external audiences all warrant explicit classification.

Even exploratory or experimental data benefits from a baseline label. An unlabeled item gives consumers no information about its sensitivity, which creates uncertainty.

## If labels aren't available

Sensitivity labels require configuration by your organization's security team. If labels aren't set up yet, you can still make sensitivity visible by using clear item descriptions, workspace naming conventions, and tags. These approaches don't enforce access controls, but they give consumers information they wouldn't otherwise have.

> [!TIP]
> Think about the data assets in your workspace. Which ones contain information that someone outside your team shouldn't see? Would a consumer know that just by looking at the item in the catalog?
