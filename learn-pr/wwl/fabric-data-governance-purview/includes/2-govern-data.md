Microsoft Fabric includes governance capabilities at every level of the platform. As a data engineer or analyst, you interact with these whenever you work with Fabric items — whether you're managing workspace access, applying labels, or exploring data in the OneLake catalog.

In this unit, you'll explore the governance capabilities included with your Fabric license and understand what each one lets you do.  

## Organize your data estate

A data estate is everything your organization stores, processes, and analyzes — lakehouses, warehouses, semantic models, reports, and more. Fabric gives you a hierarchy of containers to organize and control it:

- **Tenant**: The top-level boundary for your organization's Fabric environment. Administrators manage tenant-wide settings in the **Fabric Admin portal**, including capacity allocation, feature flags, and domain configuration.
- **Domains**: Logical groupings that represent business areas — for example, Finance, Operations, or Customer Data. Domains let you delegate governance responsibility to the teams that own that data.
- **Workspaces**: The working containers where teams create and share Fabric items. Workspace settings control who can access items and what they can do with them.
- **Capacities**: Limits on compute resources, preventing any one team or workload from consuming more than their fair share.

Fabric also includes **metadata scanning**, which extracts information such as item names, owners, sensitivity labels, and endorsements across your tenant. Governance teams can use this metadata to automate reporting and policy checks.

## Control who accesses your data

Keeping data secure means ensuring only the right people can reach it. Fabric provides layered access controls:

- **Workspace roles**: Assign roles — Admin, Member, Contributor, or Viewer — to control what users can do within a workspace. This is your first line of access control for most Fabric items.
- **Item-level permissions**: Share individual items with specific users without granting full workspace access. Useful when a report or semantic model needs a broader audience than the workspace.
- **Data-level controls**: Apply row-level security, column-level security, and object-level security within items like semantic models and warehouses. These controls restrict what data a user can see even when they have access to the item.

## Help users find and trust data

Governance isn't only about restriction — it's also about making good data easy to find and trust. Fabric includes several features that support data discovery:

- **OneLake catalog**: A centralized place to find, explore, and govern Fabric items across your tenant. The **Explore** tab lets anyone browse items, view metadata, check sensitivity labels, and see endorsement status.
- **Endorsement**: Mark items as **Promoted** or **Certified** to signal they're reliable and recommended. Certified items go through a formal review; promoted items are vouched for by the item owner.
- **Tags**: Apply custom tags to items to make them easier to filter and find — for project names, data classifications, cost centers, or any organizing label your team needs.
- **Data lineage**: The lineage view shows how data flows through a workspace — from sources through transformations to reports. Use lineage to understand the impact of changes and trace data back to its origin.

## Monitor activity across your tenant

Visibility into what's happening in your data environment is a core governance requirement. Fabric provides two built-in monitoring tools:

- **Monitoring Hub**: A centralized view of activity for Fabric items you have access to. Use it to track pipeline runs, notebook executions, and other activities across your workspaces.
- **Capacity Metrics App**: Tracks resource consumption across your Fabric capacity, helping administrators manage performance and costs.

## When you need more

These capabilities cover a wide range of governance needs and are included with your Fabric license. Some requirements, however, go further:

- Automatically detecting and classifying sensitive data — such as credit card numbers or personal identifiers — across all items in OneLake
- Enforcing encryption and access restrictions based on data sensitivity
- Preventing users from sharing sensitive items outside the organization
- Detecting unusual behavior that could indicate data theft or insider risk
- Maintaining a full compliance audit trail for regulatory investigations

For these scenarios, Fabric relies on Microsoft Purview — a family of governance, risk, and compliance solutions that extend what's built in. In the next unit, you'll learn which capabilities Purview adds and how they appear inside Fabric.
