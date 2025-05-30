Before deploying Microsoft Sentinel, it's crucial to understand the workspace options. The Microsoft Sentinel solution is installed in a Log Analytics Workspace, and most implementation considerations are focused on the Log Analytics Workspace creation. The single most important option when creating a new Log Analytics Workspace is the region. The region specifies the location where the log data resides.

The three implementation options:

- Single-Tenant with a single Microsoft Sentinel Workspace

- Single-Tenant with regional Microsoft Sentinel Workspaces

- Multiple tenants

## Single-tenant single workspace

The single-tenant with a single Microsoft Sentinel workspace is the central repository for logs across all resources within the same tenant.

This workspace receives logs from resources in other regions within the same tenant. Because the log data (when collected) travels across regions and stored in another region, this creates two possible concerns.  First, it can incur a bandwidth cost. Second, if there's a data governance requirement to keep data in a specific region, the single workspace option wouldn't be an implementation option.

:::image type="content" source="../media/single-tenant-workspace.png" alt-text="Diagram of a Single Tenant Microsoft Sentinel Workspace.":::

Single-Tenants with a single workspace trade-off include:

| Pros| Cons|
| :--- | :--- |
| Central Pane of Glass| May not meet Data Governance Requirements|
| Consolidates all security logs and information| Can incur bandwidth cost for cross region|
| Easier to query all information||
| Azure Log Analytics RBAC to control data access||
| Microsoft Sentinel RBAC for service RBAC||

## Single-tenant with regional Microsoft Sentinel workspaces

The single-tenant with regional Microsoft Sentinel workspaces, have multiple Microsoft Sentinel workspaces requiring the creation and configuration of multiple Microsoft Sentinel and Log Analytics workspaces.

:::image type="content" source="../media/single-tenant-regional-workspace.png" alt-text="Diagram of a Microsoft Sentinel Single Tenant Regional Workspace.":::

| Pros| Cons|
| :--- | :--- |
| No cross-region bandwidth costs| No central pane of glass. You aren't looking in one place to see all the data.|
| May be required to meet Data Governance requirements| Analytics, Workbooks, etc. must be deployed multiple times.|
| Granular data access control||
| Granular retention settings||
| Split billing||

To query data across workspaces, use the workspace() function before the table name.

```kusto
TableName

| union workspace("WorkspaceName").TableName

```

## Multiple tenant workspaces

If you're required to manage a Microsoft Sentinel workspace, not in your tenant, you implement Multiple tenant workspaces using Azure Lighthouse.  This security configuration grants you access to the tenants.  The tenant configuration within the tenant (regional or multi-regional) is the same consideration as before.

:::image type="content" source="../media/multi-tenant-workspaces.png" alt-text="Diagram of Microsoft Sentinel Multiple tenant Workspaces.":::

## Use the same log analytics workspace as Microsoft Defender for Cloud

Use the same workspace for both Microsoft Sentinel and Microsoft Defender for Cloud, so that all logs collected by Microsoft Defender for Cloud can also be ingested and used by Microsoft Sentinel. The default workspace created by Microsoft Defender for Cloud won't appear as an available workspace for Microsoft Sentinel.
